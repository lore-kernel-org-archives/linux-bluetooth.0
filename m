Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180321165422.17501-1-luiz.dentz@gmail.com>
References: <20180321165422.17501-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 22 Mar 2018 10:37:33 +0200
Message-ID: <CABBYNZLpqu5sPpv2djQJy3wn-DgKy5rGgftk86YhK1UV0asvCQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Fix not disabling obexd when given --disable-obex
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 21, 2018 at 6:54 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> --disable-obex shall disable building obexd daemon.
> ---
>  Makefile.am    | 4 ++++
>  Makefile.obexd | 3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index daf34b6ca..5ac76d81c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -223,7 +223,11 @@ test_scripts =
>  unit_tests =
>
>  include Makefile.tools
> +
> +if OBEX
>  include Makefile.obexd
> +endif
> +
>  include android/Makefile.am
>
>  if HID2HCI
> diff --git a/Makefile.obexd b/Makefile.obexd
> index 5959f2292..11d101158 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -1,4 +1,3 @@
> -
>  if SYSTEMD
>  systemduserunitdir = @SYSTEMD_USERUNITDIR@
>  systemduserunit_DATA = obexd/src/obex.service
> @@ -32,7 +31,6 @@ obexd_builtin_sources += obexd/plugins/opp.c
>  obexd_builtin_modules += ftp
>  obexd_builtin_sources += obexd/plugins/ftp.c obexd/plugins/ftp.h
>
> -if OBEX
>  obexd_builtin_modules += irmc
>  obexd_builtin_sources += obexd/plugins/irmc.c
>
> @@ -41,7 +39,6 @@ obexd_builtin_sources += obexd/plugins/pbap.c \
>                                 obexd/plugins/vcard.h obexd/plugins/vcard.c \
>                                 obexd/plugins/phonebook.h \
>                                 obexd/plugins/phonebook-dummy.c
> -endif
>
>  obexd_builtin_modules += mas
>  obexd_builtin_sources += obexd/plugins/mas.c obexd/src/map_ap.h \
> --
> 2.14.3

Applied.


-- 
Luiz Augusto von Dentz
