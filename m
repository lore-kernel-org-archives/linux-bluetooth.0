Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJ+AEyN1A8Mk+h5kfX3Qr85EpUu72+kqSuBaBchBFh_xD0GxmQ@mail.gmail.com>
References: <CAJ+AEyNxFa0OeYG2qGhUXk0iQvapOJEJOZ_Nxnn0J5fZ=UdWUA@mail.gmail.com>
	<1311861656.3714.13.camel@THOR>
	<CAJ+AEyN1A8Mk+h5kfX3Qr85EpUu72+kqSuBaBchBFh_xD0GxmQ@mail.gmail.com>
Date: Fri, 29 Jul 2011 09:54:59 +0100
Message-ID: <CAJ+AEyPeRbLTZUCJ2FGP95k561ORHgLfXWw4qpNE1JcJ__V5qw@mail.gmail.com>
Subject: Re: ACL/SCO packets not transferred to slave device with new
 btusb/BlueZ driver
From: Eponymous - <the.epon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Yey!

It works perfectly with this change :)

Thanks a lot!

On Thu, Jul 28, 2011 at 3:02 PM, Eponymous - <the.epon@gmail.com> wrote:
> Thanks. I'll give it a try.
>
> On Thu, Jul 28, 2011 at 3:00 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On Thu, 2011-07-28 at 04:33 -0400, Eponymous - wrote:
>>> Thanks for your reply Peter.
>>>
>>> The problem I've got is that I work for a company testing Bluetooth so
>>> I have my hands tied as to how much information I can give - this is
>>> obviously a nightmare for both you who is trying to help me and for me
>>> who is trying to get the issue fixed :)
>>>
>>> It could be very well that the program I'm using (that used to work
>>> with BlueZ just fine when the hci_usb driver was around) is no longer
>>> compatible.
>>>
>>> I need to speak to the developers of the program I'm using to work out
>>> how they communicate with BlueZ/the chip.
>>>
>>> Cheers.
>>
>> Hi,
>>
>> The patch to the btusb driver (which may or may not fix the issue you're
>> having) is on the bluetooth-next development tree and is slated for
>> inclusion in the next kernel release (probably sometime in September,
>> based on current release cycle times).
>>
>> If your familiar with how to build a kernel module, you could grab the
>> patch from this list here:
>> http://permalink.gmane.org/gmane.linux.bluez.kernel/14758
>> Then rebuild 'drivers/bluetooth/btusb'.
>>
>> Let us know whether or not that resolves the problem.
>>
>> Regards,
>> Peter
>>
>
