Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Fighting with SCO
From: Marcel Holtmann <marcel@holtmann.org>
To: Till Harbaum <harbaum@beecon.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200408261852.56641.harbaum@beecon.de>
References: <200408261852.56641.harbaum@beecon.de>
Content-Type: text/plain
Message-Id: <1093541231.2581.40.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 26 Aug 2004 19:27:11 +0200

Hi Till,

> i have a BlueTrek G2 bluetooth headset and i am just unable to get
> it work with bluez.
> 
> I can connect to it with hstool and it even sends me the AT+VGS-Volume 
> commands and AT+CKPD=200 whenever i press the button. And if i send RING to 
> it, then it rings.
> 
> But it won't send me any sco data. I have tested this with several different 
> usb dongles (d-link dbt-120, the microsoft dongle delivered with the 
> bluetooth desktop (both csr) and a Allnet WBT-3021 (broadcom chip)).
> 
> If i make scotest send some funny patterns to the headset i get some very 
> quiet hissing like some audio transmitter has been switched on, but no actual 
> audio signal is being transmitted.

actually I don't expect that the Broadcom device will work. Even if they
say that SCO over HCI is supported it behaves somekind of weird with
some USB host controller chips. All your devices should set to SCO over
HCI by default, but you may check this with "hciconfig hci0 revision".

According to the Headset profile I think the SCO channel must be
established by the audio gateway after some command was sent. Or after
you received an OK. I only tested the hstest program with a HBH-10 and
the Bluespoon analog/digital. Run "hcidump -x" and check if there is
something special on the link.

> BTW: Marcel: The l2cap buffer management student thesis is out ...

This is great. Please inform me about the results.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
