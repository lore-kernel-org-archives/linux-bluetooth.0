Return-Path: <cyrus@holtmann.org>
Message-ID: <51F3B7E9.2040208@hurleysoftware.com>
Date: Sat, 27 Jul 2013 08:07:05 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
 jslaby@suse.cz
Subject: Re: [PATCH v4 5/6] rfcomm: Fix the reference counting of tty_port
References: <1374859138-19467-1-git-send-email-gianluca@sottospazio.it> <1374859138-19467-6-git-send-email-gianluca@sottospazio.it> <51F3125F.30303@hurleysoftware.com> <20130727044809.GA22696@sottospazio.it>
In-Reply-To: <20130727044809.GA22696@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/27/2013 12:48 AM, Gianluca Anzolin wrote:
> On Fri, Jul 26, 2013 at 08:20:47PM -0400, Peter Hurley wrote:
>> On 07/26/2013 01:18 PM, Gianluca Anzolin wrote:
>>> @@ -614,7 +601,9 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
>>>   					return;
>>>   				}
>>>
>>> -				rfcomm_dev_del(dev);
>>> +				set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
>>> +				tty_port_put(&dev->port);
>>
>> Since this code can execute concurrently with rfcomm_release_dev(),
>> and the 'initial' port reference must only be dropped once, this should be
>>
>> 				if (!test_and_set_bit(RFCOMM_TTY_RELEASED, &dev->flags)
>> 					tty_port_put(&dev->port);
>>
>> Regards,
>> Peter Hurley
>
> I somehow convinced myself that it was safe but clearly it wasn't. Should I
> also change the same way the code in rfcomm_tty_hangup()?

Yes, I think that's wise. For example,

CPU 0                                  | CPU 1
                                        |
rfcomm_dev_state_change                |
   tty_port_tty_get                     |
     tty_hangup                         | rfcomm_release_dev
      .                                 |   .
      .                                 |   .
      .                                 |   .
     do_tty_hangup                      |   .
       __tty_hangup                     |   .
         rfcomm_tty_hangup              |   .
           tty_port_hangup              |   .
                                        |   if (!test_and_set_bit(RFCOMM_TTY_RELEASED))
                                        |     tty_port_put
           set_bit(RFCOMM_TTY_RELEASED) |
           tty_port_put                 |

Also, in the commit message you should explain that
!test_and_set_bit(RFCOMM_TTY_RELEASED) ensures that the 'initial'
tty_port reference is only dropped once.

On a side note, I think this exposes a flaw in the tty layer hangup handling.
It seems possible that an async hangup could be scheduled while a
sync hangup is in-progress (and vice versa). While the two hangups would
not execute concurrently (because the tty lock serializes hangups),
they would execute sequentially and that would be bad.

I'm testing a mock-up now.

Regards,
Peter Hurley
