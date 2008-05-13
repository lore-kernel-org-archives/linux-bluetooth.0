Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 13 May 2008 09:43:49 -0700
Message-ID: <F60A3CE9E807BE49B5F56BD80B894D20016883A3@sc-exch03.marvell.com>
References: <F60A3CE9E807BE49B5F56BD80B894D2001688376@sc-exch03.marvell.com>
	<1210600280.16390.62.camel@violet.holtmann.net>
From: "Angus Ainslie" <aainslie@marvell.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez 3.30 audio service problems
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

Thanks, That was the fix. 

-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Monday, May 12, 2008 7:51 AM
To: BlueZ users
Subject: Re: [Bluez-users] Bluez 3.30 audio service problems



do a "sudo rm /etc/bluetooth/*.service" and then it should work again.
We converted all services into plugin and they all will be autoloaded at
hcid startup.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
