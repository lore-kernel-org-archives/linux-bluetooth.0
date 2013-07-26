Return-Path: <cyrus@holtmann.org>
Message-ID: <51F2776F.7010108@hurleysoftware.com>
Date: Fri, 26 Jul 2013 09:19:43 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/6] rfcomm: Take proper tty_struct references
References: <1374777133-12397-1-git-send-email-gianluca@sottospazio.it> <51F26682.1010404@hurleysoftware.com> <20130726125040.GA17477@sottospazio.it>
In-Reply-To: <20130726125040.GA17477@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/26/2013 08:50 AM, Gianluca Anzolin wrote:
> On Fri, Jul 26, 2013 at 08:07:30AM -0400, Peter Hurley wrote:
>> On 07/25/2013 02:32 PM, Gianluca Anzolin wrote:
>>>
>>>   	rfcomm_dlc_lock(dlc);
>>>   	tty->driver_data = dev;
>>> -	dev->port.tty = tty;
>>> +	tty_port_tty_set(&dev->port, tty);
>>
>> Although strictly speaking, this is correct, I would drop this change
>> because its functionality is replaced in 4/6 with the call to tty_port_open().
>> If you want, you could note in the commit message that the
>> raw assignments in rfcomm_tty_open/close are addressed in commit
>> 'rfcomm: Implement .activate, .shutdown and .carrier_raised methods'.
>
> Ok I will do that.
>
>>
>> [ BTW, you remove this line in 3/6 but it's needed until 4/6]
>
> Oh, I overlooked that "detail" when I changed the order of the patches...

Same thing just happened to me with a series of mine.

>>
>>>   	rfcomm_dlc_unlock(dlc);
>>>   	set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
>>>
>>> @@ -742,7 +747,7 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
>>>
>>>   		rfcomm_dlc_lock(dev->dlc);
>>>   		tty->driver_data = NULL;
>>> -		dev->port.tty = NULL;
>>> +		tty_port_tty_set(&dev->port, NULL);
>>
>> Similarly, the call to tty_port_close() in 4/6 replaces this functionality.
>>
>> Regards,
>> Peter Hurley
>>
>
> Ok there is a need for a v4 after all.
>
> Btw did you look at the RFC patch about the dev_add nested locks?
> Do you think it's acceptable? I tried to add the device to the list at the end
> of the function but the fact is that the dlc callbacks need dev->id so I had to
> allocate it or set it to something not valid, like -1.
 >
 > I didn't also get any reply about the skb_queue_purge patch, I hope it's ok

I'm testing the whole patch series now. Assuming nothing breaks and v4 changes
are minimal, I'll give the whole series Reviewed-by: and Tested-by: tags.

When I'm done with that, I'll review the RFC patch.

For v4, you should direct To: Gustavo Padovan, cc: me instead, and add
cc's for Greg Kroah-Hartman <gregkh@linuxfoundation.org> and Jiri Slaby
<jslaby@suse.cz>

Regards,
Peter Hurley


For future reference, for a series like this you might want to consider
adding a cover letter 0/6 (with git format-patch --cover-letter) with an
overview of the whole series.

Cover letters give you an opportunity to explain the motivation
(rfcomm crashes on device disconnect because port reference counting
was broken), explain your solution (implement rfcomm as a proper tty_port),
and allows reviewers to comment on the series as whole (Good work :).
