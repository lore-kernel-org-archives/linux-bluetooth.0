Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problems with USB 2.0 hub and ehci_usb/hci_usb
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43F99D99.1030007@service2media.com>
References: <43F99D99.1030007@service2media.com>
Content-Type: text/plain
Message-Id: <1140467939.7047.46.camel@localhost>
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
Date: Mon, 20 Feb 2006 21:38:59 +0100

Hi Herman,

> I hope one of you can help me... I am trying to use a USB 2.0 bluetooth 
> dongle (Belkin F8T012) through a USB 2.0 hub. The problem I have is that 
> whenever I insert the BT dongle the kernel reports the following error:
> 
> hci_usb_intr_rx_submit: hci- intr rx submit failed urb df265514 err -28
> 
> I have seen a conversation in which Marcel participated on the linux 
> kernel mailing lists which referred to a similar problem, but the 
> discussion was never really finished so no solution was given (see 
> http://lkml.org/lkml/2004/8/20/62). The problem seems to appear only 
> when using the ehci_hcd USB module. Because when I use the uhci_hcd 
> module (by rmmod ehci_hcd) it works. Does anyone have any idea what the 
> source of this problem is and how I might be able to solve it?

and again this seems to be an USB issue and not a Bluetooth issue. Take
it up with the USB guys and make sure you run the latest 2.6 kernel.

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
