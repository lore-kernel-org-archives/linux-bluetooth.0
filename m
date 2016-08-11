Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/7] test/example-advertisement: Fix data format of properties
In-Reply-To: <1470917692-8878-3-git-send-email-luiz.dentz@gmail.com>
References: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com> <1470917692-8878-3-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 11 Aug 2016 10:41:07 -0300
Message-ID: <87shubxw24.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> D-Bus dictionaries always except the values to be of variant type.

nitpick: expect

> ---
>  test/example-advertisement | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/test/example-advertisement b/test/example-advertisement
> index ce6e40f..7da0c7b 100755
> --- a/test/example-advertisement
> +++ b/test/example-advertisement
> @@ -65,10 +65,10 @@ class Advertisement(dbus.service.Object):
>                                                      signature='s')
>          if self.manufacturer_data is not None:
>              properties['ManufacturerData'] = dbus.Dictionary(
> -                self.manufacturer_data, signature='qay')
> +                self.manufacturer_data, signature='qv')
>          if self.service_data is not None:
>              properties['ServiceData'] = dbus.Dictionary(self.service_data,
> -                                                        signature='say')
> +                                                        signature='sv')
>          if self.include_tx_power is not None:
>              properties['IncludeTxPower'] = dbus.Boolean(self.include_tx_power)
>          return {LE_ADVERTISEMENT_IFACE: properties}
> @@ -88,13 +88,13 @@ class Advertisement(dbus.service.Object):
>
>      def add_manufacturer_data(self, manuf_code, data):
>          if not self.manufacturer_data:
> -            self.manufacturer_data = dict()
> -        self.manufacturer_data[manuf_code] = data
> +            self.manufacturer_data = dbus.Dictionary({}, signature='qv')
> +        self.manufacturer_data[manuf_code] = dbus.Array(data, signature='y')
>
>      def add_service_data(self, uuid, data):
>          if not self.service_data:
> -            self.service_data = dict()
> -        self.service_data[uuid] = data
> +            self.service_data = dbus.Dictionary({}, signature='sv')
> +        self.service_data[uuid] = dbus.Array(data, signature='y')
>
>      @dbus.service.method(DBUS_PROP_IFACE,
>                           in_signature='s',
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
--
Vinicius
