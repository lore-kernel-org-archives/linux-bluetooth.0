Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 May 2011 14:49:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix endian conversion for appparams in pbap client
Message-ID: <20110515114937.GA3024@dell.ger.corp.intel.com>
References: <1305455861-26395-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305455861-26395-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Sun, May 15, 2011, Bartosz Szatkowski wrote:
> ---
>  client/pbap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/client/pbap.c b/client/pbap.c
> index 837419c..589b1ca 100644
> --- a/client/pbap.c
> +++ b/client/pbap.c
> @@ -312,7 +312,7 @@ static void read_return_apparam(struct session_data *session,
>  			if (hdr->len == PHONEBOOKSIZE_LEN) {
>  				guint16 val;
>  				memcpy(&val, hdr->val, sizeof(val));
> -				*phone_book_size = val;
> +				*phone_book_size = get_be16(&val);
>  			}
>  			break;
>  		case NEWMISSEDCALLS_TAG:

Pushed upstream. Thanks.

Johan
