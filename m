Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40452C53.4090506@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with hci_usb
References: <A1F0D47583A2D711919F00600819B3A45BDAFA@goofy.vitronics.com>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A45BDAFA@goofy.vitronics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 03 Mar 2004 00:52:35 +0000

Williams, Richard wrote:
> 
>>>>James Courtier-Dutton wrote:
> 
> 
> SCO support in bluez is still in development.
> Once it works correctly in 2.6.x, someone might back port it to 2.4.x, 
> but there is no point in back porting something until it is finished.
> Everything you describe above is "known issues".
> 
> Cheers
> James
> 
> <<<<<<<<
> 
> Hi all,
> 
> I'm trying to get my Linux machine to support audio to a headset. There's
> been several replies in the last week to my questions about SCO support 
> in Linux. But I haven't found a package or instructions that explain how
> to get it to work. A couple of people have said "hstest" or "scotest", but
> nothing really works. Now I see the above posting. Does this mean I should 
> abandon my headset work until SCO is working ?
> 
> Regards,
> 
> Rich
> 

Steps required to get a headset paired and play/record sounds from it: -
You have to have: -
kernel 2.6.4 or 2.6.3 with bluez patches. (It might work with 2.4.x 
kernels, but I have no idea if it works or not with them.)
Make sure you are root user for all of the following.

modprobe hci_usb   (If you have a usb dongle)
modprobe rfcomm
modprobe sco
hcid
sdpd
hciconfig hci0 up
bluepin <- Should return "ERR", if it returns some other error, get a 
different version of bluepin.
remove any current "link_key" and "pin" files from /etc/bluetooth.

Get your headset into to "set up pairing" mode. (for me I just keep my 
finger on the power on butter for 15 seconds, and it then flashes red/greed)

hcitool scan
That should return something like "00:0A:D9:48:00:6E       HBH-30"
00:0A:D9:48:00:6E is the bdaddr and will be used in following commands, 
so substitute your own bdaddr.
l2ping  00:0A:D9:48:00:6E   <- This should pop up a window asking for 
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
AT*ECBP=?
AT+VGS=15


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
