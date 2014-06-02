Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix missing check for FIPS security level
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401693164-19759-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 2 Jun 2014 09:35:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <23E9C2E0-4C5B-47AB-B3B3-6DBD16266929@holtmann.org>
References: <1401693164-19759-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When checking whether a legacy link key provides at least HIGH security
> level we also need to check for FIPS level which is one step above HIGH.
> This patch fixes a missing check in the hci_link_key_request_evt()
> function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

