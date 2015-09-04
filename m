Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: Delay check for conn->smp in smp_conn_security()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441358566-24428-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 4 Sep 2015 08:23:18 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <375359A6-DF9E-4C1E-9338-7801060ADD76@holtmann.org>
References: <1441358566-24428-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There are several actions that smp_conn_security() might make that do
> not require a valid SMP context (conn->smp pointer). One of these
> actions is to encrypt the link with an existing LTK. If the SMP
> context wasn't initialized properly we should still allow the
> independent actions to be done, i.e. the check for the context should
> only be done at the last possible moment.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

