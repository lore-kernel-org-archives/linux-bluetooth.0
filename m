Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030721152542.096f0a48@unixmail.qualcomm.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>, James Courtier-Dutton <James@superbug.demon.co.uk>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Bluetooth headset problems.
Cc: Cozza <ac2crp@blueyonder.co.uk>, bluez Dev <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3F08719F.70708@superbug.demon.co.uk>
References: <3F062FF5.7020703@superbug.demon.co.uk>
	<3F02DBA9.1060305@superbug.demon.co.uk>
	<004701c34153$0e650ba0$fd02a8c0@troll>
	<3F062FF5.7020703@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 21 Jul 2003 15:30:32 -0700

At 11:59 AM 7/6/2003, James Courtier-Dutton wrote:


>>I have made some progress. I can now record audio from the headset without it loosing any samples. I.e. I can record 8 bit PCM at 8000hz and it sounds fine. Before it was loosing samples and recording at more like 4000hz.
>>Once I get playback to work, I will post a patch to this list.
>>Cheers
>>James
>If anyone is interested, the fix for recording required 2 urbs for each isoc connection. The current cvs only uses 1 urb for isoc connections, so the usbcore fills one urb in real time, and then when it is full, sends it to hci_usb.c via a callback. Once hci_usb.c has finished with the urb it sends it back to the usbcore to get refilled. The problem is that while hci_usb.c is processing the urb, usbcore has no urb to put real time audio samples in, so it just drops them. If 2 urbs are used, if hci_usb.c is processing one, usbcore always has another to place samples in. As long as hci_usb.c does not hold on to it's urb for too long, all is ok. This fix was discovered by comparing the alsa snd-usb-audio driver with the hci_usb.c driver.
Make sense. 
So basically you're saying that you're just calling hci_usb_isoc_rx_submit() twice 
during open, right ? ie just like hci_usb_bulk_rx_submit() is called multiple times.

Max
        



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
