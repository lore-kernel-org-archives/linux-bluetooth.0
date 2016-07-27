Return-Path: <mathew.j.martineau@linux.intel.com>
Date: Wed, 27 Jul 2016 11:43:54 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Willem de Bruijn <willemb@google.com>,
    "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
    Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2] bluetooth, bpf: split sk_filter in
 l2cap_sock_recv_cb
In-Reply-To: <F5CADE2F-FF8C-4EBD-A56D-1C35DCA7B654@holtmann.org>
Message-ID: <alpine.OSX.2.20.1607271140320.866@mjmartin-mac01.wa.intel.com>
References: <20160726000523.11189-1-mathew.j.martineau@linux.intel.com> <CA+FuTSc18TsLQQx5v0Wdkmk6ffqS+=vUVRHxBx6pyYtpxyk2Fw@mail.gmail.com> <alpine.OSX.2.20.1607260839140.22879@mjmartin-mac01.local> <F5CADE2F-FF8C-4EBD-A56D-1C35DCA7B654@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 27 Jul 2016, Marcel Holtmann wrote:

> Hi Mat,
>
>>>> I modified the original patch to call sk_filter for ERTM before the packet is
>>>> handled by the state machine and to not set the filter locked flag. I tested
>>>> using l2test in ERTM mode, with and without a "randomly drop 1 in 64 packets"
>>>> filter attached.
>>>
>>> Thanks for testing. For consistency's sake, is it preferable to filter
>>> at this point for all modes?
>>
>> Only ERTM and streaming mode end up on this code path, and I think there's a benefit to handling these two modes similarly. There are a number of other paths to l2cap_sock_recv_cb(), and there isn't one perfect place to call sk_filter for all modes.
>
> would code restructuring help to create a better place to put sk_filter?

Maybe, but I'm not sure it's worthwhile for this purpose alone. The 
handling for ERTM is similar to what I see for TCP, but for LE we want to 
issue credits and do some more reassembly before filtering.

>
>>>>
>>>> ---
>>>> net/bluetooth/l2cap_core.c |  4 ++++
>>>> net/bluetooth/l2cap_sock.c | 13 +++++++++++--
>>>> 2 files changed, 15 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>>>> index 54ceb1f..d5de0ce 100644
>>>> --- a/net/bluetooth/l2cap_core.c
>>>> +++ b/net/bluetooth/l2cap_core.c
>>>> @@ -32,6 +32,7 @@
>>>>
>>>> #include <linux/debugfs.h>
>>>> #include <linux/crc16.h>
>>>> +#include <linux/filter.h>
>>>>
>>>> #include <net/bluetooth/bluetooth.h>
>>>> #include <net/bluetooth/hci_core.h>
>>>> @@ -6610,6 +6611,9 @@ static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
>>>>                goto drop;
>>>>        }
>>>>
>>>> +       if (chan->mode == L2CAP_MODE_ERTM && sk_filter(chan->data, skb))
>>>> +               goto drop;
>>>> +
>>>
>>> sk_filter can also accept, but trim, packets. If the protocol expects
>>> a header that it unconditionally pulls later, use sk_filter_trim to
>>
>> sk_filter_trim_cap? I see that you added that recently. It's not in bluetooth-next and we're aiming for a patch that can be easily backported to stable.
>
> Lets create a version that fixes this first. One version that we can backport into stable. And then we can start utilizing newer infrastructure available in Linus' tree.

I believe v3 is a fix suitable for stable.

--
Mat Martineau
Intel OTC
