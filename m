Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Apr 2010 18:41:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix bootstrap-configure command line parsing
Message-ID: <20100428154146.GA7515@jh-x301>
References: <1269972441-24242-1-git-send-email-jprvita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1269972441-24242-1-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 30, 2010, João Paulo Rechi Vita wrote:
> ---
>  bootstrap-configure |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/bootstrap-configure b/bootstrap-configure
> index 44e7ee8..5b7b88f 100755
> --- a/bootstrap-configure
> +++ b/bootstrap-configure
> @@ -8,4 +8,4 @@ fi
>      ./configure --enable-maintainer-mode \
>  		--enable-debug \
>  		--prefix=/usr \
> -		--mandir=/usr/share/man
> +		--mandir=/usr/share/man $*

This patch has now been pushed upstream. Thanks.

Johan
