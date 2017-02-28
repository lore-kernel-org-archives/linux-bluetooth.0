Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAEJBhK5hzUJC-x+EWkZ+MG+3-cwdFBnbuPWP1kyo5=Xub0yzA@mail.gmail.com>
References: <CAKwwfuT5t6ARrmhPnpTTDpyhTUZ1j+enRh1jsMMhyb5jjiaBYA@mail.gmail.com>
 <CAAEJBhJ_abML8TL7LQAA5S18Q9vAmV8OOX9USMeFqiU2Z9ULjA@mail.gmail.com>
 <CAKwwfuQ0zvHYCWZMbBnOKGjUWtX++a6As=SjRY-ycQym3kBL8g@mail.gmail.com>
 <CAAEJBh+vb2z7UJd0-47V2fgizNS+k-HhFjFy7W_dBtVmHFRkmw@mail.gmail.com>
 <CAKwwfuScYXwcguX6uysmzn90YvEvjrcK_Dx5=Z0DYzSOHrhd=w@mail.gmail.com>
 <CAKwwfuQecoEYY=F7ewiX+8RyJimLGnz9rMvy0L2y37OdJhpKfw@mail.gmail.com>
 <CAKwwfuThjnWe_GTJEvKxyHkGZsZeVSYd1gb3N5ywZp7oCpZ1nw@mail.gmail.com>
 <CAAEJBhKANaxmsh1E6r3wPd=mxET-RFbUVjr5qjn+OwQnCDLAUw@mail.gmail.com>
 <CAKwwfuQ3trBfkMaGqJOpKpsKjNnhO8r7SOHcKKQeJASHmN6aAg@mail.gmail.com> <CAAEJBhK5hzUJC-x+EWkZ+MG+3-cwdFBnbuPWP1kyo5=Xub0yzA@mail.gmail.com>
