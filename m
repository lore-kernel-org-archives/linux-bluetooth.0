Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Don't force dirs on bootstrap-configure
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
In-Reply-To: <1254363278-20735-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254363278-20735-1-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain
Date: Thu, 01 Oct 2009 04:58:19 +0200
Message-Id: <1254365899.2659.102.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Fixes a problem with ./bootstrap-configure --prefix=some/dir.
> bootstrap-configure was forcing dirs configuration like mandir and
> sysconfdir unless user pass all its desired dirs on
> ./bootstrap-configure.
> ---
>  bootstrap-configure |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/bootstrap-configure b/bootstrap-configure
> index 5414518..1a48fa9 100755
> --- a/bootstrap-configure
> +++ b/bootstrap-configure
> @@ -11,11 +11,6 @@ fi
>  ./bootstrap && \
>      ./configure --enable-maintainer-mode \
>  		--enable-debug \
> -		--prefix=/usr \
> -		--mandir=/usr/share/man \
> -		--sysconfdir=/etc \
> -		--localstatedir=/var \
> -		--libexecdir=/lib \
>  		--enable-netlink \
>  		--enable-tools \
>  		--enable-bccmd \

we do this on purpose this way. So NAK.

Regards

Marcel


