Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: what to do with brcm_patchram_plus?
To: Loic Poulain <loic.poulain@intel.com>
Cc: linux-bluetooth@vger.kernel.org
References: <7cef65c9-b831-b0bb-8029-38fcd99e75aa@mnementh.co.uk>
 <1f37eeff-7ce8-9242-13bc-0c718b1acefa@intel.com>
 <e3ade999-25c1-a28f-02d6-85dbcc583017@mnementh.co.uk>
 <b99e7bff-6113-b77e-3798-fe87c92de952@intel.com>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <4e20b9ff-601c-a6ba-a381-470d14cc8343@mnementh.co.uk>
Date: Tue, 27 Jun 2017 15:48:14 +0100
MIME-Version: 1.0
In-Reply-To: <b99e7bff-6113-b77e-3798-fe87c92de952@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 27/06/17 09:30, Loic Poulain wrote:
> Hi Ian,

Hi!

> Would you be able to apply the following change to your
> kernel/module and retry ?
> 
> diff --git a/drivers/bluetooth/hci_bcm.c
> b/drivers/bluetooth/hci_bcm.c index f87bfdf..b6e94ab 100644 ---
> a/drivers/bluetooth/hci_bcm.c +++ b/drivers/bluetooth/hci_bcm.c @@
> -423,7 +423,7 @@ static int bcm_setup(struct hci_uart *hu) if (!err) 
> err = bcm_setup_sleep(hu);
> 
> -       return err; +       return 0; }

I suspected as much, something on those lines - yes, your patch makes it
work.

hciconfig
hci0: Type: Primary Bus: UART
BD Address: 43:43:A1:12:1F:AC ACL MTU: 1021:8 SCO MTU: 64:1
UP RUNNING PSCAN ISCAN
RX bytes:8823 acl:150 sco:0 events:333 errors:0
TX bytes:26178 acl:150 sco:0 commands:173 errors:0


Its considerably more reliable at scanning thus far, too.

Any idea on the below point?

>> I'll prod this a bit tomorrow - in the meantime, is there a known 
>> current/good firmware for this chip? (43430a)
Mine seems to function, md5sum:

00b4a75a3bc247f96eb07f12b28dd061 /lib/firmware/brcm/BCM.hcd

ls -l /lib/firmware/brcm/BCM.hcd
-rwxr-xr-x 1 root root 14265 Jun 26 18:23 /lib/firmware/brcm/BCM.hcd

PS. Are my emails coming out OK now? I think it's fixed :)

-Ian
