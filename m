Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1452793643.1830.16.camel@redhat.com>
Subject: Re: bluetoothd crash when registering advertisement
From: Nathaniel McCallum <npmccallum@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 14 Jan 2016 12:47:23 -0500
In-Reply-To: <CABBYNZK024x77WYqiCrjX7GXXPU46zjNFhhhmrVd-y-XK4gWmw@mail.gmail.com>
References: <1452726452.1830.3.camel@redhat.com>
	 <CABBYNZK024x77WYqiCrjX7GXXPU46zjNFhhhmrVd-y-XK4gWmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2016-01-14 at 13:02 -0300, Luiz Augusto von Dentz wrote:
> Hi Nathaniel,
> 
> On Wed, Jan 13, 2016 at 8:07 PM, Nathaniel McCallum
> <npmccallum@redhat.com> wrote:
> > I added advertisement support to my application today:
> > https://git.fedorahosted.org/cgit/jelling/linux.git/commit/?id=e040
> > 16c8
> > b7f0d406b39573863cf7d5e15dac53ed
> > 
> > When registering the advertisement with bluez, bluetoothd crashes:
> > #0  0x00007f1f01ce6618 in __GI_raise (sig=sig@entry=6) at
> > ../sysdeps/unix/sysv/linux/raise.c:54
> > #1  0x00007f1f01ce821a in __GI_abort () at abort.c:89
> > #2  0x00007f1f024bc894 in _dbus_abort () at ../../dbus/dbus-
> > sysdeps.c:91
> > #3  0x00007f1f024b331e in _dbus_warn_check_failed (
> >     format=0x7f1f024c2d10 "arguments to %s() were incorrect,
> > assertion
> > \"%s\" failed in file %s line %d.\nThis is normally a bug in some
> > application using the D-Bus library.\n") at ../../dbus/dbus-
> > internals.c:275
> 
> Is your application still connected to D-Bus when that happens?

Yes. Restarting bluez results in the same crash happening again as my
app sees the new interface and attempts to register again.

> > As this was my first attempt at implementing advertisement support,
> > I
> > may be doing something wrong. If I am, your tips are appreciated!
> > However, in any case, bluez shouldn't crash.
> 
> We will definitely have to fix the crash but it would help if you
> share more information, like how your application is implemented and
> have access to bluetoothd logs before it crashes.

The entire application is a trivial, one file open source daemon. Feel
free to look at it. Here is an overview in pseudo-code (function names
correspond to the real functions):

on_bt_iface(conn, iface) {
  if (iface_has_adv_man(iface)) {
    dbus_call(conn, iface, "RegisterAdvertisement", "/");
  }
}

main() {
  conn = dbus_connect();
  make_advertisement_object(conn, "/");
  listen_for_bluetooth_interfaces(conn, on_bt_iface);
  main_loop();
}

My app never destroys its advertisement object or dbus connection. The
process runs this way until it is killed.

The bluetoothd logs are:

Jan 14 12:45:21 localhost.localdomain bluetoothd[13745]:
src/advertising.c:parse_advertising_service_uuids() Adding ServiceUUID:
B670003C-0079-465C-9BA7-6C0539CCD67F
Jan 14 12:45:21 localhost.localdomain bluetoothd[13745]:
src/advertising.c:refresh_advertisement() Refreshing advertisement: /
Jan 14 12:45:21 localhost.localdomain bluetoothd[13745]:
src/advertising.c:parse_advertising_service_uuids() Adding ServiceUUID:
B670003C-0079-465C-9BA7-6C0539CCD67F
Jan 14 12:45:21 localhost.localdomain bluetoothd[13745]:
src/advertising.c:refresh_advertisement() Refreshing advertisement: /
Jan 14 12:45:21 localhost.localdomain bluetoothd[13745]:
src/advertising.c:add_advertising_callback() Advertisement registered:
/
Jan 14 12:45:21 localhost.localdomain bluetoothd[13745]: process 13745:
arguments to dbus_message_new_method_return() were incorrect, assertion
"method_call != NULL" failed in file ../../dbus/dbus-message.c line
1378.
Jan 14 12:45:21 localhost.localdomain bluetoothd[13745]: This is
normally a bug in some application using the D-Bus library.
Jan 14 12:45:21 localhost.localdomain bluetoothd[13745]: D-Bus not
built with -rdynamic so unable to print a backtrace
Jan 14 12:45:21 localhost.localdomain systemd[1]: bluetooth.service:
Main process exited, code=dumped, status=6/ABRT
Jan 14 12:45:21 localhost.localdomain systemd[1]: bluetooth.service:
Unit entered failed state.
Jan 14 12:45:21 localhost.localdomain systemd[1]: bluetooth.service:
Failed with result 'core-dump'.
