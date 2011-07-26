Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jul 2011 13:47:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix pulling phonebook size
Message-ID: <20110726104752.GD5470@dell>
References: <1311368287-5284-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311368287-5284-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Fri, Jul 22, 2011, Bartosz Szatkowski wrote:
> ---
>  plugins/phonebook-ebook.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
> index 9cb32c3..91d0c0b 100644
> --- a/plugins/phonebook-ebook.c
> +++ b/plugins/phonebook-ebook.c
> @@ -180,7 +180,7 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
>  	 */
>  	maxcount = data->params->maxlistcount;
>  	if (maxcount == 0) {
> -		count += g_list_length(contacts);
> +		data->count += g_list_length(contacts);
>  		goto done;
>  	}

Since you're doing this I suppose it also makes sense to move the
initialization of the count variable (to 0) to the initialization part
of the for loop in the same function.

Johan
