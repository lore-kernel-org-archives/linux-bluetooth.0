Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 4/4] Bluetooth: Fix verifying confirm value when lacking remote OOB data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426499146-11959-4-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 16 Mar 2015 09:23:25 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2CFAA1B6-0147-4C0F-BD8F-13738E3DB6B0@holtmann.org>
References: <1426499146-11959-1-git-send-email-johan.hedberg@gmail.com> <1426499146-11959-4-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we haven't received remote OOB data we cannot perform any special
> checks on the confirm value. This patch updates the check after having
> received the public key to only perform the verification if we have
> remote OOB data present.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

