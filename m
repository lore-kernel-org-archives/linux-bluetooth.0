Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pci bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43E8DC7D.60603@xmission.com>
References: <43E8DC7D.60603@xmission.com>
Content-Type: text/plain
Message-Id: <1139350819.22790.57.camel@localhost>
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
Date: Tue, 07 Feb 2006 23:20:19 +0100

Hi Brad,

> are there any [m]pci bluetooth adapters supported by bluez? just noticed
> this:
> 
> http://www.msicomputer.com/product/p_spec.asp?model=MP54GBT2&class=com
> 
> I'm guessing the "warning" that it's only for their laptops is probably
> because they don't want to deliver drivers for everyone else. If done
> right, would it show up as a uart on pci that would have to be
> initialized with hciattach?

I have one of these cards. The Bluetooth chip is attached via USB, but
the card doesn't contain an USB host controller. So it uses at least two
PIN of the mini-PCI contacts to put them through an USB host controller
of the laptop. This is why it is not working. However the WiFi part of
the card works with every laptop.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
