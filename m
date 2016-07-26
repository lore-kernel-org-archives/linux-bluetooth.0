Return-Path: <willemb@google.com>
MIME-Version: 1.0
In-Reply-To: <20160726000523.11189-1-mathew.j.martineau@linux.intel.com>
References: <20160726000523.11189-1-mathew.j.martineau@linux.intel.com>
From: Willem de Bruijn <willemb@google.com>
Date: Tue, 26 Jul 2016 10:51:49 -0400
Message-ID: <CA+FuTSc18TsLQQx5v0Wdkmk6ffqS+=vUVRHxBx6pyYtpxyk2Fw@mail.gmail.com>
Subject: Re: [PATCH v2] bluetooth, bpf: split sk_filter in l2cap_sock_recv_cb
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

> I modified the original patch to call sk_filter for ERTM before the packet is
> handled by the state machine and to not set the filter locked flag. I tested
> using l2test in ERTM mode, with and without a "randomly drop 1 in 64 packets"
> filter attached.

Thanks for testing. For consistency's sake, is it preferable to filter
at this point for all modes?

>
> Mat
>
> ---
>  net/bluetooth/l2cap_core.c |  4 ++++
>  net/bluetooth/l2cap_sock.c | 13 +++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 54ceb1f..d5de0ce 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -32,6 +32,7 @@
>
>  #include <linux/debugfs.h>
>  #include <linux/crc16.h>
> +#include <linux/filter.h>
>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -6610,6 +6611,9 @@ static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
>                 goto drop;
>         }
>
> +       if (chan->mode == L2CAP_MODE_ERTM && sk_filter(chan->data, skb))
> +               goto drop;
> +

sk_filter can also accept, but trim, packets. If the protocol expects
a header that it unconditionally pulls later, use sk_filter_trim to
avoid trimming to below header length. I think I saw a path from

  l2cap_data_rcv
    l2cap_rx
      l2cap_rx_state_recv
        l2cap_reassemble_sdu
          case L2CAP_SAR_START
            skb_pull(skb, L2CAP_SDULEN_SIZE)
