Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1485277866-7071-2-git-send-email-brian.git@intel.com>
References: <1485277866-7071-1-git-send-email-brian.git@intel.com> <1485277866-7071-2-git-send-email-brian.git@intel.com>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Tue, 24 Jan 2017 19:02:38 +0100
Message-ID: <CAAEJBhLugxgdisfbL25MceV16e=MJ9qtYSkJuE0gPxykqbfGPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Require GLIB v2.46
To: Brian Gix <brian.git@intel.com>
Cc: linux-bluetooth@vger.kernel.org, Brian Gix <brian.gix@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 24 January 2017 at 18:11, Brian Gix <brian.git@intel.com> wrote:
> From: Brian Gix <brian.gix@intel.com>
>
> ---
>  configure.ac | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 91b4955..6d8bf9c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -61,8 +61,8 @@ AC_CHECK_LIB(dl, dlopen, dummy=yes,
>
>  AC_CHECK_HEADERS(linux/types.h linux/if_alg.h)
>
> -PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28, dummy=yes,
> -                               AC_MSG_ERROR(GLib >= 2.28 is required))
> +PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.46, dummy=yes,
> +                               AC_MSG_ERROR(GLib >= 2.46 is required))
>  AC_SUBST(GLIB_CFLAGS)
>  AC_SUBST(GLIB_LIBS)

Why is this needed?

-- 
pozdrawiam
Szymon K. Janc
