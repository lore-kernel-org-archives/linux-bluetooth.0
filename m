Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337612075-2697-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337612075-2697-1-git-send-email-lucas.demarchi@profusion.mobi>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 23 May 2012 19:24:35 -0300
Message-ID: <CAMOw1v4bP74N9ugbQ5RuFbnw_k8JUp7fRkQ+79TvQa0qpRN-ZA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: add macro for methods marked as NOREPLY
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, May 21, 2012 at 11:54 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>
> This one is not used in BlueZ, but it was necessary for other projects us=
ing
> gdbus. It's better to keep them in sync.
>
> =A0gdbus/gdbus.h | =A0 =A07 +++++++
> =A01 file changed, 7 insertions(+)
>
> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> index e2e160d..0a8a27c 100644
> --- a/gdbus/gdbus.h
> +++ b/gdbus/gdbus.h

This one is still missing in BlueZ, neard and ConnMan.


Lucas De Marchi
