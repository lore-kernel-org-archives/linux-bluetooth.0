Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Connection Timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Quattlebaum <stephen@covidimus.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1099102859.9167.32.camel@athene.covidimus.net>
References: <1099090255.12760.26.camel@athene.covidimus.net>
	 <1099091721.6912.35.camel@pegasus>
	 <1099102859.9167.32.camel@athene.covidimus.net>
Content-Type: text/plain
Message-Id: <1099143445.10448.11.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 30 Oct 2004 15:37:25 +0200

Hi Stephen,

> > This is the new dongle from Microsoft and it is now Broadcom based and
> > so you maybe need an additional patch to make it working. When it works,
> > send back the output from "hciconfig -a".
> 
> Your patch worked.  Thanks!
> 
> athene root # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:50:F2:E8:E5:90 ACL MTU: 377:10  SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:38552 acl:1826 sco:0 events:404 errors:0
>         TX bytes:6265 acl:155 sco:0 commands:106 errors:0
>         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x100100
>         Service Classes: Object Transfer
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x3 LMP Ver: 1.2 (0x2) LMP Subver:
> 0x800
>         Manufacturer: Broadcom Corporation (15)
> 

this Broadcom stuff is always a little bit problematic. If you like you
can test it without HCI_BROKEN_ISOC. Maybe they fixed their firmware now
and the SCO audio stuff works.

Oh and send in the output of "hcitool info ..." as root from the mouse
and the keyboard. And the results from "sdptest records ..." from the
libs2 CVS test directory would also be helpful.

> > Btw I need this new desktop package from Microsoft for testing. Is
> > there anyone willing to donate one?
> 
> Would if I could!  I really shouldn't have even spent the money on
> _mine_ right now... :-)

Anyone else who don't mind sending me another mouse and keyboard
combination?

> Now that the device is recognized, I have successfully synced w/ my T600
> using multisync and gotten the mouse to work.  Buttons 3-5 and the
> scrollwhell even work (though I still need to remap what they do...)
> The mouse is still a little hokey, though.  Perhaps someone can help me
> out here.  I think I know what's going on, but I don't know what, if
> any, is the proper way to fix things.
> 
> 1. hid2hci was not necessary.  As soon as I did "hciconfig hci0 up"
> post-patch, the mouse immediately _stopped_ working until I got it to
> work using hci below.  Apparently, when the dongle was initialized for
> hci it stopped whatever hid jiggery it might have been doing (Henryk
> hypothesized that it was spoofing itself as a standard USB mouse).  If
> that is correct, I actually think it's a nice bit of behavior, since it
> stops as soon as the OS proves that it knows what bluetooth is, thank
> you very much.  A bit of random extra info, though: when the device was
> in its apparent hid spoofing mode, there were _two_ extra mice devices
> in /dev/input.  My USB mouse is mouse0, and "cat mouse2" proved that the
> BT mouse was mouse2.  I don't know what mouse1 was... "cat mouse1" never
> had any output when I moved either mouse.  Now that the mouse is working
> in HCI mode, it's at /dev/input/mouse1 and I have no mouse2.

This thing is called HID Proxy and was invented by CSR. For these kind
of devices like the Logitech the switching is triggered by the tool
hid2hci, but Broadcom decided to trigger it on the HCI reset command. I
actually prefer the hid2hci approach, because sometimes the operating
system wants to switch to full Bluetooth mode later to get some time to
start some other services first.

Your device thing is input subsystem specific and I prefer to
use /dev/input/mice as common device for all attached mice.

> 2. In order to get the mouse to work, (since it was earlier paired to an
> XP SP2 machine, I'm guessing), I had to follow the instructions at
> http://www.bueche.ch/comp/mx900/mx900.html (which is actually for a
> logitek mouse, but worked).  I did "hidd --connect 00:50:f2:e8:fb:f2" to
> "poke" the mouse, whereafter it started working.  Before I got to that
> point, I had tried moving it back to the XP machine temporarily, and
> ended up having to remove the mouse profile from that XP machine and
> re-scan for it - not even a reboot of both the mouse (removing both
> batteries) and the OS fixed it but the remove/rescan did.  The dongle
> moved with the mouse when I switched computers (I only have one dongle
> right now).  So, for both XP and Linux, I had to manually reconnect
> before the mouse would work after talking to the other OS.  I don't
> actually plan on moving this mouse between the two a lot, but I _could_
> potentially have this mouse or another one like it on a USB KVM at some
> point in the future, so this behavior dissapoints me a little.  I think
> I understand - the mouse can only be paired to one PC at a time b/c
> otherwise it'd be moving cursors on two screens at once if both are in
> range, but surely there's an easy way to say, "you're on this PC now"
> that doesn't involve remembering or looking up the device ID (or going
> through the add/remove BT device wizard in XP).  I had hoped that the
> mouse actually paired to the adapter, in which case it should, in
> theory, work on a KVM, but its behavior makes it look like it pairs to
> the PC.  Is that right?  Any suggestions on these issues?  (A pointer to
> appropriate documentation will be more than sufficient, if I'm just
> being blind :-) )

The Broadcom guys are a little bit stupid and also implemented security
mode 3 for the mouse even if the HID specification said that this is not
really needed. So you must share your link key between the two operating
systems and that is the problem here.

> 3. Right after I got the mouse working with HCI, I walked away from the
> PC for a few minutes.  When I came back, the mouse wasn't working
> anymore.  I know this mouse goes to sleep after a while, but at least on
> the XP machine it wakes back up when you move it.  It didn't on linux,
> and I had to use hidd to poke it again.  After that first time, however,
> it hasn't happened again, even when I left it sitting for a while.
> Weird behavior... should I expect to have to hidd-poke the mouse anytime
> I walk away for a while?  (Surely not...)

Start "hidd --server" on boot and your mouse can reconnect.

> 4. usbview still shows the device as red, though it's working fine, so
> here's independent verification of Henryk's observation that it
> apparently doesn't matter.

I don't know what red means, but I wouldn't care. If the kernel says
that it works, everything is fine.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
