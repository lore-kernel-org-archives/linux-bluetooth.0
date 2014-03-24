Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Remove unnecessary assignment in SMP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395673154-32409-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 24 Mar 2014 08:01:41 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1D788D64-C61D-4C85-923B-611F14D8BDA0@holtmann.org>
References: <1395673154-32409-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The smp variable in smp_conn_security is not used anywhere before the
> smp = smp_chan_create() call in the smp_conn_security function so it
> makes no sense to assign any other value to it before that.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 2 --
> 1 file changed, 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

