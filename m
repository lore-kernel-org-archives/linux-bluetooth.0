Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexander Holler <holler@ahsoftware.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <8430000.1072356496@[192.168.207.2]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] hid2hci and Logitech Hub
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 25 Dec 2003 13:48:16 +0100

Hello,

I've just tried hid2hic with my Logitech Hub.

It doesn't work. After changing the vendor and product numbers, I receive 
-1 (errno: broken pipe) from the ioctl.

Then I've tried some of the control transfers I've logged using SnoopyPro 
and Windows XP. None of them are working. I allways receive -1 (Device or 
resource busy).

What makes me wonder is that in the windows logs, the transfers are allways 
of type 21 (out, class, interface), but hid2hci normally uses type 40 (out, 
vendor, device).

Any pointers?

Regards,

Alexander




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
