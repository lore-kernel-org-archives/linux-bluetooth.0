Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Tue, 1 Aug 2006 16:41:05 +0530
Message-ID: <000b01c6b55b$2ec2d650$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
Subject: [Bluez-devel] Reading data on two l2cap sockets
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I am listening on two l2cap sockets (on different PSMs) and then connecting to these two sockets.
I am using select() to get data on these two sockets.

fd_set readfds;
FD_ZERO(&readfds);
FD_SET(sk1, &readfds);
FD_SET(sk2, &readfds);

while(1) {
	int ready = select(FD_SETSIZE, &readfds, 0, 0, 0);
	if(ready == 0)
		continue;
	if(ready == -1 && errno != EINTR)
		break;
	if(FD_ISSET(sk1, &readfds)) {
		fprintf(stderr, "Got something on sk1\n");
		/* some code */
	}
	if(FD_ISSET(sk2, &readfds)) {
		fprintf(stderr, "Got something on sk2\n");
		/* some code */
	}
}

Now, if I send data on sk1, the line "Got something on sk1" is printed, but if I send data on sk2, the line "Got something on sk2" is never printed.
Is there any contraint that both the l2cap sockets should be on the same PSM?

Regards,
Mayank


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
