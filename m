Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org, bluez-devel@lists.sf.net
In-Reply-To: <1142934130.3964.14.camel@localhost>
References: <1137540084.4543.15.camel@localhost>
	 <1137589998.27515.8.camel@localhost>  <1137602323.4543.29.camel@localhost>
	 <1142934130.3964.14.camel@localhost>
Content-Type: text/plain
Message-Id: <1142934755.4104.2.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH] hci_usb: implement suspend/resume
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
Date: Tue, 21 Mar 2006 10:52:35 +0100

Hi Johannes,

> > The attached patch implements suspend/resume for the hci_usb bluetooth
> > driver by simply killing all outstanding urbs on suspend, and re-issuing
> > them on resume.
> > 
> > This allows me to actually use the internal bluetooth "dongle" in my
> > powerbook after suspend-to-ram without taking down all userland programs
> > (sdpd, ...) and the hci device and reloading the module.
> 
> Can someone push this patch for 2.6.17 now that 2.6.16 is out? Or is
> there still anything fundamentally wrong with it? I've been waiting for
> it forever now ;)

I will push it with some other small changes in the next few days.

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
