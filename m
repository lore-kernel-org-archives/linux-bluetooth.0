Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAEJBhJ_abML8TL7LQAA5S18Q9vAmV8OOX9USMeFqiU2Z9ULjA@mail.gmail.com>
References: <CAKwwfuT5t6ARrmhPnpTTDpyhTUZ1j+enRh1jsMMhyb5jjiaBYA@mail.gmail.com>
 <CAAEJBhJ_abML8TL7LQAA5S18Q9vAmV8OOX9USMeFqiU2Z9ULjA@mail.gmail.com>
From: Dor Shemer <dorshemer@gmail.com>
Date: Sun, 26 Feb 2017 23:54:00 +0200
Message-ID: <CAKwwfuQ0zvHYCWZMbBnOKGjUWtX++a6As=SjRY-ycQym3kBL8g@mail.gmail.com>
Subject: Re: Unable to pair Bose QC35
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for replying,

On Sun, Feb 26, 2017 at 9:57 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> Hi,
>
> On 25 February 2017 at 15:10, Dor Shemer <dorshemer@gmail.com> wrote:
>> Hello,
>>
>> I have a new set of Bose QC35 that won't my pair with ubuntu 16.10
>> (dell xps 9550). I tried everything I could find on this mailing list
>> (http://marc.info/?l=linux-bluetooth&m=148314289530765&w=2) and
>> askubuntu.com (http://askubuntu.com/questions/833322/pair-bose-quietcomfort-35-with-ubuntu-16-04-over-bluetooth)
>> but nothing seems to help.
>>
>> I'm trying to pair using either dual mode or bredr, as suggested in
>> the askubunu answer.
>>
>> Using ControllerMode = dual I get:
>>
>>     [bluetooth]# devices
>>     Device 04:52:C7:62:27:75 LE-Pigment Pete
>>     [bluetooth]# pair 04:52:C7:62:27:75
>>     Attempting to pair with 04:52:C7:62:27:75
>>     [CHG] Device 04:52:C7:62:27:75 Connected: yes
>>     Failed to pair: org.bluez.Error.AuthenticationFailed
>>     [CHG] Device 04:52:C7:62:27:75 Connected: no
>>
>>
>> OnControllerMode = bredr I can't even find the device, but if
>> remembered from the dual mode scan, I get:
>>
>>     [bluetooth]# devices
>>     Device 04:52:C7:62:27:75 LE-Pigment Pete
>>     [bluetooth]# pair 04:52:C7:62:27:75
>>     Attempting to pair with 04:52:C7:62:27:75
>>     Failed to pair: org.bluez.Error.AuthenticationRejected
>>
>>
>> I'm not sure what causes this or where to keep looking, as none of the
>> questions I found online have this exact problem. Could you help guide
>> me?
>
> Please update, this should be fixed in 5.42.

I tried that, and upgraded to 5.43 from source, however the issue
remains the same,
Should I upgrade another package? Are there logs or debug mode I should check?

>
> --
> pozdrawiam
> Szymon K. Janc
