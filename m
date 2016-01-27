Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH 2/3] Bluetooth: L2CAP: Fix auto-allocating LE PSM values
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1453846751-5925-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 27 Jan 2016 16:26:08 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <59878357-C795-4422-81F1-482777E86C70@holtmann.org>
References: <1453846751-5925-1-git-send-email-johan.hedberg@gmail.com> <1453846751-5925-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The LE dynamic PSM range is different from BR/EDR (0x0080 - 0x00ff)
> and doesn't have requirements relating to parity, so separate checks
> are needed.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

