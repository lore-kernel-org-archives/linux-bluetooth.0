Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH] Bluetooth: Fix rejecting SMP security request in slave role
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383643839-2788-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 5 Nov 2013 13:33:14 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <69E6DCE0-C93B-4095-B420-056E00E31FED@holtmann.org>
References: <1383643839-2788-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The SMP security request is for a slave role device to request the
> master role device to initiate a pairing request. If we receive this
> command while we're in the slave role we should reject it appropriately.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

