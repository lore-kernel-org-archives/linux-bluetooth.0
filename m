Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Dick <dm@chello.nl>
Date: Tue, 15 May 2007 17:12:31 +0000 (UTC)
Message-ID: <loom.20070515T190851-57@post.gmane.org>
References: <loom.20070513T135336-907@post.gmane.org>
	<1179162429.13351.63.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users]
	=?utf-8?q?dbus=2EDBusException=3A=09org=2Ebluez=2Ei?=
	=?utf-8?q?nput=2EError=2EAlreadyExists=3A=09Input_Already_exists?=
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

Marcel Holtmann <marcel <at> holtmann.org> writes:
> no need to call Connect(), because HID devices will re-connect to you.

Thank you very much for your answer, I've tried without Connect() but my dinovo
keyboard and mouse seem to connect and after some seconds disconnect (as far as
I can see with hcitool con).
Can I see why they are disconnected? I should be able to use the keyboard and
mouse as input devices this way shouldn't I?

Dick


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
