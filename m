Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: [Bluez-devel] Is there a existing test suite for bluez stackon bluez website?
Message-ID: <9FBCE015AF479F46B3B410499F3AE05B011F0582@pdsmsx405>
From: "Wang, Jing J" <jing.j.wang@intel.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Mon, 10 Apr 2006 15:25:36 +0800

Marcel,
	On our distribution, a patch is applied to standard Bluez driver to =
support specific BT hardware. So I'd like run test suite to make sure =
the patch is harmless.
	L2test and rctest are the standard test suite for bluez, right? Where =
can I get them? Thanks a lot!


WangJing

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net =
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Marcel =
Holtmann
Sent: 2006=C4=EA4=D4=C210=C8=D5 15:06
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Is there a existing test suite for bluez =
stackon bluez website?

Hi,

>          Per job requirement, I need test bluez Bluetooth stack. I
> don=A1=AFt plan to develop a test suite from scratch. So, is there any
> existing test suite I can use for bluez?

we used l2test and rctest for our testing. And the BlueZ stack has been
qualified. This means that the official Bluetooth test suite has been
run against it and we passed. What kind of tests do you need?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting =
language
that extends applications into web and mobile media. Attend the live =
webcast
and join the prime developer group breaking into this new coding =
territory!
http://sel.as-us.falkag.net/sel?cmd=3Dk&kid=110944&bid$1720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
