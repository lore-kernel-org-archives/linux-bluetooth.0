Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20041012162957.12307.qmail@web40614.mail.yahoo.com>
From: Paolino paperino <vonzoltan@yahoo.it>
Subject: [Bluez-users] problems with bytestream
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-921376012-1097598597=:10968"
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
Date: Tue, 12 Oct 2004 18:29:57 +0200 (CEST)

--0-921376012-1097598597=:10968
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

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
--0-921376012-1097598597=:10968
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

X-Apparently-To: vonzoltan@yahoo.it via 66.218.92.54; Mon, 11 Oct 2004 04:23:36 -0700
X-Originating-IP: [66.35.250.206]
Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Received: from 66.35.250.206  (EHLO sc8-sf-list2.sourceforge.net) (66.35.250.206)
  by mta287.mail.scd.yahoo.com with SMTP; Mon, 11 Oct 2004 04:23:35 -0700
Received: from localhost ([127.0.0.1] helo=projects.sourceforge.net)
	by sc8-sf-list2.sourceforge.net with esmtp (Exim 4.30)
	id 1CGxzc-00048d-Ea; Mon, 11 Oct 2004 04:05:28 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list2.sourceforge.net with esmtp (Exim 4.30)
	id 1CGxr6-0002Vy-IZ
	for bluez-devel@lists.sourceforge.net; Mon, 11 Oct 2004 03:56:40 -0700
Received: from web40607.mail.yahoo.com ([66.218.78.144])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CGxr2-0006iF-V1
	for bluez-devel@lists.sourceforge.net; Mon, 11 Oct 2004 03:56:40 -0700
Received: from [147.123.40.12] by web40607.mail.yahoo.com via HTTP; Mon, 11 Oct 2004 12:56:26 CEST
From: Paolino paperino <vonzoltan@yahoo.it>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to http://sf.net/tracker/?func=add&group_id=1&atid=200001
	0.0 SF_CHICKENPOX_AT       BODY: Text interparsed with @
	0.0 SF_CHICKENPOX_APOSTROPHE BODY: Text interparsed with '
	0.0 SF_CHICKENPOX_PERIOD   BODY: Text interparsed with .
	0.0 SF_CHICKENPOX_UNDERSCORE BODY: Text interparsed with _
Subject: [Bluez-devel] problems with bytestream
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
X-BeenThere: bluez-devel@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
X-Original-Date: Mon, 11 Oct 2004 12:56:26 +0200 (CEST)
Date: Mon, 11 Oct 2004 12:56:26 +0200 (CEST)
Content-Length: 1072

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

--0-921376012-1097598597=:10968--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
