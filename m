Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3] bluetooth, bpf: split sk_filter in l2cap_sock_recv_cb
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160727184014.10859-1-mathew.j.martineau@linux.intel.com>
Date: Wed, 24 Aug 2016 10:57:02 -0400
Cc: linux-bluetooth@vger.kernel.org, daniel@iogearbox.net,
        willemb@google.com,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        Alexei Starovoitov <ast@kernel.org>
Message-Id: <CF1D47B2-11CA-4EA8-A601-7A589D784A2F@holtmann.org>
References: <20160727184014.10859-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> During an audit for sk_filter(), we found that rx_busy_skb handling
> in l2cap_sock_recv_cb() and l2cap_sock_recvmsg() looks not quite as
> intended.
> 
> The assumption from commit e328140fdacb ("Bluetooth: Use event-driven
> approach for handling ERTM receive buffer") is that errors returned
> from sock_queue_rcv_skb() are due to receive buffer shortage. However,
> nothing should prevent doing a setsockopt() with SO_ATTACH_FILTER on
> the socket, that could drop some of the incoming skbs when handled in
> sock_queue_rcv_skb().
> 
> In that case sock_queue_rcv_skb() will return with -EPERM, propagated
> from sk_filter() and if in L2CAP_MODE_ERTM mode, wrong assumption was
> that we failed due to receive buffer being full. From that point onwards,
> due to the to-be-dropped skb being held in rx_busy_skb, we cannot make
> any forward progress as rx_busy_skb is never cleared from l2cap_sock_recvmsg(),
> due to the filter drop verdict over and over coming from sk_filter().
> Meanwhile, in l2cap_sock_recv_cb() all new incoming skbs are being
> dropped due to rx_busy_skb being occupied.
> 
> Instead, just use __sock_queue_rcv_skb() where an error really tells that
> there's a receive buffer issue. Split the sk_filter() and enable it for
> non-segmented modes at queuing time since at this point in time the skb has
> already been through the ERTM state machine and it has been acked, so dropping
> is not allowed. Instead, for ERTM and streaming mode, call sk_filter() in
> l2cap_data_rcv() so the packet can be dropped before the state machine sees it.
> 
> Fixes: e328140fdacb ("Bluetooth: Use event-driven approach for handling ERTM receive buffer")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> ---
> 
> For v3 I incorporated Willem's feedback regarding ERTM/streaming mode
> consistency and checking for a trimmed SDU length header.
> 
> Mat
> 
> ---
> net/bluetooth/l2cap_core.c |  8 ++++++++
> net/bluetooth/l2cap_sock.c | 14 ++++++++++++--
> 2 files changed, 20 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

