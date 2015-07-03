Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+Q=mze8gtge7YqsyW7t0HO4_j=NK4awV-YnP=wQ0sT+g@mail.gmail.com>
References: <CABKPALrTMqgvxRgu7TmUw+1MrTCL10FAGGzyphb1oAAyFGOBNQ@mail.gmail.com>
	<000901d0b54f$a89a9050$f9cfb0f0$@samsung.com>
	<CABBYNZ+Q=mze8gtge7YqsyW7t0HO4_j=NK4awV-YnP=wQ0sT+g@mail.gmail.com>
Date: Fri, 3 Jul 2015 11:40:00 -0500
Message-ID: <CABKPALo8XJKvxpw-ObR8NwVjREfPd_zPTtDguyCFd_DD03MbBA@mail.gmail.com>
Subject: Re: Trying to run example-advertisement
From: Neil Martin <neil@vnp.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jul 3, 2015 at 3:18 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Neil,
>
> On Fri, Jul 3, 2015 at 8:17 AM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
>> Hi Neil,
>>
>>> -----Original Message-----
>>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>>> owner@vger.kernel.org] On Behalf Of Neil Martin
>>> Sent: Friday, July 03, 2015 12:52 AM
>>> To: linux-bluetooth
>>> Subject: Trying to run example-advertisement
>>>
>>> I was having trouble using the advertising api in my own code, so decided to
>>> run the example-advertisement python test to rule out errors in my code.
>>> This doesn't work either - I get the following error message:
>>>
>>> LEAdvertisingManager1 interface not found
>>>
>>> I know the advertising api is experimental.  My bluez was built with --enable-
>>> experimental  and I'm running bluetoothd with the -E flag.
>>> It seems like this is an environment issue, but I don't find any suggestions
>>> when I try googling for help.  Is there anything obvious that I'm missing?
>>
>> I faced the similar issue and got resolved after updating the kernel to latest one.
>> Then it is able to successfully register.
>
> Yep, currently Linux 4.1 is required,  you can actually check if your
> kernel support with the tools/mgmt-tester:
>
> sudo ./tools/mgmt-tester -p "Read Advertising"
> sudo ./tools/mgmt-tester -p "Add Advertising"
>
> The tests should all pass otherwise bluetoothd wont be able to work
> since it depends on these commands to manage the advertising data.
>
> --
> Luiz Augusto von Dentz

Thanks for all the replies.  I'm running bluez on a raspberry pi 2 and
as far as I can tell, there isn't an easy path to a 4.1 kernel.  I
applied all the updates to my installation and ended up at 4.07.  I
don't have a lot of linux background, but from googling the topic, it
seems like 4.1 is so new that it isn't universally available.

Neil
