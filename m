Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Jan 2014 21:32:16 -0700 (MST)
From: Benson Chow <blc+bluez@mail.vanade.com>
To: Gianluca Anzolin <gianluca@sottospazio.it>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [REGRESSION] rfcomm (userland) broken by commit 29cd718b
In-Reply-To: <20131228084421.GA27196@sottospazio.it>
Message-ID: <alpine.LNX.2.00.1401032130500.4071@doujima.vanade.com>
References: <52AA483E.4080706@ahsoftware.de> <20131215112413.GA8980@sottospazio.it> <52ADB6B7.5010503@hurleysoftware.com> <20131215150847.GA10288@sottospazio.it> <52AF55B4.6000303@hurleysoftware.com> <20131216202044.GA19746@sottospazio.it>
 <20131216202720.GB19746@sottospazio.it> <20131216205858.GA20119@sottospazio.it> <20131216211542.GA20419@sottospazio.it> <alpine.LNX.2.00.1312271536480.28992@doujima.vanade.com> <20131228084421.GA27196@sottospazio.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Gianluca,

This patch looks like it did it, from a quick check, everything looks like 
it's working as well as what it was before the 3.8 patch.

Thanks a bunch!

-Benson

On Sat, 28 Dec 2013, Gianluca Anzolin wrote:

> Date: Sat, 28 Dec 2013 09:44:21 +0100
> From: Gianluca Anzolin <gianluca@sottospazio.it>
> To: Benson Chow <blc+bluez@mail.vanade.com>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [REGRESSION] rfcomm (userland) broken by commit 29cd718b
> 
> On Fri, Dec 27, 2013 at 04:01:27PM -0700, Benson Chow wrote:
>> First off, thanks for the fix to stop rfcomm from taking down the
>> machine. However, I have noted that blueman and
>> networkmanager/modemmanager no longer recognize the /dev/rfcomm0
>> device as a valid dialup device.  This seems to be a
>> kernel-userspace interface regression as I can boot into 3.6.11 and
>> it would work just fine.
>>
>> When I saw this thread, I agree there appears to be some
>> kernel-userspace changes that broke something, but the recent patch
>> still did not seem to let modemmanger detect the bluetooth device as
>> it did pre linux-3.12.
>>
>> Blueman reports "connection failed: modem manager did not support
>> the connection" implying there's still some userspace differences
>> from the old behavior.
>>
>> I do notice I can run a terminal emulator on /dev/rfcomm0 and able
>> to run modem AT-commands which means that I can communicate with the
>> phone through bluetooth, so that part is working.  Plus, tearing up
>> that connection no longer results in a crash like before linux-3.8.
>>
>> Any other information I could get from my system to help debug
>> what's going on here?  Or perhaps modem-manager will need to be
>> updated to work with the new behavior?
>>
>> Thanks,
>> -Benson
>
> Thank you for the report.
>
> Could you try the attached patch on top of the last rfc3.patch and see if it
> works?
>
> Regards,
> Gianluca
>

WARNING: All HTML emails get auto deleted.  DO NOT SEND HTML MAIL.
WARNING: Emails with large typo counts/spelling errors will also be deleted.
