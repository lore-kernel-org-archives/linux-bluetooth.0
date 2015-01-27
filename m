Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2] Bluetooth: Enforce zero-valued hash/rand192 for LE OOB
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422356152-13920-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 27 Jan 2015 08:59:07 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B5244DDB-AC76-479B-8C1B-870F259AC145@holtmann.org>
References: <1422277671-26069-1-git-send-email-johan.hedberg@gmail.com> <1422356152-13920-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Until legacy SMP OOB pairing is implemented user space should be given a
> clear error when trying to use it. This patch adds a corresponding check
> to the Add Remote OOB Data handler function which returns "invalid
> parameters" if non-zero Rand192 or Hash192 parameters were given for an
> LE address.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Use a define instead of a variable for the zero-valued key
> 
> net/bluetooth/mgmt.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

