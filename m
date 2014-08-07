Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/2] Bluetooth: Remove redundant check for remote_key_dist
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407395012-30446-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 7 Aug 2014 09:21:47 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EB40D1C1-B522-4C62-A389-8F27E4B4D6C7@holtmann.org>
References: <1407395012-30446-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> In the smp_cmd_sign_info() function the SMP_DIST_SIGN bit is explicitly
> cleared early on in the function. This means that there's no need to
> check for it again before calling smp_distribute_keys().
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

