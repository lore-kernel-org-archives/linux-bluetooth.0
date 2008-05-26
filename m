Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 May 2008 05:44:02 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <48379DBC.50504@judebert.com>
Message-ID: <alpine.LNX.1.00.0805251428300.13798@nge2.ngu.pk>
References: <48336FD4.9040803@judebert.com>
	<F60A3CE9E807BE49B5F56BD80B894D20016883DF@sc-exch03.marvell.com>
	<48379DBC.50504@judebert.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Syncing a Treo 680
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



On Sat, 24 May 2008, bluez-users.10.judebert@spamgourmet.com wrote:

-> I gave both pages a fair shake.  Short story: I'm still willing to provide
-> $20 for a walkthrough.  Long story: I had the following problems:

I don't have a Treo, or have seen one, but maybe I can help on the bluez 
side of things.

-> > http://www.gurulabs.com/goodies/Using_Linux_and_Bluetooth_DUN_with_the_Treo650.php
-> > 
-> That page is set up for Red Hat.  Debian doesn't have the bluez-pin package,
-> and its hcid.conf is a little different: it contains the PIN, and doesn't
-> have a dbus_pin_helper (not in any of the packages, either). There's also no
-> system-config-security-level.  Nevertheless, everything seems to go well,
-> until I enter my PIN. Even when I set up the "feed-pin.sh" file, I get an
-> error dialog on the Treo 680 titled "Bluetooth Security": "Unable to add
-> ComputerName-0 to your trusted device list."

Red Hat is moldy-oldy and those objects/packages are now obsolete from the 
current bluez setup. PIN/pairing you do with bluez-gnome or I use the 
passkey-agent/auth-agent that's in the bluez-utils source, from the command 
line since gnome stuff won't build on my system as I don't have gnome nor its 
libraries. The "Unable to...trusted device list." likely means there was 
nothing on your system answering the pairing request (properly). You seem to 
have pairing down, as you said below.

-> > http://howto.pilot-link.org/bluesync/
-> > 
-> This page also requires packages not available on Debian: bluez-lib,
-> bluez-pan and bluez-sdp.  The Palm pieces seem more relevant to my Treo;
-> however, the Treo seems to already have a Bluetooth HotSync profile.  It has
-> a nice little tutorial that, after the equivalent of figure 5-8, says I have
-> to set up a virtual serial port on my computer.  I assume that's what hcid,
-> pand, and rfcomm are doing, and carry on.  Actually clicking the "Launch
-> HotSync" button leads to a message: "Connecting with the desktop using
-> ComputerName-0", followed by an error dialog titled "HotSync Problem":
-> "Unable to initiate HotSync operation because the port is in use by another
-> application."

pand is part of bluez-utils. sdpd as a binary is gone. The actual packages are 
listed at http://www.bluez.org/download.html. Distributions mix & match those 
and create many packages from those listed few.


Changelog:

ver 3.30:
...
         Remove build option for deprecated sdpd binary.


You can use hcid -s to enable sdp. Setting up a serial port with rfcomm is 
something like so, using my phone's bluetooth modem as an example:

root@vdrl /tmp # hcitool scan
Scanning ...
         00:1C:62:19:B1:6A       LG VX8300

passkey-agent --default 0000 00:1C:62:19:B1:6A &  <-- Use bluez-gnome for
auth-agent &                                          these. It doesn't build
                                                       on my system due to lack
                                                       of gnome.

sdptool browse 00:1C:62:19:B1:6A

Passkey request for device 00:1C:62:19:B1:6A
Browsing 00:1C:62:19:B1:6A ...

....

Service Name: BT DIAG
Service RecHandle: 0x10005
Service Class ID List:
   "Serial Port" (0x1101)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 16                <--- channel 16
Language Base Attr List:
   code_ISO639: 0x656e
   encoding:    0x6a
   base_offset: 0x100
Profile Descriptor List:
   "Serial Port" (0x1101)       <-- serial port

rfcomm --help

RFCOMM configuration utility ver 3.31
Usage:
         rfcomm [options] <command> <dev>

Options:
         -i [hciX|bdaddr]      Local HCI device or BD Address
         -h, --help            Display help
         -r, --raw             Switch TTY into raw mode
         -A, --auth            Enable authentication
         -E, --encrypt         Enable encryption
         -S, --secure          Secure connection
         -M, --master          Become the master of a piconet
         -f, --config [file]   Specify alternate config file
         -a                    Show all devices (default)

Commands:
         bind     <dev> <bdaddr> [channel]       Bind device
         release  <dev>                          Release device
         show     <dev>                          Show device
         connect  <dev> <bdaddr> [channel]       Connect device
         listen   <dev> [channel [cmd]]          Listen
         watch    <dev> [channel [cmd]]          Watch

rfcomm -i hci0 bind 0 00:1C:62:19:B1:6A 16   <-- "0" means "rfcomm0"
rfcomm -a
rfcomm0: 00:0A:3A:7C:5C:74 -> 00:1C:62:19:B1:6A channel 16 clean

Then you'd give /dev/rfcomm0 to whatever was needing it (pppd, etc.) Make sure 
the rfcomm device files exist and are correct (procinfo -a should show the 
major number for rfcomm, here it's 216):

crw-rw-rw- 1 root root 216, 0 2007-12-16 07:29 /dev/rfcomm0
crw-rw-rw- 1 root root 216, 1 2007-12-16 07:29 /dev/rfcomm1
crw-rw-rw- 1 root root 216, 2 2007-12-16 07:29 /dev/rfcomm2


Using dund might skip the above step, as it might bind /dev/rfcomm0 itself. 
Note when using dund/pppd you usually use a script to hold the options to pppd 
and then a connection script. If you put the script in 
/etc/ppp/peers/ (whatever) you can do 'pppd call (whatever)'

rfcomm0: 00:0A:3A:7C:5C:74 -> 00:1C:62:19:B1:6A channel 16 connected [tty-attached]

Unfortunately, Verizon does a major disservice to their customers by crippling 
the phone's modem via bluetooth so I can't show you pppd in action since the 
phone ignores the bt commands from here on out (but I have done it via USB so 
I know it works).

Release rfcomm after you use it. Maybe the 'port is in use' is from that?

rfcomm release 0



-> I assume this is because it never asked for a PIN, but I just don't know.
-> When I carry on, adding the /etc/bluetooth/pin file as instructed in Chapter
-> 6, I get the same "Unable to add" message as above.

That file isn't used anymore, as far as I can tell. Bluez is a fast moving 
target (as I write this I find there's another new release now). They release 
new versions with major fixes and functionality changes all the time. When you 
use a distribution's packaged version, you run into a problem - whether to try 
to make something that's already out-dated and containing bugs/missing 
functionality (as compared to the current bluez source releases) work, or to 
try to go it alone and build the current bluez sources yourself. Problems 
arise when you try to help someone out as well, because of the differences in 
versions and lag time between disto/packaged bluez and the released sources.


-> Unfortunately, I still got the "port is in use" error.  I went back through
-> the second link, added my computer as a network, and tried to follow the
-> setup in Chapter 7.1 for surfing the web (because Chapter 7.2 says that I
-> need the pppd set up here), but I don't have sdpd running, and I don't know
-> where to find it.

The rest of the tut looks OK, from 7-1 on, with the exception that sdpd is 
gone from bluez-utils and hcid -s takes its place.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
