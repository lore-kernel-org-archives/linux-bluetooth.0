Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 1/3] Bluetooth: Fix BT_SECURITY socket option for fixed channels (ATT)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390687809-14408-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 27 Jan 2014 05:50:42 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <1D0EA2BD-E0AD-453C-B24D-162EA31A3AFC@holtmann.org>
References: <1390687809-14408-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The BT_SECURITY option should also be allowed for fixed channels, so
> punch the appropriate hole for it when checking for the channel type.
> The main user of fixed CID user space sockets is right now ATT (which is
> broken without this patch).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

