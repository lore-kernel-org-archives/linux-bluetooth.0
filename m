Return-Path: <cyrus@holtmann.org>
Message-ID: <506B4CC3.1010203@globaledgesoft.com>
Date: Wed, 03 Oct 2012 01:51:23 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: L2CAP Flush_Timeout  Error
References: <506B4479.3050105@globaledgesoft.com>
In-Reply-To: <506B4479.3050105@globaledgesoft.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



> On Tue, Oct 02, 2012 at 11:48:56PM +0530, Ajay wrote:
>> Hi,
>>      Im currently working in an A2DP stuff, where i noticed an error.
>> Here i wanted to monitor the flushed packets due to timeout.
>>
>>   I used the  l2test code for my testing purpose
>>
>>                On client side   "l2test  -R  -S <bdadddr> "
>>                and i set the flush timeout as 100 (opts.flush_to = 100)
>>
>>         But  later  when i print the getsockopt value of flush_to, it
>> was showing some default value (65532)  harcoded at kernel side.
>
> Try the patch in this thread.
>
> Best regards
> Andrei Emeltchenko
>

    Thanks for your patch , its working fine. Now even  if i set the
flush_timeout = 5 , i couldnt  able to see any packets missing at the
receiver side . Here in the sender  side  im giving proper sequence
number, and these same sequence is getting at the receiver side . i
doubted even though its flushing , controller is doing some
retransmission job...please help . My kernel is 2.6.39 , and im using
BASIC MODE of transmission. so shall i change it to STEAMING MODE ????

-- 
  Thanks & regards

AJAY KV
8892753703


