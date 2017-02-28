Return-Path: <pmenzel@molgen.mpg.de>
Subject: Re: Decrease long resume time of Intel Bluetooth module
To: Greg KH <greg@kroah.com>
References: <9dbb0c55-4aeb-633e-a4f8-ca3fa170e19b@molgen.mpg.de>
 <20170228110017.GA30523@kroah.com>
 <6fdd4378-fd7b-497f-6c1e-3681020bcd49@molgen.mpg.de>
 <20170228123949.GA32116@kroah.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <a8bd3e4b-6e4b-36b4-324f-a2f78946f576@molgen.mpg.de>
Date: Tue, 28 Feb 2017 13:46:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170228123949.GA32116@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Greg,


On 02/28/17 13:39, Greg KH wrote:
> On Tue, Feb 28, 2017 at 12:06:38PM +0100, Paul Menzel wrote:

>> On 02/28/17 12:00, Greg KH wrote:
>>> On Tue, Feb 28, 2017 at 11:20:11AM +0100, Paul Menzel wrote:
>>>> Is there a way to debug and optimize that – besides taking the device out –
>>>> to get resume times on par with other devices like Google Chromebooks or
>>>> Apple MacBooks?
>>>
>>> A Chromebook is running the same Linux kernel as your desktop, so
>>> perhaps you can see if it really is doing something different here or
>>> not?
>>
>> Sorry, for being ambiguous. I don’t know if there are Google Chromebooks
>> using that USB device, and I wouldn’t have access to it.
>
> Then perhaps the hardware itself just can't do this type of "quick"
> suspend/resume?  Have you tried it in MacBook and measured it there?

I also don’t know if the device in question is used there either. Sorry. 
I just know, that Apple MacBooks like Google Chromebooks resume very 
quickly. Firmware, the kernel and the user space seem to take less then 
a second, so that after resume the device is fully functional after when 
the screen is fully opened.

>> I just meant, that it would be great to get fast resume times.
>
> I agree, but sometimes hardware just sucks :)

And finding solutions to work around that makes our work interesting, 
doesn’t it. ;-)

No really, I thought, that first it’s possible to somehow trace, where 
the 500 ms are spent, and then find out, if that can be improved in the 
Linux kernel, or for example, it’s clear the problem lies with the 
device or it’s firmware, and the hardware vendor, which is Intel in this 
case, can maybe fix it.


Kind regards,

Paul
