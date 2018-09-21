Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5EDC8785-AB89-452A-AC80-E31A244A4467@intel.com>
References: <5EDC8785-AB89-452A-AC80-E31A244A4467@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 21 Sep 2018 21:47:31 +0300
Message-ID: <CABBYNZKArwJcBQG+45=5VHnQ9aEb1YLz_5Of74K2sRO==VcFYw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] test/example-advertisement: add shutdown code
To: "Hunt, Preston" <preston.hunt@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Preston,

On Fri, Sep 21, 2018 at 7:53 PM, Hunt, Preston <preston.hunt@intel.com> wrote:
> The previous sample code did not release all resources when shutting
> down. This is fine when it's a standalone program since Python will free
> all resources automatically when the process terminates. However, in a
> long-running process, this will eventually cause problems.
>
> This changeset shows how to properly release all resources. An optional
> command-line timeout argument controls the duration (if any).
> ---
>  test/example-advertisement | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
>
> diff --git a/test/example-advertisement b/test/example-advertisement
> index fd84eac..3d7873e 100755
> --- a/test/example-advertisement
> +++ b/test/example-advertisement
> @@ -2,19 +2,18 @@
>
>  from __future__ import print_function
>
> +import argparse
>  import dbus
>  import dbus.exceptions
>  import dbus.mainloop.glib
>  import dbus.service
> -
> -import array
> +import time
> +import threading
>
>  try:
> -  from gi.repository import GObject  # python3
> +    from gi.repository import GObject  # python3
>  except ImportError:
> -  import gobject as GObject  # python2
> -
> -from random import randint
> +    import gobject as GObject  # python2
>
>  mainloop = None
>
> @@ -136,6 +135,7 @@ class Advertisement(dbus.service.Object):
>      def Release(self):
>          print('%s: Released!' % self.path)
>
> +
>  class TestAdvertisement(Advertisement):
>
>      def __init__(self, bus, index):
> @@ -170,7 +170,16 @@ def find_adapter(bus):
>      return None
>
>
> -def main():
> +def shutdown(timeout):
> +    if timeout == 0:
> +        print('Advertising forever...')
> +        return
> +    print('Advertising for {} seconds...'.format(timeout))
> +    time.sleep(timeout)
> +    mainloop.quit()
> +
> +
> +def main(timeout):
>      global mainloop
>
>      dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
> @@ -183,7 +192,7 @@ def main():
>          return
>
>      adapter_props = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, adapter),
> -                                   "org.freedesktop.DBus.Properties");
> +                                   "org.freedesktop.DBus.Properties")
>
>      adapter_props.Set("org.bluez.Adapter1", "Powered", dbus.Boolean(1))
>
> @@ -198,7 +207,20 @@ def main():
>                                       reply_handler=register_ad_cb,
>                                       error_handler=register_ad_error_cb)
>
> +    threading.Thread(target=shutdown, args=(timeout,)).start()
> +
>      mainloop.run()
>
> +    ad_manager.UnregisterAdvertisement(test_advertisement)
> +    print('Advertisement unregistered')
> +    dbus.service.Object.remove_from_connection(test_advertisement)
> +
> +
>  if __name__ == '__main__':
> -    main()
> +    parser = argparse.ArgumentParser()
> +    parser.add_argument('--timeout', default=10, type=int, help="advertise " +
> +                        "for this many seconds then stop, 0=run forever " +
> +                        "(default: 10)")

Lets default to 0 so we maintain the same behavior as before.

> +    args = parser.parse_args()
> +
> +    main(args.timeout)
> --
> 2.7.4
>
>



-- 
Luiz Augusto von Dentz
