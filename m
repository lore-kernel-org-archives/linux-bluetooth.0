Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: what to do with brcm_patchram_plus?
To: Ian Molton <ian@mnementh.co.uk>
References: <7cef65c9-b831-b0bb-8029-38fcd99e75aa@mnementh.co.uk>
 <1f37eeff-7ce8-9242-13bc-0c718b1acefa@intel.com>
 <e3ade999-25c1-a28f-02d6-85dbcc583017@mnementh.co.uk>
 <b99e7bff-6113-b77e-3798-fe87c92de952@intel.com>
 <4e20b9ff-601c-a6ba-a381-470d14cc8343@mnementh.co.uk>
Cc: linux-bluetooth@vger.kernel.org
From: Loic Poulain <loic.poulain@intel.com>
Message-ID: <e89978ec-42a3-49af-ce22-8f9caf9047e9@intel.com>
Date: Tue, 27 Jun 2017 18:09:10 +0200
MIME-Version: 1.0
In-Reply-To: <4e20b9ff-601c-a6ba-a381-470d14cc8343@mnementh.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,


>> Would you be able to apply the following change to your
>> kernel/module and retry ?
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c
>> b/drivers/bluetooth/hci_bcm.c index f87bfdf..b6e94ab 100644 ---
>> a/drivers/bluetooth/hci_bcm.c +++ b/drivers/bluetooth/hci_bcm.c @@
>> -423,7 +423,7 @@ static int bcm_setup(struct hci_uart *hu) if (!err)
>> err = bcm_setup_sleep(hu);
>>
>> -       return err; +       return 0; }
>
> I suspected as much, something on those lines - yes, your patch makes it
> work.

Great!

> Any idea on the below point?
>
>>> I'll prod this a bit tomorrow - in the meantime, is there a known
>>> current/good firmware for this chip? (43430a)
> Mine seems to function, md5sum:
>
> 00b4a75a3bc247f96eb07f12b28dd061 /lib/firmware/brcm/BCM.hcd

Don't know, this is a question for Broadcom.

>
> ls -l /lib/firmware/brcm/BCM.hcd
> -rwxr-xr-x 1 root root 14265 Jun 26 18:23 /lib/firmware/brcm/BCM.hcd

I also suggest to add the subversion in the bcm_uart_subver_table so 
that it loads BCM43430A1.hcd instead of the generic BCM.hcd.

+++ b/drivers/bluetooth/btbcm.c
@@ -274,7 +274,7 @@ static struct sk_buff *btbcm_read_usb_product(struct 
hci_dev *hdev)
         { 0x410e, "BCM43341B0"  },      /* 002.001.014 */
         { 0x4406, "BCM4324B3"   },      /* 002.004.006 */
         { 0x610c, "BCM4354"     },      /* 003.001.012 */
+       { 0xXXXX, "BCM43430A1"  },      /* 001.002.009 */
         { }
  };

Can you replace with the correct subver and submit a patch ?


> PS. Are my emails coming out OK now? I think it's fixed :)

It looks good.


Regards,
Loic
