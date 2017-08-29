Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170823225839.461-1-yunhanw@google.com>
References: <20170823225839.461-1-yunhanw@google.com>
From: Yunhan Wang <yunhanw@google.com>
Date: Mon, 28 Aug 2017 20:24:48 -0700
Message-ID: <CALvjcs_F+0Xqk_BJuVXwYYGXv6Po71PPaYTyL81U56BEbLJAaw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: use abspath for lib/bluetooth
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anyone can help to take a review?

Thanks
Best wishes
Yunhan

On Wed, Aug 23, 2017 at 3:58 PM, Yunhan Wang <yunhanw@google.com> wrote:
> When building from out of tree, and the top build dir was specified as
> an absolute path, the linked headers in ${builddir}/lib/bluetooth were
> broken.  This patch fixes it by relying on make's abspath macro as
> opposed to the path concatenation.
> ---
>  Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index eaed632e8..ad638cbb2 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -499,7 +499,7 @@ $(lib_libbluetooth_la_OBJECTS): $(local_headers)
>
>  lib/bluetooth/%.h: lib/%.h
>         $(AM_V_at)$(MKDIR_P) lib/bluetooth
> -       $(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
> +       $(AM_V_GEN)$(LN_S) -f $(abspath $<) $@
>
>  if COVERAGE
>  clean-coverage:
> --
> 2.14.1.342.g6490525c54-goog
>
