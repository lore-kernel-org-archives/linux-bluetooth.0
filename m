Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Benoit Panizzon <panizzon@woody.ch>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501091845.27395.panizzon@woody.ch>
Subject: [Bluez-users] Accept incomming serial connection (palm hotsync)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 9 Jan 2005 18:45:26 +0100

Hi all

I'm trying to be able to sync my palm zire via bluetooth.

As I understood from the ircomm or USBtty Connection the palm just wants to 
build a simple serial connection to the hotsync host.

Everything else via bluetooth works fine: obexpush, dund... (strange it does 
not recognize pand, but I assume palm only supports dund...)

But I don't manage to build a serial connection.

When I add bind yes into frcomm.conf then the computer initiates the 
connection and the palm of course rejects it...

So the solutions seamed to be to have an entry in rfcomm.conf with bind no and 
then use:

rfcomm list /dev/rfcomm1 8

To announce channel 8 as serial service and then have the palm connect to 
rfcomm1.

Unfortunately before the palm connects the rfcomm1 device is not availabe and 
without it being available the palm does not seam to want to connect...

Are there any 'undocummented' options to rfcomm to make the device show being 
present and waiting for the palm to connect? Like dund does?

Regards
-Benoit-


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
