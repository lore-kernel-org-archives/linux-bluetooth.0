Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 2/4] Bluetooth: Track local vs remote OOB data availability
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426499146-11959-2-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 16 Mar 2015 09:23:22 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C0FEB7CB-95E9-4EF7-96AC-19AAF35DDADE@holtmann.org>
References: <1426499146-11959-1-git-send-email-johan.hedberg@gmail.com> <1426499146-11959-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There are several decisions in the SMP logic that depend not only on
> whether we're doing SMP or not, but also whether local and/or remote OOB
> data is present. This patch splits the existing SMP_FLAG_OOB into two
> new flags to track local and remote OOB data respectively.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

