Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5f34bf160604020326h3c60ae7bmd4a214cca69d5e87@mail.gmail.com>
From: "elad wertzberger" <wertzber@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] More then 2 RFCOMM channels open
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
Date: Sun, 2 Apr 2006 03:26:46 -0700

Hi All,

We are students building a network from bluetooth
modules and bluez.
We connected 2 units in Serial Port Profile using minicom application
and RFCOMM channels.
We want to pass information from Module A to Module B through Module C
(A -> C -> B).
Like a repeater in bluetooth.
the problem is that we cannot open RFCOMM connection between more then
2 units. (??)
1. Is it possible to open in bluez an RFCOMM
   connection with 3 units, means from A to C and
   from b to C at the same time ?
2.Do you support it in software ? is there a hardware
  limitation ? (with bluetooth 1.1)
3.Can we open more then one minicom at the same time?

Best Regards,
Elad wertzberger


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
