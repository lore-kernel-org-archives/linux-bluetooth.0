Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 28 Nov 2007 21:35:34 -0500 (EST)
From: Tim Smith <tsmith@cs.toronto.edu>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.LNX.4.64.0711282121010.18049@apps0.cs.toronto.edu>
MIME-Version: 1.0
Subject: [Bluez-devel] RFCOMM 2x faster than L2CAP on the Nokia N800
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi all,

I've noticed something strange on the Nokia N800 (which runs linux 2.6.18 
and uses the BlueZ stack). I have two programs: one opens an L2CAP socket, 
accepts a connection, and receives data in MTU-sized packets, then 
discards the data. The other does the same thing, but uses RFCOMM. I also 
have corresponding "sender" programs that send data on the correct 
PSM/channel.

When I run the pair of L2CAP programs and transfer 10MB of data, it takes 
142 seconds. The RFCOMM programs take 74 seconds to perform the same 
transfer, despite the fact that a) RFCOMM imposes additional overhead and 
b) RFCOMM uses an L2CAP socket at the kernel level.

Further complicating things is that I also have a simple program that 
floods a remote host with malformed SDP packets (which are sized at the 
L2CAP MTU). When I run this program and send 10MB of malformed SDP packets 
to the N800's SDP server, it runs in 66 seconds.

So, what I have:
- L2CAP on SDP PSM: 66s
- L2CAP on other PSM: 142s
- RFCOMM: 74s

I've done multiple (at least three) runs of each. I've also tried sending 
to the N800 from multiple machines (x505 laptop and mac mini running 
linux) and both see this effect.

Does anyone have any idea what is going on here?

Thanks,
Tim

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
