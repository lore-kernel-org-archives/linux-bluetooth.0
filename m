Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 26 Jul 2016 10:00:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Willem de Bruijn <willemb@google.com>
cc: linux-bluetooth@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2] bluetooth, bpf: split sk_filter in
 l2cap_sock_recv_cb
In-Reply-To: <CA+FuTSc18TsLQQx5v0Wdkmk6ffqS+=vUVRHxBx6pyYtpxyk2Fw@mail.gmail.com>
Message-ID: <alpine.OSX.2.20.1607260839140.22879@mjmartin-mac01.local>
References: <20160726000523.11189-1-mathew.j.martineau@linux.intel.com> <CA+FuTSc18TsLQQx5v0Wdkmk6ffqS+=vUVRHxBx6pyYtpxyk2Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Tue, 26 Jul 2016, Willem de Bruijn wrote:

>> I modified the original patch to call sk_filter for ERTM before the packet is
>> handled by the state machine and to not set the filter locked flag. I tested
>> using l2test in ERTM mode, with and without a "randomly drop 1 in 64 packets"
>> filter attached.
>
> Thanks for testing. For consistency's sake, is it preferable to filter
> at this point for all modes?

Only ERTM and streaming mode end up on this code path, and I think there's 
a benefit to handling these two modes similarly. There are a number of 
other paths to l2cap_sock_recv_cb(), and there isn't one perfect place to 
call sk_filter for all modes.

>
>>
>> Mat
>>
>> ---
>>  net/bluetooth/l2cap_core.c |  4 ++++
>>  net/bluetooth/l2cap_sock.c | 13 +++++++++++--
>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 54ceb1f..d5de0ce 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -32,6 +32,7 @@
>>
>>  #include <linux/debugfs.h>
>>  #include <linux/crc16.h>
>> +#include <linux/filter.h>
>>
>>  #include <net/bluetooth/bluetooth.h>
>>  #include <net/bluetooth/hci_core.h>
>> @@ -6610,6 +6611,9 @@ static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
>>                 goto drop;
>>         }
>>
>> +       if (chan->mode == L2CAP_MODE_ERTM && sk_filter(chan->data, skb))
>> +               goto drop;
>> +
>
> sk_filter can also accept, but trim, packets. If the protocol expects
> a header that it unconditionally pulls later, use sk_filter_trim to

sk_filter_trim_cap? I see that you added that recently. It's not in 
bluetooth-next and we're aiming for a patch that can be easily backported 
to stable.

> avoid trimming to below header length. I think I saw a path from
>
>  l2cap_data_rcv
>    l2cap_rx
>      l2cap_rx_state_recv
>        l2cap_reassemble_sdu
>          case L2CAP_SAR_START
>            skb_pull(skb, L2CAP_SDULEN_SIZE)

How about checking skb->len before that skb_pull instead?

--
Mat Martineau
Intel OTC
