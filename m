Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <12a241ad050415175936c651a1@mail.gmail.com>
From: Bruno Abinader <brunoabinader@gmail.com>
To: Bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Baseband Packets
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
Date: Sat, 16 Apr 2005 00:59:42 +0000

Hello guys, now that I know that bluez supports all types of packets,
i'm just wondering if it changes the packet type according to the
sender/receiver devices supported packets  info, and if it does, if it
automatically selects the best packet type according to the
enviroment, like in a file transfer, for example, according to the BER
or other error factors. (e.g: DH5 when BER < 10^(-5), or DM1 when BER
> 10^(-2)). Thanks!
--=20
Bruno de Oliveira Abinader
GVoIP - INdT/UFAM


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
