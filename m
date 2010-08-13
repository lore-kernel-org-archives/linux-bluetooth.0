Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Aug 2010 17:07:46 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: Re: [RFC 5/7] Bluetooth: Handle fragmented skbs in
 bt_sock_stream_recvmsg()
In-Reply-To: <20100811042543.GA9428@vigoh>
Message-ID: <alpine.DEB.2.00.1008121643480.8460@linux-sea-02>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org> <1281467704-5378-6-git-send-email-mathewm@codeaurora.org> <20100811042543.GA9428@vigoh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On Wed, 11 Aug 2010, Gustavo F. Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2010-08-10 12:15:02 -0700]:
>
>> When reading L2CAP skbuffs, add the ability to copy from
>> fragmented skbuffs generated during ERTM or streaming mode
>> reassembly.  This defers extra copying of L2CAP payloads
>> until the final, unavoidable copy to userspace.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/af_bluetooth.c |   30 ++++++++++++++++++++++++++++--
>>  1 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
>> index 77a26fe..5e0375b 100644
>> --- a/net/bluetooth/af_bluetooth.c
>> +++ b/net/bluetooth/af_bluetooth.c
>> @@ -342,7 +342,7 @@ int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
>>  		}
>>
>>  		chunk = min_t(unsigned int, skb->len, size);
>> -		if (memcpy_toiovec(msg->msg_iov, skb->data, chunk)) {
>> +		if (skb_copy_datagram_iovec(skb, 0, msg->msg_iov, chunk)) {
>>  			skb_queue_head(&sk->sk_receive_queue, skb);
>>  			if (!copied)
>>  				copied = -EFAULT;
>> @@ -354,7 +354,33 @@ int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
>>  		sock_recv_ts_and_drops(msg, sk, skb);
>>
>>  		if (!(flags & MSG_PEEK)) {
>> -			skb_pull(skb, chunk);
>> +			int skb_len = skb_headlen(skb);
>
> Why are you using the header length here?

skb_headlen() returns the length of the first fragment.


>> +
>> +			if (chunk <= skb_len) {
>> +				__skb_pull(skb, chunk);
>> +			} else {
>> +				struct sk_buff *frag;
>> +
>> +				__skb_pull(skb, skb_len);
>> +				chunk -= skb_len;
>
> Why do we have this __skb_pull() here? I think skb_walk_frags() can
> handle everything.

That first __skb_pull() is necessary to deal with data in the first 
skbuff, and the skb_walk_frags() deals with anything in 
skb_shinfo(skb)->frag_list.  The linked skb list looks roughly like 
this:

skb
  unsigned char *data -> (L2CAP data)
  struct sk_buff *frag_list -> 2nd frag
                                 unsigned char *data -> (more data)
                                 struct sk_buff *next -> 3rd frag
                                                           (etc.)

So the first frag is special - the pointer to the fragment is 
frag_list.  Each linked fragment after that uses the "next" pointer in 
the sk_buff struct.  The skb_walk_frags() macro starts with the 
sk_buff pointed to by frag_list, then follows the "next" links.



>> +
>> +				skb_walk_frags(skb, frag) {
>> +					if (chunk <= frag->len) {
>> +						/* Pulling partial data */
>> +						skb->len -= chunk;
>> +						skb->data_len -= chunk;
>> +						__skb_pull(frag, chunk);
>> +						break;
>
> If we break here what will happen whit the rest of the data to be
> pulled.

The data is left to be pulled later.  The skb is not freed until all 
the fragments are empty, and this is handled by existing code.  I've 
added the next couple of lines of context below to help explain.

>
>> +					} else if (frag->len) {
>> +						/* Pulling all frag data */
>> +						chunk -= frag->len;
>> +						skb->len -= frag->len;
>> +						skb->data_len -= frag->len;
>> +						__skb_pull(frag, frag->len);
>> +					}
>> +				}
>> +			}
>> +
>>  			if (skb->len) {
>>  				skb_queue_head(&sk->sk_receive_queue, skb);
>>  				break;
                         }
                         kfree_skb(skb);

If the skb is not empty, it's pushed back on the head of the receive 
queue.  If it is empty, it's freed.

I based this approach on some code I found in the SCTP protocol.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


