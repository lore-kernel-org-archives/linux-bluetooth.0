Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Nov 2014 11:44:46 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <acho@suse.com>
Subject: Re: btusb_intr_complete returns -EPIPE
In-Reply-To: <CAG0bkv+DL0bVs9irE7eUB3rC-J16Ue=b9+_TqeuTHJYMJDkC0g@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1411061100280.886-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 6 Nov 2014, Naveen Kumar Parna wrote:

> > Any idea why you see the CSPLITs now but didn't see them before?
> 
> It looks like , I failed to locate the exact portion of the analyzer
> log that corresponds to one of those -32 events in the usbmon log.

Well, I still don't understand that, but never mind...

> USB Analyzer records several megabytes of data very quickly, so it’s
> very hard to find the portion of the analyzer log that corresponds to
> one of those -32 events in the usbmon log. To avoid this difficulty I
> applied the attached patch
> (0002-btusb-clear-halt-if-intr-in-stalls.patch – got it from Oliver
> Neukum) to btusb driver and reloaded this driver.
> 
> The applied patch calls usb_clear_halt() on receiving the stall
> response, so now I can easily search for ClearFeature(ENDPOINT_HALT)
> request in the analyzer log. It can be found at "2.304 252 217" &
> "2.316 264 600" time instance in the attached log.
> 
> Re ran the Analyzer again and attached it’s exported text
> log([2014-11-06 session 125138] Trace0000_only_ep0_ep1.txt). Here
> filtered out the BulkIN transactions.
> 
> usbmon log:
> ffff8800b7670a80 506095728 C Ii:1:108:1 -32:1 0
> ffff8800affdccc0 506107757 C Ii:1:108:1 -32:1 0

> Here is the portion of the log that corresponds to “ffff8800b7670a80
> 506095728 C Ii:1:108:1 -32:1 0”:
> 
> Start of Frame (6) HS 553.2 -> 553.7 2.302 964 717
> SSPLIT IN transaction 105 1 HS No data 2.303 590 367
> SSPLIT IN transaction 106 1 HS No data 2.303 591 283
> SSPLIT IN transaction 107 1 HS No data 2.303 600 283
> SSPLIT IN transaction 108 1 HS No data 2.303 601 350
> Start of Frame (2) HS 554.0 -> 554.1 2.303 714 817
> CSPLIT IN transaction 105 1 NAK HS No data 2.303 840 400
> CSPLIT IN transaction 106 1 NAK HS No data 2.303 842 033
> CSPLIT IN transaction 107 1 NAK HS No data 2.303 855 317
> Start of Frame (3) HS 554.2 -> 554.4 2.303 964 850

Obviously, there aren't any CSPLITs for device 108 ep 1.

> Here is the portion of the log that corresponds to “ffff8800affdccc0
> 506107757 C Ii:1:108:1 -32:1 0":
> 
> Start of Frame (6) HS 565.2 -> 565.7 2.314 966 383
> SSPLIT IN transaction 105 1 HS No data 2.315 592 033
> SSPLIT IN transaction 106 1 HS No data 2.315 592 967
> SSPLIT IN transaction 107 1 HS No data 2.315 612 800
> SSPLIT IN transaction 108 1 HS No data 2.315 613 850
> Start of Frame (2) HS 566.0 -> 566.1 2.315 716 483
> CSPLIT IN transaction 105 1 NAK HS No data 2.315 842 067
> CSPLIT IN transaction 106 1 NAK HS No data 2.315 843 683
> CSPLIT IN transaction 107 1 NAK HS No data 2.315 928 750
> Start of Frame (3) HS 566.2 -> 566.4 2.315 966 517

> In both the cases, CSPLIT of Dev-108 is missing in this portion of the log.
> 
> So, Does this test log gives some conclusion?

It indicates that the EHCI host controller hardware isn't working 
right.  Every now and then it skips sending CSPLIT packets when it 
should send them.

I suppose it's possible that the host controller is okay and the 
problem is a bad memory chip.  That could also cause this sort of 
error.  Regardless, it has to be a hardware problem.

Now, this doesn't explain why you get the -32 status code.  Maybe the 
patch below will provide more information.  Try running your test with 
this patch installed and see what shows up in the dmesg log.

Alan Stern



Index: usb-3.18/drivers/usb/host/ehci-q.c
===================================================================
--- usb-3.18.orig/drivers/usb/host/ehci-q.c
+++ usb-3.18/drivers/usb/host/ehci-q.c
@@ -346,6 +346,12 @@ qh_completions (struct ehci_hcd *ehci, s
 		/* always clean up qtds the hc de-activated */
  retry_xacterr:
 		if ((token & QTD_STS_ACTIVE) == 0) {
+			u32 info2 = hc32_to_cpu(ehci, hw->hw_info2);
+
+			if ((info2 & QH_SMASK) && (token & 0x7e))
+				ehci_info(ehci, "split intr info2 %x token %x overlay token %x\n",
+						info2, token, hc32_to_cpu(ehci,
+							hw->hw_token));
 
 			/* Report Data Buffer Error: non-fatal but useful */
 			if (token & QTD_STS_DBE)

