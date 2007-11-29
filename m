Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474EA586.5010602@student.uib.no>
Date: Thu, 29 Nov 2007 12:41:58 +0100
From: Isabel Maldonado <Isabel.Maldonado@student.uib.no>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Is it posible to generate passkey on some external
 device, and then update the BT-device (without MMi) automatically?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

Useally a BT device without MMI uses a fixed passkey. If this device is
a public device, so that a group of people can connect to it, each
person should have a unique passkey with the public device.

I wonder if it is possible with BlueZ to let some other external
controll/system generate a unique passkey for each person that wishes to
connect to this public device in the future.

The external controll/system updates the public device and sends the new
passkey through a secure channel.

Is there some function in BLueZ for this? Is this be possible?

-- Tripas


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
