Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 3/4] Bluetooth: Set local OOB data flag if remote has our OOB data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426499146-11959-3-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 16 Mar 2015 09:23:23 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <64B5FB56-04DD-4BA5-9838-83A20466A4C0@holtmann.org>
References: <1426499146-11959-1-git-send-email-johan.hedberg@gmail.com> <1426499146-11959-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If the SMP Pairing Request or Response PDU received from the remote
> device indicates that it has received our OOB data we should set the
> SMP_FLAG_LOCAL_OOB flag.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

