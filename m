Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Aug 2014 21:43:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix double free of SMP data skb
Message-ID: <20140811184323.GA6161@t440s.P-661HNU-F1>
References: <1407760528-25463-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407760528-25463-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 11, 2014, johan.hedberg@gmail.com wrote:
> In the case that the SMP recv callback returns error the calling code in
> l2cap_core.c expects that it still owns the skb and will try to free it.
> The SMP code should therefore not try to free the skb if it return an
> error. This patch fixes such behavior in the SMP command handler
> function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> This patch should probably get Cc: stable, however it should only be
> applied after my "[PATCH 0/3] Some more SMP fixes" patch set. The reason
> I ordered these like this is for this patch to have the familiar
> smp_sig_channel function name to ease backporting.

Correction to this backporting part: I must have been looking at some
other receive path since now that I checked a second time
smp_sig_channel() usage should be fine on old kernels. I.e. this patch
is only needed for bluetooth-next.

Johan
