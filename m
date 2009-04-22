Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8b5debfa0904220516u591f1cb8v6b04650794f2d20b@mail.gmail.com>
References: <8b5debfa0904220516u591f1cb8v6b04650794f2d20b@mail.gmail.com>
Date: Wed, 22 Apr 2009 16:22:14 -0300
Message-ID: <2d5a2c100904221222u4c3bd45aj3163f0c57d9bb70b@mail.gmail.com>
Subject: Re: [PATCH][HCIRAW] Initial proposal for hciraw plugin.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: alok barsode <alokbarsode@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

On Wed, Apr 22, 2009 at 9:16 AM, alok barsode <alokbarsode@gmail.com> wrote=
:
> Hi Marcel,
>
> Here are the initial patches for hciraw plugin.
>
> I have pulled the IO event stuff from main.c to hciraw.c
>
> Let me know what you think.
>
> Cheers,
> Alok.
>

The logic on Using-device_event-to-register-and-setup-already-kno.patch
seems to be wrong, it will not do what the current code does which is
to always register the adapter and in case of being up initialize it.

--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
