Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <403E67E8.7080900@nist.gov>
From: Ronan Daniellou <ronan.daniellou@nist.gov>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Bluetooth and SSL
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
Date: Thu, 26 Feb 2004 16:40:56 -0500



Hello everybody,

got stuck using SSL over Bluez, and I look for help.
I try to use SSL (TLS precisely) over bluetooth. Foe those who do not 
know much about SSL, you build a SSL structure, then a socket wich you 
connect and then you set the socket to the SSL structure.

So first I used a socket (L2CAP, SOCK_SEQPACKET), following the how-to 
of Bluez. I exchange data flawlessly.

Then I wanted to use SSL over my socket. My problem is, the client sends 
data to open the SSL channel, a hci dump shows that the packet actually 
arrives on the server side, but the server does not react.

Well the root example of the SSL part, was developped over usual TCP/IP 
sockets. Then I set a BNEP connection, set the IP addresses and tried 
it. I checked that the packets were actually going through the bluetooth 
link.

Then it is possible to do it. As it works over a TCP/IP layer, I thought 
that maybe openssl, is actually developped for that kind of sockets 
(even if the specification of SSL/TLS is supposed to work over any 
protocol). Moreover some SSL functions ask not only an address, but a 
port for parameter for example. But the socket structure of the L2CAP 
layer of Bluez has no port field for example, but psm. Then maybe SSL 
expect some fields that are not present...?

What I would try is to "wrap" my L2CAP socket through a "fake" TCP/IP 
one, so that SSL thinks it works with a TCP/IP connection, but I use a 
L2CAP link. I think something in that way was done to carry on TCP/IP 
over bluetooth?

I also heard about the Nokia bluetooth stack Affix, which seems to have 
a bluetooth stack which has the different fields like port, but with a 
different meaning because of the protocol you are actually using 
(RFCOMM, etc...).

Thanks a lot for anyone who could help me.

Ronan




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
