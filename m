Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1468500345-5833-1-git-send-email-luiz.dentz@gmail.com>
References: <1468500345-5833-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Jul 2016 10:39:27 +0300
Message-ID: <CABBYNZJbb-_cgQxJnAc-aUHukz-5TXng=ZCAA_uj6_+JPikc0Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] test/example-gatt-server: Fix error on Property.GetAll
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 14, 2016 at 3:45 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> get_properties is a method not a dictionary which cause the following
> error:
>   TypeError: 'method' object is not subscriptable
> ---
>  test/example-gatt-server | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/test/example-gatt-server b/test/example-gatt-server
> index 71aeb1b..84905f3 100755
> --- a/test/example-gatt-server
> +++ b/test/example-gatt-server
> @@ -117,7 +117,7 @@ class Service(dbus.service.Object):
>          if interface != GATT_SERVICE_IFACE:
>              raise InvalidArgsException()
>
> -        return self.get_properties[GATT_SERVICE_IFACE]
> +        return self.get_properties()[GATT_SERVICE_IFACE]
>
>
>  class Characteristic(dbus.service.Object):
> @@ -164,7 +164,7 @@ class Characteristic(dbus.service.Object):
>          if interface != GATT_CHRC_IFACE:
>              raise InvalidArgsException()
>
> -        return self.get_properties[GATT_CHRC_IFACE]
> +        return self.get_properties()[GATT_CHRC_IFACE]
>
>      @dbus.service.method(GATT_CHRC_IFACE,
>                          in_signature='a{sv}',
> @@ -222,7 +222,7 @@ class Descriptor(dbus.service.Object):
>          if interface != GATT_DESC_IFACE:
>              raise InvalidArgsException()
>
> -        return self.get_properties[GATT_CHRC_IFACE]
> +        return self.get_properties()[GATT_CHRC_IFACE]
>
>      @dbus.service.method(GATT_DESC_IFACE,
>                          in_signature='a{sv}',
> --
> 2.7.4

Applied.


-- 
Luiz Augusto von Dentz
