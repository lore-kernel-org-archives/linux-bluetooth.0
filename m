Return-Path: <cyrus@holtmann.org>
Message-ID: <48379DBC.50504@judebert.com>
Date: Sat, 24 May 2008 00:46:52 -0400
From: bluez-users.10.judebert@spamgourmet.com
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <48336FD4.9040803@judebert.com>
	<F60A3CE9E807BE49B5F56BD80B894D20016883DF@sc-exch03.marvell.com>
In-Reply-To: <F60A3CE9E807BE49B5F56BD80B894D20016883DF@sc-exch03.marvell.com>
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

I gave both pages a fair shake.  Short story: I'm still willing to 
provide $20 for a walkthrough.  Long story: I had the following problems:

Wendell MacKenzie - mackendw@sympatico.ca wrote:
> This helped me:
>
> http://www.gurulabs.com/goodies/Using_Linux_and_Bluetooth_DUN_with_the_Treo650.php
>   
That page is set up for Red Hat.  Debian doesn't have the bluez-pin 
package, and its hcid.conf is a little different: it contains the PIN, 
and doesn't have a dbus_pin_helper (not in any of the packages, either). 
There's also no system-config-security-level.  Nevertheless, everything 
seems to go well, until I enter my PIN. Even when I set up the 
"feed-pin.sh" file, I get an error dialog on the Treo 680 titled 
"Bluetooth Security": "Unable to add ComputerName-0 to your trusted 
device list."

Angus Ainslie - aainslie@marvell.com wrote:
> The page is old but should still be valid for new devices. I use a
> similar setup to sync and surf on my Treo 650.
>
> http://howto.pilot-link.org/bluesync/
>   
This page also requires packages not available on Debian: bluez-lib, 
bluez-pan and bluez-sdp.  The Palm pieces seem more relevant to my Treo; 
however, the Treo seems to already have a Bluetooth HotSync profile.  It 
has a nice little tutorial that, after the equivalent of figure 5-8, 
says I have to set up a virtual serial port on my computer.  I assume 
that's what hcid, pand, and rfcomm are doing, and carry on.  Actually 
clicking the "Launch HotSync" button leads to a message: "Connecting 
with the desktop using ComputerName-0", followed by an error dialog 
titled "HotSync Problem": "Unable to initiate HotSync operation because 
the port is in use by another application."

I assume this is because it never asked for a PIN, but I just don't 
know.  When I carry on, adding the /etc/bluetooth/pin file as instructed 
in Chapter 6, I get the same "Unable to add" message as above.

Since $20 is at stake, and I'm awake, I figured I'd give it another 
try.  I installed bluez-gnome and ran the bluetooth-applet from the 
command line.  From there I enabled "Automatically authorize incoming 
requests".  This time when I tried to add the computer to my trusted 
devices, the bluetooth-applet prompted me for a passkey; when I had 
entered the same passkey on both devices, it claimed to have verified my 
phone.

Unfortunately, I still got the "port is in use" error.  I went back 
through the second link, added my computer as a network, and tried to 
follow the setup in Chapter 7.1 for surfing the web (because Chapter 7.2 
says that I need the pppd set up here), but I don't have sdpd running, 
and I don't know where to find it.

Respectfully,
Judebert

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
