Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349332630-8901-2-git-send-email-lucas.de.marchi@gmail.com>
References: <1349332630-8901-1-git-send-email-lucas.de.marchi@gmail.com>
	<1349332630-8901-2-git-send-email-lucas.de.marchi@gmail.com>
Date: Thu, 4 Oct 2012 06:38:28 -0400
Message-ID: <CAJdJm_Pc8T1yk3hpfugZNsAjLqh2RDCFxV7AXy-_ZKWhHZg9tw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] build-sys: Don't use deprecated INCLUDES variable
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas/Johan,

On Thu, Oct 4, 2012 at 2:37 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Makefile.am:410: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
> ---
>  Makefile.am | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index dea207e..3b08f9a 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -407,13 +407,13 @@ AM_YFLAGS = -d
>
>  AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
>
> -INCLUDES = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
> +AM_CPPFLAGS = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
>                         -I$(srcdir)/audio -I$(srcdir)/sbc -I$(srcdir)/gdbus \
>                         -I$(srcdir)/attrib -I$(srcdir)/btio -I$(srcdir)/tools \
>                         -I$(builddir)/tools -I$(srcdir)/monitor
>
>  if MCAP
> -INCLUDES += -I$(builddir)/health
> +AM_CPPFLAGS += -I$(builddir)/health
>  endif

This reminds me that the patch I sent few days ago which removes the
snippet above (which is unnecessary, given the directory does not
exist anymore and profiles/health still builds just fine) was not
applied yet.

I'll rebase and resend. There were comments from Marcel regarding the
use of symlinks for drivers (i.e. telephony, sap), which will be
addressed in a separate patch.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
