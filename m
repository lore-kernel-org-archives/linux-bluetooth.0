Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20041013133844.49389.qmail@web40627.mail.yahoo.com>
From: Paolino paperino <vonzoltan@yahoo.it>
Subject: [Bluez-users] rfcomm sockets problems
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200410131143.26811.n1c0l4s.l3@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Wed, 13 Oct 2004 15:38:44 +0200 (CEST)

Hi,
I've used the test program rctest to test the
capability of open a connection between two linux
boxes with bt. Well the protocol seems (l2test) to be
instable, when i transmit  a sequence of packets
composed of only 1 bytes, the reader loose some
packets. The command lines i use are:
rctest -s -b 1 -N 1024 <addr> (sender, client)
and
rctest -d -b 1 (receiver, server)

I see the source code and i put an usleep pause after
the send call in the function void send_mode(int
s)...with this pause all seems work, but when i try to
send packet bigger than 1019 bytes other problem
arises, for example if i send a packet of 1024 bytes
then the packet will be braked in two packets, one of
1019 e the other of 5. In the case i send many packets
bigger than 1019, some data is lost, the receiver
receive less bytes of what are sended.

rfcomm socket must be realiable sequence stream, but
is not so, i can't understand where is the problem, if
mine or Bluez stack's.
Anybody could tell me if he had the same problems!!
I use Fedora Core 2, kernel  2.6.8-1.521 and bluez
libs/utils 2.8.

Thanks
Regards
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
