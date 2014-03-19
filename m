Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1395228873-32719-2-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1395228873-32719-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1395228873-32719-2-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Wed, 19 Mar 2014 20:11:45 +0100
Message-ID: <CAOJw-HYsep+gVgFyE77-hwyGzKFusE4wwr4W9gCASAeaGVTP6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: Fix cyclingspeed manager interface name
From: Markus Roppelt <markus.roppelt@peus-testing.de>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

How are you testing the cycling speed?
I get an error like this (with watcher or manager interface):

[markus@localhost test]$ ./test-cyclingspeed -b D1:83:15:3C:26:F0
Traceback (most recent call last):
  File "./test-cyclingspeed", line 153, in <module>
    cscmanager.RegisterWatcher(
watcher_path)
  File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 70, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 145, in __call__
    **keywords)
  File "/usr/lib/python2.7/site-packages/dbus/connection.py", line
651, in call_blocking
    message, timeout)
dbus.exceptions.DBusException:
org.freedesktop.DBus.Error.UnknownMethod: Method "RegisterWatcher"
with signature "s" on interface "org.bluez.CyclingSpeedManager1"
doesn't exist

I compiled with ./configure --enable-experimental
and then changed in /usr/lib/systemd/system/bluetooth.service to start
with the experimental flag:
ExecStart=/usr/local/libexec/bluetooth/bluetoothd -E

Is there anything else I need to do?

Greetings
 Markus

2014-03-19 12:34 GMT+01:00 Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>:
> ---
>  test/test-cyclingspeed | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/test-cyclingspeed b/test/test-cyclingspeed
> index 4b8d841..393f79c 100755
> --- a/test/test-cyclingspeed
> +++ b/test/test-cyclingspeed
> @@ -144,7 +144,7 @@ if __name__ == "__main__":
>         device_path = device.object_path
>
>         cscmanager = dbus.Interface(bus.get_object(BUS_NAME, adapter_path),
> -                                               CYCLINGSPEED_WATCHER_INTERFACE)
> +                                               CYCLINGSPEED_MANAGER_INTERFACE)
>
>         watcher_path = "/test/watcher"
>         watcher = Watcher(bus, watcher_path)
> --
> 1.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
