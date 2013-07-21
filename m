Return-Path: <cyrus@holtmann.org>
Message-ID: <51EC1483.8030608@hurleysoftware.com>
Date: Sun, 21 Jul 2013 13:04:03 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org
Subject: Re: [PATCH 3/8] Move device initialization and shutdown to tty_port_operations
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it> <1373661649-1385-3-git-send-email-gianluca@sottospazio.it> <51E5B196.7010704@hurleysoftware.com> <20130720071059.GA28216@sottospazio.it> <51EA9AA6.3000000@hurleysoftware.com> <20130721080838.GA2998@sottospazio.it>
In-Reply-To: <20130721080838.GA2998@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/21/2013 04:08 AM, Gianluca Anzolin wrote:
> On Sat, Jul 20, 2013 at 10:11:50AM -0400, Peter Hurley wrote:
>> Sorry Gianluca, I should have been more specific here.
>>
>> There's no need to test for dlc->state == BT_CLOSED in carrier_raised().
>> At the point where port->carrier_raised is called, the tty will have been
>> linked with the file descriptor, so if the dlc->state goes to BT_CLOSED,
>> then rfcomm_dev_state_change() will call
>>    tty_hangup() -> driver hangup() -> tty_port_hangup() -> tty_port_shutdown()
>> This call chain will
>>    1. set the file_ops to hung_up_tty_fops which will cause tty_hung_up_p() to
>>       return true
>>    2. clear ASYNCB_INITIALIZED in port->flags
>>    3. wakeup port->open_wait
>>
>> So an open() parked in the schedule loop of tty_port_block_til_ready()
>> will wake and exit the loop with either -EAGAIN or -ERESTARTSYS.
>>
>> rfcomm_dev_state_change() should only do a wakeup on port->open_wait when
>> dlc->state == BT_CONNECTED.
>>
>>> In case of success I should also call some device_move,
>>> rfcomm_tty_copy_pending and rfcomm_dlc_unthrottle. Could I do it in
>>> carrier_raised directly?
>>
>> I wouldn't. That would be a nasty hack and a potential problem if a
>> signal occurred.
>>
>> The device_move() isn't dependent on success, and can stay in .activate().
>
> I changed the code and it's cleaner than before, very nice. However the
> device_move() is really dependent on success: the parent device is there only
> when the connection has been successfully established.

Oh, right.

> So I have to call that function after the carrier is raised, or right before.
> Since you already told me that calling it in the .carrier_raised method is
> unwise the only place left is the state_change callback of the dlc.

That seems fine. [ Another place would be in rfcomm_tty_open() just after
tty_port_open() returns success -- the tty is still locked here so it won't
race with .close/.hangup() ]

I do wonder why the tty device is re-parented to the host controller device.
It's obviously not for subsystem teardown. Maybe one of the bluetooth
maintainers could clarify this? Are there userspace components waiting for
this uevent?

> Conversely in .shutdown the check for the device parent == NULL takes care of
> the scenario in which the aforementioned device_move() is never called.
>
> Another unrelated question: I'm working on the rfcomm_dev_add function to avoid
> the two nested locks. When the patch is ready should I send it separately or
> can I include it with the other patches?

Your preference.

Just a reminder: the dlc lock will still need to be dropped after bumping the
rfcomm_dev ref count via rfcomm_dev_get(), because when you subsequently drop
both references, rfcomm_dev destruction will attempt to gain the dlc lock,
resulting in deadlock. [Or do it as a work item]

Regards,
Peter Hurley
