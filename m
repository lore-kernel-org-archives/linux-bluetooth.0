Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] Bluetooth: btusb: Use USB_INTERFACE_INFO to do device
 matching
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 16 Nov 2011 14:45:27 +0900
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF28C2@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF2759@nasanexd02b.na.qualcomm.com>
	 <1321406185.15441.502.camel@aeonflux>
	 <07BBB2AAB1A10A488A2AD166C7CB8B0DEF28C2@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321422330.15441.508.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> 1 Use USB_INTERFACE_INFO to do device matching, other than USB_DEVICE_INFO.
> 2 Delete desc.bInterfaceNumber != 0 check.
> 
> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


