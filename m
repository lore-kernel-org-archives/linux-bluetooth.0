Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20070515T190851-57@post.gmane.org>
References: <loom.20070513T135336-907@post.gmane.org>
	<1179162429.13351.63.camel@violet>
	<loom.20070515T190851-57@post.gmane.org>
Date: Tue, 15 May 2007 19:27:44 +0200
Message-Id: <1179250065.10069.30.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users]
	dbus.DBusException:	org.bluez.input.Error.AlreadyExists:	Input
	Already	exists
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

Hi Dick,

> > no need to call Connect(), because HID devices will re-connect to you.
> 
> Thank you very much for your answer, I've tried without Connect() but my dinovo
> keyboard and mouse seem to connect and after some seconds disconnect (as far as
> I can see with hcitool con).
> Can I see why they are disconnected? I should be able to use the keyboard and
> mouse as input devices this way shouldn't I?

run "hcidump -X -V" to see what actually happens.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
