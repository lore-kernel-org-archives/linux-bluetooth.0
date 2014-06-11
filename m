Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix setting correct authentication information for SMP STK
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402402790-9844-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 11 Jun 2014 09:17:15 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B0E0D739-0D95-47FB-9320-084751DACAB9@holtmann.org>
References: <1402402790-9844-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we store the STK in slave role we should set the correct
> authentication information for it. If the pairing is producing a HIGH
> security level the STK is considered authenticated, and otherwise it's
> considered unauthenticated. This patch fixes the value passed to the
> hci_add_ltk() function when adding the STK on the slave side.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

