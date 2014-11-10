Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1411061100280.886-100000@iolanthe.rowland.org>
References: <CAG0bkv+DL0bVs9irE7eUB3rC-J16Ue=b9+_TqeuTHJYMJDkC0g@mail.gmail.com>
	<Pine.LNX.4.44L0.1411061100280.886-100000@iolanthe.rowland.org>
Date: Mon, 10 Nov 2014 12:08:13 +0530
Message-ID: <CAG0bkvJCTS7s=GOV2aQ44ENCmpJWvi7yHCgtd5_o-EM7D=9kdQ@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am sorry for the late response.

I applied the patch and here is the dmesg log:

[  713.125709] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
80108d46 overlay token 80108d46
[  713.125796] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
80108d46 overlay token 80108d46
[  713.125853] hci4 urb ffff8800b89a7c00 status -32 count 0
[  713.125857] hci3 urb ffff8800b7399c00 status -32 count 0
[  713.126801] hci4
[  713.127003] hci3
[ 3046.032153] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 3046.032227] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
108d46 overlay token 108d46
[ 3046.032272] hci3 urb ffff8800b30f5a80 status -32 count 0
[ 3046.032278] hci4 urb ffff8800b30f53c0 status -32 count 0
[ 3046.033326] hci4
[ 3046.033344] hci3

Does it gives the reason for -32 status code?

Thanks,
Naveen

On Thu, Nov 6, 2014 at 10:14 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 6 Nov 2014, Naveen Kumar Parna wrote:
>
>> > Any idea why you see the CSPLITs now but didn't see them before?
>>
>> It looks like , I failed to locate the exact portion of the analyzer
>> log that corresponds to one of those -32 events in the usbmon log.
>
> Well, I still don't understand that, but never mind...
>
>> USB Analyzer records several megabytes of data very quickly, so it’s
>> very hard to find the portion of the analyzer log that corresponds to
>> one of those -32 events in the usbmon log. To avoid this difficulty I
>> applied the attached patch
>> (0002-btusb-clear-halt-if-intr-in-stalls.patch – got it from Oliver
>> Neukum) to btusb driver and reloaded this driver.
>>
>> The applied patch calls usb_clear_halt() on receiving the stall
>> response, so now I can easily search for ClearFeature(ENDPOINT_HALT)
>> request in the analyzer log. It can be found at "2.304 252 217" &
>> "2.316 264 600" time instance in the attached log.
>>
>> Re ran the Analyzer again and attached it’s exported text
>> log([2014-11-06 session 125138] Trace0000_only_ep0_ep1.txt). Here
>> filtered out the BulkIN transactions.
>>
>> usbmon log:
>> ffff8800b7670a80 506095728 C Ii:1:108:1 -32:1 0
>> ffff8800affdccc0 506107757 C Ii:1:108:1 -32:1 0
>
>> Here is the portion of the log that corresponds to “ffff8800b7670a80
>> 506095728 C Ii:1:108:1 -32:1 0”:
>>
>> Start of Frame (6) HS 553.2 -> 553.7 2.302 964 717
>> SSPLIT IN transaction 105 1 HS No data 2.303 590 367
>> SSPLIT IN transaction 106 1 HS No data 2.303 591 283
>> SSPLIT IN transaction 107 1 HS No data 2.303 600 283
>> SSPLIT IN transaction 108 1 HS No data 2.303 601 350
>> Start of Frame (2) HS 554.0 -> 554.1 2.303 714 817
>> CSPLIT IN transaction 105 1 NAK HS No data 2.303 840 400
>> CSPLIT IN transaction 106 1 NAK HS No data 2.303 842 033
>> CSPLIT IN transaction 107 1 NAK HS No data 2.303 855 317
>> Start of Frame (3) HS 554.2 -> 554.4 2.303 964 850
>
> Obviously, there aren't any CSPLITs for device 108 ep 1.
>
>> Here is the portion of the log that corresponds to “ffff8800affdccc0
>> 506107757 C Ii:1:108:1 -32:1 0":
>>
>> Start of Frame (6) HS 565.2 -> 565.7 2.314 966 383
>> SSPLIT IN transaction 105 1 HS No data 2.315 592 033
>> SSPLIT IN transaction 106 1 HS No data 2.315 592 967
>> SSPLIT IN transaction 107 1 HS No data 2.315 612 800
>> SSPLIT IN transaction 108 1 HS No data 2.315 613 850
>> Start of Frame (2) HS 566.0 -> 566.1 2.315 716 483
>> CSPLIT IN transaction 105 1 NAK HS No data 2.315 842 067
>> CSPLIT IN transaction 106 1 NAK HS No data 2.315 843 683
>> CSPLIT IN transaction 107 1 NAK HS No data 2.315 928 750
>> Start of Frame (3) HS 566.2 -> 566.4 2.315 966 517
>
>> In both the cases, CSPLIT of Dev-108 is missing in this portion of the log.
>>
>> So, Does this test log gives some conclusion?
>
> It indicates that the EHCI host controller hardware isn't working
> right.  Every now and then it skips sending CSPLIT packets when it
> should send them.
>
> I suppose it's possible that the host controller is okay and the
> problem is a bad memory chip.  That could also cause this sort of
> error.  Regardless, it has to be a hardware problem.
>
> Now, this doesn't explain why you get the -32 status code.  Maybe the
> patch below will provide more information.  Try running your test with
> this patch installed and see what shows up in the dmesg log.
>
> Alan Stern
>
>
>
> Index: usb-3.18/drivers/usb/host/ehci-q.c
> ===================================================================
> --- usb-3.18.orig/drivers/usb/host/ehci-q.c
> +++ usb-3.18/drivers/usb/host/ehci-q.c
> @@ -346,6 +346,12 @@ qh_completions (struct ehci_hcd *ehci, s
>                 /* always clean up qtds the hc de-activated */
>   retry_xacterr:
>                 if ((token & QTD_STS_ACTIVE) == 0) {
> +                       u32 info2 = hc32_to_cpu(ehci, hw->hw_info2);
> +
> +                       if ((info2 & QH_SMASK) && (token & 0x7e))
> +                               ehci_info(ehci, "split intr info2 %x token %x overlay token %x\n",
> +                                               info2, token, hc32_to_cpu(ehci,
> +                                                       hw->hw_token));
>
>                         /* Report Data Buffer Error: non-fatal but useful */
>                         if (token & QTD_STS_DBE)
>
