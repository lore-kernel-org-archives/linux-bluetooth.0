Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <8684664B-22C2-45E8-B547-48F173B3CA7A@holtmann.org>
References: <1429212265-26750-1-git-send-email-geert@linux-m68k.org>
	<A962A040-4EB5-4AE6-A790-A8767185172B@holtmann.org>
	<CAMuHMdUxnrg1BVoFpKExzGHKj2aOmYGp+wChhMbPfmWvMzQT=Q@mail.gmail.com>
	<8684664B-22C2-45E8-B547-48F173B3CA7A@holtmann.org>
Date: Mon, 20 Apr 2015 10:47:03 +0200
Message-ID: <CAMuHMdUXcAYe4KCqG9wV3O5QYzK9RGt+QZz7E_jk7v9yhtrkRQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Pre-initialize variables in read_local_oob_ext_data_complete()
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Apr 17, 2015 at 10:38 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
>>>> net/bluetooth/mgmt.c: In function =E2=80=98read_local_oob_ext_data_com=
plete=E2=80=99:
>>>> net/bluetooth/mgmt.c:6474: warning: =E2=80=98r256=E2=80=99 may be used=
 uninitialized in this function
>>>> net/bluetooth/mgmt.c:6474: warning: =E2=80=98h256=E2=80=99 may be used=
 uninitialized in this function
>>>> net/bluetooth/mgmt.c:6474: warning: =E2=80=98r192=E2=80=99 may be used=
 uninitialized in this function
>>>> net/bluetooth/mgmt.c:6474: warning: =E2=80=98h192=E2=80=99 may be used=
 uninitialized in this function
>>>>
>>>> While these are false positives, the code can be shortened by
>>>> pre-initializing the hash table pointers and eir_len. This has the sid=
e
>>>> effect of killing the compiler warnings.
>>>
>>> can you be a bit specific on which compiler version is this. I fixed on=
e occurrence that seemed valid. However in this case the compiler seems to =
be just plain stupid. On a gcc 4.9, I am not seeing these for example.
>>
>> gcc 4.1.2. As there were too many false positives, these warnings were
>> disabled in later versions (throwing away the children with the bad wate=
r).
>>
>> If you don't like my patch, just drop it. I only look at newly
>> introduced warnings
>> of this kind anyway.
>
> I really do not know what is the best solution here. This is a false posi=
tive. And I have been looking at this particular code for a warning that wa=
s valid, but we missed initially. But these warnings that you are fixing ar=
e clearly false positive.

I only sent patches to fix false positives if I think the patches improve t=
he
code. As this is a subjective matter, it's up to you as the maintainer to
decide.

> If this only happens with an old compiler version, I would tend to leave =
the code as is. Then again, what is the general preferred approach here?

As this is a false positive, it's clearly up to the maintainer to
decide if the patch
improves the code or not.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
