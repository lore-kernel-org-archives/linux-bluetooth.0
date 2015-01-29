Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Fix check for SSP when enabling SC
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422440598-12210-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 28 Jan 2015 18:38:13 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2B36F20B-5AEA-4E43-9825-4F2F45DD7C33@holtmann.org>
References: <1422440598-12210-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There's a check in set_secure_conn() that's supposed to ensure that SSP
> is enabled before we try to request the controller to enable SC (since
> SSP is a pre-requisite for it). However, this check only makes sense for
> controllers actually supporting BR/EDR SC. If we have a 4.0 controller
> we're only interested in the LE part of SC and should therefore not be
> requiring SSP to be enabled. This patch adds an additional condition to
> check for lmp_sc_capable(hdev) before requiring SSP to be enabled.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

