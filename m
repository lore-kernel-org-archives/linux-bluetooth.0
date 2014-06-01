Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix requiring SMP MITM for outgoing connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401605124-330-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 1 Jun 2014 08:52:44 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D745860E-4623-427B-8218-18C529EB552F@holtmann.org>
References: <1401605124-330-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Due to recent changes to the way that the MITM requirement is set for
> outgoing pairing attempts we can no longer rely on the hcon->auth_type
> variable (which is actually good since it was formed from BR/EDR
> concepts that don't really exist for SMP).
> 
> To match the logic that BR/EDR now uses simply rely on the local IO
> capability and/or needed security level to set the MITM requirement for
> outgoing pairing requests.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

