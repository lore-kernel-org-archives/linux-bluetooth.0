Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201007211753.26822.LuHe@gmx.at>
References: <AANLkTikxtNwbaiSRouqTwB1o7y4hFTRXJ_mejsBFeYKM@mail.gmail.com>
	<AANLkTilPI6nA-9SJJx74L1wEIMci7IZ7K_bnGAT2YYTT@mail.gmail.com>
	<201007211753.26822.LuHe@gmx.at>
Date: Thu, 22 Jul 2010 16:17:57 +0200
Message-ID: <AANLkTinRSokfhf68OMIsFH9ccMd18Z7pq705KGWnKt8S@mail.gmail.com>
Subject: Re: Any update on software caused connection abort issue??
From: john michelle <jhnmichelle@gmail.com>
To: Lukas <LuHe@gmx.at>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukas,

> It would be great to see this problem fixed soon, because it's nearly
> impossible to use bluetooth on my PC.

I think it's useless to get any reply from this mailing list, i have
been reporting this
Problem for a long time and no one simply cares.


John

On Wed, Jul 21, 2010 at 5:53 PM, Lukas <LuHe@gmx.at> wrote:
> Hello,
>
> On Wednesday 21 July 2010 17:35:15 john michelle wrote:
>> Any update on software caused connection abort issue
>
> I also noticed this error when I used the software suite Series60-Remote to
> connect to my mobile phone.
>
> Shortly after the connection establishment is completed I get the error
> message "software caused connection abort" and the device gets disconnected.
>
> I also see the HCI reset, as described below, when I try to investigate this
> error using hcidump.
>
> The software uses the RFCOMM protocol for the connection.
> I use an USB bluetooth adapter from Belkin, lsusb reports the following device
> id:
> ID 050d:0131 Belkin Components Bluetooth Device with trace filter
>
> This bug happens with the following kernel:
> root@erde ~  #  rpm -q kernel bluez
> kernel-2.6.33.6-147.fc13.x86_64
> bluez-4.64-1.fc13.x86_64
>
> You can also look at this thread in my mailing list for further informations:
> https://sourceforge.net/mailarchive/forum.php?thread_name=201007192136.27723.LuHe%40gmx.at&forum_name=series60-
> remote-devel
>
> It would be great to see this problem fixed soon, because it's nearly
> impossible to use bluetooth on my PC.
>
> Thanks,
> Lukas
>
>> >>On Wed, Jun 23, 2010 at 12:48 AM, john michelle <jhnmichelle@gmail.com>
> wrote:
>> >> Dear Bluetooth community,
>> >>
>> >> You are committing version after version and have time to add new
>> >> Features and the core stack have a major bug (software Caused
>> >> connection abort) that i
>> >> Have reported on the 7th of may the problem seems to be either in the
>> >> usb part of the
>> >> Kernel or the bluez stack, i am no kernel engineer so i came directly
>> >> to you for reporting
>> >> This problem and my requests to look into this problem are just
>> >> ignored. this is a blocker
>> >> Issue that would prevent and discourage any one from developing
>> >> application that rely on
>> >> Bluez sco capabilities, since during transmission the above mentioned
>> >> error just occurs.
>> >> I hope that my voice is heared and i would get a reply from the bluez
>> >> community.
>> >>
>> >> John
>> >>
>> >> On Wed, Jun 16, 2010 at 3:11 PM, john michelle <jhnmichelle@gmail.com>
> wrote:
>> >>> On Sun, May 30, 2010 at 1:12 PM, john michelle <jhnmichelle@gmail.com>
> wrote:
>> >>>> Hi Gustavo,
>> >>>>
>> >>>>>> Please post the output of hcidump when the connection abort happens.
>> >>>>
>> >>>> Below is the output of hcidump the moments the software caused
>> >>>> connection abort
>> >>>>
>> >>>> Dongle 1:
>> >>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>> >>>>
>> >>>>  . * . . .
>> >>>> < HCI Command: Reset (0x03|0x0003) plen 0
>> >>>> device: disconnected
>> >>>>
>> >>>> Dongle 2:
>> >>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>> >>>>
>> >>>>  . * . . .
>> >>>> < HCI Command: Reset (0x03|0x0003) plen 0
>> >>>> device: disconnected
>> >>>>
>> >>>>
>> >>>> I think something triggers hci reset which causes this problem, but
>> >>>> what exactly Triggers it i don't know.
>> >>>>
>> >>>>
>> >>>> John
>> >>>
>> >>> Hi all,
>> >>>
>> >>> Is anyone going to give this problem a try, it has been like a month
>> >>> now This is a real problem in the bluez stack and someone have to look
>> >>> in this Issue.
>> >>>
>> >>> John
>> >>>
>> >>>> On Mon, May 17, 2010 at 5:21 PM, john michelle <jhnmichelle@gmail.com>
> wrote:
>> >>>>>> Hi Jonh,
>> >>>>>>
>> >>>>>> First of all, don't do top posting in this mailing list. ;)
>> >>>>>
>> >>>>> Thanks for the advise , will keep that in mind for future posts.
>> >>>>>
>> >>>>>> In which bluez/kernel version the problem started? Any hardware
>> >>>>>> update during this time? The problem happens when you are already
>> >>>>>> tranfering SCO data?
>> >>>>>
>> >>>>> I tried bluez versions 3.XX  and kernel 2.6.26(I think) the problem
>> >>>>> occurs and the kernel panics with no core dumps.then i tried with
>> >>>>> bluez 4.53-4.62 with
>> >>>>> Kernel 2.6.31 and 2.6.32. the connection abort problem occurs but the
>> >>>>> kernel doesn't
>> >>>>> Panic. regarding the hardware update you mean the dongle or the
>> >>>>> box.Anyway i changed both and tried different box's, this even
>> >>>>> happens on a box with 2 giga ram
>> >>>>> And core2 processor . as for the dongles i am using trust
>> >>>>>
>> >>>>> http://www.twenga.co.uk/prices-Bluetooth-2-USB-Adapter-10m-BT-2250p-T
>> >>>>> RUST-Wireless-network-card-adapter-176178-0
>> >>>>>
>> >>>>>  and also using no name dongles all the same problem.
>> >>>>>
>> >>>>>> Please post the output of hcidump when the connection abort happens.
>> >>>>>
>> >>>>> well that is going to be a hard one since i have more than one dongle
>> >>>>> in place And very hard to predict which one will crash.i will work
>> >>>>> on this and update You as soon as i have the hcidump log.
>> >>>>>
>> >>>>>> I tried reproduce this issue in L2CAP but it is a bit hard, lets
>> >>>>>> say it happen once in a thousand, so it's not easy to track it. I
>> >>>>>> have to try reproduce that using the SCO, but I'm not used to that
>> >>>>>> layer yet. ;)
>> >>>>>
>> >>>>> I hoped that it happens 1 in 1000 in SCO , but it actually happens 1
>> >>>>> in 15
>> >>>>>
>> >>>>>
>> >>>>> John
>> >>>>>
>> >>>>>> Regards,
>> >>>>>>
>> >>>>>>> John
>> >>>>>>>
>> >>>>>>> On Fri, May 7, 2010 at 3:53 PM, Gustavo F. Padovan
> <gustavo@padovan.org> wrote:
>> >>>>>>> > * john michelle <jhnmichelle@gmail.com> [2010-05-07 15:49:05
> -0400]:
>> >>>>>>> >> Hi Bluetooth hackers,
>> >>>>>>> >>
>> >>>>>>> >> i am having this consistent problem with bluez , from time to
>> >>>>>>> >> time i get the error Software caused connection abort (103 )
>> >>>>>>> >> And the bluetooth stick seems to disconnect and reconnects. this
>> >>>>>>> >> happens during an sco connection and it occurs even
>> >>>>>>> >> More when i am having the voice stream comming through the
>> >>>>>>> >> internet rather than the lan.i don't know what exact
>> >>>>>>> >> Details you need to solve this problem please tell me and i will
>> >>>>>>> >> give you an immediate reply . i have linux kernel 2.6.33 and
>> >>>>>>> >> bluez 4.62
>> >>>>>>> >
>> >>>>>>> > I get the same problem sometimes when testing ERTM with l2test.
>> >>>>>>> > So the problem is on l2cap too. I didn't have time to debug this
>> >>>>>>> > yet. Now that someone else have confirmed it too, I'll to take a
>> >>>>>>> > look at the problem.
>> >>>>>>
>> >>>>>> --
>> >>>>>> Gustavo F. Padovan
>> >>>>>> http://padovan.org
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
