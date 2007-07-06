Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thilo Riessner <thilo@riessner.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Fri, 6 Jul 2007 14:53:00 +0200
References: <200706181148.34291.thilo@riessner.de>
In-Reply-To: <200706181148.34291.thilo@riessner.de>
MIME-Version: 1.0
Message-Id: <200707061453.00990.thilo@riessner.de>
Subject: Re: [Bluez-users] HP Bluetooth PC Card Mouse
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

Finally I found the solution myself (with help from the post: "hidd connection 
to mouse interferes with headset"). I start the hidd now with the argumets:
--connect 00:02:76:00:D0:3E --master
I put it in the /etc/sysconfig/bluetooth file in the variable: HID_DAEMON_ARGS
This gives the desired behavior. When I switch the mouse on and activate it by 
a click on one of the buttons, it starts to work after a few seconds.

Thilo 

Am Montag, 18. Juni 2007 11:48 schrieb Thilo:
> I bought a HP Bluetooth PC Card Mouse. It works when I press the connect
> button underneath the mouse, and hidd -c adress. This is ok for the first
> time using it, but I have to press the button every time i am using it.
> This is bothersome. Is there a possibility to avoid this procedure? I am
> using a Dell Latitude D620 with OpenSuSE 10.2 operating system.
> Thanks for any help
>
> Thilo
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
