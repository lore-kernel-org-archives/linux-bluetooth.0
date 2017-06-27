Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170626183304.GA10416@localhost.localdomain>
References: <20170626183304.GA10416@localhost.localdomain>
From: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Date: Tue, 27 Jun 2017 09:01:02 +0200
Message-ID: <CAExxLLAxyG6wLcpfJ6BDzbjG5o6q5aF2FJHjX4dP_x+zbrvADQ@mail.gmail.com>
Subject: Re: Setting LE advertisement interval, bluez
To: Ravi Minnikanti <ravichandraminnikanti@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On 26 June 2017 at 20:33, Ravi Minnikanti
<ravichandraminnikanti@gmail.com> wrote:
> Hi all,
>
> I implemented a GATT server using bluez DBus API and everything works wel=
l.
> I want to know is there any way I can set advertisement interval from my
> application. Advertisement Data is set and advertisment is enabled when
> I register my advertisement through DBus API. I don't see any mgmt API to
> just set advertisement interval.
>

I'm afraid the only way to play with advertising intverval is  via debugfs.
You are looking for adv_max_interval and adv_min_interval in
/sys/kernel/debug/bluetooth/hcix/

> Any help would be very useful.
>
> Thanks,
> Ravi

Best regards
=C5=81ukasz

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
