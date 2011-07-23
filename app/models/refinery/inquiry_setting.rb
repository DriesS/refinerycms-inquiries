module Refinery
  class InquirySetting < ActiveRecord::Base

    class << self
      def confirmation_subject(locale='en')
        Refinery::Setting.find_or_set("inquiry_confirmation_subject_#{locale}".to_sym,
                                      "Thank you for your inquiry")
      end

      def confirmation_subject=(value)
        value.first.keys.each do |locale|
          Refinery::Setting.set("inquiry_confirmation_subject_#{locale}".to_sym, value.first[locale.to_sym])
        end
      end

      def confirmation_message(locale='en')
        Refinery::Setting.find_or_set("inquiry_confirmation_messeage_#{locale}".to_sym,
                                      "Thank you for your inquiry %name%,\n\nThis email is a receipt to confirm 
                                      we have received your inquiry and we'll be in touch shortly.\n\nThanks.")
      end

      def confirmation_message=(value)
        value.first.keys.each do |locale|
          Refinery::Setting.set("inquiry_confirmation_messeage_#{locale}".to_sym, value.first[locale.to_sym])
        end
      end

      def notification_recipients
        Refinery::Setting.find_or_set(:inquiry_notification_recipients,
                                      ((Refinery::Role[:refinery].users.first.email rescue nil) if defined?(Refinery::Role)).to_s)
      end

      def notification_subject
        Refinery::Setting.find_or_set(:inquiry_notification_subject,
                                      "New inquiry from your website")
      end
      
      def send_confirmation?
        Refinery::Setting.find_or_set(:inquiry_send_confirmation, true)
      end
    end

  end
end