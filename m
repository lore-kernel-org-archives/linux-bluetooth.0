Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Aug 2015 12:32:57 +0200
From: Antonio Ospite <ao2@ao2.it>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Mark A. Haun" <haunma@keteu.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: IdleTimeout behavior for Sony PS3 remote in Bluez 5
Message-Id: <20150820123257.9da221075f808f322b02dce8@ao2.it>
In-Reply-To: <CABBYNZ+w2EiecMLp-NjA59u=LVsSD4TxCqLZB-zmWXFsaDi=pw@mail.gmail.com>
References: <20150818220604.05b7a862@angwin.home>
	<CABBYNZLJQchUh7z1xCfmmuVq1Nexx3RYLB0AUq+DWUFpo-=gnw@mail.gmail.com>
	<CABBYNZ+qjOtB4=qba6DF+KY5wiYnhCFcMX4fPSrHRrVDx0R04w@mail.gmail.com>
	<20150819161441.GA8142@hau.nz>
	<CABBYNZK_Vy+o_XN9RSGrMVbnEMt=BHAkmpoyFmv5bK0PwCnXJw@mail.gmail.com>
	<20150819220231.58a3b14f@angwin.home>
	<CABBYNZ+w2EiecMLp-NjA59u=LVsSD4TxCqLZB-zmWXFsaDi=pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I helped with the kernel HID driver, but I do not know much about the
bluetooth side of the story, some comments below tho.

On Thu, 20 Aug 2015 11:52:02 +0300
Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> Hi Mark,
> 
> On Thu, Aug 20, 2015 at 8:02 AM, Mark A. Haun <haunma@keteu.org> wrote:
> > Hi Luiz and the group,
> >
> > I captured a debug log from bluetoothd while testing the PS3 remote.  I'm not
> > sure it sheds any light on what is happening though.  When the timeout occurs
> > and the input device goes away, there is no log output from bluetoothd or the
> > kernel.
> >
> > Here is the same test sequence as in my original post, with the bluetoothd
> > lots interspersed:
> >
> > Press a key (or two) on the remote when it is not connected:
> >
> > Aug 19 21:04:13 kolonia bluetoothd[11186]: src/adapter.c:connected_callback() hci0 device 00:21:4F:48:D1:D2 connected eir_len 5
> > Aug 19 21:04:13 kolonia bluetoothd[11186]: profiles/input/server.c:connect_event_cb() Incoming connection from 00:21:4F:48:D1:D2 on PSM 17
> > Aug 19 21:04:13 kolonia bluetoothd[11186]: profiles/input/device.c:input_device_set_channel() idev 0x7ff49ff8 psm 17
> > Aug 19 21:04:13 kolonia bluetoothd[11186]: profiles/input/server.c:confirm_event_cb()
> > Aug 19 21:04:13 kolonia bluetoothd[11186]: profiles/input/server.c:connect_event_cb() Incoming connection from 00:21:4F:48:D1:D2 on PSM 19
> > Aug 19 21:04:13 kolonia bluetoothd[11186]: profiles/input/device.c:input_device_set_channel() idev 0x7ff49ff8 psm 19
> > Aug 19 21:04:13 kolonia bluetoothd[11186]: src/service.c:change_state() 0x7ff484a8: device 00:21:4F:48:D1:D2 profile input-hid state changed: disconnected -> connected (0)
> > Aug 19 21:04:13 kolonia bluetoothd[11186]: src/service.c:btd_service_ref() 0x7ff484a8: ref=3
> > Aug 19 21:04:13 kolonia bluetoothd[11186]: plugins/policy.c:service_cb() Added input-hid reconnect 0
> > Aug 19 21:04:13 kolonia kernel: [1244066.144277] input: BD Remote Control as /devices/soc0/7d004000.usb/usb1/1-1/1-1:1.0/bluetooth/hci0/hci0:256/0005:054C:0306.0006/input/input8
> > Aug 19 21:04:13 kolonia kernel: [1244066.158238] sony 0005:054C:0306.0006: input,hidraw1: BLUETOOTH HID v1.00 Gamepad [BD Remote Control] on ac:fd:ce:76:f2:4a
> >
> > Input device is created; can run evemu-record and watch keypress events on
> > the remote.  After one minute of inactivity, the remote is still sending
> > packets (which can be seen in the hciconfig packet counter), but the kernel
> > input device has gone away.  No new messages in dmesg or in the bluetoothd
> > log at this time :(
> >
> > <Time passes...>
> >
> > Remote is still connected.  Forcibly disconnect using "hcitool dc 00:21:4f:48:d1:d2":
>

This makes me think that a udev rule can detect the kernel input device
disconnection, and then force the bluetooth disconnection.

[...]
> > and we can again see keypresses in evemu-record, until the next timeout.
> >
> > About your other questions,
> >
> >> > The PS3 remote is definitely one of those broken devices.  During
> >> > bluez 4.xx there were a set of unofficial patches maintained at
> >> > kitlaan.twinaxis.com (now defunct).
> >>
> >> Patches to what exactly, BlueZ userspace, kernel?
> >
> > They were patches to the bluez userspace distribution.  Much of it was
> > non-essential: timeout in seconds rather than minutes, and key-code
> > mapping for ease of integration with media software.  Details here:
> > https://www.mythtv.org/wiki/Sony_PS3_BD_Remote
> >
> >> Note that using IdleTimeout affects every single HID that you connect
> >> over Bluetooth, which is why I think this is in the wrong place, it
> >> should probably be up to the PS3 remote driver to implement such
> >> policy to disconnect on idle. Either way I don't see another option
> >> other then to set the socket err so userspace can cleanup it own
> >> reference to the socket.
> >
> > By "PS3 remote driver" you mean adding an exception for the Sony remote
> > in the evdev driver?  Because I don't think there is a PS3 remote driver
> > per se.  It's just a generic HID.
> 
> I think we might have a driver for PS3 after all, you can see from
> dmesg that it is detected as a Gamepad [BD Remote Control] or is that
> just the game of the device?
>

There is a HID driver, because the original descriptor had to be
overridden in order to get useful events, but it's just HID, no
explicit dependencies on input or bluetooth.

[...]
> > I don't know enough to understand what this was doing, but I see that
> > the source was heavily reworked in kernel 3.10...  If someone could
> > craft a patch against recent kernels (4.2) I would be happy to test
> > it.  As bluez 5 rolls out to more distros, I imagine there will be
> > more users wanting to know why their remote is broken :)
> 
> Well you are the first one to complain, so either people are stuck
> with very only kernel or they don't care if the controller stay always
> connected.
>

Or they just remove the batteries when not using the remote, and are
even thinking about adding a physical ON/OFF switch to the remote...

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
