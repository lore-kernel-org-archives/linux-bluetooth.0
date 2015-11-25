Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAH4GWYEC3HEui497u4N2-+mHYa-Z7thWmHJ_nLHbfr7XN58scg@mail.gmail.com>
References: <CAH4GWYEC3HEui497u4N2-+mHYa-Z7thWmHJ_nLHbfr7XN58scg@mail.gmail.com>
Date: Wed, 25 Nov 2015 23:51:02 +0100
Message-ID: <CAExxLLAQb7719mdOYXo_NVnG4VK2_vAf9b_95rUOz=11x7GmKA@mail.gmail.com>
Subject: Re: Bluez g_dbus api for services
From: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
To: Marian Cingel <cingel.marian@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marian,

On Wed, Nov 25, 2015 at 11:18 PM, Marian Cingel <cingel.marian@gmail.com> wrote:
> Hello,
>
> I would like to ask whether current Bluez provides possibility to connect
> third part software through g_dbus and allows creating custom services and
> characteristics. I'm referring to the last post of Arman Uguray in thread
> http://comments.gmane.org/gmane.linux.bluez.kernel/53822 from 3.10.2014

Latest BlueZ has GATT API you mentioned, hidden behind experimental
flag (-E option)
API described in doc/gatt-api.txt. I recommend to play a bit with
D-Feet as a start.

>
> Regards,
> Marian

BR
Lukasz

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
BR / Pozdrawiam
Łukasz
