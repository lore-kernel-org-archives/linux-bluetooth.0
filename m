Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Jun 2014 17:46:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Assign L2CAP socket priority when allocating
 SKB
Message-ID: <20140605144637.GA20662@t440s.P-661HNU-F1>
References: <1401974571-19264-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401974571-19264-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jun 05, 2014, Marcel Holtmann wrote:
> The SKB for L2CAP sockets are all allocated in a central callback
> in the socket support. Instead of having to pass around the socket
> priority all the time, assign it to skb->priority when actually
> allocating the SKB.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h |  3 +--
>  net/bluetooth/a2mp.c          |  2 +-
>  net/bluetooth/l2cap_core.c    | 23 +++++++----------------
>  net/bluetooth/l2cap_sock.c    |  4 +++-
>  4 files changed, 12 insertions(+), 20 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
