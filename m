Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] bluetooth: add support for device 0489:e092
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1465652610-1293-1-git-send-email-yvain.thonnart@m4x.org>
Date: Mon, 4 Jul 2016 20:10:02 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <ABE47F5C-BF8C-40F9-AAEA-EA96E3A476CB@holtmann.org>
References: <1465652610-1293-1-git-send-email-yvain.thonnart@m4x.org>
To: Yvain THONNART <yvain.thonnart@m4x.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yvain,

> With current btusb.ko kernel module, Bluetooth pretends to be active
> but there is no real activity.
> 
> I'm using an Acer Aspire VN7-791.
> 
> Output of lsusb:
> Bus 003 Device 007: ID 0489:e092 Foxconn / Hon Hai
> 
> On my laptop, this device is actually used as a combo with wifi chipset
> Atheros Qualcomm Killer N1525 Wireless-AC [168c:003e],
> 
> * Fix by adding a declaration in kernel sources drivers/bluetooth/btusb.c
> 
>        { USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
> 
> * Compiled extra module /lib/modules/4.4.0-22-generic/extra/btusb.ko
> 
> * Successfully tested against my phone (obex file transfer)
> 
> DistroRelease: Ubuntu 16.04
> Package: linux-image-4.4.0-22-generic 4.4.0-22.40
> ProcVersionSignature: Ubuntu 4.4.0-22.40-generic 4.4.8
> Uname: Linux 4.4.0-22-generic x86_64
> Signed-off-by: Yvain THONNART <yvain.thonnart@m4x.org>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

