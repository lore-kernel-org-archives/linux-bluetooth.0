Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO audio packets dropping
From: Marcel Holtmann <marcel@holtmann.org>
To: ubaldo <ubaldo@eja.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040718194607.29341.qmail@webmail.aruba.it>
References: <20040718194607.29341.qmail@webmail.aruba.it>
Content-Type: text/plain
Message-Id: <1090183633.4400.42.camel@pegasus>
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
Date: Sun, 18 Jul 2004 22:47:13 +0200

Hi,

> With kernel 2.4.22, hcitools 2.2 and voice set 0x0060 HV1 if I play what I 
> recorded (aplay -f S16_LE) the voice is a little bit quicker than normal. If 
> I set voice as 0x0040 and "aplay -f S8" everything is perfect. 
> 
> With kernel 2.6.6 and voice 0x0060 HV1 everything is ok until I set the 
> packet type as HV3, then same problem as with kernel 2.4.22. 

try 2.4.22-mh6 and don't modify the packet types. Let the link manager
be able to choose between HV1, HV2 and HV3.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
