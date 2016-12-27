Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161226202634.28195-1-eu@felipetonello.com>
References: <20161226202634.28195-1-eu@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Dec 2016 15:03:20 +0200
Message-ID: <CABBYNZJoCOuiL1v8pc4gr4pN-Z-oC8FULG6Tn8PVnWw7tDhSOg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 0/2] MIDI over BLE implementation
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        agoode@chromium.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Mon, Dec 26, 2016 at 10:26 PM, Felipe F. Tonello
<eu@felipetonello.com> wrote:
> This patchset implements the MIDI over BLE spec, more information on patch #1.
>
> Patch #2 is some unit-tests to make sure the MIDI parser works properly.
>
> Felipe F. Tonello (2):
>   profiles/midi: Added MIDI over BLE profile implementation
>   unit/test-midi: Added libmidi use-case tests
>
>  Makefile.am             |  14 +-
>  Makefile.plugins        |   8 +
>  configure.ac            |  11 +
>  profiles/midi/libmidi.c | 412 +++++++++++++++++++++++++++++++
>  profiles/midi/libmidi.h | 150 ++++++++++++
>  profiles/midi/midi.c    | 490 +++++++++++++++++++++++++++++++++++++
>  unit/test-midi.c        | 628 ++++++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 1712 insertions(+), 1 deletion(-)
>  create mode 100644 profiles/midi/libmidi.c
>  create mode 100644 profiles/midi/libmidi.h
>  create mode 100644 profiles/midi/midi.c
>  create mode 100644 unit/test-midi.c
>
> --
> 2.10.2

Looks like there is something not quite rigth:

https://paste.fedoraproject.org/513667/48284373/

-- 
Luiz Augusto von Dentz
