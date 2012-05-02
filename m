Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 May 2012 18:55:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unneeded elements from size calculation
Message-ID: <20120502155510.GA25604@x220.P-661HNU-F1>
References: <1335970577-19224-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335970577-19224-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, May 02, 2012, Gustavo Padovan wrote:
> hlen - L2CAP_HDR_SIZE = 0, so we don't need to add them in the
> calculation.
> 
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
