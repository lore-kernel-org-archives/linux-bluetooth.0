Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems establishing connection to Cellular
	phone
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1110766661.9456.4.camel@tux>
References: <1110766661.9456.4.camel@tux>
Content-Type: text/plain
Message-Id: <1110795678.8158.46.camel@pegasus>
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
Date: Mon, 14 Mar 2005 11:21:18 +0100

Hi Tamer,

> How do I make a stable connection to my cellular phone via bluetooth
> without that the connection is dying. 
> 
> 
> I make: 
> hcitool cc MAC-ADDRESS 
> hcitool auth MAC-ADDRESS 
> 
> then I enter the pin on the mobile phone and I receive the answer: 
> 
> HCI authentication request failed: Input/output error
> 
> 
> Can somebody help me? 
> 
> However I get this bluez-pin installed. In which relation does it belong
> to my problem? And if yes, how do I use it? 

you will never get a stable connection with "hcitool cc". In the case of
a mobile phone establish a RFCOMM connection. If you see problems then
check with "hcidump -X -V" as root what really happens on the device.

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
