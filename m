Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <fc3d922d0706120106y3a7fd657l1cada74a63166010@mail.gmail.com>
Date: Tue, 12 Jun 2007 10:06:54 +0200
From: "=?ISO-8859-2?Q?Przemys=B3aw_Jakubowski?=" <przemyslaw.jakubowski@javatech.com.pl>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] hci_inquiry
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

Hello

I'm writing aplication in Java using Avetana library. Sometimes
inquiry hangs up, and I want to stop it. There is native method in
library cancelInquiry but it's not implemented. I need to stop
existing inquiry. Function hci_inquiry implemented in hci.c starts
inquiry, but i don't find there any function that cancels it.
I'll be very thankful for any help

Greetings, Przemek.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
