Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Reply-To: tim@birdsnest.maths.tcd.ie
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200405171427.30900.tim@birdsnest.maths.tcd.ie>
Subject: [Bluez-users] Some queries on using Bluetooth with GPRS
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
Date: Mon, 17 May 2004 14:27:30 +0100

I've been playing with Bluetooth this morning,
linking my Sony C1VFK Picturebook (with in-built Bluetooth)
to my Nokia 6310.

A couple of things puzzle me.

(1) Each time I connect the channel number increases by 1.
Eg on my fourth attemtp I used channel 4:
=======================================
Serial connection established.
using channel 4
Using interface ppp0
Connect: ppp0 <--> /dev/rfcomm0
rcvd [LCP ConfReq id=0x0 <auth pap> <mru 1500> <asyncmap 0xa0000>]
...
rcvd [IPCP ConfAck id=0x3 <addr 62.40.49.216>]
local  IP address 62.40.49.216
remote IP address 10.6.6.6
=======================================

(2) For some reason I only succeed in connecting every other try.
On the odd attempts I get
=======================================
Script /etc/ppp/ip-up started (pid 6584)
Script /etc/ppp/ip-up finished (pid 6584), status = 0x0
Terminating on signal 2.
=======================================

(3) This is not really a Bluetooth query, I guess,
but I'm slightly puzzled by the fact that I cannot ping
the remote address, which is always 10.6.6.6
=======================================
[tim@martha 2004]$ ifconfig ppp0
ppp0      Link encap:Point-to-Point Protocol
          inet addr:62.40.49.19  P-t-P:10.6.6.6  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:86 errors:0 dropped:0 overruns:0 frame:0
          TX packets:108 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3
          RX bytes:35498 (34.6 Kb)  TX bytes:11851 (11.5 Kb)
=======================================

(4) Also, I'm surprised I don't have to specify any nameservers
(in my /etc/resolv.conf).
Is that normal?

(5) Incidentally, the last obstacle that stopped me connecting
was that I needed "\r" in the ATD line of my chat-sequence
 ========================================
OK              ATE0
OK              ATV1
OK              'AT+CGDCONT=1,"IP","open.internet","",0,0'
OK              'ATD*99#\r\n'
TIMEOUT         60
CONNECT         ""
========================================

Any suggestions or advice gratefully received.

-- 
Timothy Murphy  
e-mail (<80k only): tim /at/ birdsnest.maths.tcd.ie
tel: +353-86-2336090, +353-1-2842366
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
