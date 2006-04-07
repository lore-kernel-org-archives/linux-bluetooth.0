Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1144405107.13072.10.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] endianess question
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
Date: Fri, 07 Apr 2006 12:18:27 +0200

Hello together,

whenever I take data out of a socket buffer using the get_unaligned()
function like this:
	u16 control = get_unaligned((u16 *) skb->data);
do I have to worry about endianess correctness if I need to do some bit
fiddling stuff?
For example:
The specification states that all packet formats shall use little-endian
byte order, so an iframe is denoted like the following:
| 16 | 15 | 14 | 13 | 12 | 11 | 10 | 09 | 08 | 07 06 05 04 03 02 01
|---SAR---|------------ReqSeq-----------|-R--| ...

if I need to pull the ReqSeq value out of the 16 Bits, do I need to make
use of a function like __btoh(control):
	u16 reqseq = (__btoh16(control) & 0x3F00) >> 8;
or is it enough to say:
	u16 reqseq = (control & 0x3F00) >> 8;
when I took the get_unaligned() function?

Martin



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
