Return-Path: <cyrus@holtmann.org>
Message-ID: <664d43d60901100639x2cde2c9ek89316e66e8af16f@mail.gmail.com>
Date: Sat, 10 Jan 2009 16:39:50 +0200
From: event <event.riga@gmail.com>
To: "Jelle de Jong" <jelledejong@powercraft.nl>
Subject: Re: can somebody show me an example asound configuration for dmixing with hifi bluetooth speakers/headset
Cc: "BlueZ development" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <664d43d60901090348j7a5af1baw894ff14710f36914@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_266791_16803128.1231598390059"
References: <494E2ACD.2080900@powercraft.nl> <4958A3E5.4030105@powercraft.nl>
	 <49632D4C.6060207@powercraft.nl>
	 <664d43d60901061352y72c39fdctdeae5d7242ce559d@mail.gmail.com>
	 <49647B4D.2020907@powercraft.nl>
	 <664d43d60901090348j7a5af1baw894ff14710f36914@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------=_Part_266791_16803128.1231598390059
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 2009-01-09, event <event.riga@gmail.com> wrote:
> On 2009-01-07, Jelle de Jong <jelledejong@powercraft.nl> wrote:
>> event wrote:
>>> On Tue, Jan 6, 2009 at 12:07, Jelle de Jong <jelledejong@powercraft.nl>
>>> wrote:
>>>> Jelle de Jong wrote:
>>>>>> Hello everybody,
>>>>>>
>>>>>> I have been periodically trying to get multiple audio sources to play
>>>>>> together (dmixing) to a hifi bluetooth speaker system or hifi
>>>>>> bluetooth
>>>>>> headset.
>>>>>>
>>>>>> I am using only alsa and no pulseaudio, esd, jack, mas of something
>>>>>> else
>>>>>> just alsa with asoundrc configuration files and no graphical
>>>>>> environment.
>>>>>>
>>>>>> Can somebody show me an example asoundrc config file to make it
>>>>>> possible
>>>>>> to use software audio mixing with my bluetooth devices. If this is
>>>>>> currently not possible, please tell why and what we can do about it. I
>>>>>> am willing to donate some payal money to the person providing me with
>>>>>> a
>>>>>> working asoundrc configuration file that allows me to play multiple
>>>>>> audio sources at the same time.
>>>>>>
>>>>>> Thanks in advance,
>>>>>>
>>>>>> Jelle
>>>>>>
>>>>> Bumping up this mail, I would really like to see a solution for my
>>>>> problem or receive information why the problem is not possible not
>>>>> solvable?
>>>>>
>>>>> Thanks in advance for any help,
>>>>>
>>>>> Best regards,
>>>>>
>>>>> Jelle
>>>> Bump for the mail, I still have this issue, and would really appreciate
>>>> somebody taking a look at. I don't know if there is code limitation or
>>>> that it is just a asoundrc configuration issue.
>>>>
>>>> Please help,
>>>>
>>>> Best regards,
>>>>
>>>> Jelle
>>>
>>> Hello Jelle,
>>> could you please provide more details:
>>> 1. what happen when you play from two sources simultaneously?
>>> 2. what happen if you play only one source?
>>> 3. please provide your asoundrc (at least the pcm.bluetooth part)
>>> 4. does it work fine with other output device?
>>>
>>> Vale,
>>> event
>>
>> Thank you for responding, I had reattached the configurations and
>> outputs with some more info. I have already spent a bloody awful lot of
>> time on testing with trial and error. I am not an alsa or bluetooth
>> developer I cannot get it to work. If a capable person could get it
>> working I would be very great full.
>>
>> I am also not able to get bluetooth working without adding a sound card
>> to my system, so i put in a usb sound dongle just to get bluetooth with
>> alsa working, alsa won't load its modules without it first finding a
>> soundcard. It is all very very confusing.
>>
>> Thanks in advance for any help,
>>
>> Best regards,
>>
>> Jelle
>>
>
> Hello Jelle,
>
> I will setup the environment and do some tries as well. I'll come back
> to you when some outcome will be available
>
> Vale,
> Leonid Movshovich
>

Hello Jelle,

You need to setup a passkey agent (for bluez 3.x) for connection to
succeed. I've attached one simple

For dmix setups you have to define slaves as "pcm_slave." not "pcm."
is .asoundrc

Hope this helps.

