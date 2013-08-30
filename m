Return-Path: <cyrus@holtmann.org>
Message-ID: <52211677.4000406@hurleysoftware.com>
Date: Fri, 30 Aug 2013 18:02:31 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: Alexander Holler <holler@ahsoftware.de>, gustavo@padovan.org,
 marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.cz
Subject: Re: [PATCH v5 0/6] rfcomm: Implement rfcomm as a proper tty_port
References: <1375110493-5237-1-git-send-email-gianluca@sottospazio.it> <51F94E67.3040402@hurleysoftware.com> <52127E0A.6060208@hurleysoftware.com> <521CB03B.1030003@ahsoftware.de> <521CE6E1.2020206@hurleysoftware.com> <20130830174916.GA7204@sottospazio.it>
In-Reply-To: <20130830174916.GA7204@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/30/2013 01:49 PM, Gianluca Anzolin wrote:
> On Tue, Aug 27, 2013 at 01:50:25PM -0400, Peter Hurley wrote:
>> On 08/27/2013 09:57 AM, Alexander Holler wrote:
>>> Am 19.08.2013 22:20, schrieb Peter Hurley:
>>>> On 07/31/2013 01:50 PM, Peter Hurley wrote:
>>>
>>>>> I reviewed these changes and retested. All ok.
>>>>
>>>> Gustavo,
>>>>
>>>> This series fixes a crashing regression from 3.10+ forward.
>>>> Why is this not in linux-next yet?
>>>
>>> 3.8+ to be exact, just in case someone has to deal with older kernels.
>>
>> Thanks for the reminder.
>>
>> This series is too extensive to consider for -stable. Any ideas for
>> how to address this crash for -stable?
>>
>> Regards,
>> Peter Hurley
>>
>
> The tty refcount patch is needed but clearly not sufficient because the system
> locks up when the device is released.
>
> Unfortunately I cannot capture any oops, this is why I went and implemented the
> tty port methods in the first place, inspired by the usb serial code.
>
> I agree the patches are extensive and a solution is needed not only for 3.10
> kernels but also for 3.11.
>
> It's not clear for me how to debug the old code further. A couple of patches
> to make the debug process easier were mentioned before but I cannot find
> them. Could anybody point me at them?

I was thinking more along the lines of what we could go back and revert,
rather than re-engineering another solution.

Regards,
Peter Hurley
