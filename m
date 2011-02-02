Return-Path: <cyrus@holtmann.org>
Message-ID: <4D49879F.8020000@Atheros.com>
Date: Wed, 2 Feb 2011 22:04:39 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC] Bluetooth: process received S-frames when socket is locked
 by user process
References: <1296479571-2971-1-git-send-email-suraj@atheros.com> <20110202162818.GD2273@joana>
In-Reply-To: <20110202162818.GD2273@joana>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 2/2/2011 9:58 PM, Gustavo F. Padovan wrote:
> Hi Suraj,
>
> * Suraj Sumangala<suraj@atheros.com>  [2011-01-31 18:42:51 +0530]:
>
>> This patch lets L2CAP process received S-frames even when socket is
>> continuously being locked by user process.
>>
>> This issue was seen when testing with l2test without using "-D" option.
>>
>> Since the user process does not expect any Rx packets,
>> it hogs the socket with continuous call to "send()".
>>
>> When the TxWindow is full Tx stops untill the I-frames are acked by the receiver.
>>
>> But the Rx S-Frame acknowleding the Tx frames will stay in the backlog queue
>> because the "sock_owned_by_user()" call in l2cap_data_channel()
>> will always return true.
>>
>> The user process does not have an idea about this
>> mechanism and keep pumping data and locking the socket and cause a deadlock.
>
> In which kernel are you seeing this error? I think it is already fixed.
>
> Regards,
>

Can you direct me to the patch which fixed it?
I had see this problem when verifying Bluetooth 3.0 in kernel version 
2.6.35 and see similar code in the kernel-next tree. That is the reason 
why I sent an RFC.

Regards
Suraj
