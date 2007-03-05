Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <001301c75f37$84ec09d0$c301a8c0@Bahubali>
References: <001301c75f37$84ec09d0$c301a8c0@Bahubali>
Date: Mon, 05 Mar 2007 20:34:18 +0100
Message-Id: <1173123258.6638.55.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] undefined reference to `XML_StopParser'
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

Hi Vikram,

> I could successfully configure and make the bluez-utils-3.9. and also
> I could build l2test.
> But right now I want to run l2test on CASIRA uart(com1 ,115200
> Baudrate). If I run ( ./l2test) Bluetooth is not resetting.
> I think right now it is configured for USB (in /etc/modules.conf ).
> Can you please tell me how can I configure it to UART(com1 ,115200
> Baudrate).

this is Casira specific. Look up the PS key settings for the Casira and
then you can use the bccmd utility to change it.

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
