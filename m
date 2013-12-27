Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Dec 2013 16:01:27 -0700 (MST)
From: Benson Chow <blc+bluez@mail.vanade.com>
To: Gianluca Anzolin <gianluca@sottospazio.it>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [REGRESSION] rfcomm (userland) broken by commit 29cd718b
In-Reply-To: <20131216211542.GA20419@sottospazio.it>
Message-ID: <alpine.LNX.2.00.1312271536480.28992@doujima.vanade.com>
References: <52AA1854.500@ahsoftware.de> <52AA1E62.1030109@hurleysoftware.com> <52AA483E.4080706@ahsoftware.de> <20131215112413.GA8980@sottospazio.it> <52ADB6B7.5010503@hurleysoftware.com> <20131215150847.GA10288@sottospazio.it> <52AF55B4.6000303@hurleysoftware.com>
 <20131216202044.GA19746@sottospazio.it> <20131216202720.GB19746@sottospazio.it> <20131216205858.GA20119@sottospazio.it> <20131216211542.GA20419@sottospazio.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

First off, thanks for the fix to stop rfcomm from taking down the machine. 
However, I have noted that blueman and networkmanager/modemmanager no 
longer recognize the /dev/rfcomm0 device as a valid dialup device.  This 
seems to be a kernel-userspace interface regression as I can boot into 
3.6.11 and it would work just fine.

When I saw this thread, I agree there appears to be some 
kernel-userspace changes that broke something, but the recent patch still 
did not seem to let modemmanger detect the bluetooth device as it did pre 
linux-3.12.

Blueman reports "connection failed: modem manager did not support 
the connection" implying there's still some userspace differences from the 
old behavior.

I do notice I can run a terminal emulator on /dev/rfcomm0 and able to run 
modem AT-commands which means that I can communicate with the phone 
through bluetooth, so that part is working.  Plus, tearing up that 
connection no longer results in a crash like before linux-3.8.

Any other information I could get from my system to help debug what's 
going on here?  Or perhaps modem-manager will need to be updated to 
work with the new behavior?

Thanks,
-Benson

On Mon, 16 Dec 2013, Gianluca Anzolin wrote:

> Date: Mon, 16 Dec 2013 22:15:42 +0100
> From: Gianluca Anzolin <gianluca@sottospazio.it>
> To: Peter Hurley <peter@hurleysoftware.com>
> Cc: Alexander Holler <holler@ahsoftware.de>, marcel@holtmann.org,
>     Gustavo Padovan <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org,
>     gregkh@linuxfoundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org
> Subject: Re: [REGRESSION] rfcomm (userland) broken by commit 29cd718b
> 
> On Mon, Dec 16, 2013 at 09:58:58PM +0100, Gianluca Anzolin wrote:
>> On Mon, Dec 16, 2013 at 09:27:20PM +0100, Gianluca Anzolin wrote:
>>> On Mon, Dec 16, 2013 at 09:20:44PM +0100, Gianluca Anzolin wrote:
>>>> On Mon, Dec 16, 2013 at 02:34:12PM -0500, Peter Hurley wrote:
>>>>>
>>>>> This solution is acceptable to me, but I think the comment should briefly
>>>>> explain why this fix is necessary, and the changelog should explain why in detail.
>>>>>
>>>>> Perhaps with a fixme comment that rfcomm_tty_install() should just take over
>>>>> the port reference (instead of adding one) and rfcomm_tty_cleanup() should
>>>>> conditionally release on RFCOMM_RELEASE_ONHUP.
>>>>>
>>>>> Because then:
>>>>> 1) this fix would not be necessary.
>>>>> 2) the release in rfcomm_tty_hangup() would not be necessary
>>>>> 3) the second release in rfcomm_release_dev would not be necessary
>>>>> 4) the RFCOMM_TTY_RELEASED bit could be removed
>>>>>
>>>>>
>>>>> Regards,
>>>>> Peter Hurley
>>>>
>>>> Taking over the refcount in the install method would certainly look better. I'm
>>>> going to test it ASAP :D
>>>>
>>>> But why getting rid of the release in in rfcomm_tty_hangup()?
>>>> We could lose the bluetooth connection at any time and the dlc callback
>>>> would have to hangup the tty (and release the port if necessary).
>>>>
>>>> Also the RFCOMM_TTY_RELEASED bit should still be necessary if the port is
>>>> created without the RFCOMM_RELEASE_ONHUP flag.
>>>>
>>>> Besides any process could release the port behind us (with the command rfcomm
>>>> release rfcomm1 for example).
>>>>
>>>> Gianluca
>>>
>>> Nevermind I figured it out the reason...
>>
>> I'm testing the attached patch ATM, which does what you described. It works
>> very well.
>>
>> It doesn't remove the RFCOMM_TTY_RELEASE flag yet, another patch should remove
>> that bit.
>
> ok, replying to myself again (sorry for that). RFCOMM_TTY_RELEASE cannot go
> away. We have still to manage the case where the port is opened without
> RFCOMM_RELEASE_ONHUP.
>
> This last patch does release the port in that situation.
>
> Tested with:
> # rfcomm bind 1 <addr>
> # rfcomm release 1
>
> and with
> # rfcomm connect 1 <addr>
>
> Thanks,
> Gianluca
>
