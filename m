Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Apr 2009 08:52:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Fix null dereference in src/main.c
Message-ID: <20090401055244.GA17550@jh-x301>
References: <1238553045-23938-1-git-send-email-gustavo@las.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238553045-23938-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Mar 31, 2009, Gustavo F. Padovan wrote:
> str could be null when dst isn't null
> ---
>  src/main.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/main.c b/src/main.c
> index 2d24d07..3ad9048 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -266,7 +266,7 @@ static char *expand_name(char *dst, int size, char *str, int dev_id)
>  	register int sp, np, olen;
>  	char *opt, buf[10];
>  
> -	if (!str && !dst)
> +	if (!str || !dst)
>  		return NULL;
>  
>  	sp = np = 0;

The patch has been pushed upstream. Thanks.

Johan
