Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats.andersson64@comhem.se>
To: Bluez-users <bluez-users@lists.sourceforge.net>
Date: Mon, 02 Jul 2007 23:49:07 +0200
Message-Id: <1183412947.20815.7.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] Only one pand-daemon?
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

Hello all,

I am facing the problem that I cannot start more than
one listening pand-daemon, in spite of using two usb-dongles.
The second call with 'pand --listen -e bdaddr ...' immediately
ends with return value zero and no traces in any log file.
I am running Bluez-utils 3.7 on Debian Etch. Slowly I am 
beginning to think that it could be DBUS that haunts me, but I
have just begun studying the source code of pand to make sure.
Any pointers are welcome.!


Best regards,	Mats Erik Andersson


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
