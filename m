Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 3/5] Bluetooth: Remove unneeded "force" parameter from smp_distribute_keys()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393450427-12438-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 26 Feb 2014 13:47:05 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A4D01643-329A-4CC2-BB30-C0EF8206C36F@holtmann.org>
References: <1393450427-12438-1-git-send-email-johan.hedberg@gmail.com> <1393450427-12438-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Now that to-be-received keys are properly tracked we no-longer need the
> "force" parameter to smp_distribute_keys(). It was essentially acting as
> an indicator whether all keys have been received, but now it's just
> redundant together with smp->remote_key_dist.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c |  2 +-
> net/bluetooth/smp.c        | 10 +++++-----
> net/bluetooth/smp.h        |  2 +-
> 3 files changed, 7 insertions(+), 7 deletions(-)

patches 1-3 have been applied to bluetooth-next tree.

Regards

Marcel

