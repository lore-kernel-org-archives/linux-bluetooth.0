Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAK4aCBbDAG82YKZLhLg_jTG_dQoDykwimO3a18fb7eGHiXgA0Q@mail.gmail.com>
References: <CAK4aCBbDAG82YKZLhLg_jTG_dQoDykwimO3a18fb7eGHiXgA0Q@mail.gmail.com>
Date: Mon, 19 Aug 2013 11:04:06 +0300
Message-ID: <CABBYNZKPwpg8=7Ehg86MkSuWxHfK62eEyJ2-XGV==ROF9K3W4w@mail.gmail.com>
Subject: Re: Cannot connect to A2DP audio sink on Bluetooth headset
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Fabrice Delente <delentef@gmail.com>
Cc: Liste Linux-Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabrice,

On Mon, Aug 19, 2013 at 12:41 AM, Fabrice Delente <delentef@gmail.com> wrote:
> Hello.
>
> I have a headset that used to work with bluez-4.101 (on gentoo), but
> all of a sudden it was impossible to connect, even though I haven't
> changed anything to my configuration...
>
> Anyway, I tried bluez-5.7 through a gentoo overlay, as stock gentoo
> only carries bluez-4.101
>
> Since blueman doesn't work with bluez-5.7, I have tried to connect to
> the sink through bluetoothctl. However, as root, I get this:
>
> [bluetooth]# connect 00:18:91:D0:7A:24
> Attempting to connect to 00:18:91:D0:7A:24
> [CHG] Device 00:18:91:D0:7A:24 Connected: yes
> Failed to connect: org.bluez.Error.Failed

You probably need a newer PulseAudio with BlueZ 5 support, we are
working on a release candidate for PulseAudio 5.0 that should work
properly.
