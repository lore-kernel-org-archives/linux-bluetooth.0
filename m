Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 10:49:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Fix packet size provided to the controller
Message-ID: <20120516074958.GB25830@x220>
References: <1336752974-7747-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336752974-7747-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, May 11, 2012, Gustavo Padovan wrote:
> When building fragmented skb's skb->len keeps track of the size of head
> plus all fragments combined, however when queueing the skb for sending we
> need to report the head size instead of the total size, so we just set
> skb->len to skb_headlen().
> 
> This bug appeared when implementing MSG_MORE support for L2CAP sockets, it
> never showed up before because l2cap_skbuff_fromiovec() never accounted skb
> size correctly. A following patch will fix this.
> 
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> Reviewed-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/hci_core.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Patches 1 and 2 have been applied to bluetooth-next. Thanks.

Johan