Vale,
Leonid Movshovich

------=_Part_266791_16803128.1231598390059
Content-Type: text/plain; name=.asoundrc
Content-Transfer-Encoding: base64
X-Attachment-Id: file0
Content-Disposition: attachment; filename=.asoundrc

cGNtLmhlYWRzZXQgewoJdHlwZSBibHVldG9vdGgKCWF1dG9jb25uZWN0IHRydWUKCWRldmljZSAw
MDowMjo3ODpERDpGRTpFQgoJcHJvZmlsZSBoaWZpCn0KCg==
------=_Part_266791_16803128.1231598390059
Content-Type: application/x-python; name=bt_sec_impl.py
Content-Transfer-Encoding: base64
X-Attachment-Id: file2
Content-Disposition: attachment; filename=bt_sec_impl.py

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uCgppbXBvcnQgZGJ1cywgZGJ1cy5zZXJ2aWNlCmZyb20gZGJ1
cy5tYWlubG9vcC5nbGliIGltcG9ydCBEQnVzR01haW5Mb29wCmltcG9ydCBnb2JqZWN0CgpjbGFz
cyBNeVBhc3NrZXlBZ2VudChkYnVzLnNlcnZpY2UuT2JqZWN0KSA6CgogICAgZGVmIF9faW5pdF9f
KHNlbGYsIHBhdGgpOgogICAgICAgIGRidXMuc2VydmljZS5PYmplY3QuX19pbml0X18oc2VsZiwg
ZGJ1cy5TeXN0ZW1CdXMoKSwgcGF0aCkKICAgIAogICAgQGRidXMuc2VydmljZS5tZXRob2QoZGJ1
c19pbnRlcmZhY2U9J29yZy5ibHVlei5QYXNza2V5QWdlbnQnLAogICAgICAgICAgICAgICAgICAg
ICAgICAgaW5fc2lnbmF0dXJlPSdzc2InLCBvdXRfc2lnbmF0dXJlPSdzJykKICAgIGRlZiBSZXF1
ZXN0KHNlbGYsIHBhdGgsIGFkZHJlc3MsIHNoaXQpOgogICAgICAgIHByaW50IHBhdGgsIGFkZHJl
c3MKICAgICAgICByZXR1cm4gJzAwMDAnCgogICAgQGRidXMuc2VydmljZS5tZXRob2QoZGJ1c19p
bnRlcmZhY2U9J29yZy5ibHVlei5QYXNza2V5QWdlbnQnLAogICAgICAgICAgICAgICAgICAgICAg
ICAgaW5fc2lnbmF0dXJlPSdzcycsIG91dF9zaWduYXR1cmU9JycpCiAgICBkZWYgQ2FuY2VsKHNl
bGYsIHBhdGgsIGFkZHJlc3MpOgogICAgICAgIHBhc3MKCiAgICBAZGJ1cy5zZXJ2aWNlLm1ldGhv
ZChkYnVzX2ludGVyZmFjZT0nb3JnLmJsdWV6LlBhc3NrZXlBZ2VudCcsCiAgICAgICAgICAgICAg
ICAgICAgICAgICBpbl9zaWduYXR1cmU9JycsIG91dF9zaWduYXR1cmU9JycpCiAgICBkZWYgUmVs
ZWFzZShzZWxmKToKICAgICAgICBwYXNzCgoKCkRCdXNHTWFpbkxvb3Aoc2V0X2FzX2RlZmF1bHQ9
VHJ1ZSkKCmFnZW50ID0gTXlQYXNza2V5QWdlbnQoJy9vcmcvYmx1ZXovQWdlbnQwJykKc2lzX2J1
cyA9IGRidXMuU3lzdGVtQnVzKCkKc2VjdSA9IGRidXMuSW50ZXJmYWNlKHNpc19idXMuZ2V0X29i
amVjdCgnb3JnLmJsdWV6JywgJy9vcmcvYmx1ZXovaGNpMCcpLCAnb3JnLmJsdWV6LlNlY3VyaXR5
JykKc2VjdS5SZWdpc3RlckRlZmF1bHRQYXNza2V5QWdlbnQoJy9vcmcvYmx1ZXovQWdlbnQwJykK
Cmxvb3AgPSBnb2JqZWN0Lk1haW5Mb29wKCkKCmxvb3AucnVuKCkK
------=_Part_266791_16803128.1231598390059--
