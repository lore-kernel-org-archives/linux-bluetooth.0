Return-Path: <cyrus@holtmann.org>
Message-ID: <52AA1854.500@ahsoftware.de>
Date: Thu, 12 Dec 2013 21:11:00 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Gustavo Padovan <gustavo@padovan.org>,
 Gianluca Anzolin <gianluca@sottospazio.it>,
 peter@hurleysoftware.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
 jslaby@suse.cz, linux-kernel@vger.kernel.org
Subject: [REGRESSION] rfcomm (userland) broken by commit 29cd718b
References: <1377620926-23370-1-git-send-email-gianluca@sottospazio.it> <20130919162413.GG4006@joana>
In-Reply-To: <20130919162413.GG4006@joana>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

since commit 29cd718beba999bda4bdbbf59b5a4d25c07e1547 "rfcomm: don't 
release the port in rfcomm_dev_state_change()" the userland utility 
rfcomm (both from bluez 4.101 and 5.12) is broken.

In detail the following note in the patch

Am 19.09.2013 18:24, schrieb Gustavo Padovan:
> Hi Gianluca,
>
> 2013-08-27 Gianluca Anzolin <gianluca@sottospazio.it>:
>
>> When the dlc is closed, rfcomm_dev_state_change() tries to release the
>> port in the case it cannot get a reference to the tty. However this is
>> racy and not even needed.
>>
>> Infact as Peter Hurley points out:

(...)

>> 4. After releasing the dlc lock in rfcomm_dev_add(),
>>     rfcomm_dev_state_change() will 'see' an incomplete rfcomm_dev if a
>>     tty reference could not be obtained. Again, the best thing to do here
>>     is nothing. Any future attempted open() will block on
>>     rfcomm_dev_carrier_raised(). The unconnected device will exist until
>>     released by ioctl(RFCOMMRELEASEDEV).
>>
>> The patch removes the aforementioned code and uses the
>> tty_port_tty_hangup() helper to hangup the tty.

reads like the usage of that ioctl now necessary.

What currently happens is that when one kills rfcomm (and any other 
terminal which might use that tty), the entry in /dev doesn't disappear. 
That means the same call to refcomm with the same device (e.g. 
[/dev/]rfcomm1 doesn't work.

My current solution is to just revert that commit.
I haven't tested if modifying (the userland utility) rfcomm (adding that 
ioctl) will help, but that looks only like a longterm solution.

Regards,

Alexander Holler
