Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] UMTS - Bluetooth - Bandwidth issue
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <7DBAFEC6A76F3E42817DF1EBE64CB02601DEF72A@FTRDMEL2.rd.francetelecom.fr>
References: 
	 <7DBAFEC6A76F3E42817DF1EBE64CB02601DEF72A@FTRDMEL2.rd.francetelecom.fr>
Content-Type: text/plain
Message-Id: <1108149309.18099.55.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 11 Feb 2005 20:15:09 +0100

Hi Bastien,

> I currently encounter bandwidth problem with a UMTS (3G) mobile phone
> (Sony Ericsson z1010). Basically, I am using the Bluetooth link to
> establish a ppp connection from a laptop through the phone's modem. On
> Fedora core 3 the bandwidth is perfect, I mean I can reach the maximum
> bandwidth achievable on UMTS (around 380 Kbit/s). 
> 
> My problem is on Redhat 9 (2.4.26). I do the same thing but I am
> limited to < 104 Kbit/s. It sounds like I have a serial speed
> bandwidth (115 200 bit/s) over Bluetooth. I also tried on Ipaq
> (familiar v0.7.2) and it's the same problem.

I would assume that this is a problem with the Bluetooth stack inside
the phone. There could be also a bug inside our RFCOMM layer. I don't
know, because I can't test it. Bluez <-> BlueZ connection are performing
at full piconet speed.

To really track this down I would need an UMTS phone and a flatrate like
internet access from an UMTS provider.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
