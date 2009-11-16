Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <dfb262380911150431h79650f28kadea09c26aee811f@mail.gmail.com>
References: <dfb262380911141026x72fafeb8tbffd8692bd0c1ad5@mail.gmail.com>
	 <dfb262380911150431h79650f28kadea09c26aee811f@mail.gmail.com>
Date: Mon, 16 Nov 2009 12:09:23 +0200
Message-ID: <dfb262380911160209v42da3134y8e645b33ac65ccdb@mail.gmail.com>
Subject: Re: bluetooth audio fails
From: Ramagudi Naziir <naziirr@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have just tried that with bluez 3.36 and it works!

So - should I downgrade to bluez 3.36 ?

Can you just tell me how you would debug this ?

On Sun, Nov 15, 2009 at 2:31 PM, Ramagudi Naziir <naziirr@gmail.com> wrote:
> I have just tried that also with a Motorola H700 headset,
> and got exact same error message.
>
> (I also tried bluez 4.56 and got same error)
>
> please help me to debug this.
>
> thank you,
> naziirr
>
>
> On Sat, Nov 14, 2009 at 8:26 PM, Ramagudi Naziir <naziirr@gmail.com> wrote:
>> Hi all,
>>
>> Can anyone pls help me debug this:
>>
>> # aplay -D bluetooth /startup.wav
>> ALSA lib audio/pcm_bluetooth.c:1607:(audioservice_expect)
>> BT_GET_CAPABILITIES failed : Input/output error(5)
>> aplay: main:608: audio open error: Input/output error
>>
>> I'm running the latest bluez git sources with a 9xxPlantronics HFP headset.
>> I tried both "auto" and "voice" in .asoundrc:
>>
>> pcm.bluetooth {
>>        type bluetooth
>>        device mybdaddr
>>        profile “voice”
>> }
>>
>>
>> Any idea what this could be and how to debug/fix it ?
>>
>> thank you
>> naziirr
>>
>
