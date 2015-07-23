Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] Bluetooth: Fix NULL pointer dereference in smp_conn_security
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1437413485-1180-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 23 Jul 2015 16:44:12 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D92C276D-BFD5-47E8-BF83-94AE7DD530E3@holtmann.org>
References: <1437413485-1180-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The l2cap_conn->smp pointer may be NULL for various valid reasons where SMP has
> failed to initialize properly. One such scenario is when crypto support is
> missing, another when the adapter has been powered on through a legacy method.
> The smp_conn_security() function should have the appropriate check for this
> situation to avoid NULL pointer dereferences.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org # 4.0+
> ---
> net/bluetooth/smp.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

