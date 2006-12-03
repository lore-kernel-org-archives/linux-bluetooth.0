Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b5dccebe0612031030v75c15bf6o688a5b198d6d6bb5@mail.gmail.com>
Date: Sun, 3 Dec 2006 19:30:08 +0100
From: "Mikael Lindqvist" <li.mikael.spam@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Timeout for connections
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

Hello,

I would like to be able to set a timeout for service discoveries (and
eventually for rfcomm connections as well, but so far I've been
experimenting with service discoveries). For this I use non blocking
sockets by passing SDP_NON_BLOCKING to sdp_connect. Then I use select
with a timeout on the socket, and if it times out I call sdp_close.

The problem is that after I have done this I can't use the bluetooth
chip for other connections for some time. Dumping the traffic with
hcidump, I saw that this is because even though the l2cap socket is
closed, the bluetooth chip is still doing the connection in the
background. For this connection to actually get canceled the chip
needs to be sent a HCI_Create_Connection_Cancel command, but it is not
sent when the socket is closed.

To work around this I made some code to send this command myself
before calling sdp_close. This works, but the problem is that you need
to be root to send the HCI_Create_Connection_Cancel command. The
implication being that if you want to set a timeout for service
discovery, you need to be root. And this can't be the case, am I
thinking wrong in some fundamental way?

Or can this be considered a bug? shouldn't
HCI_Create_Connection_Cancel be sent automatically on some lower level
of bluez if you close an l2cap/rfcomm socket while it is connecting?

Or is there some other way to set a timeout for l2cap/rfcomm connections?

Thanks in advance,

Mikael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
