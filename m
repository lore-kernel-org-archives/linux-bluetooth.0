Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 14:52:06 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix accepting connect requests for
 defer_setup
Message-ID: <20110614175206.GA2613@joana>
References: <1307679307-18302-1-git-send-email-johan.hedberg@gmail.com>
 <1308044899-18953-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308044899-18953-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-06-14 12:48:19 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> When authentication completes we shouldn't blindly accept any pending
> L2CAP connect requests. If the socket has the defer_setup feature
> enabled it should still wait for user space acceptance of the connect
> request. The issue only happens for non-SSP connections since with SSP
> the L2CAP Connect request may not be sent for non-SDP PSMs before
> authentication has completed successfully.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: rebased against latest bluetooth-next tree
> 
>  net/bluetooth/l2cap_core.c |   21 +++++++++++++++------
>  1 files changed, 15 insertions(+), 6 deletions(-)

Applied with the needed modifications to make it works for bluetooth-2.6.
Thanks.

	Gustavo
