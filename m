Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Problem with hci_usb
Message-ID: <A1F0D47583A2D711919F00600819B3A45BDAFB@goofy.vitronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 3 Mar 2004 07:50:15 -0500

James,

Thanks very much for the instructions. I'll try this out today.

Best Regards,

Rich

-----Original Message-----
From: James Courtier-Dutton [mailto:James@superbug.demon.co.uk]
Sent: Tuesday, March 02, 2004 7:53 PM
To: Williams, Richard
Cc: BlueZ Mailing List
Subject: Re: [Bluez-devel] Problem with hci_usb


Williams, Richard wrote:
>=20
>>>>James Courtier-Dutton wrote:
>=20
>=20
> SCO support in bluez is still in development.
> Once it works correctly in 2.6.x, someone might back port it to 2.4.x, =

> but there is no point in back porting something until it is finished.
> Everything you describe above is "known issues".
>=20
> Cheers
> James
>=20
> <<<<<<<<
>=20
> Hi all,
>=20
> I'm trying to get my Linux machine to support audio to a headset. =
There's
> been several replies in the last week to my questions about SCO =
support=20
> in Linux. But I haven't found a package or instructions that explain =
how
> to get it to work. A couple of people have said "hstest" or "scotest", =
but
> nothing really works. Now I see the above posting. Does this mean I =
should=20
> abandon my headset work until SCO is working ?
>=20
> Regards,
>=20
> Rich
>=20

Steps required to get a headset paired and play/record sounds from it: -
You have to have: -
kernel 2.6.4 or 2.6.3 with bluez patches. (It might work with 2.4.x=20
kernels, but I have no idea if it works or not with them.)
Make sure you are root user for all of the following.

modprobe hci_usb   (If you have a usb dongle)
modprobe rfcomm
modprobe sco
hcid
sdpd
hciconfig hci0 up
bluepin <- Should return "ERR", if it returns some other error, get a=20
different version of bluepin.
remove any current "link_key" and "pin" files from /etc/bluetooth.

Get your headset into to "set up pairing" mode. (for me I just keep my=20
finger on the power on butter for 15 seconds, and it then flashes =
red/greed)

hcitool scan
That should return something like "00:0A:D9:48:00:6E       HBH-30"
00:0A:D9:48:00:6E is the bdaddr and will be used in following commands,=20
so substitute your own bdaddr.
l2ping  00:0A:D9:48:00:6E   <- This should pop up a window asking for=20
your pin.
Enter 0000 <- for may headset.
You should then get something like: -
l2ping  00:0A:D9:48:00:6E
Ping: 00:0A:D9:48:00:6E from 00:A0:96:1F:42:BF (data size 20) ...
20 bytes from 00:0A:D9:48:00:6E id 200 time 28.18ms
20 bytes from 00:0A:D9:48:00:6E id 201 time 20.93ms
20 bytes from 00:0A:D9:48:00:6E id 202 time 15.99ms
20 bytes from 00:0A:D9:48:00:6E id 203 time 27.02ms

This means you now have your devices paired.
This will create a "/etc/bluetooth/link_key" file.

hstest record test1.wav 00:0A:D9:48:00:6E 1
This should output: -
Voice setting: 0x0060
RFCOMM channel connected
SCO audio channel connected (handle 43, mtu 64)
AT*ECBP=3D?
AT+VGS=3D15


and then record sound from the headset.

hstest record test1.wav 00:0A:D9:48:00:6E 1
to playback to the sound on the headset.

Cheers
James












-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
