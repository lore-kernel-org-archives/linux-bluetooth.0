Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] EVT_EXTENDED_INQUIRY_RESULT
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <44229D0A.5080508@rumms.uni-mannheim.de>
References: <44229D0A.5080508@rumms.uni-mannheim.de>
Content-Type: text/plain
Message-Id: <1143122060.9923.12.camel@localhost>
Mime-Version: 1.0
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
Date: Thu, 23 Mar 2006 14:54:20 +0100

Hi Andreas,

> We've just received an HCI 2.0 dongle (Belkin/Broadcom) and I've 
> recompiled my periodic scan code (on SuSE 10.1b8 w/BlueZ 2.24) to enable 
> support for EVT_EXTENDED_INQUIRY_RESULT. Unfortunately I still get the 
> "old" EVT_INQUIRY_RESULT only; I could not find an 
> OCF_EXTENDED_PERIODIC_INQUIRY command or the like so my expectation was 
> to simply get back EVT_EXTENDED_INQUIRY_RESULT from OCF_PERIODIC_INQUIRY 
> now that our hardware supports it (and I include it in the filter).
> 
> Am I missing anything? Do I need to enable this feature somewhere?
> 
> We want either EVT_INQUIRY_RESULT_WITH_RSSI or 
> EVT_EXTENDED_INQUIRY_RESULT because we need to read the RSSI without 
> connecting.

call "hciconfig hci0 inqmode 1" first to switch the device into the
correct inquiry mode. However the extended inquiry will be only
supported by Bluetooth 2.1 (aka Lisbon) devices.

You can also check the features with "hciconfig hci0 features" if it
tells you it supports inquiry with RSSI. However in case of some
Broadcom chips, this doesn't mean anything, because they support it
anyway even if the features bit is not set.

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
