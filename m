Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de46576041116061851f9e35f@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] bluetooth connection goes down
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 16 Nov 2004 19:48:13 +0530

hi marcel and all,
I have the following doubts

1> I use "hcitool cc <bt_addr> command " to connect to my neighboring 
BT device. The first few times this connects with no errors.  After
sometime, the connection goes down for some reason and if I try yo
coonect again, I get an error saying

"Can't create connection: Input/output error"......can someone tell me
as to why i am getting this error.

2> I use bnep for tcp/ip communication and this connection also goes
down after sometime. I try to connect using "pand --connect
<bt_addr>"....and in /var/log/daemon.log in get the following lines

Nov 16 19:42:29 edpc449 pand[2128]: Bluetooth PAN daemon
Nov 16 19:42:29 edpc449 pand[2128]: Connecting to <bt_addr>
Nov 16 19:42:29 edpc449 pand[2128]: Connect to <bt_addr> failed.
Operation already in progress(114)

I have tried killing the processes and connection(using pand --kill)
on both sides....and then restarting them....but to no effect. Only a
clean reboot seems to be the solution.
Hope u can help me with this too.

regards,
manjunath


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
