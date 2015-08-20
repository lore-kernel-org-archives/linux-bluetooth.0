Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Aug 2015 22:02:31 -0700
From: "Mark A. Haun" <haunma@keteu.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: IdleTimeout behavior for Sony PS3 remote in Bluez 5
Message-ID: <20150819220231.58a3b14f@angwin.home>
In-Reply-To: <CABBYNZK_Vy+o_XN9RSGrMVbnEMt=BHAkmpoyFmv5bK0PwCnXJw@mail.gmail.com>
References: <20150818220604.05b7a862@angwin.home>
	<CABBYNZLJQchUh7z1xCfmmuVq1Nexx3RYLB0AUq+DWUFpo-=gnw@mail.gmail.com>
	<CABBYNZ+qjOtB4=qba6DF+KY5wiYnhCFcMX4fPSrHRrVDx0R04w@mail.gmail.com>
	<20150819161441.GA8142@hau.nz>
	<CABBYNZK_Vy+o_XN9RSGrMVbnEMt=BHAkmpoyFmv5bK0PwCnXJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz and the group,

I captured a debug log from bluetoothd while testing the PS3 remote.  I'm not
sure it sheds any light on what is happening though.  When the timeout occurs
and the input device goes away, there is no log output from bluetoothd or the
kernel.

Here is the same test sequence as in my original post, with the bluetoothd
lots interspersed:

Press a key (or two) on the remote when it is not connected:

Aug 19 21:04:13 kolonia bluetoothd[11186]: src/adapter.c:connected_callback() hci0 device 00:21:4F:48:D1:D2 connected eir_len 5
Aug 19 21:04:13 kolonia bluetoothd[11186]: profiles/input/server.c:connect_event_cb() Incoming connection from 00:21:4F:48:D1:D2 on PSM 17
Aug 19 21:04:13 kolonia bluetoothd[11186]: profiles/input/device.c:input_device_set_channel() idev 0x7ff49ff8 psm 17
Aug 19 21:04:13 kolonia bluetoothd[11186]: profiles/input/server.c:confirm_event_cb() 
Aug 19 21:04:13 kolonia bluetoothd[11186]: profiles/input/server.c:connect_event_cb() Incoming connection from 00:21:4F:48:D1:D2 on PSM 19
Aug 19 21:04:13 kolonia bluetoothd[11186]: profiles/input/device.c:input_device_set_channel() idev 0x7ff49ff8 psm 19
Aug 19 21:04:13 kolonia bluetoothd[11186]: src/service.c:change_state() 0x7ff484a8: device 00:21:4F:48:D1:D2 profile input-hid state changed: disconnected -> connected (0)
Aug 19 21:04:13 kolonia bluetoothd[11186]: src/service.c:btd_service_ref() 0x7ff484a8: ref=3
Aug 19 21:04:13 kolonia bluetoothd[11186]: plugins/policy.c:service_cb() Added input-hid reconnect 0
Aug 19 21:04:13 kolonia kernel: [1244066.144277] input: BD Remote Control as /devices/soc0/7d004000.usb/usb1/1-1/1-1:1.0/bluetooth/hci0/hci0:256/0005:054C:0306.0006/input/input8
Aug 19 21:04:13 kolonia kernel: [1244066.158238] sony 0005:054C:0306.0006: input,hidraw1: BLUETOOTH HID v1.00 Gamepad [BD Remote Control] on ac:fd:ce:76:f2:4a

