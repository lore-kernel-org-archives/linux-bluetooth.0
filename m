Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Sep 2010 10:53:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix problem with EIR data when setting the name
Message-ID: <20100928075349.GB16571@jh-x301>
References: <AANLkTi=6ORUZLTY28iHn4q6gAi1mMZjqb=Nt7B6zQN2R@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=6ORUZLTY28iHn4q6gAi1mMZjqb=Nt7B6zQN2R@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Sep 23, 2010, Lukasz Pawlik wrote:
> Subject: [PATCH] Fix problem with EIR data when setting the name
> 
> Previously changed BT fiendly name was not reflected until BT adapter reboot.
> This patch fix this problem. Now changed name is reflected without need of
> rebooting adapter.
> ---
>  src/adapter.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 9b638cf..0e9be5f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1031,6 +1031,7 @@ static DBusMessage *set_name(DBusConnection *conn, DBusMessage *msg,
>  			return failed_strerror(msg, err);
>  
>  		adapter->name_stored = TRUE;
> +		update_ext_inquiry_response(adapter);
>  	}
>  
>  done:

Thanks for the patch. It has now been pushed upstream.

Johan
