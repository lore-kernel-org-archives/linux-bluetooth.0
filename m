Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20041020140143.52337.qmail@web40611.mail.yahoo.com>
From: Paolino paperino <vonzoltan@yahoo.it>
To: bluez users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] [ECONNRESET]Problem with last buffer readed with a read or recv
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
Date: Wed, 20 Oct 2004 16:01:43 +0200 (CEST)

Hi, i need some hints.
I writed a RFCOMM cleint side socket and its servere
side. The server sends an arbitrary sequence of 2048
bytes throught the write function. The client side
read as far as it receive a 0 or -1 frem the read.
The code is like this:
char *buffer[2048];
do {
   tmpPtr += nread;		
   nread = recv(fd, buffer, length, 0);
} while (nread > 0);

The problem arise when the server correctly send its
last bucket, the client must read it (read 2048
bytes), at the next read the client must get an EOF
(0) value from the recv...but this not happen it
receive -1 and errno=ECONNRESET. The same code works
as expected using TCP streams, but when it is used
over RFCOMM SOCK_STREAM it causes this anomaly.

Somebody could explain what happens, why the recv call
doesn't return a 0 when last data are reached on the
stream, but give an error message?

Thank's a lot
Best regards
 Andrea S.


		
___________________________________ 
Nuovo Yahoo! Messenger: E' molto più divertente: Audibles, Avatar, Webcam, Giochi, Rubrica… Scaricalo ora! 
http://it.messenger.yahoo.it


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
