Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec04051123362c7aa9f8@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] does bluez support dynamic psm for l2cap?
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
Date: Wed, 12 May 2004 02:36:26 -0400

I want a simple client/server that operates as follows.

server listens for l2cap connections.  accepts a connection, does
something with it.

client discovers server by entering inquiry mode and then checking SDP
records for service id of the server.

I don't want to hard-code the l2cap psm, as that seems like it defeats
half the point of SDP, but I can't figure out how to request a dynamic
psm.  I want to be able to do somethiing like this:

int s;
struct sockaddr_l2 s_addr;
s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);

s_addr.l2_family = AF_BLUETOOTH;
bacopy( &s_addr.l2_bdaddr, BDADDR_ANY );
s_addr.l2_psm = L2CAP_PSM_ANY;

bind(s, (struct sockaddr *)&s_addr, sizeof(s_addr) );

struct sockaddr_l2 local_addr;
struct socklen_t addr_len = sizeof(local_addr);
getsockname( s, (struct sockaddr *)&local_addr, &addr_len);
int psm = btohs( local_addr.l2_psm );

// register service with SDP using dynamic psm

Is this possible with bluez?  Or do I have to do the ugly thing and
pick an arbitrary psm?

thanks!
-albert


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
