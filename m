Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAALU38OAXUzdNq7ufILcZbxfCgAAAEAAAACHTzNQYXF1JtETGiT760e0BAAAAAA==@tiscali.it>
References: <!&!AAAAAAAAAAAYAAAAAAAAALU38OAXUzdNq7ufILcZbxfCgAAAEAAAACHTzNQYXF1JtETGiT760e0BAAAAAA==@tiscali.it>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 Feb 2018 16:22:31 +0200
Message-ID: <CABBYNZLvGY+pmHr7RSShCK_Gw9ZXf2G1nYibdg+7+Z=SBQy=AQ@mail.gmail.com>
Subject: Re: HSP issue
To: AETERNAICT <info.aeterna@tiscali.it>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Francesco,

On Wed, Feb 21, 2018 at 4:12 PM, AETERNAICT <info.aeterna@tiscali.it> wrote:
> Hi,
>
> I'm testing bluetooth headphone on ubuntu mate 16.04 with Odroid C2 ARM
> board computer.
>
> Anyone have HSP/HFP source/sink working under bluez5.37, Pulseaudio11, ofono
> 1.17?
>
> A2DP profile of bluetooth headphone works correctly (sound is perfect), but
> HSF/HFP profile doesn't work.
> The audio is discontinuous and audio microphone is absent.

This sometimes indicates that the audio routing of the chip is wrong,
but apparently, you do get some audio so perhaps it is just dropping
frames left and right. For the microphone, I trust that you have
selected it as input.

> Here hardware setup:
> Odroid C2 Arm computer
> http://www.hardkernel.com/main/products/prdt_info.php?g_code=G145457216438
> BT dongle https://www.adafruit.com/product/1327
> Headphone http://peltorcomms.3m.com/Admin/files/20121001030809.pdf
>
> Best regards,
> Francesco
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
