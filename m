Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352754221-29672-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1352754221-29672-1-git-send-email-anderson.lizardo@openbossa.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 13 Nov 2012 10:21:39 -0200
Message-ID: <CAMOw1v4h9wfcFLL-j5+fmEUNF=ShHZryw93aOC+_8d2NsbMFag@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Fix make distcheck for input plugin
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Nov 12, 2012 at 7:03 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> suspend.c is a symlink generated at build time, therefore it should be
> created on build directory. Additionally, it is necessary to add
> -I$(srcdir)/profiles/input to CPPFLAGS so suspend.h can be found (the
> compiler does not follow symlinks prior to resolving #include
> directives).
> ---
>  Makefile.am |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index d49e8a0..c398e74 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -366,6 +366,10 @@ if MCAP
>  AM_CPPFLAGS += -I$(builddir)/health
>  endif
>
> +if HOGPLUGIN
> +AM_CPPFLAGS += -I$(srcdir)/profiles/input
> +endif

Humn... maybe we need to review these CPPFLAGS for plugins. Appending
it to AM_CPPFLAGS means that every single source file has
"-I$(srcdir)/profiles/input". Even those sources not at all related to
HOGPLUGIN.

However the only way I can think to fix it is by creating convenience
libs since autofoo doesn't support CPPFLAGS per source file.


Lucas De Marchi
