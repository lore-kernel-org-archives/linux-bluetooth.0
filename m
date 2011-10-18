Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Oct 2011 13:58:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix missing initialization of eir name_len
Message-ID: <20111018105829.GA3732@fusion.localdomain>
References: <1318934522-31475-1-git-send-email-chanyeol.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318934522-31475-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

On Tue, Oct 18, 2011, chanyeol.park@samsung.com wrote:
> From: Chan-yeol Park <chanyeol.park@samsung.com>
> 
> ---
>  src/eir.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/eir.c b/src/eir.c
> index e82d30b..b76bfa2 100644
> --- a/src/eir.c
> +++ b/src/eir.c
> @@ -70,7 +70,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data)
>  	uuid_t service;
>  	char *uuid_str;
>  	const char *name = NULL;
> -	size_t name_len;
> +	size_t name_len = 0;
>  	unsigned int i;
>  
>  	eir->flags = -1;

This was already discussed on the list:
http://www.spinics.net/lists/linux-bluetooth/msg17222.html

It's essentially a gcc bug which doesn't show up with newer gcc
versions. Instead of adding this unnecessary initialization, Marcels
proposal was to rewrite the eir_parse function since its logic is quite
hard to follow right now.

Johan
