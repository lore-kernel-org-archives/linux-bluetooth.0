Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMxgYMNu8uFDSmM3Gqd_tBg+jY8FieM14ivoXOn+VJHMvojpbA@mail.gmail.com>
References: <CAMxgYMM5LxoD=RC44ARObUh9jV=d9LXyd6Gegi0MS95v7bW7GA@mail.gmail.com>
	<13872098A06B02418CF379A158C0F1460163744AA6@dnce02.ent.ti.com>
	<CAMxgYMNu8uFDSmM3Gqd_tBg+jY8FieM14ivoXOn+VJHMvojpbA@mail.gmail.com>
Date: Fri, 23 Sep 2011 16:28:12 +0530
Message-ID: <CAMxgYMNqfaPBrRK0+Pd-WXvoxEhSs4OjYgZXWd0A7vMrCNfbGg@mail.gmail.com>
Subject: Re: Dynamicall control the maximum or default transmit power
From: Vaishali D <justdoit.wg@gmail.com>
To: "Keren, Doron" <doronkeren@ti.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Nope , this is not what I want .will setting the Inquiry Transmit
power change my transmit power level? Well unable to change the inqtpl
using the hcitool as it reverts back exactly like in the
http://permalink.gmane.org/gmane.linux.bluez.kernel/4008.Thanks for
the response though , it inspired me to do more research.
I want to set the max transmit power level of my Bluetooth
transmission which is currently set to 11dbm and the signal drops
after the range of 10 m approx.Acccording to my understanding I should
be able to raise the signal stength to 20dbm as per the Bluetooth chip
datasheet and I should be able to get the bluetooth to work in the
100m range distance.

Been through the hciconfig and hcitool very carefully but not a
solution to this over there.
bccmd is not the answer as this is for CSR chips only not mine which
is broadcom 4329. rfkill is only to enable and disable to transmitter.

Then looking through the code is the only solution . If anyone has a
idea , Plz suggest.

Regards
Vaishali

On Fri, Sep 23, 2011 at 10:30 AM, Vaishali D <justdoit.wg@gmail.com> wrote:
> Thank you , Keren.
> Thank you.
> Regards
> Vaishali
>
> On Thu, Sep 22, 2011 at 8:17 PM, Keren, Doron <doronkeren@ti.com> wrote:
>> Hi,
>>
>> Regarding the bccmd it is CSR transport (BlueCore Command).
>> BlueCore is CSR chip.
>>
>> You can use hcitool and send what u need.
>>
>> HCI_Write_Inquiry_Transmit_Power_Level, ocf = 0x0059, ogf = 0x01
>> #hcitool cmd ...
>>
>> Most of the vendors distinguish between TX power and Inquiry TX power.
>> You can also read the value in HCI_Read_Inquiry...
>>
>> BR,
>> Doron
>>
>>> -----Original Message-----
>>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>>> owner@vger.kernel.org] On Behalf Of Vaishali Dhakate
>>> Sent: Thursday, September 22, 2011 10:31 AM
>>> To: linux-bluetooth@vger.kernel.org
>>> Subject: Dynamicall control the maximum or default transmit power
>>>
>>> From: Ed Tsang <netdesign_98@...>
>>> Subject: Dynamicall control the maximum or default transmit power
>>> Newsgroups: gmane.linux.bluez.kernel
>>> Date: 2009-02-18 20:12:08 GMT (2 years, 30 weeks, 4 days, 23 hours and
>>> 16 minutes ago)
>>>
>>> Hi, I am looking at possibility of dynamically control the maximum or
>>> default transmit power.
>>>    Basically I would like to change the transmit power level during
>>> inquiry. So I could kind of dynamically
>>> control the physical range of devices that I see. In CSR's Bluecore
>>> chip, I think there are pskey that
>>>
>>> stored the maximum and default transmit power. And there seem to be
>>> bccmd psget 0x0017 to get the value.
>>>   Now my problem is I am using a class 1 dongle using Broadcom
>>> chipset. Is there a way to dynamically control the
>>>
>>> default or maximum transmit power e.g.
>>>    hcitool cmd 0x.. 0x.. ..... ?
>>>
>>>    During the inquiry paging, does anyone know if they use default or
>>> maximum transmit power?
>>>
>>> Thanks,
>>> Edwin
>>>
>>>
>>>
>>> Regarding this.
>>> I also have the same question I am trying to find answer to ? Want to
>>> know if you found the answer. I see three ways of doing this.
>>> 1)In the bcm4329 code
>>> 2)using bccmd
>>> 3)using hcitool cmd 0x0 0x0..
>>>
>>> Going through the code can be time consuming And I ll have to go to
>>> the theory before I start, Already scimmed through it to see if there
>>> is any power control or anything like utility for hw control in the
>>> driver , in the drivers/net/wireless/bcm4329 ..
>>>
>>> I compiled bccmd , But this doesnot support some chips like mine
>>> bcm4329 , the bccmd is for CSR chips ,Plz correct me , Mine is not
>>> working on the phone. Maybe I ll have to take a clue from the bccmd
>>> tool to write my own or check in the code where these pskeys will be.
>>> So far I can surmise they are soemwhere in the eeprom. Also this phy.c
>>> has some reference to power tables. Need to look carefully.
>>>
>>> Next hcitool is the option. hcitool I ll look into the ogf and ocf
>>> commands in the LMP specifications that I can send, havent tried this.
>>> Tell me how did you do it.
>>>
>>> Just thought I ll send you a mail,if you could plz share your
>>> experience regarding this.
>>>
>>> Regards
>>> Vaishali
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
