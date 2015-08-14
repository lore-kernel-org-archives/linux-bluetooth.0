Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v1] Bluetooth: hciuart: Fix to use boolean flag with u32 type
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55CD7816.8090305@qualcomm.com>
Date: Thu, 13 Aug 2015 23:56:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C0630B95-E63D-4154-879D-522007A9404C@holtmann.org>
References: <55CD7816.8090305@qualcomm.com>
To: Ben YoungTae Kim <ytkim@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

> debugfs_create_bool is asking to put u32 type pointer instead of bool
> so that passing bool type with u32* cast will cause memory corruption
> to read that value since it is handled by 4 bytes instead of 1 byte
> inside.
> 
> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
> ---
> drivers/bluetooth/hci_qca.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

