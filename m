Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Aug 2015 22:06:04 -0700
From: "Mark A. Haun" <haunma@keteu.org>
To: linux-bluetooth@vger.kernel.org
Subject: IdleTimeout behavior for Sony PS3 remote in Bluez 5
Message-ID: <20150818220604.05b7a862@angwin.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There were no replies to this question two weeks ago, so I'm trying
again.  If there exists documentation which I am missing, I'd be happy
to be directed to RTFM, but as far as I can tell, the Bluez 5 userspace
is undocumented.  That would make this list my only recourse :(
--Mark

---

I've successfully attached a PS3 bluetooth remote to a Debian Jessie
system running bluez 5.23.  In bluetoothctl it appears as

Device 00:21:4F:48:D1:D2
        Name: BD Remote Control
        Alias: BD Remote Control
        Class: 0x00250c
        Paired: no
        Trusted: yes
        Blocked: no
        Connected: yes
        LegacyPairing: no
        UUID: Human Interface Device...
(00001124-0000-1000-8000-00805f9b34fb) UUID: PnP Information
(00001200-0000-1000-8000-00805f9b34fb) Modalias: usb:v054Cp0306d0100

(Note that it is not paired.  I believe this is the normal, operational
state even though everyone refers to the setup process as "pairing."
See e.g. https://www.mythtv.org/wiki/Sony_PS3_BD_Remote)

Upon first connection, an input device is created:

[87044.559923] input: BD Remote Control as /devices/soc0/7d004000.usb/usb1/1-1/1-1:1.0/bluetooth/hci0/hci0:256/0005:054C:0306.0005/input/input7
[87044.573409] sony 0005:054C:0306.0005: input,hidraw1: BLUETOOTH HID v1.00 Gamepad [BD Remote Control] on ac:fd:ce:76:f2:4a

and I can watch keypresses using evemu-record.  So far, so good.

I have set IdleTimeout=1 in /etc/bluetooth/input.conf.  My
understanding is that this should disconnect from the remote after one
minute of inactivity.  What I find, however, is that after exactly one
minute, the *input device* disappears (i.e. no longer listed
in /proc/bus/input/devices) but the connection to the remote remains
active.  Ten or twenty minutes later, it still shows as "Connected" in
bluetoothctl or hcitool con:

Connections:
        > ACL 00:21:4F:48:D1:D2 handle 256 state 1 lm MASTER   

Pressing buttons on the remote at this stage does not bring back the
input device, although hciconfig shows that packets are being
received.  If I forcibly disconnect (hcitool dc 00:21:4F:48:D1:D2), and
then press a button on the remote, the connection is automatically
re-established, along with the input device, and input events are
available until the next timeout.

Automatic disconnect is important due to limited battery life in the
remote.  How can I achieve this?  My recollection is that this worked in
older bluez releases (pre-5).  For a long time there were patches
floating around, but I thought those found their way back to the
mainline.
