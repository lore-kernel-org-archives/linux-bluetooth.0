Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 1/3] build: Disable some warnings from GCC 8
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180509121113.4110-1-szymon.janc@codecoup.pl>
Date: Wed, 9 May 2018 14:26:36 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EDA6E2ED-674B-45FE-900B-6DA05D1D1EC2@holtmann.org>
References: <20180509121113.4110-1-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> GCC 8 -Wall -Wextra seem to enable additional checks. Those generates
> lots of spourious warnings so disable them (at least for time being).
> ---
> acinclude.m4 | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/acinclude.m4 b/acinclude.m4
> index bc39c6d73..39a6be44a 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -16,6 +16,9 @@ AC_DEFUN([COMPILER_FLAGS], [
> 		with_cflags="$with_cflags -Wall -Werror -Wextra"
> 		with_cflags="$with_cflags -Wno-unused-parameter"
> 		with_cflags="$with_cflags -Wno-missing-field-initializers"
> +		with_cflags="$with_cflags -Wno-format-truncation"
> +		with_cflags="$with_cflags -Wno-cast-function-type"
> +		with_cflags="$with_cflags -Wno-stringop-truncation”

can you explain these with examples on why we would disable them.

Regards

Marcel

