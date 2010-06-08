Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jun 2010 14:13:17 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
cc: Nathan Holstein <ngh@isomerica.net>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: L2CAP ERTM compatibility problem
In-Reply-To: <20100608205125.GA24245@vigoh>
Message-ID: <alpine.DEB.2.00.1006081406110.31069@linux-sea-02>
References: <1276017637.3546.519.camel@strawberry> <20100608205125.GA24245@vigoh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On Tue, 8 Jun 2010, Gustavo F. Padovan wrote:

> Hi Nathan,
>
> * Nathan Holstein <ngh@isomerica.net> [2010-06-08 13:20:37 -0400]:
>
>> I'm currently testing an older set of Gustavo's ERTM fixes backported
>> onto a 2.6.32 kernel.  I'm seeing a compatibility problem while
>> attempting to establish a connection using ERTM.  This appears to be
>> caused by commit 277ffbe in Gustavo's testing tree which adds minimum
>> length checks to received ERTM and Streaming Mode packets.
>>
>> Here's the incoming packet (hcidump -Xt):
>>
>>         1276011301.453633 > ACL data: handle 12 flags 0x02 dlen 11
>>             L2CAP(d): cid 0x0040 len 7 [psm 0]
>>               0000: 02 01 07 00 06 2e 0b
>>
>> This appears to be a valid packet containing a three byte sequence which
>> should be passed up to the application.  However, the check added by
>> commit 277ffbe causes the kernel to disconnect the socket since the data
>> length is less than 4.
>>
>> I don't see the point of the minimum length at this point in the code.
>> The len variable already subtracts for the control, FCS and SAR fields
>> if necessary.  It seems to me that the remaining length of the skb is
>> purely socket data, and as such should be passed on to the application.
>
> The checks comes from the section 3.3.7 of the L2CAP spec.
>
>>
>> Here's my proposed fix:
>>
>>         @@ -4189,19 +4193,23 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>>
>>
>>                         if (__is_iframe(control)) {
>>         -                       if (len < 4) {
>>         +                       if (len < 0) {
>>                                         l2cap_send_disconn_req(pi->conn, sk);
>>                                         goto drop;
>>                                 }
>>         @@ -4222,7 +4230,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>>                         if (pi->fcs == L2CAP_FCS_CRC16)
>>                                 len -= 2;
>>
>>         -               if (len > pi->mps || len < 4 || __is_sframe(control))
>>         +               if (len > pi->mps || len < 0 || __is_sframe(control))
>>                                 goto drop;
>>
>>                         if (l2cap_check_fcs(pi, skb))
>>
>> This lowers the minimum-packet length of I-frame and streaming mode
>> packets put in place by commit 277ffbe.  It maintains the length check
>> for S-frames.  I believe ensuring a non-negative length is necessary,
>> but this check may need to be performed prior to the call to
>> l2cap_check_fcs().
>
> I agree with you that we should lower the value to 0. Please, send a proper
> git-formatted patch so I can pick it.

However, len is an unsigned value that will never be less than 0.  The 
easy fix is probably to make len an int instead of a u16.

-- 
Mat Martineau
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
