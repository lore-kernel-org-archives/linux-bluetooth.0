Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Jun 2011 20:11:46 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Michael Jarosch <mitsch@riotmusic.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluetooth on ubuntu without desktop environment
Message-ID: <20110607231146.GB8705@piper>
References: <1307131935.1862.189.camel@powermacG4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307131935.1862.189.camel@powermacG4>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On 22:12 Fri 03 Jun, Michael Jarosch wrote:
> Hi!
> 
> I'm using the latest Ubuntu (11.04) minimal installation with XBMC and I
> try to make a Logitech Cordless MediaBoard Pro work with it. The
> keyboard-/touchpad-combination designed for the PS3 worked just fine
> with a "normal" install of Ubuntu 10.10 with the Gnome desktop
> environment (and I guess it should work with 11.04/Unity, also). My
> special problem now is, that I don't use any kind of desktop environment
> any more, it's just X and the XBMC-GUI. I tried to use "blueman" to
> configure the bluetooth connection, but it doesn't seem to start - just
> getting some weird errors. So, I totally depend on the console-tools of
> bluez and dbus - but, hey, this is linux and it shouldn't be a problem,
> right?
> 
> Well, partly, it actually isn't. Pairing and connecting the keyboard
> works right away. But if I reboot the computer or try to reconnect the
> keyboard for other reasons, I'm forced to pair the devices again and
> again, which isn't exactly the spirit of using bluetooth devices. :)
> 
> My goal is to make the keyboard connect to my PC whenever I need it. All
> I achieved is that the connection only works if the PC initialises it.
> 
> 
> I used an entry from the arch linux wiki for my configuration, which
> only uses console-commands, mainly dbus-specific:
> https://wiki.archlinux.org/index.php/Bluetooth_mouse_configuration
> 
> 
> I tried this:
> 
> 1) Pressing the reset button of the Logitech-device to make it
> discoverable to the PC.
> 
> 2) Scanning for the Logitech-device with "hcitool scan". I get this
> answer from the kyeboard:
> 00:07:61:F6:97:F7   Logitech Cordless MediaBoard Pro(TM)
> 
> 3) Getting the dbus adress of the BT-Dongle:
> $ dbus-send --system --type=method_call --print-reply --dest=org.bluez
> "/" org.bluez.Manager.ListAdapters
> 
> method return sender=:1.23 -> dest=:1.26 reply_serial=2
>    array [
>       object path "/org/bluez/1926/hci0"
>    ]
> 
> 4) Create the bluez-device for the keyboard:
> $ dbus-send --system --type=method_call --print-reply --dest=org.bluez
> "/org/bluez/1926/hci0" org.bluez.Adapter.CreateDevice
> string:00:07:61:F6:97:F7
> 
> 5) Give keyboard permission to connect the PC:
> $ dbus-send --system --type=method_call --print-reply --dest=org.bluez
> "/org/bluez/1926/hci0/dev_00_07_61_F6_97_F7"
> org.bluez.Device.SetProperty string:Trusted variant:boolean:true
> 

I didn't read the Arch wiki closely, but there are much better ways to that.
This is what I would do:

1. Get the BlueZ sources, and go to the test/ directory;

2. ./simple-agent hci0 <keyboard address> 
   (follow the instructions from the keyboard for pairing, usually putting the
   same passkey in both sides). This will pair your computer with the
   keyboard. If it complains about that the pairing already exists, just add a
   third parameter, it can be anything.

3. ./test-device trusted <keyboard address> yes
   This will set the device as trusted, so connection comming from it will
   be automatically accepted.

4. Now as the device is already bonded and connections are automatically
   accepted, reconnections should work as they should.

Some notes: those are simple python scripts, be sure to have python already
installed. In case you still have some troubles drop by #bluez-users on 
freenode.

> 
> I can connect the Logitech-device with hidd --connect 00:07:61:F6:97:F7,
> now, but if the connection somehow breaks, it's not possible to
> reconnect from the keyboard (by just pressing a button or turning the
> device off and on, f.e.)
> 

[ snip ]


Cheers,
-- 
Vinicius
