Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: david <gangchen@mobilesoft.com.cn>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1126687254.2330.26.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] bluetooth power management
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
Date: Wed, 14 Sep 2005 16:40:54 +0800

hi,

Does anybody use BRF6100 chip on the phone? I have read "BRF6100
singel-chip bluetooth RF device" date sheet to get the method of doing
power management. It tells me that I can use the HCI command to take the
BRF6100 from wake up to deep sleep.  It seems that the date sheet
doesn't tell me how to turn off/on the BRF6100(Is this called
power-down/on mode?). I wonder to know what do ioctl(ctl, HCIDEVUP,
hdev)) and ioctl(ctl, HCIDEVDOWN, hdev) do in bluez hcitool.c? Can it
turn BRF6100 on or off? If yes, is the menu "bluetooth on/off" in
mobilephone means that the power of BRF6100 is turned on/off?
Thanks a lot!


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
