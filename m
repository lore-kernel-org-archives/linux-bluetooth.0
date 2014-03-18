Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Fix MITM flag when initiating SMP pairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395150150-31418-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 18 Mar 2014 10:19:00 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DF2F6FC2-3FBE-4EB3-B598-46B08B22F1D4@holtmann.org>
References: <1395150150-31418-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The pairing process initiated through mgmt sets the conn->auth_type
> value regardless of BR/EDR or LE pairing. This value will contain the
> MITM flag if the local IO capability allows it. When sending the SMP
> pairing request we should check the value and ensure that the MITM bit
> gets correctly set in the bonding flags.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

