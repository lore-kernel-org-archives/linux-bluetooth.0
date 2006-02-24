Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DUN fails to do fast data
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43FE9633.5090704@xmission.com>
References: <43FE9633.5090704@xmission.com>
Content-Type: text/plain
Message-Id: <1140800286.7264.23.camel@localhost>
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
Date: Fri, 24 Feb 2006 17:58:06 +0100

Hi Brad,

> I have been using dialup networking over bluetooth for some time. The
> carrier was providing cdma/1xrtt which runs at about 130kbps. When they
> upgraded to ev-do (should deliver at least 200kbps), I found that the
> link would drop if I was trying to max out the connection.
> 
> Now I've had a chance to test this on two different phones on two
> different carriers (samsung i730 on verizon and xv6700 on sprint) and
> both show this problem with maxing the connection. Actually, the i730
> will drop the connection but the xv6700 is more likely to lock up the
> phone. Is something getting out of sync?

maybe both phones are at fault. The RFCOMM flow control is actually
implemented that it supports LAN access profile which is PPP over RFCOMM
as fast as possible. The latest version of hcidump has a integrated PPP
parser (only partial useful) and a pppdump export facility. Use this to
track down the reason for the link drop.

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
