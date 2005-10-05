Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20051005070755.21011.qmail@community29.interfree.it>
From: lax@interfree.it
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Problems with sdp_connect()
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
Date: 5 Oct 2005 07:07:55 -0000


Hi to all! I am writing my thesis on Bluetooth programming under Linux and I would be grateful to you if you could give me hints to solve this problem. I have two bt devices on my laptop, both of them run the same program and register the same SDP service. When I register the service I call sdp_connect(&src, BDADDR_LOCAL, RETRY_IF_BUSY). It works but when I try to search the service from a device outside my laptop I discover the same service twice for each device. Resuming:
- Bluetooth device A register a service C on my laptop --- sdp_connect(&srcA, BDADDR_LOCAL, ...) 
- Bluetooth device B register a service C on my laptop --- sdp_connect(&srcB, BDADDR_LOCAL, ...)
- Searching service C on device A will find it twice instead of once

I thought the problem was in BDADDR_LOCAL, which is defined as {0, 0, 0, 0xff, 0xff, 0xff} but if I try to register the service connecting with SDP server as sdp_connect(&srcA, &srcA, ...) it returns error "Host is down". I don't know where to hurt my head...

Thanks

-------------------------------------------------------------------------
Visita http://domini.interfree.it, il sito di Interfree dove trovare
soluzioni semplici e complete che soddisfano le tue esigenze in Internet,
ecco due esempi di offerte:

-  Registrazione Dominio: un dominio con 1 MB di spazio disco +  2 caselle
   email a soli 18,59 euro
-  MioDominio: un dominio con 20 MB di spazio disco + 5 caselle email 
   a soli 51,13 euro

Vieni a trovarci!

Lo Staff di Interfree 
-------------------------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
