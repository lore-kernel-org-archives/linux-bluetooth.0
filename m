Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jul 2011 14:25:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix writing out of bounds in add_slash func
Message-ID: <20110726112516.GB10285@dell>
References: <1311232939-32431-1-git-send-email-radoslawjablonski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311232939-32431-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Jul 21, 2011, Radoslaw Jablonski wrote:
> diff --git a/plugins/vcard.c b/plugins/vcard.c
> index b997fc4..a6eb5f5 100644
> --- a/plugins/vcard.c
> +++ b/plugins/vcard.c
> @@ -101,27 +101,41 @@ static void add_slash(char *dest, const char *src, int len_max, int len)
>  {
>  	int i, j;
>  
> -	for (i = 0, j = 0; i < len && j < len_max; i++, j++) {
> +	for (i = 0, j = 0; i < len && j < len_max - 1; i++, j++) {
> +		/* filling dest buffer - last field need to be reserved
> +		 * for '\0'*/
>  		switch (src[i]) {
>  		case '\n':
> +			if (j == len_max - 2)
> +				/* not enough space in the buffer to put char
> +				 * preceded with escaping sequence */
> +				goto done;

I think it'd be more robust and clear that you're testing for an upper
limit to have a > or >= comparison here and in the other places, e.g.
if (j + 2 >= len_max)

> +done:
>  	dest[j] = 0;
> -	return;
>  }

The return statement removal is a code cleanup which should be in its
own patch.

Johan
