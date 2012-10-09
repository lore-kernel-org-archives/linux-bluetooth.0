Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349790707-8464-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1349790707-8464-1-git-send-email-andrzej.kaczmarek@tieto.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 9 Oct 2012 14:42:30 -0300
Message-ID: <CAMOw1v5yHTKSOVwhbNHZsAA=XS0N=-09VJehUKDLwVfet3vpPw@mail.gmail.com>
Subject: Re: [PATCH] build: Add missing documentation files to EXTRA_DIST
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 9, 2012 at 10:51 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> This patch adds missing documentation files to EXTRA_DIST variable so they
> are included when creating tarball.
> ---
>  Makefile.am | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 3b08f9a..dbbd794 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -401,7 +401,9 @@ EXTRA_DIST += doc/manager-api.txt \
>                 doc/network-api.txt doc/input-api.txt doc/audio-api.txt \
>                 doc/control-api.txt doc/hfp-api.txt doc/health-api.txt \
>                 doc/sap-api.txt doc/media-api.txt doc/assigned-numbers.txt \
> -               doc/supported-features.txt doc/alert-api.txt
> +               doc/supported-features.txt doc/alert-api.txt doc/mgmt-api.txt \
> +               doc/oob-api.txt doc/proximity-api.txt doc/heartrate-api.txt \
> +               doc/thermometer-api.txt
>
>  AM_YFLAGS = -d

Not related, but... what's this AM_YFLAGS doing in here? I'm sending a
patch to fix this


Lucas De Marchi
