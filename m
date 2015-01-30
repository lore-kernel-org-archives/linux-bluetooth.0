Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Use wait_on_bit_timeout() for BTUSB_BOOTING
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422608335-29090-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 30 Jan 2015 02:07:19 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <50FDE447-5E76-4272-BD13-B6EAC4C7006C@holtmann.org>
References: <1422608335-29090-1-git-send-email-johan.hedberg@gmail.com> <1422608335-29090-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The wait_on_bit_timeout() is a simpler and race-free way of waiting for
> a bit to be cleared than the current code in btusb.c. This patch updates
> the code to use the helper function (its btusb copy - to be later
> updated to use a global one).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> drivers/bluetooth/btusb.c | 44 +++++++++++++++++++-------------------------
> 1 file changed, 19 insertions(+), 25 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

