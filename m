Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <464C8133.9010901@gmail.com>
References: <464C8133.9010901@gmail.com>
Date: Thu, 17 May 2007 18:29:13 +0200
Message-Id: <1179419354.10069.144.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] How do I enable rfcomm?
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

Hi,

> I installed the blues-3.10 version in Gentoo but it doesn't start the 
> rfcomm stuff.  I have rfcomm.conf set up to bind to my phone.  It used 
> to work before with a previous version and I am pretty sure I just don't 
> have the config set to enable it this time around.  Where do I set that?

the next bluez-utils release will provide a nice D-Bus interface to make
that a lot easier and deprecate the use of rfcomm at all. Until then
simply call "rfcomm bind all".

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
