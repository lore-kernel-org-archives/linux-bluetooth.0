Return-Path: <mathew.j.martineau@linux.intel.com>
Date: Tue, 26 Jul 2016 11:48:25 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Willem de Bruijn <willemb@google.com>
cc: linux-bluetooth@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
    Marcel Holtmann <marcel@holtmann.org>,
    Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
    Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2] bluetooth, bpf: split sk_filter in
 l2cap_sock_recv_cb
In-Reply-To: <CA+FuTSdzHMrhcYHMafnrEs=BqzohT36maH6L=yhOppp_tQHQtw@mail.gmail.com>
Message-ID: <alpine.OSX.2.20.1607261037580.22879@mjmartin-mac01.local>
References: <20160726000523.11189-1-mathew.j.martineau@linux.intel.com> <CA+FuTSc18TsLQQx5v0Wdkmk6ffqS+=vUVRHxBx6pyYtpxyk2Fw@mail.gmail.com> <alpine.OSX.2.20.1607260839140.22879@mjmartin-mac01.local>
 <CA+FuTSdzHMrhcYHMafnrEs=BqzohT36maH6L=yhOppp_tQHQtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


On Tue, 26 Jul 2016, Willem de Bruijn wrote:

> On Tue, Jul 26, 2016 at 1:00 PM, Mat Martineau
> <mathew.j.martineau@linux.intel.com> wrote:
>>
>> On Tue, 26 Jul 2016, Willem de Bruijn wrote:
>>
>>> sk_filter can also accept, but trim, packets. If the protocol expects
>>> a header that it unconditionally pulls later, use sk_filter_trim to
>>
>>
>> sk_filter_trim_cap? I see that you added that recently. It's not in
>> bluetooth-next and we're aiming for a patch that can be easily backported to
>> stable.
>>
>>> avoid trimming to below header length. I think I saw a path from
>>>
>>>  l2cap_data_rcv
>>>    l2cap_rx
>>>      l2cap_rx_state_recv
>>>        l2cap_reassemble_sdu
>>>          case L2CAP_SAR_START
>>>            skb_pull(skb, L2CAP_SDULEN_SIZE)
>>
>>
>> How about checking skb->len before that skb_pull instead?
>
> That works, preferably using pskb_may_pull. The only downside of doing
> that exactly in this path, is that it is not easy to verify that all
> other code paths downstream from sk_filter are also safe. If all
> expect this header, the check is best added right after filter.

The SDULEN header is only present for SAR_START frames (handled on this 
code path), and there is no other manipulation of skb data/tail/len after 
sk_filter. We know these skbs are linear, or at least they were before 
sk_filter was called. Can sk_filter fragment an otherwise linear skb? 
(Looks like the answer is "no" but I'd like to confirm)

--
Mat Martineau
Intel OTC
