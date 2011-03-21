Return-Path: <cyrus@holtmann.org>
Message-ID: <4D87DAC6.3090409@codeaurora.org>
Date: Mon, 21 Mar 2011 16:09:58 -0700
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: SMP data within struct l2cap_conn  -vs-  single threading SMP
References: <4D8286A4.4000706@codeaurora.org> <20110321222829.GA2910@piper>
In-Reply-To: <20110321222829.GA2910@piper>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On 3/21/2011 3:28 PM, Vinicius Costa Gomes wrote:
> Hi Brian,
>
> Sorry for the delay,
>
> On 15:09 Thu 17 Mar, Brian Gix wrote:
>>
>> Hi Vinicius,
>>
>> As you probably know, I am working on adding mgmt.c plumbing into
>> SMP, to enable user level input (Confirmation, passkeys, perhaps
>> OOB).
>>
>
> I didn't know. Cool.
>
>> One issue I am running into is matching up the return of user
>> confirmation with the (struct l2cap_conn *).  There is nothing
>> within the user confirmation aside from the bdaddr that identifies
>> who it is intended for, and there is no one-to-one relationship
>> between bdaddrs and L2CAP channels.
>>
>
> Yeah, I can see why this is a problem.
>
>> What would you think about enforcing a "one at a time" SMP process?
>>
>
> Short answer: seems easier to get right, but a little ugly. Long answer
> below, opinions welcome.
>
>> The SMP pairing data within the l2cap_conn structure is certainly a
>> handy place for it, however it is bulky for the times (most of the
>> time) where SMP is *not* taking place, and as in the obvious case I
>> mention above, there is not a handy way to track the L2CAP
>> connection back to the user input.
>
> I agree that this information needs to be grouped and moved somewhere
> else. Something similar to l2cap_pinfo? smp_pinfo perhaps?

Maybe.  I will look at that mechanism. Is this a way to attach a block 
of data to a socket?

>
>>
>> I would like to suggest that all of the SMP data be pulled out of
>> the l2cap_conn structure, and put into a private structure within
>> smp.c. It can be malloc'd when the pairing process starts, free'd
>> when it completes, and any traffic (from either the User or the
>> Baseband) that takes place when another device is in the midst of
>> pairing gets rejected.
>
> This sounds very tempting, but I don't think that imposing this
> restriction from kernel side is the right aproach, the only hard
> limitation that I can imagine is user interaction. And if we use
> Just Works even that limitation is droped.

The JUST_WORKS case becomes a race condition.  In my experience, because 
there is no user interaction (aside from the initial action the caused 
the request), this all happens in well under a second. The 
"inconvenience factor" is therefore mitigated by it being very short.

Also, for the foreseeable future, the RF links do not have the ability 
to be connected to more than one LE peer at a time, making concurrent LE 
SMP sessions a technical impossibility at this point regardless (except 
in the case of multiple adapters).

>
> One question: what were your plans for dealing with multiple adapters?

I didn't have any. I still sort of think that concurrent pairing is 
unlikely to ever be a critical use case. Even though user input is a 
user space responsibility and not kernel, I think accounting for the 
fact that the User can only respond to a single pairing request at a 
time should not be ignored if it can make the code simpler.

>
> Btw, it would be great if we could maintain a similar behaviour to
> Basic Rate.

There will necessarily need to be some minor changes due to the fact 
that passkey handling is different between BR and LE. In BR, if both 
devices have Displays and Y/N capabilities, the same passkey is 
presented to both, and other than visual comparison, nobody has to 
actually enter the digits.  In LE, for MITM protection without oob, one 
of the two devices MUST be able to enter a 6 digit number.

I think both BR interfaces will be maintained as is, and I am adding a 
"one off" of the standard JUST WORKS, plus a couple explicit requests:

1. If Local Device has Input capabilities, it will be asked to 
Accept/Reject any *BONDING* requests, even if the pairing method is 
JUST_WORKS. This isn't really necessary if not bonding. This aligns with 
standard BR functionality, which requests confirmation even without MITM 
authentication.

2. I am writing a new MGMT function which explicitely requests a 
passkey. The existing one for BR always supplies the baseband generated 
passkey (which doesn't exist in LE), and passes that to user space, 
which can be used either to visually compare, or to request user entry 
of matching value.

3. I am adding a placeholder for OOB input which I intend to leave as an 
unused shell for now, until I see a little more about how it is done for 
BR. I see patches being submitted by Szymon Janc for BR OOB, so I don't 
imagine we'll be waiting for too long for that.


>
>>
>> This structure local to smp.c would store both the bdaddr (to match
>> up with user input) and the l2cap_conn * to match up with BB
>> traffic, and provide the outbound path for the user confirmation
>> which would otherwise be difficult to track down.
>
> It would be a little harder but we could do something similar to l2cap
> when it's needed to find a socket associated with a connection.
>
>>
>> Your Thoughts?
>>
>> --
>> Brian Gix
>> bgix@codeaurora.org
>> Employee of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
>
> Cheers,


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
