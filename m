Return-Path: <hanipouspilot@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANoib0FoY86caY-zABHssXq_G8zmt3zJemvYrTyvQ1R58xseoQ@mail.gmail.com>
References: <CANoib0FoY86caY-zABHssXq_G8zmt3zJemvYrTyvQ1R58xseoQ@mail.gmail.com>
From: Dmitry Tunin <hanipouspilot@gmail.com>
Date: Sun, 13 May 2018 16:20:33 +0300
Message-ID: <CANoib0ENa5LX4hFrQJvdBsHFVs6+3eH+VbzNJ=iW-nGd11Ga-g@mail.gmail.com>
Subject: Re: [REGRESSION] And a drity fix for 0cf3:3004 QCA Rome device
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

And the worst thing is that if has been CCed to
stable@vger.kernel.org. This means that the regression will affect all
supported kernels soon. This should be fixed!!

2018-05-13 16:08 GMT+03:00 Dmitry Tunin <hanipouspilot@gmail.com>:
> Hi, Marcel
>
> Since  f44cb4b older AR3012 devices stopped working. We discussed that
> before that QCA released a ROME device with a duplicate code.
>
> If there is no easy way to check which one is used, then it may be a
> good decision to change the kernel code for the newer device in new
> kernels.
>
> But anyway it should be made cleaner. The device is still listed in
> ath3k.o as an AR3012.
>
> Regards,
>
> Dmitry.
