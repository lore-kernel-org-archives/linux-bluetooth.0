Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Thor Egil Skaug" <paxtonrd@hotmail.com>
To: "'TM'" <bluez@gammah.com>, <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Socket permissions
Message-ID: <000501c3ffa8$255baee0$46a57e40@thores>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <40435E1B.7000900@gammah.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 1 Mar 2004 08:13:34 -0800

>I did 
># chown root hciconfig
># chmod 4711 hciconfig 
>
>which sets that program setUID root. This should solve that problem,
but setting programs setuid root *could* cause a problem for security.
Since all my bluez stuff is on a laptop that's rarely online, the risk
is negligible for me.
>
>-t.

Thanks, but this is not what I meant. The application that I am writing
(using raw-data hci sockets) should not require any
different permissions or owner. What I am looking for is a way to let a
normal user run my application that has normal permissions and
open a BlueZ hci socket.

An example is using the serial port in an application. To allow users to
run such a program, one would have to set permissions
on /dev/ttyS*.

Thor


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
