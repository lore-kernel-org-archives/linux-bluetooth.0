Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Add clarifying comment when setting local OOB flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426533154-10483-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 16 Mar 2015 12:16:56 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5DDE521D-FAC0-4513-B307-03028AA2BA1D@holtmann.org>
References: <1426533154-10483-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> It might be a bit counterintuitive to set a 'local' flag based on remote
> data. This patch adds a clarifying comment to the pairing req/rsp
> handlers when setting the LOCAL_OOB flag based on the PDU received from
> the remote side.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

