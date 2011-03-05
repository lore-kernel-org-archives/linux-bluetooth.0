Return-Path: <cyrus@holtmann.org>
Message-ID: <4D71F996.1070203@Atheros.com>
Date: Sat, 5 Mar 2011 14:21:34 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: updating unacked_frames counter during retransmission
References: <4D6F358B.9020603@Atheros.com> <20110305005309.GB9005@joana>
In-Reply-To: <20110305005309.GB9005@joana>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 3/5/2011 6:23 AM, Gustavo F. Padovan wrote:
> Hi Suraj,
>
> * Suraj Sumangala<suraj@Atheros.com>  [2011-03-03 12:00:35 +0530]:
>
>> Hi Gustavo,
>>
>> I have a question regarding the ERTM implementation.
>>
>> Should we be incrementing the "l2cap_pinfo.unacked_frames" variable if
>> we are retransmitting a frame?
>
> No, if we are retransmitting a frame that means L2CAP didn't received an ack
> for it and we are already accounting it in unacked_frames and there is no need
> to increment unacked_frames in this case.

I think right now we are incrementing the "l2cap_pinfo.unacked_frames" 
for retransmission also.
>
>>
>> Won't this cause the same frame to be accounted twice?
>>
>> If there are too many retransmissions, will there be a chance that
>> "unacked_frames" could cross 0xFF and over flow.
>
> No, unacked_frames number is limited by the remote transmission window size.
>
Actually, I am seeing an overflow (crossing the remote transmit window) 
issue, when there is retransmission. This was found in older kernel(2.6.35).

So not sure if this is valid in the latest kernel. Will anyway try to 
send a patch for the same.

Regards
Suraj


