Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY12-F23AB83A4A7F029ACE4AC76AB9E0@phx.gbl>
From: "Pegasus ..." <uwpegasus@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Cc: uwpegasus@hotmail.com
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [Bluez-devel] Continuous Inquiry
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
Date: Sat, 01 Jan 2005 08:02:28 +0000

Hi All:

My program is running a thread with continuos hci_inquiry(). I need to know 
when a new device is discovered in the middle of the inquiry. How do I do 
this?

The hcidump seems to show a lot of Inquiry Result event and the Remote Name 
Request for the devices found at the end of the Inquiry.


Thanks a lot.... and have a Happy New Year.

Keshav




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