From: Dor Shemer <dorshemer@gmail.com>
Date: Tue, 28 Feb 2017 13:44:04 +0200
Message-ID: <CAKwwfuSkboGDk0-Gt+FgEAkDq2gggkR3wqWH6fdnnfPFG5X0gA@mail.gmail.com>
Subject: Re: Unable to pair Bose QC35
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 28, 2017 at 12:13 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> Hi,
>
> On 28 February 2017 at 10:44, Dor Shemer <dorshemer@gmail.com> wrote:
>> Hi,
>>
>> On Mon, Feb 27, 2017 at 6:50 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
>>> Hi,
>>>
>>> On 27 February 2017 at 17:36, Dor Shemer <dorshemer@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On Feb 27, 2017 1:27 PM, "Szymon Janc" <szymon.janc@codecoup.pl> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 26 February 2017 at 22:54, Dor Shemer <dorshemer@gmail.com> wrote:
>>>> > Thanks for replying,
>>>> >
>>>> > On Sun, Feb 26, 2017 at 9:57 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
>>>> >> Hi,
>>>> >>
>>>> >> On 25 February 2017 at 15:10, Dor Shemer <dorshemer@gmail.com> wrote:
>>>> >>> Hello,
>>>> >>>
>>>> >>> I have a new set of Bose QC35 that won't my pair with ubuntu 16.10
>>>> >>> (dell xps 9550). I tried everything I could find on this mailing list
>>>> >>> (http://marc.info/?l=linux-bluetooth&m=148314289530765&w=2) and
>>>> >>> askubuntu.com (http://askubuntu.com/questions/833322/pair-bose-quietcomfort-35-with-ubuntu-16-04-over-bluetooth)
>>>> >>> but nothing seems to help.
>>>> >>>
>>>> >>> I'm trying to pair using either dual mode or bredr, as suggested in
>>>> >>> the askubunu answer.
>>>> >>>
>>>> >>> Using ControllerMode = dual I get:
>>>> >>>
>>>> >>>     [bluetooth]# devices
>>>> >>>     Device 04:52:C7:62:27:75 LE-Pigment Pete
>>>> >>>     [bluetooth]# pair 04:52:C7:62:27:75
>>>> >>>     Attempting to pair with 04:52:C7:62:27:75
>>>> >>>     [CHG] Device 04:52:C7:62:27:75 Connected: yes
>>>> >>>     Failed to pair: org.bluez.Error.AuthenticationFailed
>>>> >>>     [CHG] Device 04:52:C7:62:27:75 Connected: no
>>>> >>>
>>>> >>>
>>>> >>> OnControllerMode = bredr I can't even find the device, but if
>>>> >>> remembered from the dual mode scan, I get:
>>>> >>>
>>>> >>>     [bluetooth]# devices
>>>> >>>     Device 04:52:C7:62:27:75 LE-Pigment Pete
>>>> >>>     [bluetooth]# pair 04:52:C7:62:27:75
>>>> >>>     Attempting to pair with 04:52:C7:62:27:75
>>>> >>>     Failed to pair: org.bluez.Error.AuthenticationRejected
>>>> >>>
>>>> >>>
>>>> >>> I'm not sure what causes this or where to keep looking, as none of the
>>>> >>> questions I found online have this exact problem. Could you help guide
>>>> >>> me?
>>>> >>
>>>> >> Please update, this should be fixed in 5.42.
>>>> >
>>>> > I tried that, and upgraded to 5.43 from source, however the issue
>>>> > remains the same,
>>>> > Should I upgrade another package? Are there logs or debug mode I should check?
>>>>
>>>> It seems to work just fine here.
>>>>
>>>> Are you sure your headset is in pairing mode?
>>>> You could collect btmon traces from pairing (including device discovery).
>>>>
>>>> --
>>>> pozdrawiam
>>>> Szymon K. Janc
>>>>
>>>>
>>>> I'm positive it's in pairing mode. The same procedure works with my Android and Windows devices.
>>>>
>>>> How can I collect pairing traces from btmon? I'm not familiar with it.
>>>> Is there anywhere I can get a more detailed error than AuthenticationFailed / AuthenticationRejected?
>>>
>>> You can use 'sudo btmon' for HCI traces and then you'll see all the traffic.
>>>
>>> But what you describe seems like you are not using 5.43 but older
>>> version. This looks like you try
>>> to pair over LE and QC35 doesn't support pairing over LE (nor cross
>>> transport pairing).
>>>
>>> Please double check if you correctly upgraded BlueZ (since you use
>>> Ubuntu I'd just use debs from
>>> 'zesty' release instead of building from sources).
>>>
>>> --
>>> pozdrawiam
>>> Szymon K. Janc
>>
>>
>> I believe I am using 5.43, because this is the output I get from btmon:
>>
>> $ sudo btmon
>> Bluetooth monitor ver 5.43
>> = Note: Linux version 4.8.0-39-generic (x86_64)
>> = Note: Bluetooth subsystem version 2.21
>> = New Index: 48:E2:44:F6:67:44 (Primary,USB,hci0)
>> = Open Index: 48:E2:44:F6:67:44
>> = Index Info: 48:E2:44:F6:67:44 (Broadcom Corporation)
>>
>> I don't mind trying again with the zesty debs if you think that would
>> help, though.
>> I also set ControllerMode = bredr in /etc/bluetooth/main.conf, which
>> should have prevented LE pairing. Non of this seems to work.
>> My headset firmware version is 1.2.10, if it matters at all.
>>
>> It's really frustrating, having no idea what I'm doing wrong.
>> Should I just remove any bluetooth related package and try again from scratch?
>>
>> I'm starting to think this is not a problem with connecting the
>> headset but rather with pairing ANY bluetooth device, since I can't
>> even see my android phone on the devices list (while it is
>> discoverable and managed to pair with a mac)
>
> Since you have Broadcom chip make sure that its firmware is loaded
> (some Broadcom
> chips require extracting firmware from windows drivers, you should be
> able to google that).
> Check dmesg for any logs related to BT firmware.
>
>
> --
> pozdrawiam
> Szymon K. Janc

Loading the Broadcom drivers did the trick!
Thanks so much for your patience, I doubt I would've figured it out myself :)
