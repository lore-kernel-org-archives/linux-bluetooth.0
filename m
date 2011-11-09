Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Nov 2011 12:35:58 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix cancel_delayed_work_sync usage with locks
Message-ID: <20111109143558.GH25584@joana>
References: <1320795862-18741-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320795862-18741-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-09 01:44:22 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The cancel_delayed_work_sync function should not be used if we hold any
> locks. Luckily all places where this is the case it is also safe to use
> the non-sync version.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c |    6 +++---
>  net/bluetooth/mgmt.c     |    4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

	Gustavo
