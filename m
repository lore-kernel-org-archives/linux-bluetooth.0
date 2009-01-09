Return-Path: <cyrus@holtmann.org>
Message-ID: <664d43d60901090348j7a5af1baw894ff14710f36914@mail.gmail.com>
Date: Fri, 9 Jan 2009 13:48:24 +0200
From: event <event.riga@gmail.com>
To: "Jelle de Jong" <jelledejong@powercraft.nl>
Subject: Re: can somebody show me an example asound configuration for dmixing with hifi bluetooth speakers/headset
Cc: "BlueZ development" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <49647B4D.2020907@powercraft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <494E2ACD.2080900@powercraft.nl> <4958A3E5.4030105@powercraft.nl>
	 <49632D4C.6060207@powercraft.nl>
	 <664d43d60901061352y72c39fdctdeae5d7242ce559d@mail.gmail.com>
	 <49647B4D.2020907@powercraft.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 2009-01-07, Jelle de Jong <jelledejong@powercraft.nl> wrote:
> event wrote:
>> On Tue, Jan 6, 2009 at 12:07, Jelle de Jong <jelledejong@powercraft.nl>
>> wrote:
>>> Jelle de Jong wrote:
>>>>> Hello everybody,
>>>>>
>>>>> I have been periodically trying to get multiple audio sources to play
>>>>> together (dmixing) to a hifi bluetooth speaker system or hifi bluetooth
>>>>> headset.
>>>>>
>>>>> I am using only alsa and no pulseaudio, esd, jack, mas of something
>>>>> else
>>>>> just alsa with asoundrc configuration files and no graphical
>>>>> environment.
>>>>>
>>>>> Can somebody show me an example asoundrc config file to make it
>>>>> possible
>>>>> to use software audio mixing with my bluetooth devices. If this is
>>>>> currently not possible, please tell why and what we can do about it. I
>>>>> am willing to donate some payal money to the person providing me with a
>>>>> working asoundrc configuration file that allows me to play multiple
>>>>> audio sources at the same time.
>>>>>
>>>>> Thanks in advance,
>>>>>
>>>>> Jelle
>>>>>
>>>> Bumping up this mail, I would really like to see a solution for my
>>>> problem or receive information why the problem is not possible not
>>>> solvable?
>>>>
>>>> Thanks in advance for any help,
>>>>
>>>> Best regards,
>>>>
>>>> Jelle
>>> Bump for the mail, I still have this issue, and would really appreciate
>>> somebody taking a look at. I don't know if there is code limitation or
>>> that it is just a asoundrc configuration issue.
>>>
>>> Please help,
>>>
>>> Best regards,
>>>
>>> Jelle
>>
>> Hello Jelle,
>> could you please provide more details:
>> 1. what happen when you play from two sources simultaneously?
>> 2. what happen if you play only one source?
>> 3. please provide your asoundrc (at least the pcm.bluetooth part)
>> 4. does it work fine with other output device?
>>
>> Vale,
>> event
>
> Thank you for responding, I had reattached the configurations and
> outputs with some more info. I have already spent a bloody awful lot of
> time on testing with trial and error. I am not an alsa or bluetooth
> developer I cannot get it to work. If a capable person could get it
> working I would be very great full.
>
> I am also not able to get bluetooth working without adding a sound card
> to my system, so i put in a usb sound dongle just to get bluetooth with
> alsa working, alsa won't load its modules without it first finding a
> soundcard. It is all very very confusing.
>
> Thanks in advance for any help,
>
> Best regards,
>
> Jelle
>

Hello Jelle,

I will setup the environment and do some tries as well. I'll come back
to you when some outcome will be available

Vale,
Leonid Movshovich
