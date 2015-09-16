Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1442382841-25729-1-git-send-email-simon.fels@canonical.com>
References: <1442382841-25729-1-git-send-email-simon.fels@canonical.com>
Date: Wed, 16 Sep 2015 14:23:28 +0300
Message-ID: <CABBYNZJx-vL5Q5HXd5_b19=yqFgyDehbkLHt05vP0ma99JodfQ@mail.gmail.com>
Subject: Re: [PATCH] obexd: enable ebook backend conditionally
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Simon Fels <simon.fels@canonical.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

On Wed, Sep 16, 2015 at 8:54 AM, Simon Fels <simon.fels@canonical.com> wrote:
> EDS support was sitting around but wasn't usable cause it was not included
> in the build configuration. It is now put behind an additional configure
> switch. By default still the dummy backend is used.
> ---
>  Makefile.obexd | 12 ++++++++----
>  configure.ac   | 12 ++++++++++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile.obexd b/Makefile.obexd
> index 2e33cbc..16aff59 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -39,8 +39,12 @@ obexd_builtin_sources += obexd/plugins/irmc.c
>  obexd_builtin_modules += pbap
>  obexd_builtin_sources += obexd/plugins/pbap.c \
>                                 obexd/plugins/vcard.h obexd/plugins/vcard.c \
> -                               obexd/plugins/phonebook.h \
> -                               obexd/plugins/phonebook-dummy.c
> +                               obexd/plugins/phonebook.h
> +if PHONEBOOK_EBOOK
> +obexd_builtin_sources += obexd/plugins/phonebook-ebook.c
> +else
> +obexd_builtin_sources += obexd/plugins/phonebook-dummy.c
> +endif
>  endif
>
>  obexd_builtin_modules += mas
> @@ -81,12 +85,12 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
>                         obexd/src/map_ap.h
>  obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
>                         gdbus/libgdbus-internal.la \
> -                       @ICAL_LIBS@ @DBUS_LIBS@ @GLIB_LIBS@ -ldl
> +                       @ICAL_LIBS@ @EBOOK_LIBS@ @DBUS_LIBS@ @GLIB_LIBS@ -ldl
>
>  obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
>
>  obexd_src_obexd_CFLAGS = $(AM_CFLAGS) @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
> -                               @ICAL_CFLAGS@ -DOBEX_PLUGIN_BUILTIN \
> +                               @ICAL_CFLAGS@ @EBOOK_CFLAGS@ -DOBEX_PLUGIN_BUILTIN \
>                                 -DPLUGINDIR=\""$(obex_plugindir)"\" \
>                                 -fPIC -D_FILE_OFFSET_BITS=64
>
> diff --git a/configure.ac b/configure.ac
> index 92b468d..12dffd8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -166,6 +166,11 @@ AC_ARG_ENABLE(cups, AC_HELP_STRING([--disable-cups],
>                  [disable CUPS printer support]), [enable_cups=${enableval}])
>  AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
>
> +AC_ARG_ENABLE(phonebook-ebook, AC_HELP_STRING([--enable-phonebook-ebook],
> +               [disable Phonebook support through EDS]),
> +               [enable_phonebook_ebook=${enableval}])
> +AM_CONDITIONAL(PHONEBOOK_EBOOK, test "${enable_phonebook_ebook}" = "yes")
> +

In the past we used to have --with-phonebook=<backend> perhaps we
should add it back, I think this was lost during the merge of obexd to
bluez. Ultimately I would like to move away from this kind backend
design to a D-Bus agent design which is registered at runtime so no
extra dependencies would be needed but currently I have no time to
work on it.

>  AC_ARG_ENABLE(obex, AC_HELP_STRING([--disable-obex],
>                 [disable OBEX profile support]), [enable_obex=${enableval}])
>  if (test "${enable_obex}" != "no"); then
> @@ -173,6 +178,13 @@ if (test "${enable_obex}" != "no"); then
>                                         AC_MSG_ERROR(libical is required))
>         AC_SUBST(ICAL_CFLAGS)
>         AC_SUBST(ICAL_LIBS)
> +
> +       if (test "${enable_phonebook_ebook}" = "yes"); then
> +               PKG_CHECK_MODULES(EBOOK, libebook-1.2, dummy=yes,
> +                                       AC_MSG_ERROR(libebook is required))
> +               AC_SUBST(EBOOK_CFLAGS)
> +               AC_SUBST(EBOOK_LIBS)
> +       fi
>  fi
>  AM_CONDITIONAL(OBEX, test "${enable_obex}" != "no")
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
