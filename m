Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: what to do with brcm_patchram_plus?
To: Loic Poulain <loic.poulain@intel.com>
Cc: linux-bluetooth@vger.kernel.org
References: <7cef65c9-b831-b0bb-8029-38fcd99e75aa@mnementh.co.uk>
 <1f37eeff-7ce8-9242-13bc-0c718b1acefa@intel.com>
 <e3ade999-25c1-a28f-02d6-85dbcc583017@mnementh.co.uk>
 <b99e7bff-6113-b77e-3798-fe87c92de952@intel.com>
 <4e20b9ff-601c-a6ba-a381-470d14cc8343@mnementh.co.uk>
 <e89978ec-42a3-49af-ce22-8f9caf9047e9@intel.com>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <1907faaa-3865-720a-69a0-5d365cbd486d@mnementh.co.uk>
Date: Wed, 28 Jun 2017 19:48:26 +0100
MIME-Version: 1.0
In-Reply-To: <e89978ec-42a3-49af-ce22-8f9caf9047e9@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 27/06/17 17:09, Loic Poulain wrote:
> Hi Ian,

> +++ b/drivers/bluetooth/btbcm.c
> @@ -274,7 +274,7 @@ static struct sk_buff *btbcm_read_usb_product(struct
> hci_dev *hdev)
>         { 0x410e, "BCM43341B0"  },      /* 002.001.014 */
>         { 0x4406, "BCM4324B3"   },      /* 002.004.006 */
>         { 0x610c, "BCM4354"     },      /* 003.001.012 */
> +       { 0xXXXX, "BCM43430A1"  },      /* 001.002.009 */
>         { }
>  };
> 
> Can you replace with the correct subver and submit a patch ?

Will do. I'll have a look at getting any DT fluff done too, if its not
already.

>> PS. Are my emails coming out OK now? I think it's fixed :)
> 
> It looks good.

Awesome, ta!

-Ian

