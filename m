Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Jun 2012 03:26:35 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Fix deadlock and crash when SMP pairing
 times out
Message-ID: <20120608062634.GD1546@joana>
References: <1338979451-15851-1-git-send-email-johan.hedberg@gmail.com>
 <1338979451-15851-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338979451-15851-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-06-06 18:44:11 +0800]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The l2cap_conn_del function tries to cancel_sync the security timer, but
> when it's called from the timeout function itself a deadlock occurs.
> Subsequently the "hcon->l2cap_data = NULL" that's supposed to protect
> multiple calls to l2cap_conn_del never gets cleared and when the
> connection finally drops we double free's etc which will crash the
> kernel.
> 
> This patch fixes the issue by using the HCI_CONN_LE_SMP_PEND for
> protecting against this. The same flag is also used for the same purpose
> in other places in the SMP code.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

It looks ok to me, patch has been applied to bluetooth.git. Thanks.

	Gustavo
