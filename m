Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Oct 2013 14:28:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] android: Remove reduntant structure
Message-ID: <20131029122827.GA12345@x220.p-661hnu-f1>
References: <1383049016-23371-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383049016-23371-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Oct 29, 2013, Jakub Tyszkowski wrote:
> ---
>  android/adapter.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/android/adapter.c b/android/adapter.c
> index 15b65e5..7e5c1a1 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -234,12 +234,11 @@ static void load_link_keys(GSList *keys)
>  {
>  	struct mgmt_cp_load_link_keys *cp;
>  	size_t key_len = g_slist_length(keys);
> -	struct mgmt_link_key_info *key;
>  	size_t len;
>  
>  	DBG("");
>  
> -	len = sizeof(*cp) + key_len * sizeof(*key);
> +	len = sizeof(*cp) + key_len * sizeof(struct mgmt_link_key_info);
>  	cp = g_malloc0(len);
>  
>  	cp->debug_keys = 0;

If the point of the keys list is to contain struct mgmt_link_key_info
entries I'd rather fix this function to properly fill in the mgmt
command with those since right now it's broken if the list contains any
entries at all.

Johan
