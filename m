Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth:btusb:fix incorrect type in qca_device_info
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5aa0581dcf9f4432a9080cdb18c9106a@nalasexr02e.na.qualcomm.com>
Date: Tue, 10 Mar 2015 20:00:03 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E5474641-E722-4670-AB6A-AF155EB43746@holtmann.org>
References: <5aa0581dcf9f4432a9080cdb18c9106a@nalasexr02e.na.qualcomm.com>
To: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

> While qca_device_info is not coming from outside communication,
> no reason to use specific endian type inside and fix the wrong
> version comparison on big-endian platform.
> 
> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
> ---
> drivers/bluetooth/btusb.c | 34 +++++++++++++++++++++-------------
> 1 file changed, 21 insertions(+), 13 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

