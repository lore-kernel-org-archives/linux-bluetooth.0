Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thilo Riessner <thilo@riessner.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 10 Jul 2007 17:18:51 +0200
References: <87d4z1fdae.fsf@grogan.peloton>
In-Reply-To: <87d4z1fdae.fsf@grogan.peloton>
MIME-Version: 1.0
Message-Id: <200707101718.52425.thilo@riessner.de>
Subject: Re: [Bluez-users] Why do I have to pair my headset each time?
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

Am Dienstag, 10. Juli 2007 00:00 schrieb David Abrahams:
> My cellphone remembers its relationship to my bluetooth headset, but
> it seems the computer does not.  Is there some trick I'm missing?
>
> TIA,
Sounds like a similar problem I've had with my bluetooth mouse (see 
thread: "HP Bluetooth PC Card Mouse"). I solved it by starting the hidd with 
the following options:
--connect 00:02:76:00:D0:3E --master --server
(with your correct bluetooth address of course)
openSuSE 10.2 to starts the hidd during system boot with the arguments found 
in the variable HID_DAEMON_ARGS in the file /etc/sysconfig/bluetooth. I 
guess, other distributions have similar mechanisms. So you need not to set 
this options every time after a restart.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
