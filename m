Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <462BE48E.8000000@gmail.com>
References: <12a679470704221147v13b00925vf41dead8dc98ed24@mail.gmail.com>
	<c49421c50704221228x4fdd2ea1uda37debc07f6bc3e@mail.gmail.com>
	<462BDFE9.7010001@gmail.com>
	<c49421c50704221536g1e696aeaj8d97c10a84e3f98a@mail.gmail.com>
	<462BE48E.8000000@gmail.com>
Date: Mon, 23 Apr 2007 06:25:54 +0200
Message-Id: <1177302354.6644.120.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Max number of RFCOMM connections?
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

Hi Manuel,

> Yes you are right, the question is quite tricky.

the answer is quite simple. Per ACL link between two devices you can
have 30 RFCOMM connections and another 30 one initiated by the other
device. Every piconet can have 7 ACL links and so you can do the math by
yourself.

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
