Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Fix checking for HCI_SETUP flag when receiving mgmt commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381421164-30749-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 10 Oct 2013 18:14:43 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <02A3EC2C-B97C-4F3E-84E2-0A2930A5DC4F@holtmann.org>
References: <1381421164-30749-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When the HCI_SETUP flag is set the controller has not yet been announced
> over mgmt and therefore doesn't exist from that perspective. If we
> nevertheless get a mgmt command for it we should respond with the
> appropriate INVALID_INDEX error.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

