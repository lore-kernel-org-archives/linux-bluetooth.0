Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v3 2/2] Bluetooth: hci_uart: Fix dereferencing of ERR_PTR
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434543039-5494-2-git-send-email-chanyeol.park@samsung.com>
Date: Wed, 17 Jun 2015 14:22:05 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5F263A26-4380-4ABA-9838-85BB7ED9C991@holtmann.org>
References: <1434543039-5494-1-git-send-email-chanyeol.park@samsung.com> <1434543039-5494-2-git-send-email-chanyeol.park@samsung.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

> If h4_recv_buf() return ERR_PTR instead sk_buff pointer, it should be
> cleared once PTR_ERR is completed for the further dereference such as
> h4_recv(), or h4_close().
> 
> Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
> ---
> drivers/bluetooth/hci_ath.c | 1 +
> drivers/bluetooth/hci_bcm.c | 1 +
> drivers/bluetooth/hci_h4.c  | 1 +
> 3 files changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

