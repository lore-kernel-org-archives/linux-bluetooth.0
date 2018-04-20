Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLmjfzBUfR1hWKvxcTaHhH7XKi_wZhjAuNMdpUxn2vBTw@mail.gmail.com>
References: <20180420120036.040c1b09@windsurf.numericable.fr> <CABBYNZLmjfzBUfR1hWKvxcTaHhH7XKi_wZhjAuNMdpUxn2vBTw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Apr 2018 16:04:37 +0300
Message-ID: <CABBYNZJrOLb0PZ8Y7kP8SuSJYOamaw54rr2VLwu-zV-5aubhzw@mail.gmail.com>
Subject: Re: [blueZ] Readline mandatory ?
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

On Fri, Apr 20, 2018 at 3:57 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Thomas,
>
> On Fri, Apr 20, 2018 at 1:00 PM, Thomas Petazzoni
> <thomas.petazzoni@bootlin.com> wrote:
>> Hello,
>>
>> Until commit bee3796113196da1b3f56da42fcae4d9bae6695e, the readline
>> library was an optional dependency of bluez (only needed when
>> --enable-client was used).
>>
>> However, following this commit, shell.c is now built as part of
>> libshared, and readline becomes a mandatory dependency, which is not even
>> checked by the configure script. This leads to a build failure such as:
>>
>> src/shared/shell.c:39:31: fatal error: readline/readline.h: No such file or directory
>>  #include <readline/readline.h>
>>
>> Is this an intended side effect of commit
>> bee3796113196da1b3f56da42fcae4d9bae6695e ? If yes, then the configure
>> script should be adjusted accordingly. If not, how should the code be
>> fixed to not use readline unconditionally ?
>>
>> The fact that readline is under GPLv3 might be an issue for some
>> people, so having it as a mandatory dependency might be problematic.
>>
>> The problem reported here exists in both the 5.49 release and the
>> latest master branch as of a085d8c88bd45474d3f9d9a0d3d20ebf7de858f6.
>>
>> Any hint on how to resolve this issue ?
>
> We will have to fix this, it shell should probably be conditional to
> build with libshared like the tools are.

Ive send a patch for it, could please check if it does build properly
on a system without readline.

>> Thanks,
>>
>> Thomas Petazzoni
>> --
>> Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
