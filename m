Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1401727071-28731-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401727071-28731-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Fri, 6 Jun 2014 11:43:30 +0300
Message-ID: <CABBYNZJYg8=0pHPfhW7J5ppdCRahyNcExcn0zkOOz5iEGbg6Ow@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] android: aptX support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Mon, Jun 2, 2014 at 7:37 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> v3 changes:
> - fixed variable names
> - added queue for loaded codecs
>
>
> Andrzej Kaczmarek (5):
>   android/hal-audio: Always call qos_update
>   android/hal-audio: Allow codec to init on startup
>   android/hal-audio-aptx: Add initial support for aptX codec
>   android/hal-audio-aptx: Load aptX encoder library
>   android/hal-audio-aptx: Add encoding
>
>  android/Android.mk       |   4 +
>  android/Makefile.am      |   1 +
>  android/hal-audio-aptx.c | 276 +++++++++++++++++++++++++++++++++++++++++++++++
>  android/hal-audio.c      |  84 +++++++++++----
>  android/hal-audio.h      |   4 +
>  5 files changed, 349 insertions(+), 20 deletions(-)
>  create mode 100644 android/hal-audio-aptx.c
>
> --
> 1.9.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
