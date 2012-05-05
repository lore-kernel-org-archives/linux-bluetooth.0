Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 May 2012 21:01:04 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCHv2 2/2] Bluetooth: Lock the L2CAP channel when sending
Message-ID: <20120505000104.GB23728@joana>
References: <1336166431-4926-1-git-send-email-mathewm@codeaurora.org>
 <1336166431-4926-3-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336166431-4926-3-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-05-04 14:20:31 -0700]:

> The ERTM and streaming mode transmit queue must only be accessed while
> the L2CAP channel lock is held.  Locking the channel before calling
> l2cap_chan_send ensures that multiple threads cannot simultaneously
> manipulate the queue when sending and receiving concurrently.
> 
> L2CAP channel locking had previously moved to the l2cap_chan struct
> instead of the associated socket, so some of the old socket locking
> can also be removed in this patch.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/bluetooth.h |    2 --
>  net/bluetooth/l2cap_sock.c        |   19 +++++++++++--------
>  2 files changed, 11 insertions(+), 10 deletions(-)

Patch has been applied to the bluetooth tree. Thanks.

	Gustavo
