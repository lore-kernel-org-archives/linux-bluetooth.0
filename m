Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Jun 2014 15:39:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use explicit header and body length for L2CAP
 SKB allocation
Message-ID: <20140608123922.GA4865@t440s.P-661HNU-F1>
References: <1402219348-17134-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402219348-17134-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 08, 2014, Marcel Holtmann wrote:
> When allocating the L2CAP SKB for transmission, provide the upper layers
> with a clear distinction on what is the header and what is the body
> portion of the SKB.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/a2mp.c          |  3 ++-
>  net/bluetooth/l2cap_core.c    | 10 +++++-----
>  net/bluetooth/l2cap_sock.c    |  3 ++-
>  4 files changed, 10 insertions(+), 7 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
