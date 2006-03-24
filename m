Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] EVT_EXTENDED_INQUIRY_RESULT
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4422C49C.2060004@rumms.uni-mannheim.de>
References: <44229D0A.5080508@rumms.uni-mannheim.de>
	 <1143122060.9923.12.camel@localhost>
	 <4422C49C.2060004@rumms.uni-mannheim.de>
Content-Type: text/plain
Message-Id: <1143218750.12582.33.camel@localhost>
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
Date: Fri, 24 Mar 2006 17:45:50 +0100

Hi Andreas,

> >You can also check the features with "hciconfig hci0 features" if it
> >tells you it supports inquiry with RSSI. However in case of some
> >Broadcom chips, this doesn't mean anything, because they support it
> >anyway even if the features bit is not set.
> >  
> The feature is actually listed. The only weird thing I'm still tracking 
> down is that I only get inquiry results every five minutes while it did 
> work as expected with the previous dongles...

ask Broadcom, I have no idea. You might wanna try to compare it against
a CSR based dongle.

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
