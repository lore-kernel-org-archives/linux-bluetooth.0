Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: HSP issue
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        AETERNAICT <info.aeterna@tiscali.it>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAALU38OAXUzdNq7ufILcZbxfCgAAAEAAAACHTzNQYXF1JtETGiT760e0BAAAAAA==@tiscali.it>
 <CABBYNZLvGY+pmHr7RSShCK_Gw9ZXf2G1nYibdg+7+Z=SBQy=AQ@mail.gmail.com>
From: Harald Schmitt <linux@hschmitt.de>
Message-ID: <59f75e0e-2d94-1fa6-28c7-8aeb964108ad@hschmitt.de>
Date: Wed, 21 Feb 2018 16:15:29 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZLvGY+pmHr7RSShCK_Gw9ZXf2G1nYibdg+7+Z=SBQy=AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 21.02.2018 um 15:22 schrieb Luiz Augusto von Dentz:
> Hi Francesco,
>
> On Wed, Feb 21, 2018 at 4:12 PM, AETERNAICT <info.aeterna@tiscali.it> wrote:
>> Hi,
>>
>> I'm testing bluetooth headphone on ubuntu mate 16.04 with Odroid C2 ARM
>> board computer.
>>
>> Anyone have HSP/HFP source/sink working under bluez5.37, Pulseaudio11, ofono
>> 1.17?
>>
>> A2DP profile of bluetooth headphone works correctly (sound is perfect), but
>> HSF/HFP profile doesn't work.
>> The audio is discontinuous and audio microphone is absent.
> This sometimes indicates that the audio routing of the chip is wrong,
> but apparently, you do get some audio so perhaps it is just dropping
> frames left and right. For the microphone, I trust that you have
> selected it as input.
I just can share my observations with Jolla's SailfishOS which uses
ofono 1.20, bluez 5.47, pulseaudio 8 (with backported HSP/HFP). If the
carkit initiates the bluetooth connection phoning works correctly
(HSP/HFP) but media playback uses the phone speaker (a2dp) if the
connection is initated from the phone it is the other way round.
You can see what they did at https://git.merproject.org
>
>> Here hardware setup:
>> Odroid C2 Arm computer
>> http://www.hardkernel.com/main/products/prdt_info.php?g_code=G145457216438
>> BT dongle https://www.adafruit.com/product/1327
>> Headphone http://peltorcomms.3m.com/Admin/files/20121001030809.pdf
>>
>> Best regards,
>> Francesco
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

