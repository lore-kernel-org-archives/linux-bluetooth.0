Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: Bluetooth: hciuart: Fix to use boolean flag with u32 type
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55CD22F8.3060006@qca.qualcomm.com>
Date: Thu, 13 Aug 2015 21:14:10 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8F5EF1AB-8CAF-45B0-85CC-AC3C565728D9@holtmann.org>
References: <55CD22F8.3060006@qca.qualcomm.com>
To: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
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

this patch does not apply against bluetooth-next tree.

Regards

Marcel

