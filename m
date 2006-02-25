Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43FFDF4B.2080708@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sdptool fails with ppc6700
References: <C70061B183DE09419568AB2060C52A9501C19892@arion.intra.local>	 <43FF1F65.3010708@xmission.com> <1140793583.4260.19.camel@localhost>
In-Reply-To: <1140793583.4260.19.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Fri, 24 Feb 2006 21:38:35 -0700

Marcel

>>The phone still locks up whenever I try to max out the connection so
>>it's going back unless there's an easy fix. Maybe it's some kind of bad
>>interaction between bluez and pocketpc. :(
> 
> 
> show me the "hcidump -X -V" for that problem. I think that I know what
> it is and I titled it ByeByeMoto. I've seen similar things on my new
> RAZR V3x.

I only have the samsung i730 currently. So it will work for a while and
then drop the connection when I do something that saturates the link. Is
it useful to see the output of the older hcidump? The capture ends in:

> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0045
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0045
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 42 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x16
    Reason: Connection Terminated by Local Host

A complete dump is at
http://www.xmission.com/~bmidgley/dump.gz

Brad



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
