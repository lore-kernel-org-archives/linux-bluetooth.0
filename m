Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Matthias =?utf-8?b?QnJ1bsOp?= <matthiasbrune@gmx.de>
Message-ID: <loom.20050217T125538-559@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] RFCOMM: UIH response is splitted into 3 packets
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 17 Feb 2005 11:57:20 +0000 (UTC)

Hi,

i wrote a programm for testing the RFCOMM layer and during a connection
i observed a strange behaviour that could be an implementation error within 
BlueZ?!
My connection is always broken at this point.
The scenario is decsribed during the traces below.
I hope somebody can help me with this problem, because i need a solution 
urgently.

regards
Matthias


command 1 (Request): Set Asynchronous Balanced Mode (SABM)
20050217 12:34:09 port 1047 --> 127.0.0.1 port 8000 4 octet(s)
20050217 12:34:09 000000 03 3f 01 1c                 

command 2 (Response): Unnumbered Acknowledgement (UA)
20050217 12:34:13 port 1047 <-- 127.0.0.1 port 8000 4 octet(s)
20050217 12:34:13 000000 03 73 01 d7             

command 3 (Request): Unnumbered Information with Header Check (UIH)
20050217 12:34:13 port 1047 --> 127.0.0.1 port 8000 14 octet(s)
20050217 12:34:13 000000 03 ef 15 83 11 1c f0 00 ........
20050217 12:34:13 000008 00 9a 02 00 04 70       .....p  


so far so good, but now i get 3 packets response back instead of one with 
14Bytes length:
4 Bytes, 6Bytes and 4 Bytes

command 4_1 (Response): Unnumbered Information with Header Check (UIH)
20050217 12:34:13 port 1047 <-- 127.0.0.1 port 8000 4 octet(s)
20050217 12:34:13 000000 01 ef 15 81             ....    

After the first response, the next request for further connection is made.
But because of the missing 10 Bytes from command 4 the conection is broken down.
Could this be an implementation error within BlueZ?

command 5 (Request): Set Asynchronous Balanced Mode (SABM)
20050217 12:34:13 port 1047 --> 127.0.0.1 port 8000 4 octet(s)
20050217 12:34:13 000000 73 00 00 28            

command 4_2: (Response): Unnumbered Information with Header Check (UIH)
20050217 12:34:13 port 1047 <-- 127.0.0.1 port 8000 6 octet(s)
20050217 12:34:13 000000 11 1c e0 00 00 9a       ......  

command 4_3: (Response): Unnumbered Information with Header Check (UIH)
20050217 12:34:14 port 1047 <-- 127.0.0.1 port 8000 4 octet(s)
20050217 12:34:14 000000 02 00 00 aa             ....  



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
