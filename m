Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Aug 2010 09:55:18 -0400
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix multiple phone numbers problem in vcard-listing
Message-ID: <20100809135518.GA10150@jh-x301>
References: <1281352623-30856-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281352623-30856-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Mon, Aug 09, 2010, Radoslaw Jablonski wrote:
> This fixes displaying problem in vcard-listing when contact had multiple
> home or work phone set(one contact was displayed more than one time in
> vcard-listing. Now query is changed and additional entries are omitted.
> ---
>  plugins/phonebook-tracker.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
> index 41d7fde..f2b9649 100644
> --- a/plugins/phonebook-tracker.c
> +++ b/plugins/phonebook-tracker.c
> @@ -76,7 +76,7 @@
>  		"?c nco:hasAffiliation ?a . "				\
>  		"?a nco:hasPhoneNumber ?h . "				\
>  	"} "								\
> -	"}"
> +	"} GROUP BY ?c"
>  
>  #define MISSED_CALLS_QUERY						\
>  	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\

This patch is now upstream. Thanks.

Johan
