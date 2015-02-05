Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v4] Bluetooth: Add support for QCA ROME chipset family
Date: Thu, 5 Feb 2015 17:28:48 +0000
Message-ID: <548C9901-5613-46E9-BA0F-ED4B5E1F5F81@qca.qualcomm.com>
References: <e80d5700d3ea468491319d2580787dc5@nalasexr02e.na.qualcomm.com>
 <89D43368-81D2-4366-8C0F-94A93759B39F@holtmann.org>
In-Reply-To: <89D43368-81D2-4366-8C0F-94A93759B39F@holtmann.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Feb 4, 2015, at 2:01 PM, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Ben,
> 
>> This patch supports ROME Bluetooth family from Qualcomm Atheros,
>> e.g. QCA61x4 or QCA6574.
>> 
>> New chipset have similar firmware downloading sequences to previous
>> chipset from Atheros, however, it doesn't support vid/pid switching
>> after downloading the patch so that firmware needs to be handled by
>> btusb module directly.
> 
> I am fine with merging this patch, but I am still concerned about pushing non-HCI data down the bulk endpoint. As explained earlier, we already have the interrupt and bulk URBs for reception in fly. And these URBs expect HCI data.
> 
> Can you do some testing of running btusb_setup_qca() function directly from btusb_open(). I am thinking about adding a btusb internal setup callback that runs before we start any URBs. I think that would be a lot cleaner way of handling this since you are not talking HCI to the hardware.

Yes, I’m testing right now with code changed to call btusb_setup_qca() function from btusb_open. These are also okay and more safe to use URBs because it can be downloaded without any potential conflict. I’ll send the patch once testing is done today.

> 
> Any chance you can send me some USB dongles? I can do some testing by myself then.

Currently we don’t have a product of USB dongle type. Recently Asus has launched the product with ours but no dongle type. Since we might have a plan, I’ll ship it to you once it will come out to the market.

> 
> Regards
> 
> Marcel
> 

