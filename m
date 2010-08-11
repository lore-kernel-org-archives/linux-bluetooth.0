Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Aug 2010 19:24:20 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
    rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 2/7] Bluetooth: Use enhanced L2CAP header structure and
 symbolic values.
In-Reply-To: <20100810220712.GC3203@vigoh>
Message-ID: <alpine.DEB.2.00.1008101916090.6276@linux-sea-02>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org> <1281467704-5378-3-git-send-email-mathewm@codeaurora.org> <20100810220712.GC3203@vigoh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>



Gustavo -

On Tue, 10 Aug 2010, Gustavo F. Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2010-08-10 12:14:59 -0700]:
>
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  net/bluetooth/l2cap.c |   23 +++++++++++++----------
>>  1 files changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index 5e78c18..aa69c84 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -1753,33 +1753,36 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *m
>>  {
>>  	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
>>  	struct sk_buff *skb;
>> -	int err, count, hlen = L2CAP_HDR_SIZE + 2;
>> -	struct l2cap_hdr *lh;
>> +	int err, count, hlen = L2CAP_ENHANCED_HDR_SIZE;
>> +	struct l2cap_enhanced_hdr *lh;
>
> This patch shouldn't even compile. Since there no definition for
> struct l2cap_enhanced_hdr. Anyway we should not have that struct, keep
> the code to handle this as it is.
> We'll have to change this code again to add the extended control bit
> field.

Sorry about that - I did my git format-patch starting one commit too 
late.

I also have an l2cap_extended_hdr struct to add later, but it sounds 
like you don't want that one either.

>
>>
>> -	BT_DBG("sk %p len %d", sk, (int)len);
>> +	BT_DBG("sk %p, msg %p, len %d, control %x, sdulen %d",
>> +		sk, msg, (int)len, control, (int)sdulen);
>>
>>  	if (!conn)
>>  		return ERR_PTR(-ENOTCONN);
>>
>>  	if (sdulen)
>> -		hlen += 2;
>> +		hlen += L2CAP_SDULEN_SIZE;
>
> Separated patch to add L2CAP_SDULEN_SIZE

Ok.

>>
>>  	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16)
>> -		hlen += 2;
>> +		hlen += L2CAP_FCS_SIZE;
>
> Separated patch to ad L2CAP_FCS_SIZE

Ok.  Does this need to be separate from the L2CAP_SDULEN_SIZE patch?

>
>>
>>  	count = min_t(unsigned int, (conn->mtu - hlen), len);
>> +
>>  	skb = bt_skb_send_alloc(sk, count + hlen,
>>  			msg->msg_flags & MSG_DONTWAIT, &err);
>>  	if (!skb)
>> -		return ERR_PTR(-ENOMEM);
>> +		return ERR_PTR(err);
>
> This also should not be in this patch.

No problem.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
