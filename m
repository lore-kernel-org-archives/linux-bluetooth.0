Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAK4aCBZgH0uCGz2oaRSaHzRX8p6vK1YrOKG+X+mHAJd33WHmRQ@mail.gmail.com>
References: <CAK4aCBbDAG82YKZLhLg_jTG_dQoDykwimO3a18fb7eGHiXgA0Q@mail.gmail.com>
	<CABBYNZKPwpg8=7Ehg86MkSuWxHfK62eEyJ2-XGV==ROF9K3W4w@mail.gmail.com>
	<CAK4aCBZgH0uCGz2oaRSaHzRX8p6vK1YrOKG+X+mHAJd33WHmRQ@mail.gmail.com>
Date: Mon, 19 Aug 2013 13:37:40 +0300
Message-ID: <CABBYNZKyH50gq0ZsryypyyVR5KSqARQyoYoUGct-xXvpZ9=mRw@mail.gmail.com>
Subject: Re: Cannot connect to A2DP audio sink on Bluetooth headset
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Fabrice Delente <delentef@gmail.com>
Cc: Liste Linux-Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabrice,

On Mon, Aug 19, 2013 at 12:34 PM, Fabrice Delente <delentef@gmail.com> wrote:
> Hello Luiz,
>
> Are you a gentoo developer ? Because I am stuck with the packages that
> are integrated in this distribution; I have tried with the bluez-5.7
> 'palmer' overlay ebuild, but I have the same problem (no A2DP) and
> blueman expects the bluez-4 API...
>
> The worst is that I had A2DP with bluez-4 2 days ago, and all of a
> sudden no-go... Something broke, but what ?? I just recompiled the
> kernel to hardcode some parts that were modules...
>
> Thanks for you reply anyway!

No, Im not gentoo developer in fact I use Fedora, for controlling the
Bluetooth adapter you can use bluetoothctl but for audio streaming you
really need a newer version of PulseAudio. Take a look at fedora
rawhide they just recently integrate BlueZ 5.


-- 
Luiz Augusto von Dentz
