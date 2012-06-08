Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Jun 2012 04:19:33 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Fix SMP security elevation from medium to
 high
Message-ID: <20120608071933.GE1546@joana>
References: <1339052318-11423-1-git-send-email-johan.hedberg@gmail.com>
 <1339052318-11423-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339052318-11423-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-06-07 14:58:37 +0800]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> If we have an unauthenticated key it is not sufficient to acheive high
> security. Therefore, when deciding whether to encrypt the link or
> request pairing, it is essential to in addition to checking the
> existence of a key to also check whether it is authenticated or not.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/smp.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
