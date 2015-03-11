Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2] Bluetooth: Check for matching IRK when looking for paired LE devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426063928-13382-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 11 Mar 2015 07:55:47 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DD6ABBEE-554A-4666-92C9-A0E40797F537@holtmann.org>
References: <1426063491-11398-1-git-send-email-johan.hedberg@gmail.com> <1426063928-13382-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we're given an RPA when checking whether we're paired or not, we
> should consult the local RPA storage whether there's a matching IRK.
> This we we ensure that hci_bdaddr_is_paired() gives the right result
> even when trying to pair a second time with the same device with an RPA.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Avoid overwriting callers bdaddr
> 
> net/bluetooth/hci_core.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

