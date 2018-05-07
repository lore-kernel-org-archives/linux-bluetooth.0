Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <DF5EAE85-3D61-4D67-A452-4E6AEB3320CA@intel.com>
In-Reply-To: <DF5EAE85-3D61-4D67-A452-4E6AEB3320CA@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 07 May 2018 09:42:54 +0000
Message-ID: <CABBYNZKvGo_asL26gBZPgp1wHhzDj1kcTtq2Ro-fRm8T6FH4Ag@mail.gmail.com>
Subject: Re: [PATCH BlueZ] test/example-advertisement: add python3 support
To: preston.hunt@intel.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Preston,
On Fri, May 4, 2018 at 6:01 PM Hunt, Preston <preston.hunt@intel.com> wrote:

> This adds support for python3 to the existing script. The script will
> now work with either python2 or python3.
> ---
>   test/example-advertisement | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)

> diff --git a/test/example-advertisement b/test/example-advertisement
> index d9b5b42..fd84eac 100755
> --- a/test/example-advertisement
> +++ b/test/example-advertisement
> @@ -1,12 +1,18 @@
>   #!/usr/bin/python

> +from __future__ import print_function
> +
>   import dbus
>   import dbus.exceptions
>   import dbus.mainloop.glib
>   import dbus.service

>   import array
> -import gobject
> +
> +try:
> +  from gi.repository import GObject  # python3
> +except ImportError:
> +  import gobject as GObject  # python2

>   from random import randint

> @@ -118,17 +124,17 @@ class Advertisement(dbus.service.Object):
>                            in_signature='s',
>                            out_signature='a{sv}')
>       def GetAll(self, interface):
> -        print 'GetAll'
> +        print('GetAll')
>           if interface != LE_ADVERTISEMENT_IFACE:
>               raise InvalidArgsException()
> -        print 'returning props'
> +        print('returning props')
>           return self.get_properties()[LE_ADVERTISEMENT_IFACE]

>       @dbus.service.method(LE_ADVERTISEMENT_IFACE,
>                            in_signature='',
>                            out_signature='')
>       def Release(self):
> -        print '%s: Released!' % self.path
> +        print('%s: Released!' % self.path)

>   class TestAdvertisement(Advertisement):

> @@ -144,11 +150,11 @@ class TestAdvertisement(Advertisement):


>   def register_ad_cb():
> -    print 'Advertisement registered'
> +    print('Advertisement registered')


>   def register_ad_error_cb(error):
> -    print 'Failed to register advertisement: ' + str(error)
> +    print('Failed to register advertisement: ' + str(error))
>       mainloop.quit()


> @@ -157,7 +163,7 @@ def find_adapter(bus):
>                                  DBUS_OM_IFACE)
>       objects = remote_om.GetManagedObjects()

> -    for o, props in objects.iteritems():
> +    for o, props in objects.items():
>           if LE_ADVERTISING_MANAGER_IFACE in props:
>               return o

> @@ -173,7 +179,7 @@ def main():

>       adapter = find_adapter(bus)
>       if not adapter:
> -        print 'LEAdvertisingManager1 interface not found'
> +        print('LEAdvertisingManager1 interface not found')
>           return

>       adapter_props = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME,
adapter),
> @@ -186,7 +192,7 @@ def main():

>       test_advertisement = TestAdvertisement(bus, 0)

> -    mainloop = gobject.MainLoop()
> +    mainloop = GObject.MainLoop()

>       ad_manager.RegisterAdvertisement(test_advertisement.get_path(), {},
>                                        reply_handler=register_ad_cb,
> --
> 2.7.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
