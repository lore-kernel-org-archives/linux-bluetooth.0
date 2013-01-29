Return-Path: <cyrus@holtmann.org>
Message-ID: <1359482320.9998.0.camel@aeonflux>
Subject: Re: [PATCH v2] Bluetooth: Fix handling of unexpected SMP PDUs
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 29 Jan 2013 18:58:40 +0100
In-Reply-To: <1359477863-24645-1-git-send-email-johan.hedberg@gmail.com>
References: <1359477863-24645-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The conn->smp_chan pointer can be NULL if SMP PDUs arrive at unexpected
> moments. To avoid NULL pointer dereferences the code should be checking
> for this and disconnect if an unexpected SMP PDU arrives. This patch
> fixes the issue by adding a check for conn->smp_chan for all other PDUs
> except pairing request and security request (which are are the first
> PDUs to come to initialize the SMP context).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> CC: stable@vger.kernel.org
> ---
> v2: Move the checks to a single place in smp_sig_channel() and instead
> of ignoring the PDUs return failure from smp_sig_channel() to trigger a
> disconnection.
> 
>  net/bluetooth/smp.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)

this looks way better.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


