Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTin7W9jtfAmV4vo9E+YOrkUfrWpO0-B_jzkXZChm@mail.gmail.com>
References: <AANLkTin7W9jtfAmV4vo9E+YOrkUfrWpO0-B_jzkXZChm@mail.gmail.com>
Date: Thu, 24 Feb 2011 09:23:57 +0800
Message-ID: <AANLkTinBOT_JqkxxQryOQRaoFXR5=3gvZK_ZJ+Ux4wjj@mail.gmail.com>
Subject: Re: Help hcitool cmd (hci to connect)
From: haijun liu <liuhaijun.er@gmail.com>
To: Thibaut L <thibaut.dvr@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thibaut,
I remember there is a monitor for hci connection, if nobody reference
it for a while, then it will issue a disconnect request, so you'd
better make a l2cap connection on it to keep it alive.

Haijun.Liu
skype: liu.haijun

On 2/22/11, Thibaut L <thibaut.dvr@gmail.com> wrote:
> Dear all,
>
> Please, could anyone tell me how to connect to a bluetooth device
> through hcitool (BlueZ) hci command. Like this: "hcitool cmd 0x01
> 0x0005 [parameters]". How can I input this cmd? Is the [parameters] a
> bt device MAC adress like XX:XX:XX:XX:XX:XX?
>
> I've tryed to use "hcitool cc <MAC>", but it doesn't work for me cause
> it disconnects the device a second later.
>
> I just wanna measure RSSI.
>
> Thanks in advance.
>
> Best
>
> Thibaut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Haijun Liu
