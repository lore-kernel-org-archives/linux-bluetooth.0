Return-Path: <cyrus@holtmann.org>
Message-ID: <535619.95725.qm@web95401.mail.in2.yahoo.com>
References: <25e5cce0905271909q747731acj4be42694772e67f8@mail.gmail.com>  <5d223510905281012j75808257t60d9fc095575016@mail.gmail.com> <25e5cce0905281555q6e2b85a3hf901aae4bd14bda1@mail.gmail.com>
Date: Fri, 29 May 2009 11:16:26 +0530 (IST)
From: balaji palaniswami <balaji_palaniswami@yahoo.com>
Subject: Re: Can't play sound on bluetooth headset
To: Diego Garcia <diegogarciamendoza@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <25e5cce0905281555q6e2b85a3hf901aae4bd14bda1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>






----- Original Message ----
From: Diego Garcia <diegogarciamendoza@gmail.com>
To: Rafael Seste <rseste@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Sent: Friday, 29 May, 2009 4:25:24 AM
Subject: Re: Can't play sound on bluetooth headset

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
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Rafael S. Seste
>



-- 
Diego García Mendoza
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


Hello Diego ,

I dont know configurations related audacious but following steps would work in rhythm player
I have assumed that you are having Ubuntu 9.04 , latest blueman and bluez.

Please try out following steps to make a2dp work.
1. pair headset and connect a2dp service.
2. add .asoundrc in your HOME directory 

pcm.bluetooth {
type bluetooth
device XX:XX:XX:XX:XX:XX
profile "auto"
}
pcm.bluetoothraw {
type bluetooth
}
pcm.bluetooth {
type plug
slave {
pcm bluetoothraw
}
}

replace XX by BT_ADDR of MOTO S9

3. gconftool -t string -s /system/gstreamer/0.10/default/musicaudiosink "alsasink buffer-time=6000000 latency-time=1000000 device=bluetoothraw"

4. restart bluetooth service  or do reboot (optional)

Please try it out and let me know any further issues. 

Thanks,
Balaji



      Cricket on your mind? Visit the ultimate cricket website. Enter http://beta.cricket.yahoo.com

