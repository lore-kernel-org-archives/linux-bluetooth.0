Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Oct 2012 15:16:34 +0200
From: Ludek Finstrle <luf@pzkagis.cz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] AVDTP: Do not keep a internal reference
Message-ID: <20121023131633.GA12443@pzkagis.cz>
References: <1350640763-24186-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350640763-24186-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

  finally I find some time and find the reason (change).
I also see one strange thing in the patch.

Fri, Oct 19, 2012 at 12:59:23PM +0300, Luiz Augusto von Dentz napsal(a):
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Don't initialize reference with 1, instead always start disconnect timer
> when reference drops to 0, so in case nobody reclaims the session it
> automatically disconnect after 1 second and frees the memory.
> ---
> v2: Fix with stream_setup flag being ignored in disconnect_timeout
> 
>  audio/avdtp.c | 217 +++++++++++++++++++++++++---------------------------------
>  1 file changed, 94 insertions(+), 123 deletions(-)
> 
> diff --git a/audio/avdtp.c b/audio/avdtp.c
> index bd91cb6..bca4809 100644
> --- a/audio/avdtp.c
> +++ b/audio/avdtp.c
> @@ -387,8 +387,7 @@ struct avdtp_stream {
>  /* Structure describing an AVDTP connection between two devices */
>  
>  struct avdtp {
> -	int ref;
> -	int free_lock;
> +	unsigned int ref;
>  
>  	uint16_t version;
>  
> @@ -657,50 +656,6 @@ static gboolean stream_open_timeout(gpointer user_data)
>  	return FALSE;
>  }
>  
> -static gboolean disconnect_timeout(gpointer user_data)
> -{
> -	struct avdtp *session = user_data;
> -	struct audio_device *dev;
> -	gboolean stream_setup;
> -
> -	session->dc_timer = 0;
> -	stream_setup = session->stream_setup;
> -	session->stream_setup = FALSE;
> -
> -	dev = manager_get_device(&session->server->src, &session->dst, FALSE);
> -
> -	if (dev && dev->sink && stream_setup)
> -		sink_setup_stream(dev->sink, session);
> -	else if (dev && dev->source && stream_setup)
> -		source_setup_stream(dev->source, session);
> -	else
> -		connection_lost(session, ETIMEDOUT);
> -
> -	return FALSE;
> -}
> -
> -static void remove_disconnect_timer(struct avdtp *session)
> -{
> -	g_source_remove(session->dc_timer);
> -	session->dc_timer = 0;
> -	session->stream_setup = FALSE;
> -}
> -
> -static void set_disconnect_timer(struct avdtp *session)
> -{
> -	if (session->dc_timer)
> -		remove_disconnect_timer(session);
> -
> -	if (session->device_disconnect) {
> -		session->dc_timer = g_idle_add(disconnect_timeout, session);
> -		return;
> -	}
> -
> -	session->dc_timer = g_timeout_add_seconds(DISCONNECT_TIMEOUT,
> -						disconnect_timeout,
> -						session);
> -}
> -
>  void avdtp_error_init(struct avdtp_error *err, uint8_t category, int id)
>  {
>  	err->category = category;
> @@ -780,8 +735,9 @@ static void avdtp_set_state(struct avdtp *session,
>  	}
>  }
>  
> -static void stream_free(struct avdtp_stream *stream)
> +static void stream_free(void *data)
>  {
> +	struct avdtp_stream *stream = data;
>  	struct avdtp_remote_sep *rsep;
>  
>  	stream->lsep->info.inuse = 0;
> @@ -1144,37 +1100,42 @@ static int avdtp_cancel_authorization(struct avdtp *session)
>  		return err;
>  
>  	session->auth_id = 0;
> +	avdtp_unref(session);
>  
>  	return 0;
>  }
>  
> -static void connection_lost(struct avdtp *session, int err)
> +static void sep_free(gpointer data)
>  {
> -	char address[18];
> +	struct avdtp_remote_sep *sep = data;
>  
> -	ba2str(&session->dst, address);
> -	DBG("Disconnected from %s", address);
> +	g_slist_free_full(sep->caps, g_free);
> +	g_free(sep);
> +}
>  
> -	if (err != EACCES)
> -		avdtp_cancel_authorization(session);
> +static void remove_disconnect_timer(struct avdtp *session)
> +{
> +	g_source_remove(session->dc_timer);
> +	session->dc_timer = 0;
> +	session->stream_setup = FALSE;
> +}
>  
> -	session->free_lock = 1;
> +static void avdtp_free(void *data)
> +{
> +	struct avdtp *session = data;
>  
> -	finalize_discovery(session, err);
> +	DBG("%p", session);
>  
> -	g_slist_foreach(session->streams, (GFunc) release_stream, session);
> -	session->streams = NULL;
> +	g_slist_free_full(session->streams, stream_free);
>  
> -	session->free_lock = 0;
> +	if (session->state != AVDTP_SESSION_STATE_DISCONNECTED)
> +		avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
>  
>  	if (session->io) {
>  		g_io_channel_shutdown(session->io, FALSE, NULL);
>  		g_io_channel_unref(session->io);
> -		session->io = NULL;
>  	}
>  
> -	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
> -
>  	if (session->io_id) {
>  		g_source_remove(session->io_id);
>  		session->io_id = 0;
> @@ -1183,69 +1144,92 @@ static void connection_lost(struct avdtp *session, int err)
>  	if (session->dc_timer)
>  		remove_disconnect_timer(session);
>  
> -	if (session->ref != 1)
> -		error("connection_lost: ref count not 1 after all callbacks");
> -	else
> -		avdtp_unref(session);
> +	avdtp_cancel_authorization(session);

Why do you call avdtp_cancel_authorization here? It's useless as above you have
in the same function:
	if (session->state != AVDTP_SESSION_STATE_DISCONNECTED)
		avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);

and the first if statement inf avdtp_cancel_authorization is to check if the
state is AVDTP_SESSION_STATE_CONNECTING (otherwise return).

> +
> +	if (session->req)
> +		pending_req_free(session->req);
> +
> +	g_slist_free_full(session->seps, sep_free);
> +
> +	g_free(session->buf);
> +
> +	g_free(session);
>  }
>  
> -static void sep_free(gpointer data)
> +static gboolean disconnect_timeout(gpointer user_data)
>  {
> -	struct avdtp_remote_sep *sep = data;
> +	struct avdtp *session = user_data;
> +	struct audio_device *dev;
> +	gboolean stream_setup;
>  
> -	g_slist_free_full(sep->caps, g_free);
> -	g_free(sep);
> +	session->dc_timer = 0;
> +
> +	stream_setup = session->stream_setup;
> +	session->stream_setup = FALSE;
> +	dev = manager_get_device(&session->server->src, &session->dst, FALSE);
> +
> +	if (dev && dev->sink && stream_setup)
> +		sink_setup_stream(dev->sink, session);
> +	else if (dev && dev->source && stream_setup)
> +		source_setup_stream(dev->source, session);

See below. Why you deinitialize the session different way for ref=0?

> +	else if (session->ref > 0)
> +		connection_lost(session, ETIMEDOUT);
> +	else {
> +		struct avdtp_server *server = session->server;
> +
> +		server->sessions = g_slist_remove(server->sessions, session);
> +		avdtp_free(session);
> +	}

If I change whole block above (starting else if ((session->ref > 0)) this
way it works with N900 as expected:

	else {
		connection_lost(session, ETIMEDOUT);

		if (session->ref <= 0) {
			struct avdtp_server *server = session->server;

			server->sessions = g_slist_remove(server->sessions, session);
			avdtp_free(session);
		}
	}

> +
> +	return FALSE;
>  }
>  
> -void avdtp_unref(struct avdtp *session)
> +static void set_disconnect_timer(struct avdtp *session)
>  {
> -	struct avdtp_server *server;
> +	if (session->dc_timer)
> +		remove_disconnect_timer(session);
>  
> -	if (!session)
> +	if (session->device_disconnect) {
> +		session->dc_timer = g_idle_add(disconnect_timeout, session);
>  		return;
> +	}
>  
> -	session->ref--;
> -
> -	DBG("%p: ref=%d", session, session->ref);
> +	session->dc_timer = g_timeout_add_seconds(DISCONNECT_TIMEOUT,
> +						disconnect_timeout,
> +						session);
> +}
>  
> -	if (session->ref == 1) {
> -		if (session->state == AVDTP_SESSION_STATE_CONNECTING &&
> -								session->io) {
> -			avdtp_cancel_authorization(session);
> -			g_io_channel_shutdown(session->io, TRUE, NULL);
> -			g_io_channel_unref(session->io);
> -			session->io = NULL;
> -			avdtp_set_state(session,
> -					AVDTP_SESSION_STATE_DISCONNECTED);
> -		}
> +static void connection_lost(struct avdtp *session, int err)
> +{
> +	char address[18];
>  
> -		if (session->io)
> -			set_disconnect_timer(session);
> -		else if (!session->free_lock) /* Drop the local ref if we
> -						 aren't connected */
> -			session->ref--;
> -	}
> +	ba2str(&session->dst, address);
> +	DBG("Disconnected from %s", address);
>  
> -	if (session->ref > 0)
> -		return;
> +	if (err != EACCES)
> +		avdtp_cancel_authorization(session);
>  
> -	server = session->server;
> +	g_slist_foreach(session->streams, (GFunc) release_stream, session);
> +	session->streams = NULL;
>  
> -	DBG("%p: freeing session and removing from list", session);
> +	finalize_discovery(session, err);
>  
> -	if (session->dc_timer)
> -		remove_disconnect_timer(session);
> +	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
> +}
>  
> -	server->sessions = g_slist_remove(server->sessions, session);
> +void avdtp_unref(struct avdtp *session)
> +{
> +	if (!session)
> +		return;
>  
> -	if (session->req)
> -		pending_req_free(session->req);
> +	session->ref--;
>  
> -	g_slist_free_full(session->seps, sep_free);
> +	DBG("%p: ref=%d", session, session->ref);
>  
> -	g_free(session->buf);
> +	if (session->ref > 0)
> +		return;
>  
> -	g_free(session);
> +	set_disconnect_timer(session);
>  }
>  
>  struct avdtp *avdtp_ref(struct avdtp *session)
> @@ -2231,12 +2215,6 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
>  			goto failed;
>  		}
>  
> -		if (session->ref == 1 && !session->streams && !session->req)
> -			set_disconnect_timer(session);
> -
> -		if (session->streams && session->dc_timer)
> -			remove_disconnect_timer(session);
> -
>  		if (session->req && session->req->collided) {
>  			DBG("Collision detected");
>  			goto next;
> @@ -2383,7 +2361,7 @@ static struct avdtp *avdtp_get_internal(const bdaddr_t *src, const bdaddr_t *dst
>  
>  	session->server = server;
>  	bacpy(&session->dst, dst);
> -	session->ref = 1;
> +	set_disconnect_timer(session);
>  	/* We don't use avdtp_set_state() here since this isn't a state change
>  	 * but just setting of the initial state */
>  	session->state = AVDTP_SESSION_STATE_DISCONNECTED;
> @@ -2490,6 +2468,8 @@ static void auth_cb(DBusError *derr, void *user_data)
>  	struct avdtp *session = user_data;
>  	GError *err = NULL;
>  
> +	avdtp_unref(session);
> +
>  	if (derr && dbus_error_is_set(derr)) {
>  		error("Access denied: %s", derr->message);
>  		connection_lost(session, EACCES);
> @@ -2578,10 +2558,12 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
>  							auth_cb, session);
>  	if (session->auth_id == 0) {
>  		avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
> -		avdtp_unref(session);
>  		goto drop;
>  	}
>  
> +	/* Disable disconnect timer while authorizing */
> +	avdtp_ref(session);
> +
>  	dev->auto_connect = auto_connect;
>  
>  	return;
> @@ -3949,23 +3931,12 @@ proceed:
>  void avdtp_exit(const bdaddr_t *src)
>  {
>  	struct avdtp_server *server;
> -	GSList *l;
>  
>  	server = find_server(servers, src);
>  	if (!server)
>  		return;
>  
> -	l = server->sessions;
> -	while (l) {
> -		struct avdtp *session = l->data;
> -
> -		l = l->next;
> -		/* value of l pointer should be updated before invoking
> -		 * connection_lost since it internally uses avdtp_unref
> -		 * which operates on server->session list as well
> -		 */
> -		connection_lost(session, -ECONNABORTED);
> -	}
> +	g_slist_free_full(server->sessions, avdtp_free);
>  
>  	servers = g_slist_remove(servers, server);
>  
> -- 
> 1.7.11.4

My fix should be wrong as I don't fully understand why it fixed my problem
but I think it's not ok to deinitialize it different way based on some counter.

I know you don't support N900 with bluez 4.99 with a lot of fixes from upstream
and pulseaudio 0.9.15 hacked by Nokia but I think this should be general problem.

Best regards,

Luf
