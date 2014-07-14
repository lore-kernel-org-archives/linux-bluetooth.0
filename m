Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix trying LTK re-encryption when we don't have an LTK
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405337695-16462-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 14 Jul 2014 14:04:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <56AB2E9B-2244-401D-A68C-4085466AEDF5@holtmann.org>
References: <1405337695-16462-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> In the case that the key distribution bits cause us not to generate a
> local LTK we should not try to re-encrypt if we're currently encrypted
> with an STK. This patch fixes the check for this in the
> smp_sufficient_security function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

