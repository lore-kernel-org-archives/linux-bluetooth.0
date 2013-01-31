Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Jan 2013 15:36:45 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix handling of unexpected SMP PDUs
Message-ID: <20130131173645.GA2556@joana>
References: <1359477863-24645-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359477863-24645-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-01-29 10:44:23 -0600]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
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

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
