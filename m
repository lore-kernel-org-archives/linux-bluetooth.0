Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Dec 2010 17:38:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] More CodingStyle in lib and tools
Message-ID: <20101220153817.GB14575@jh-x301>
References: <1292840029-27770-1-git-send-email-michal.labedzki@tieto.com>
 <1292840029-27770-4-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292840029-27770-4-git-send-email-michal.labedzki@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Mon, Dec 20, 2010, Michal Labedzki wrote:
> --- a/lib/hci.c
> +++ b/lib/hci.c
> @@ -56,8 +56,8 @@ typedef struct {
>  
>  static int is_number(const char *c)
>  {
> -	while(*c) {
> -		if (! isdigit(*c))
> +	while (*c) {
> +		if (!isdigit(*c))
>  			return 0;
>  		++c;

Could you please merge this part to your first patch that introduced the
issue. Besides that the cleanups seem fine to me (after a very quick
look).

Johan
