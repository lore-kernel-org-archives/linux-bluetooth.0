Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/6] android/avctp: Fix crashes caused by re-entrant calls
Date: Thu, 26 Mar 2015 15:39:05 +0100
Message-ID: <1494330.WEzLnnu2PD@leonov>
In-Reply-To: <1427379625-20412-2-git-send-email-luiz.dentz@gmail.com>
References: <1427379625-20412-1-git-send-email-luiz.dentz@gmail.com> <1427379625-20412-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thursday 26 of March 2015 16:20:21 Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This make sure that while processing a PDU the session callbacks are
> not able to destroy the session causing crashes.
> ---
>  android/avctp.c | 74
> ++++++++++++++++++++++++++++++++++++++------------------- 1 file changed,
> 50 insertions(+), 24 deletions(-)
> 
> diff --git a/android/avctp.c b/android/avctp.c
> index 758dbd4..0d92a81 100644
> --- a/android/avctp.c
> +++ b/android/avctp.c
> @@ -162,6 +162,7 @@ struct key_pressed {
>  };
> 
>  struct avctp {
> +	unsigned int ref;
>  	int uinput;
> 
>  	unsigned int passthrough_id;
> @@ -708,6 +709,47 @@ static gboolean process_queue(void *user_data)
> 
>  }
> 
> +static struct avctp *avctp_ref(struct avctp *session)
> +{
> +	__sync_fetch_and_add(&session->ref, 1);
> +
> +	DBG("%p: ref=%d", session, session->ref);
> +
> +	return session;
> +}
> +
> +static void avctp_unref(struct avctp *session)
> +{
> +	if (__sync_sub_and_fetch(&session->ref, 1))
> +		return;
> +
> +	DBG("%p: ref=%d", session, session->ref);

I'd print this debug before subtracting so that one can track unrefs.

> +
> +	if (session->browsing)
> +		avctp_channel_destroy(session->browsing);
> +
> +	if (session->control)
> +		avctp_channel_destroy(session->control);
> +
> +	if (session->destroy)
> +		session->destroy(session->data);
> +
> +	g_free(session->handler);
> +
> +	if (session->key.timer > 0)
> +		g_source_remove(session->key.timer);
> +
> +	if (session->uinput >= 0) {
> +		DBG("AVCTP: closing uinput");
> +
> +		ioctl(session->uinput, UI_DEV_DESTROY);
> +		close(session->uinput);
> +		session->uinput = -1;
> +	}
> +
> +	g_free(session);
> +}
> +
>  static void control_response(struct avctp_channel *control,
>  					struct avctp_header *avctp,
>  					struct avc_header *avc,
> @@ -740,6 +782,8 @@ static void control_response(struct avctp_channel
> *control, if (p->transaction != avctp->transaction)
>  			continue;
> 
> +		avctp_ref(control->session);
> +
>  		if (req->func && req->func(control->session, avc->code,
>  						avc->subunit_type,
>  						operands, operand_count,
> @@ -749,6 +793,8 @@ static void control_response(struct avctp_channel
> *control, control->processed = g_slist_remove(control->processed, p);
>  		pending_destroy(p, NULL);
> 
> +		avctp_unref(control->session);
> +
>  		return;
>  	}
>  }
> @@ -784,6 +830,8 @@ static void browsing_response(struct avctp_channel
> *browsing, if (p->transaction != avctp->transaction)
>  			continue;
> 
> +		avctp_ref(browsing->session);
> +
>  		if (req->func && req->func(browsing->session, operands,
>  						operand_count, req->user_data))
>  			return;
> @@ -1563,7 +1611,7 @@ struct avctp *avctp_new(int fd, size_t imtu, size_t
> omtu, uint16_t version) control->watch =
> g_io_add_watch(session->control->io, cond,
>  						(GIOFunc) session_cb, session);
> 
> -	return session;
> +	return avctp_ref(session);
>  }
> 
>  int avctp_connect_browsing(struct avctp *session, int fd, size_t imtu,
> @@ -1599,27 +1647,5 @@ void avctp_shutdown(struct avctp *session)
>  	if (!session)
>  		return;
> 
> -	if (session->browsing)
> -		avctp_channel_destroy(session->browsing);
> -
> -	if (session->control)
> -		avctp_channel_destroy(session->control);
> -
> -	if (session->destroy)
> -		session->destroy(session->data);
> -
> -	g_free(session->handler);
> -
> -	if (session->key.timer > 0)
> -		g_source_remove(session->key.timer);
> -
> -	if (session->uinput >= 0) {
> -		DBG("AVCTP: closing uinput");
> -
> -		ioctl(session->uinput, UI_DEV_DESTROY);
> -		close(session->uinput);
> -		session->uinput = -1;
> -	}
> -
> -	g_free(session);
> +	avctp_unref(session);
>  }

-- 
BR
Szymon Janc
