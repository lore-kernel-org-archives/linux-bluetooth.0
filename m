Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 May 2011 02:30:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix endian conversion for appparams in pbap client
Message-ID: <20110514233057.GH28969@dell.ger.corp.intel.com>
References: <1304877615-10038-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304877615-10038-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, May 08, 2011, Bartosz Szatkowski wrote:
> ---
>  client/pbap.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/client/pbap.c b/client/pbap.c
> index 837419c..dee85c8 100644
> --- a/client/pbap.c
> +++ b/client/pbap.c
> @@ -312,6 +312,7 @@ static void read_return_apparam(struct session_data *session,
>  			if (hdr->len == PHONEBOOKSIZE_LEN) {
>  				guint16 val;
>  				memcpy(&val, hdr->val, sizeof(val));
> +                                val = get_be16(&val);
>  				*phone_book_size = val;
>  			}
>  			break;

Two issues with this:

1. Fix your editor settings. You're using spaces instead of tabs for
indentation.

2. Why not do *phone_book_size = get_be16(&val); directly?

Johan
