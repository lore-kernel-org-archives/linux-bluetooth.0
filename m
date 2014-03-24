Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Use memdup_user in le_auto_conn_write()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395688128-30563-1-git-send-email-andre.guedes@openbossa.org>
Date: Mon, 24 Mar 2014 13:15:16 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Fengguang Wu <fengguang.wu@intel.com>
Message-Id: <11F1A4B5-A68E-4CC2-8831-5C030C114522@holtmann.org>
References: <1395688128-30563-1-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch does a small code simplification replacing the tipical
> kmalloc-copy_from_user sequence by memdup_user() helper.
> 
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_core.c | 11 +++--------
> 1 file changed, 3 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

