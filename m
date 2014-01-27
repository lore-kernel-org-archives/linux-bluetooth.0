Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 2/3] Bluetooth: Fix disconnecting L2CAP channel for credits violation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390864295-4259-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 28 Jan 2014 00:32:22 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <AFC88FD2-A8F0-4C9B-9E5D-658625F6DC4B@holtmann.org>
References: <1390864295-4259-1-git-send-email-johan.hedberg@gmail.com> <1390864295-4259-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The L2CAP specification requires us to disconnect a channel if the
> remote device sends us data when it doesn't have any credits to do so.
> This patch makes sure that we send the appropriate L2CAP Disconnect
> request in this situation.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

