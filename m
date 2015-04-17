Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <A962A040-4EB5-4AE6-A790-A8767185172B@holtmann.org>
References: <1429212265-26750-1-git-send-email-geert@linux-m68k.org>
	<A962A040-4EB5-4AE6-A790-A8767185172B@holtmann.org>
Date: Fri, 17 Apr 2015 22:03:29 +0200
Message-ID: <CAMuHMdUxnrg1BVoFpKExzGHKj2aOmYGp+wChhMbPfmWvMzQT=Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Pre-initialize variables in read_local_oob_ext_data_complete()
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Apr 16, 2015 at 10:34 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
>> net/bluetooth/mgmt.c: In function =E2=80=98read_local_oob_ext_data_compl=
ete=E2=80=99:
>> net/bluetooth/mgmt.c:6474: warning: =E2=80=98r256=E2=80=99 may be used u=
ninitialized in this function
>> net/bluetooth/mgmt.c:6474: warning: =E2=80=98h256=E2=80=99 may be used u=
ninitialized in this function
>> net/bluetooth/mgmt.c:6474: warning: =E2=80=98r192=E2=80=99 may be used u=
ninitialized in this function
>> net/bluetooth/mgmt.c:6474: warning: =E2=80=98h192=E2=80=99 may be used u=
ninitialized in this function
>>
>> While these are false positives, the code can be shortened by
>> pre-initializing the hash table pointers and eir_len. This has the side
>> effect of killing the compiler warnings.
>
> can you be a bit specific on which compiler version is this. I fixed one =
occurrence that seemed valid. However in this case the compiler seems to be=
 just plain stupid. On a gcc 4.9, I am not seeing these for example.

gcc 4.1.2. As there were too many false positives, these warnings were
disabled in later versions (throwing away the children with the bad water).

If you don't like my patch, just drop it. I only look at newly
introduced warnings
of this kind anyway.

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
