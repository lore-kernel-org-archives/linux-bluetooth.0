Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v4] Bluetooth: Add support for QCA ROME chipset family
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <e80d5700d3ea468491319d2580787dc5@nalasexr02e.na.qualcomm.com>
Date: Wed, 4 Feb 2015 14:01:46 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <89D43368-81D2-4366-8C0F-94A93759B39F@holtmann.org>
References: <e80d5700d3ea468491319d2580787dc5@nalasexr02e.na.qualcomm.com>
To: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

> This patch supports ROME Bluetooth family from Qualcomm Atheros,
> e.g. QCA61x4 or QCA6574.
> 
> New chipset have similar firmware downloading sequences to previous
> chipset from Atheros, however, it doesn't support vid/pid switching
> after downloading the patch so that firmware needs to be handled by
> btusb module directly.

I am fine with merging this patch, but I am still concerned about pushing non-HCI data down the bulk endpoint. As explained earlier, we already have the interrupt and bulk URBs for reception in fly. And these URBs expect HCI data.

Can you do some testing of running btusb_setup_qca() function directly from btusb_open(). I am thinking about adding a btusb internal setup callback that runs before we start any URBs. I think that would be a lot cleaner way of handling this since you are not talking HCI to the hardware.

Any chance you can send me some USB dongles? I can do some testing by myself then.

Regards

Marcel

