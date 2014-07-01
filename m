Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Allow re-encryption with LTK when STK is in use
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404231253-21119-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Jul 2014 18:28:54 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5A116121-6FA1-4149-9244-A6D5B92DC04C@holtmann.org>
References: <1404231253-21119-1-git-send-email-johan.hedberg@gmail.com> <1404231253-21119-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we're encrypted with the STK we should allow re-encryption with an
> LTK even though the acheived security level is the same. This patch adds
> the necessary logic to the smp_sufficient_security function which is
> used to determine whether to proceed with encryption or not.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

