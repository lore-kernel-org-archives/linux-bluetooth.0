Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46EFC921.30001@tfh-berlin.de>
Date: Tue, 18 Sep 2007 14:48:33 +0200
From: David Rehle <rehle@tfh-berlin.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] can't establish more than two rfcomm connections
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

i have built a rfcomm server, using bluez-stack. I created a service 
record containing a service-id 0x1234 on rfcomm port 1.

A client can connect sdpd and establish a connection to my tcplike 
rfcomm-server. rfcomm-server first gets a socket, binds it on 
rfcommchannel 1 and listens on that, accepting incomming requests. 
Incomming connections are handled by sysfunction select().

But only two clients can connect at the same time. It seems that sdpd 
can not handle more than two clients.
I tried to make a "sdptool browse", when two clients are connected, but 
it fails with "Host is down"-msg.
(But on the local machine, where rfcomm-server is running "sdptool 
browse local" gives me the correct servicerecord including my 0x1234 
serviceid)

It's weird, why there can connect two clients on one rfcomm-channel 1 
and not only one client, or more than two???

Is there a secret option to tell sdpd how much clients have to be handled?

The first "solution" in my brain was to build another servicerecord with 
same serviceid 0x1234 and let rfcomm-server bind and listen on more than 
one rfcomm-channel. But clients can not communicate with sdpd when two 
connections are established. On my J2ME client i get a "security block" 
exception when trying to connect as third client.

Does somebody got same issues?
Has anybody an idea why only two connections can be established?


Thank you for any suggestions.


with kind regards

David



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
