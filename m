Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20041011105626.70557.qmail@web40607.mail.yahoo.com>
From: Paolino paperino <vonzoltan@yahoo.it>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] problems with bytestream
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 11 Oct 2004 12:56:26 +0200 (CEST)

Hi, i'm writing a library to get a L2CAP stream in
Java, this library is Java Native Library that uses
L2CAP sockets of Bluez.
I've the following problem: when i send 4 bytes over
the socket, on the other side of the connection i get
5 valid read operation. Well at this point i started
to investigate and i founded very usefull the l2test
program tool. On one machine i've lauched l2test with
l2test -d -b 1 (for packets of 1 byte) and on the
client side l2test -s -b 1 -N 10 <my_srv_addr>....the
client seems to work correctly, but the server doesn't
receive any data.

[client screen dump]
[zande@ZANDEGIA andrea]$ ./l2test -s  -b 1 -N 10
00:0B:0D:40:64:D5
l2test[8186]: Connected [imtu 672, omtu 672, flush_to
65535]
l2test[8186]: Sending ...
l2test[8186]: Closing channel ...
l2test[8186]: Done
l2test[8186]: Exit

[server screen dump]
[andrea@tsunami tests]$ ./l2test -d
l2test[4907]: Waiting for connection on psm 10 ...
l2test[4908]: Connect from 00:10:C6:4D:38:AC [imtu
672, omtu 672, flush_to 65535]
l2test[4908]: Receiving ...
l2test[4908]: Disconnect. Success

No data are received by the server, nothig is printed
on the screen.

Somebody have an explanation for this things or
somebody could test my 2 commands lines on other
machine to test the behaviour.

Thanks to anybody could help me!!!
Best regards 
Andrew




		
___________________________________ 
Nuovo Yahoo! Messenger: E' molto più divertente: Audibles, Avatar, Webcam, Giochi, Rubrica… Scaricalo ora! 
http://it.messenger.yahoo.it


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
