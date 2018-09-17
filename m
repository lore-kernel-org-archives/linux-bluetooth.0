Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DBD047A0-7CFC-4A66-B721-6BDC717D644A@intel.com>
References: <DBD047A0-7CFC-4A66-B721-6BDC717D644A@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Sep 2018 16:13:38 +0300
Message-ID: <CABBYNZ+5_0DEDUqvzU61Ru8VqjkTBc+3r4wNyFCaHBNdzMdUaQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] test/example-advertisement: add shutdown code
To: "Hunt, Preston" <preston.hunt@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Preston,

On Wed, Sep 12, 2018 at 5:57 PM, Hunt, Preston <preston.hunt@intel.com> wrote:
> The previous sample code did not release all resources when shutting
> down. This is fine when it's a standalone program since Python will free
> all resources automatically when the process terminates. However, in a
> long-running process, this will eventually cause problems.

I would add the timeout as argument to the tool e.g.
example-advertisement --timeout=10

>
> This changeset shows how to properly release all resources.
> ---
>  test/example-advertisement | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/test/example-advertisement b/test/example-advertisement
> index fd84eac..1db61d6 100755
> --- a/test/example-advertisement
> +++ b/test/example-advertisement
> @@ -6,15 +6,13 @@ import dbus
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
> @@ -136,6 +134,7 @@ class Advertisement(dbus.service.Object):
>      def Release(self):
>          print('%s: Released!' % self.path)
>
> +
>  class TestAdvertisement(Advertisement):
>
>      def __init__(self, bus, index):
> @@ -170,6 +169,12 @@ def find_adapter(bus):
>      return None
>
>
> +def shutdown():
> +    print('Advertising for 10 seconds...')
> +    time.sleep(10)
> +    mainloop.quit()
> +
> +
>  def main():
>      global mainloop
>
> @@ -183,7 +188,7 @@ def main():
>          return
>
>      adapter_props = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, adapter),
> -                                   "org.freedesktop.DBus.Properties");
> +                                   "org.freedesktop.DBus.Properties")
>
>      adapter_props.Set("org.bluez.Adapter1", "Powered", dbus.Boolean(1))
>
> @@ -198,7 +203,13 @@ def main():
>                                       reply_handler=register_ad_cb,
>                                       error_handler=register_ad_error_cb)
>
> +    threading.Thread(target=shutdown).start()
> +
>      mainloop.run()
>
> +    ad_manager.UnregisterAdvertisement(test_advertisement)
> +    print('Advertisement unregistered')
> +    dbus.service.Object.remove_from_connection(test_advertisement)
> +
>  if __name__ == '__main__':
>      main()
> --
> 2.7.4
>



-- 
Luiz Augusto von Dentz
