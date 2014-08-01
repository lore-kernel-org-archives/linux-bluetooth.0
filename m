Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Aug 2014 13:38:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 11/12] obexd: Fix memory leak
Message-ID: <20140801103830.GC24358@t440s.P-661HNU-F1>
References: <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406643661-29323-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406643661-29323-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Jul 29, 2014, Andrei Emeltchenko wrote:
> Fixes memory leak for message_listing_cb()
> ---
>  obexd/client/map.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 331aebc..5d7f0dc 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -1182,8 +1182,10 @@ static void message_listing_cb(struct obc_session *session,
>  	}
>  
>  	reply = dbus_message_new_method_return(request->msg);
> -	if (reply == NULL)
> +	if (reply == NULL) {
> +		g_free(contents);
>  		return;
> +	}
>  

Here also there seems to be a missing call to pending_request_free().
Might be simplest if you simply replace the return with goto done and
then put the g_dbus_send_message call behind a NULL check (same applies
to the previous patch).

Johan