Input device is created; can run evemu-record and watch keypress events on
the remote.  After one minute of inactivity, the remote is still sending
packets (which can be seen in the hciconfig packet counter), but the kernel
input device has gone away.  No new messages in dmesg or in the bluetoothd
log at this time :(

<Time passes...>

Remote is still connected.  Forcibly disconnect using "hcitool dc 00:21:4f:48:d1:d2":

Aug 19 21:17:46 kolonia bluetoothd[11186]: src/adapter.c:dev_disconnected() Device 00:21:4F:48:D1:D2 disconnected, reason 2
Aug 19 21:17:46 kolonia bluetoothd[11186]: src/adapter.c:adapter_remove_connection() 
Aug 19 21:17:46 kolonia bluetoothd[11186]: plugins/policy.c:disconnect_cb() reason 2
Aug 19 21:17:46 kolonia bluetoothd[11186]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:21:4F:48:D1:D2 type 0 status 0xe
Aug 19 21:17:46 kolonia bluetoothd[11186]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Aug 19 21:17:46 kolonia bluetoothd[11186]: src/device.c:device_bonding_failed() status 14
Aug 19 21:17:46 kolonia bluetoothd[11186]: src/adapter.c:resume_discovery() 
Aug 19 21:17:46 kolonia bluetoothd[11186]: profiles/input/device.c:ctrl_watch_cb() Device 00:21:4F:48:D1:D2 disconnected
Aug 19 21:17:46 kolonia bluetoothd[11186]: profiles/input/device.c:intr_watch_cb() Device 00:21:4F:48:D1:D2 disconnected
Aug 19 21:17:46 kolonia bluetoothd[11186]: src/service.c:change_state() 0x7ff484a8: device 00:21:4F:48:D1:D2 profile input-hid state changed: connected -> disconnected (0)
Aug 19 21:17:46 kolonia bluetoothd[11186]: profiles/input/device.c:input_device_enter_reconnect_mode() path=/org/bluez/hci0/dev_00_21_4F_48_D1_D2 reconnect_mode=device

Now press keys on the remote, and it reconnects again:

Aug 19 21:19:22 kolonia bluetoothd[11186]: src/adapter.c:connected_callback() hci0 device 00:21:4F:48:D1:D2 connected eir_len 5
Aug 19 21:19:22 kolonia bluetoothd[11186]: profiles/input/server.c:connect_event_cb() Incoming connection from 00:21:4F:48:D1:D2 on PSM 17
Aug 19 21:19:22 kolonia bluetoothd[11186]: profiles/input/device.c:input_device_set_channel() idev 0x7ff49ff8 psm 17
Aug 19 21:19:22 kolonia bluetoothd[11186]: profiles/input/server.c:confirm_event_cb() 
Aug 19 21:19:22 kolonia bluetoothd[11186]: profiles/input/server.c:connect_event_cb() Incoming connection from 00:21:4F:48:D1:D2 on PSM 19
Aug 19 21:19:22 kolonia bluetoothd[11186]: profiles/input/device.c:input_device_set_channel() idev 0x7ff49ff8 psm 19
Aug 19 21:19:22 kolonia bluetoothd[11186]: src/service.c:change_state() 0x7ff484a8: device 00:21:4F:48:D1:D2 profile input-hid state changed: disconnected -> connected (0)
Aug 19 21:19:22 kolonia bluetoothd[11186]: plugins/policy.c:service_cb() Added input-hid reconnect 0
Aug 19 21:19:22 kolonia kernel: [1244975.379906] input: BD Remote Control as /devices/soc0/7d004000.usb/usb1/1-1/1-1:1.0/bluetooth/hci0/hci0:256/0005:054C:0306.0007/input/input9
Aug 19 21:19:22 kolonia kernel: [1244975.393392] sony 0005:054C:0306.0007: input,hidraw1: BLUETOOTH HID v1.00 Gamepad [BD Remote Control] on ac:fd:ce:76:f2:4a

and we can again see keypresses in evemu-record, until the next timeout.

About your other questions,

> > The PS3 remote is definitely one of those broken devices.  During
> > bluez 4.xx there were a set of unofficial patches maintained at
> > kitlaan.twinaxis.com (now defunct).
> 
> Patches to what exactly, BlueZ userspace, kernel?

They were patches to the bluez userspace distribution.  Much of it was
non-essential: timeout in seconds rather than minutes, and key-code
mapping for ease of integration with media software.  Details here:
https://www.mythtv.org/wiki/Sony_PS3_BD_Remote
 
> Note that using IdleTimeout affects every single HID that you connect
> over Bluetooth, which is why I think this is in the wrong place, it
> should probably be up to the PS3 remote driver to implement such
> policy to disconnect on idle. Either way I don't see another option
> other then to set the socket err so userspace can cleanup it own
> reference to the socket.

By "PS3 remote driver" you mean adding an exception for the Sony remote
in the evdev driver?  Because I don't think there is a PS3 remote driver
per se.  It's just a generic HID.

I agree that the blanket timeout is not a great solution but in my case
it would be sufficient, *if* it worked.  (I don't have any other
bluetooth HIDs to worry about.)

> >> Apparently the following lines were removed in the commit
> >> 5205185d461d5902325e457ca80bd421127b7308:
> >>
> >> -       /* Wakeup user-space polling for socket errors */
> >> -       session->intr_sock->sk->sk_err = EUNATCH;
> >> -       session->ctrl_sock->sk->sk_err = EUNATCH;
> >>
> >> Without this I doubt the userspace will realize that it should
> >> release the sockets which means this as been broken for over 2
> >> years and probably nobody realized up until today, it is probably
> >> only useful when IdleTimeout is set since it is the only case
> >> where the module itself device to remove the device and disconnect.

I don't know enough to understand what this was doing, but I see that
the source was heavily reworked in kernel 3.10...  If someone could
craft a patch against recent kernels (4.2) I would be happy to test
it.  As bluez 5 rolls out to more distros, I imagine there will be
more users wanting to know why their remote is broken :)

Thanks,
Mark
