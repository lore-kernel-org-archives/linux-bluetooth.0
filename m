Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <1086088581.40bc65850efcf@webmail.rnl.ist.utl.pt>
From: dsas@mega.ist.utl.pt
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Problems while sending and receiving with rfcomm sockects
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
Date: Tue,  1 Jun 2004 12:16:21 +0100

Hello,

I'm writting a server-client application over bluez using rfcomm sockets.=
 I've
created two threads: one for sending and the other for receiving. The pro=
blem
occurs sometimes (sporadical) and only when I'm sending and receiving dat=
a at
the same time: The received data seems to be corrupt... Do I have to use
mutexes or other synchronizing method? The error ocurrs more often if I e=
xecute
more than one server at the same time.

Thanks.

PS: Please tell me if I'm sending this message to the right mailing list.=
..

Didier.



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
