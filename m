Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <408312.63792.qm@web31701.mail.mud.yahoo.com>
References: <408312.63792.qm@web31701.mail.mud.yahoo.com>
Date: Mon, 19 Feb 2007 09:40:09 +0100
Message-Id: <1171874409.26567.3.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] mouse wont connect...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Tim

> so after uninstalling and reinstalling bluez-utils 3.7
> i can connect using sudo hidd --search
> but i cant auto reconnect. im in discoverable mode.
> and when i move the mouse the little light on the
> dongle flashes like its trying to connect but the
> mouse pointer just wont move...

you don't have to be discoverable for re-connect. That is a
misconception. You only have to be connectable. Check with hciconfig.
You also should run "hcidump -X -V" to see if the mouse actually
connects back or not.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
