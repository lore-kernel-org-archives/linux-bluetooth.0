Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427922602-6253-11-git-send-email-jamuraa@chromium.org>
References: <1427922602-6253-1-git-send-email-jamuraa@chromium.org>
	<1427922602-6253-11-git-send-email-jamuraa@chromium.org>
Date: Wed, 1 Apr 2015 19:40:34 -0700
Message-ID: <CAHrH25Qff4Ft_6jhkWM=Pf7SmQLfodE0KPwi_WJKpzgYQDQpSA@mail.gmail.com>
Subject: Re: [BlueZ v8 10/10] test: improvements to advertising-example
From: Arman Uguray <armansito@google.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> On Wed, Apr 1, 2015 at 2:10 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> Improves the advertising-example in two ways:

I'd change the commit message to say 'example-advertisement' following
the new naming.

>
> It uses 16-bit service UUIDs so that it does not overflow the
> Advertisement Data
>
> It turns the adapter's power on so that it works out of the box.
> ---
>  test/example-advertisement | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/test/example-advertisement b/test/example-advertisement
> index 98aeafa..6e47391 100755
> --- a/test/example-advertisement
> +++ b/test/example-advertisement
> @@ -113,11 +113,10 @@ class TestAdvertisement(Advertisement):
>
>      def __init__(self, bus, index):
>          Advertisement.__init__(self, bus, index, 'broadcast')
> -        self.add_service_uuid('0000180D-0000-1000-8000-00805F9B34FB')
> -        self.add_service_uuid('0000180F-0000-1000-8000-00805F9B34FB')
> +        self.add_service_uuid('180D')
> +        self.add_service_uuid('180F')
>          self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02, 0x03, 0x04])
> -        self.add_service_data('00009999-0000-1000-8000-00805F9B34FB',
> -                              [0x00, 0x01, 0x02, 0x03, 0x04])
> +        self.add_service_data('9999', [0x00, 0x01, 0x02, 0x03, 0x04])
>
>
>  def register_ad_cb():
> @@ -153,6 +152,11 @@ def main():
>          print 'LEAdvertisingManager1 interface not found'
>          return
>
> +    adapter_props = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, adapter),
> +                                   "org.freedesktop.DBus.Properties");
> +
> +    adapter_props.Set("org.bluez.Adapter1", "Powered", dbus.Boolean(1))
> +
>      ad_manager = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, adapter),
>                                  LE_ADVERTISING_MANAGER_IFACE)
>
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
