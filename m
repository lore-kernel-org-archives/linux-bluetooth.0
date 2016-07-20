Return-Path: <willemb@google.com>
MIME-Version: 1.0
In-Reply-To: <ca6905bba5f094171cef36a9279fd991b30a2abc.1469030410.git.daniel@iogearbox.net>
References: <ca6905bba5f094171cef36a9279fd991b30a2abc.1469030410.git.daniel@iogearbox.net>
From: Willem de Bruijn <willemb@google.com>
Date: Wed, 20 Jul 2016 14:57:42 -0400
Message-ID: <CA+FuTScJn4osUUZaCK0bnBwZPQjqy2zrRwqRNepwhPWL_Y11Bw@mail.gmail.com>
Subject: Re: [PATCH net RFT] bluetooth, bpf: split sk_filter in l2cap_sock_recv_cb
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	mathew.j.martineau@linux.intel.com, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

> In that case sock_queue_rcv_skb() will return with -EPERM, propagated
> from sk_filter() and if in L2CAP_MODE_ERTM mode, wrong assumption was
> that we failed due to receive buffer being full. From that point onwards,
> due to the to-be-dropped skb being held in rx_busy_skb, we cannot make
> any forward progress as rx_busy_skb is never cleared from l2cap_sock_recvmsg(),
> due to the filter drop verdict over and over coming from sk_filter().
> Meanwhile, in l2cap_sock_recv_cb() all new incoming skbs are being
> dropped due to rx_busy_skb being occupied.
>
> Instead, just use __sock_queue_rcv_skb() where an error really tells
> that there's a receive buffer issue. Split the sk_filter() and only
> enable it for non-L2CAP_MODE_ERTM modes since at this point in time the
> skb has already been through the ERTM state machine and it has been
> acked, so dropping is not allowed. Since skipping sk_filter() for ERTM
> may have consequences wrt future abi, we need to generally disallow
> filters to be attached for this mode. So set SOCK_FILTER_LOCKED during
> socket initialization. Given that noone run into this issue before as
> it otherwise would have been noticed and fixed, there should be little
> risk of any breakage. The SOCK_FILTER_LOCKED can later on be lifted
> should there be a use case to call sk_filter() at a safe place for such
> kind of sockets.

Silently setting SOCK_FILTER_LOCKED is unexpected and inconsistent
with all other socket types. I don't think that we need to protect
processes in this way against their own actions.

All socket types support SO_ATTACH_FILTER and there is value in being
able to expect consistent behavior across sockets for SOL_SOCKET
options. Even if using the feature incorrectly can cause a protocol to
become wedged.

Even without this precaution, this patch fixes the real wedge: an
infinite rx_busy_skb filter loop. It is a stretch, but I could imagine
scenarios where a protocol wants to acknowledge data arrival, but drop
contents instead of queue it to userspace.
