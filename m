Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] duplication of h4 protocol broken in btuart_cs
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <OF1ED005D5.FC685CD1-ONC125714F.005778F6-C125714F.00581C63@sagem.com>
References: 
	 <OF1ED005D5.FC685CD1-ONC125714F.005778F6-C125714F.00581C63@sagem.com>
Content-Type: text/plain
Message-Id: <1144945080.11159.50.camel@localhost>
Mime-Version: 1.0
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
Date: Thu, 13 Apr 2006 18:18:00 +0200

Hi Matthieu,

> in hci_h4.c, the h4 stack checks the len of the packet given in the header 
> with h4_check_data_len.
> in btuart_cs.c, it doesn't. This could lead to skb_over_panic if the read len is wrong.
> 
> I think it could be great if all drivers using h4 could use the same h4 
> stack.

this would be great, but unfortunately nobody has done this. Feel free
to send in a patch to make this happen.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
