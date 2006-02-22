Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1140652705.4519.71.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] The new D-Bus API specification
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
Date: Thu, 23 Feb 2006 00:58:25 +0100

Hi,

there have been rumors about a written API specification for the D-Bus
interface of hcid (and bluetoothd in the future) and all of them is
actually true. You will find the current version under hcid/dbus-api.txt
inside the bluez-utils CVS. This isn't the final version, but it really
looks good and something about 90% has been implemented in the last few
weeks. Most of the work has been done by Claudio, Eduardo and Johan. So
thank these guys for their work.

I like to see the rest 10% implemented and after that my plan is to
release the next version of bluez-utils and open it for wider testing,
but any feedback at this point is highly welcome. And I also like to see
sample programs in various languages that we can include for reference.

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
