Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <b88f52540712010301t154c17f2xa5629b5b9fb335d3@mail.gmail.com>
Date: Sat, 1 Dec 2007 11:01:53 +0000
From: "j t" <mark473@gmail.com>
To: bluez-devel@lists.sf.net
MIME-Version: 1.0
Subject: [Bluez-devel] "hci_scodata_packet: hci0 SCO packet for unknown
	connection handle 92" for 1131:1001 (issc usb dongle)
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

Hi.

I'm getting the usual "syslog flooded" problem with my usb dongle, id 1131:1001.

Just for reference, the problem (and other very similar problems) are
mentioned here:
http://qa.mandriva.com/show_bug.cgi?id=30638
http://bugzilla.kernel.org/show_bug.cgi?id=6833
https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.15/+bug/39414
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=444603


I've tried applying the patch mentioned here:
http://permalink.gmane.org/gmane.linux.bluez.devel/13721
and the patch appears to fix the problem (and my bluetooth dongle
seems to continue to work).


Could you please push this patch upstream? (I've checked
http://git.kernel.org/?p=linux/kernel/git/holtmann/bluetooth-2.6.git;a=blob_plain;f=drivers/bluetooth/hci_usb.c;hb=HEAD
and the patch does not yet appear to be included - I may be looking in
the wrong place, of course!)

One other question - does this quirk make my usb bluetooth dongle
"inferior" in some way? What do I lose if I don't have "ISOC
transfers"? (this way, I can work out if I should buy a different
dongle).

Thank you.

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
