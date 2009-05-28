Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5d223510905281012j75808257t60d9fc095575016@mail.gmail.com>
References: <25e5cce0905271909q747731acj4be42694772e67f8@mail.gmail.com>
	 <5d223510905281012j75808257t60d9fc095575016@mail.gmail.com>
Date: Thu, 28 May 2009 17:55:24 -0500
Message-ID: <25e5cce0905281555q6e2b85a3hf901aae4bd14bda1@mail.gmail.com>
Subject: Re: Can't play sound on bluetooth headset
From: Diego Garcia <diegogarciamendoza@gmail.com>
To: Rafael Seste <rseste@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for your response, i did it but it don't work. Actually i saw
that wiki and did the .asoundrc part but missed that part u mentioned.

Anyways it still don't work. And tried with headphones service and A2DP.

Maybe there is another workaround?

On Thu, May 28, 2009 at 12:12 PM, Rafael Seste <rseste@gmail.com> wrote:
> Hi Diego,
>
> On Wed, May 27, 2009 at 11:09 PM, Diego Garcia
> <diegogarciamendoza@gmail.com> wrote:
>> Hi,
>>
>> I'm using ubuntu 9.04 and my headset is Motorola S9.
>>
>> I connected my BT antenna and it didn't recognized as headset so i
>> installed blueman and upgraded bluez.
>>
>> Now it recognize it correctly, so i tried to configure the ALSA Driver
>> on Audacious for selecting bluetooth but that option doesn't appear.
>>
>> Anyone can give any advice about this?
>
> this howto from bluez wiki should help you.
>
> "if you can't see the audio device form there, you can force the
> bluetooth output by modifying your audacious property file"
>
> ~/.config/audacious/config. Modify the "pcm_device" value by
> "pcm_device=bluetooth"
>
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices
>
>>
>> Regards,
>> Diego García Mendoza
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Rafael S. Seste
>



-- 
Diego García Mendoza
