Return-Path: <cyrus@holtmann.org>
Message-ID: <497DC261.9050305@powercraft.nl>
Date: Mon, 26 Jan 2009 15:02:09 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: can somebody show me an example asound configuration for dmixing
 with hifi bluetooth speakers/headset
References: <494E2ACD.2080900@powercraft.nl> <4958A3E5.4030105@powercraft.nl>	 <49632D4C.6060207@powercraft.nl>	 <664d43d60901061352y72c39fdctdeae5d7242ce559d@mail.gmail.com>	 <49647B4D.2020907@powercraft.nl>	 <664d43d60901090348j7a5af1baw894ff14710f36914@mail.gmail.com>	 <664d43d60901100639x2cde2c9ek89316e66e8af16f@mail.gmail.com>	 <4969F52D.2070405@powercraft.nl> <664d43d60901161728h57b5e22euca1e38e03dfb0227@mail.gmail.com> <4971B31F.1020204@powercraft.nl>
In-Reply-To: <4971B31F.1020204@powercraft.nl>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Jelle de Jong wrote:
> event wrote:
>> On Sun, Jan 11, 2009 at 15:33, Jelle de Jong <jelledejong@powercraft.nl> wrote:
>>> event wrote:
>>>> On 2009-01-09, event <event.riga@gmail.com> wrote:
>>>>> On 2009-01-07, Jelle de Jong <jelledejong@powercraft.nl> wrote:
>>>>>> event wrote:
>>>>>>> On Tue, Jan 6, 2009 at 12:07, Jelle de Jong <jelledejong@powercraft.nl>
>>>>>>> wrote:
>>>>>>>> Jelle de Jong wrote:
>>>>>>>>>> Hello everybody,
>>>>>>>>>>
>>>>>>>>>> I have been periodically trying to get multiple audio sources to play
>>>>>>>>>> together (dmixing) to a hifi bluetooth speaker system or hifi
>>>>>>>>>> bluetooth
>>>>>>>>>> headset.
>>>>>>>>>>
>>>>>>>>>> I am using only alsa and no pulseaudio, esd, jack, mas of something
>>>>>>>>>> else
>>>>>>>>>> just alsa with asoundrc configuration files and no graphical
>>>>>>>>>> environment.
>>>>>>>>>>
>>>>>>>>>> Can somebody show me an example asoundrc config file to make it
>>>>>>>>>> possible
>>>>>>>>>> to use software audio mixing with my bluetooth devices. If this is
>>>>>>>>>> currently not possible, please tell why and what we can do about it. I
>>>>>>>>>> am willing to donate some payal money to the person providing me with
>>>>>>>>>> a
>>>>>>>>>> working asoundrc configuration file that allows me to play multiple
>>>>>>>>>> audio sources at the same time.
>>>>>>>>>>
>>>>>>>>>> Thanks in advance,
>>>>>>>>>>
>>>>>>>>>> Jelle
>>>>>>>>>>
>>>>>>>>> Bumping up this mail, I would really like to see a solution for my
>>>>>>>>> problem or receive information why the problem is not possible not
>>>>>>>>> solvable?
>>>>>>>>>
>>>>>>>>> Thanks in advance for any help,
>>>>>>>>>
>>>>>>>>> Best regards,
>>>>>>>>>
>>>>>>>>> Jelle
>>>>>>>> Bump for the mail, I still have this issue, and would really appreciate
>>>>>>>> somebody taking a look at. I don't know if there is code limitation or
>>>>>>>> that it is just a asoundrc configuration issue.
>>>>>>>>
>>>>>>>> Please help,
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>>
>>>>>>>> Jelle
>>>>>>> Hello Jelle,
>>>>>>> could you please provide more details:
>>>>>>> 1. what happen when you play from two sources simultaneously?
>>>>>>> 2. what happen if you play only one source?
>>>>>>> 3. please provide your asoundrc (at least the pcm.bluetooth part)
>>>>>>> 4. does it work fine with other output device?
>>>>>>>
>>>>>>> Vale,
>>>>>>> event
>>>>>> Thank you for responding, I had reattached the configurations and
>>>>>> outputs with some more info. I have already spent a bloody awful lot of
>>>>>> time on testing with trial and error. I am not an alsa or bluetooth
>>>>>> developer I cannot get it to work. If a capable person could get it
>>>>>> working I would be very great full.
>>>>>>
>>>>>> I am also not able to get bluetooth working without adding a sound card
>>>>>> to my system, so i put in a usb sound dongle just to get bluetooth with
>>>>>> alsa working, alsa won't load its modules without it first finding a
>>>>>> soundcard. It is all very very confusing.
>>>>>>
>>>>>> Thanks in advance for any help,
>>>>>>
>>>>>> Best regards,
>>>>>>
>>>>>> Jelle
>>>>>>
>>>>> Hello Jelle,
>>>>>
>>>>> I will setup the environment and do some tries as well. I'll come back
>>>>> to you when some outcome will be available
>>>>>
>>>>> Vale,
>>>>> Leonid Movshovich
>>>>>
>>>> Hello Jelle,
>>>>
>>>> You need to setup a passkey agent (for bluez 3.x) for connection to
>>>> succeed. I've attached one simple
>>>>
>>>> For dmix setups you have to define slaves as "pcm_slave." not "pcm."
>>>> is .asoundrc
>>>>
>>>> Hope this helps.
>>>>
>>>> Vale,
>>>> Leonid Movshovich
>>>>
>>> Thank you Leonid for responding. I gave it a good try again, with trial
>>> and error with all kind of variations of the different asoundrc files I
>>> attached in my previous mails. I am unable to get it working with two
>>> audio streams to one bluetooth devices (mixing).
>>>
>>> I ended up with lots of messages like "Unknown field pcm_slave". Could
>>> you please post a complete asoundrc file that has been tested to work
>>> with two speaker-test -c2 programs running beside each other?
>>>
>>> Just to be clear, I have no problem getting my bluetooth audio device to
>>> work with single audio streams, I would like to have mixing support
>>> working so I can play multiple audio sources at the same time.
>>>
>>> Thanks in advance,
>>>
>>> Jelle
>>>
>> Hi Jelle,
> 
>> I've digged there a bit and found out the following:
>> 1. you cannot use dmix over bluetooth as bluetooth is implemented as a
>> plugin but dmix works with cards only
>> 2. bluetooth itself doesn't do mixing
> 
>> so dmix is not a thing which could help you here, but...
>> I have one crazy idea for you :)
>> you can try to setup alsa jACK plugin and then setup jACK to use your
>> alsa bluetooth device. Thus if jACK supports mixing itself (which most
>> probably the truth) the whole setup should work as you want.
>> Unfortunately, I don't have jACK installed so cannot give it a try.
> 
>> Vale,
>> Leonid Movshovich
> 
> Thank you Leonid for confirming my issues getting mixing to work with
> alsa and bluetooth.
> 
> I don't really like jack or pulseaudio, and would like to stick with
> alsa a while more until all the bugs, usability, and performance issues
> are gone. I do not feel like going into there issues in this mail,
> because the mail would get 4 pages long, please search with google for
> "pulseaudio broken" and find some answers.
> 
> My real question is, what would it take to fix the alsa plugin to make
> it possible to use streaming. Maybe bluetooth devices should work as
> cards... this would also solve the problem that I cant use bluetooth
> without a dummy usb soundcard insert into my system. Alsa would not
> start without finding a soundcard...
> 
> Is somebody willing to take a look at the alsa system for bluetooth?
> What would resources or rewards would you like to fix it?
> 
> Best regards,
> 
> Jelle

Hello everybody,

I am popping up this email again, I would really like to see this
issue fixed, would somebody be willing to take a look at it?

Best regards,

Jelle
