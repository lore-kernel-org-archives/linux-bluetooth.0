Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Oct 2012 17:56:09 +0800
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: SMP: Fix setting unknown auth_req bits
Message-ID: <20121012095609.GC10739@joana>
References: <1349965566-29482-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349965566-29482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-10-11 16:26:06 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> When sending a pairing request or response we should not just blindly
> copy the value that the remote device sent. Instead we should at least
> make sure to mask out any unknown bits. This is particularly critical
> from the upcoming LE Secure Connections feature perspective as
> incorrectly indicating support for it (by copying the remote value)
> would cause a failure to pair with devices that support it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@kernel.org
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
