Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1387283107-4356-1-git-send-email-luiz.dentz@gmail.com>
References: <1387283107-4356-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 17 Dec 2013 09:07:13 -0400
Message-ID: <CAJdJm_MT5oKUhWQ+KqdQHv0wt54o=12vtDWPYVA1=jtLfUFZrA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Add coverage support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Dec 17, 2013 at 8:25 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> diff --git a/Makefile.am b/Makefile.am
> index 15cc149..337d849 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -331,5 +331,23 @@ lib/bluetooth/%.h: lib/%.h
>         $(AM_V_at)$(MKDIR_P) lib/bluetooth
>         $(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
>
> +if MAINTAINER_MODE
> +clean-coverage:
> +       -find $(top_builddir) -name "*.gcda" -delete
> +       @lcov --directory $(top_builddir) --zerocounters
> +       $(RM) -r coverage

You may want to remove coverage.info as well.

> +
> +coverage: clean-coverage check
> +       @lcov --compat-libtool --directory $(top_builddir) --capture \
> +                               --output-file $(top_builddir)/coverage.info
> +       $(AM_V_at)$(MKDIR_P) -p coverage

MKDIR_P already includes the "-p" option, so it should be
"$(AM_V_at)$(MKDIR_P) coverage" above.

> +       @genhtml -o coverage/ $(top_builddir)/coverage.info
> +
> +clean-local: clean-coverage
> +       -find $(top_builddir) -name "*.gcno" -delete
> +       $(RM) -r lib/bluetooth
> +
> +else
>  clean-local:
>         $(RM) -r lib/bluetooth
> +endif

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
