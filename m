Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Jan 2008 17:38:56 +0100
From: Miguel <mc354@tid.es>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <1200328736.6259.21.camel@McM>
MIME-version: 1.0
Subject: [Bluez-users] bluetooth mobile connection without pin request
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

Hello,

I ' m trying to connect my mobile phone with my laptop using the
following:

sudo rfcomm connect 0 00:17:E3:04:8E:89

in this way, I get a serial device attached to /dev/rfcomm0 after pin
exchanging between the mobile and the laptop.

is there any way no to request the pin when pairing the devices?

If I ' m not using gnome, how can manage the key exchange?

thank you in advance,




-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
