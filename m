Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ef6beb0a-e40d-8b3a-9ebb-0d0489f2ca00@gmail.com>
References: <ef6beb0a-e40d-8b3a-9ebb-0d0489f2ca00@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Aug 2018 15:57:17 +0300
Message-ID: <CABBYNZ+cDf5Xu_f-Q0UodRGLpcfR-8BXa7tkMQgDmOeSBDj+2w@mail.gmail.com>
Subject: Re: [Patch 1/1] Fix Clang compilation of BlueZ
To: StormByte <stormbyte@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 7, 2018 at 2:34 PM, StormByte <stormbyte@gmail.com> wrote:
> When trying to compile as much as I can in Gentoo with CLang, I realized
> that Bluez is not compiling due to a function definition inside a
> function, which is not allowed by clang.
>
> I am not sure if this may be the best solution, but I've made a patch
> that makes it compile without errors (not sure if it runs good yet though).
>
> I hope it is useful for reviewing and applying if you consider necesary,

Apparently this one passed the review, but we normally don't allow
such construction, anyway do you mind sending a proper patch as stated
in HACKING?

> Thanks,
>
>
> David C. Manuelda
>



-- 
Luiz Augusto von Dentz
