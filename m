Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] obexd: Remove unused parameter from manager_request_authorization
Date: Wed, 08 Apr 2015 12:39:21 +0200
Message-ID: <1778487.jXsPSmtx9k@leonov>
In-Reply-To: <1426160579-9281-1-git-send-email-szymon.janc@tieto.com>
References: <1426160579-9281-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 12 of March 2015 12:42:59 Szymon Janc wrote:
> This fix compilation error with musl due to missing (now not needed)
> stdint.h include.
> ---
>  obexd/plugins/opp.c | 4 +---
>  obexd/src/manager.c | 2 +-
>  obexd/src/manager.h | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/obexd/plugins/opp.c b/obexd/plugins/opp.c
> index 5228ba8..445688d 100644
> --- a/obexd/plugins/opp.c
> +++ b/obexd/plugins/opp.c
> @@ -62,7 +62,6 @@ static void opp_progress(struct obex_session *os, void
> *user_data) static int opp_chkput(struct obex_session *os, void *user_data)
>  {
>  	char *folder, *name, *path;
> -	int32_t time;
>  	const char *t;
>  	int err;
> 
> @@ -79,8 +78,7 @@ static int opp_chkput(struct obex_session *os, void
> *user_data) goto skip_auth;
>  	}
> 
> -	time = 0;
> -	err = manager_request_authorization(user_data, time, &folder, &name);
> +	err = manager_request_authorization(user_data, &folder, &name);
>  	if (err < 0)
>  		return -EPERM;
> 
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index 371f127..f84384a 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -671,7 +671,7 @@ static gboolean auth_error(GIOChannel *io, GIOCondition
> cond, void *user_data) return FALSE;
>  }
> 
> -int manager_request_authorization(struct obex_transfer *transfer, int32_t
> time, +int manager_request_authorization(struct obex_transfer *transfer,
> char **new_folder, char **new_name)
>  {
>  	struct obex_session *os = transfer->session;
> diff --git a/obexd/src/manager.h b/obexd/src/manager.h
> index 669b223..d9781b2 100644
> --- a/obexd/src/manager.h
> +++ b/obexd/src/manager.h
> @@ -36,7 +36,7 @@ void manager_unregister_transfer(struct obex_transfer
> *transfer); void manager_emit_transfer_started(struct obex_transfer
> *transfer); void manager_emit_transfer_progress(struct obex_transfer
> *transfer); void manager_emit_transfer_completed(struct obex_transfer
> *transfer); -int manager_request_authorization(struct obex_transfer
> *transfer, int32_t time, +int manager_request_authorization(struct
> obex_transfer *transfer, char **new_folder, char **new_name);
> 
>  DBusConnection *manager_dbus_get_connection(void);

Applied.
-- 
BR
Szymon Janc
