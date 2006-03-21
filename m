Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: =?ISO-8859-1?Q?Rickard_Borgm=E4ster?= <doktorn@sub.nu>
Message-ID: <dvp997$em0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Broadcom 2035 USB Dongle
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
Date: Tue, 21 Mar 2006 17:23:03 +0100

Hello,

I've just spent a few hours struggling to get GPRS Bluetooth connections
 to work with a Broadcom 2035 (OEM) USB Dongle and my Nokia 6230i. The
dongle address is for some reason set to 00:00:00:00:00:00. "hcitool
can" and similar commands return "Device not available: No such device".
While I was about to think that this dongle wouldn't work with
linux/BlueZ at all, I accidently addressed it explicitly with "hcitool
-i hci0 scan" and voila... it works.

Though the null-set address and such, I can connect to my provider and
everything. So this device works well, you developers probably just need
to "recognize" it better and find out how to make sure it get's a proper
address.

Please tell me if I can help you out. I have no programming skills but I
can always try out some code or so :-)

Best regards
Rickard Borgmäster
Sweden



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
