Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] Bluetooth: btusb: Add Qualcomm Atheros AR3006 in
 blacklist_table
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 18 Nov 2011 08:48:39 +0100
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3DD8@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3A49@nasanexd02b.na.qualcomm.com>
	 <1321450153.15441.548.camel@aeonflux>
	 <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3C48@nasanexd02b.na.qualcomm.com>
	 <1321545089.15441.572.camel@aeonflux>
	 <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3D67@nasanexd02b.na.qualcomm.com>
	 <1321593478.15441.578.camel@aeonflux>
	 <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3DD8@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321602529.15441.581.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> Add AR3006 entry in blacklist_table in btusb.c for bcdDevice check.
> Then ath3k.c has the chance to download firmware and reset hardware.
> 
> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

this looks good now.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


