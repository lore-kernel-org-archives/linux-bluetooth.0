Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Some queries on using Bluetooth with GPRS
From: Marcel Holtmann <marcel@holtmann.org>
To: tim@birdsnest.maths.tcd.ie
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405171427.30900.tim@birdsnest.maths.tcd.ie>
References: <200405171427.30900.tim@birdsnest.maths.tcd.ie>
Content-Type: text/plain
Message-Id: <1084807111.5833.4.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 17 May 2004 17:18:31 +0200

Hi Timothy,

> I've been playing with Bluetooth this morning,
> linking my Sony C1VFK Picturebook (with in-built Bluetooth)
> to my Nokia 6310.
> 
> A couple of things puzzle me.
> 
> (1) Each time I connect the channel number increases by 1.
> Eg on my fourth attemtp I used channel 4:
> =======================================
> Serial connection established.
> using channel 4
> Using interface ppp0
> Connect: ppp0 <--> /dev/rfcomm0
> rcvd [LCP ConfReq id=0x0 <auth pap> <mru 1500> <asyncmap 0xa0000>]
> ...
> rcvd [IPCP ConfAck id=0x3 <addr 62.40.49.216>]
> local  IP address 62.40.49.216
> remote IP address 10.6.6.6
> =======================================

this is pppd specific, so you must ask the PPP guys about that.

> (2) For some reason I only succeed in connecting every other try.
> On the odd attempts I get
> =======================================
> Script /etc/ppp/ip-up started (pid 6584)
> Script /etc/ppp/ip-up finished (pid 6584), status = 0x0
> Terminating on signal 2.
> =======================================

This is funny. I haven't seen this before. Maybe it is also a pppd
problem.

> (3) This is not really a Bluetooth query, I guess,
> but I'm slightly puzzled by the fact that I cannot ping
> the remote address, which is always 10.6.6.6
> =======================================
> [tim@martha 2004]$ ifconfig ppp0
> ppp0      Link encap:Point-to-Point Protocol
>           inet addr:62.40.49.19  P-t-P:10.6.6.6  Mask:255.255.255.255
>           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
>           RX packets:86 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:108 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:3
>           RX bytes:35498 (34.6 Kb)  TX bytes:11851 (11.5 Kb)
> =======================================

Can you ping any other address. Maybe your provider don't support the
ICMP protocol.

> (4) Also, I'm surprised I don't have to specify any nameservers
> (in my /etc/resolv.conf).
> Is that normal?

The PPP scripts will replace resolv.conf for your session.

> (5) Incidentally, the last obstacle that stopped me connecting
> was that I needed "\r" in the ATD line of my chat-sequence
>  ========================================
> OK              ATE0
> OK              ATV1
> OK              'AT+CGDCONT=1,"IP","open.internet","",0,0'
> OK              'ATD*99#\r\n'
> TIMEOUT         60
> CONNECT         ""
> ========================================

Looks like a phone specific bug. Check with "hcidump -a" what the chat
script really sends.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
