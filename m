Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343665491-16362-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1343665491-16362-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1343665491-16362-2-git-send-email-lucas.demarchi@profusion.mobi>
Date: Mon, 30 Jul 2012 12:57:42 -0400
Message-ID: <CAJdJm_OgYuaXuUa50he8u=FANPWXEYgJS81xOHcuU7KrOdeNdQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] rfcomm: Remove support for configuration file
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Jul 30, 2012 at 12:24 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> diff --git a/Makefile.tools b/Makefile.tools
> index 5579b86..e05d588 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -1,7 +1,6 @@
>
>  if TOOLS
>  if DATAFILES
> -conf_DATA += tools/rfcomm.conf
>  endif

Why not remove the whole "if DATAFILES ... endif" block?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
