Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Feb 2008 03:38:56 +0100 (CET)
From: Leszek Koltunski <leszek@3miasto.net.pl>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BLU140-W76F2261C8313336A0D258CB200@phx.gbl>
Message-ID: <20080218031930.M61651@3miasto.net.pl>
References: <BLU140-W76F2261C8313336A0D258CB200@phx.gbl>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Connecting to a two-way headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net




> I have several bluetooth-related Debian packages installed, for 
> example: "bluetooth" (3.24-1+b1); "bluetooth-alsa" (0.5cvs20070327-1); 
> "bluetooth-audio" (3.4-1+b1);  "bluez-gnome" (0.13-1); "bluez-utils"
> (3.24-1+b1); "gnome-bluetooth" (0.9.1-1); "gnome-vfs-obexftp" (0.4-1); 
> "libbluetooth2" (3.24-1); "libbtctl4" (0.9.0-2); libgnomebt0 (0.9.1-1); 
> "libsbc0" (0.0cvs20070728-1); etc.  (This, according to Synaptic.)

You have a strange mixture of packages. If all you're trying to do 
(bluetooth-wise) is use your bt headset, those are all the packages you 
need:

- bluez-gnome
- bluez-utils
- bluez-audio 
- libbluetooth2

'bluetooth' is just a metapackage (empty package that pulls in all 
bluetooth-related things ) bluetooth-alsa is a part of an older project, 
not related to this ML. 'bluetooth-audio' - ditto. gnome-bluetooth - I 
have no idea. gnome-vfs-obexftp - that's for browsing remote filesystems 
over bluetooth. libbtctl4, libgnomebt0, libsbc0 - obsolete libraries


> From the headset's user's manual, I have learned that to connect it to 
>another device, I must first "prepare" the headset - which I assume 
> means put it into "pairing" mode by pressing both volume-up and 
> volume-down buttons simultaneously until the LED alternates red/green.
>
> I learned from various sources on the net, that to connect my computer 
> to the headset, as the root user I must run the command:
>
> hcitool scan
>
> to discern the headset's (what-I'm-calling-"MAC") address:
>
> Scanning ...
> 	00:1C:A4:20:CE:BE	HBH-PV702
>
> And, once I have that address, I can use it with the hcitool cc command 
> to connect to the headset
>
> hcitool cc 00:1C:A4:20:CE:BE
>

No, that's not true. Since you're already paired with the Headset, all you 
need to do now is start playing music :) ( and possibly switch the audio 
service on ) 
Follow http://wiki.bluez.org/wiki/HOWTO/AudioDevices

> I have a what is called a "Bluetooth Applet" in what I call my 
> desktop's taskbar.  When I right-click on it and select "Browse 
Devices", I get a one-item list of devices: "HBH-PV702 Headset".

Cool! that means you're paired already. No need to do any 'hcitool scan - 
hcitool cc' magic anymore.

The first time I ran
>
> hcitool info 00:1C:A4:20:CE:BE
>
> I was prompted by a graphical (rather than command-line) prompt 
> (seemingly from the applet) saying "Pairing request for device:
> HBH-PV702 (00:1C:A4:20:CE:BE) Enter passkey for authentication:"
>
> I entered "0000" (as mentioned in the headset's user's manual) and 
> clicked the prompt's "OK" button, and the following was then
> printed in the command-prompt window where I had entered the hcitool 
> info command:

That was the pairing process. As you say, a one-time phenomenon.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
