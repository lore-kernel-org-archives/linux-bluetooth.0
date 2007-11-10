Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: <wadex@km.ru>
To: bluez-devel@lists.sourceforge.net
Date: Sat, 10 Nov 2007 06:24:41 +0300
Message-Id: <47352479.01613A.04980@e-post07.km.ru>
MIME-Version: 1.0
Subject: [Bluez-devel] j2me hid profile
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

Hi everyone.

I'm interesping how to plugin a bluetooth keyboard to cell phone with j2me + jsr-82. It's need implement a HID profile. But the problem is happened. It described here: http://developer.sonyericsson.com/thread.jspa?&threadID=37949&start=0
 
But I can't understand: if HID based on L2CAP layer and it works correct on j2se, why it can't work properly on j2me's L2CAR layer? What's matter? What's need else for HID implementation on j2me? Or is it possible plugin the keyboard some another way (keyboard's bios or some think else)? Can you advise some solutions?

Best regards, wadex.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
