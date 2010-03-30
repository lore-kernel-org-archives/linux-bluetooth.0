Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1269972441-24242-1-git-send-email-jprvita@gmail.com>
References: <1269972441-24242-1-git-send-email-jprvita@gmail.com>
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Tue, 30 Mar 2010 18:08:34 +0000
Message-ID: <aa32413d1003301108ucb903ak4aba6f2767981a1b@mail.gmail.com>
Subject: Re: [PATCH] Fix bootstrap-configure command line parsing
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/3/30 João Paulo Rechi Vita <jprvita@gmail.com>:
> ---
>  bootstrap-configure |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/bootstrap-configure b/bootstrap-configure
> index 44e7ee8..5b7b88f 100755
> --- a/bootstrap-configure
> +++ b/bootstrap-configure
> @@ -8,4 +8,4 @@ fi
>     ./configure --enable-maintainer-mode \
>                --enable-debug \
>                --prefix=/usr \
> -               --mandir=/usr/share/man
> +               --mandir=/usr/share/man $*
> --
> 1.6.3.3
>
>

This patch is to bluez-hcidump.

-- 
João Paulo Rechi Vita
http://jprvita.wordpress.com/
