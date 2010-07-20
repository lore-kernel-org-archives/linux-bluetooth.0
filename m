Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimicKT1FS2G3MDtVha5AWLp_wV2rtW35MfHFro6@mail.gmail.com>
References: <AANLkTikcX6_SydJf4YRG3ym4Q0GVGQ26WpAh3Mm1uyyQ@mail.gmail.com>
	<AANLkTilJNclAEoLpJnUDkHHiwpynoSpIXErJnYpHF6aF@mail.gmail.com>
	<AANLkTiltkfeX0iT2qwmIIlg8t4xO5iqoS2qtvbMZkZCA@mail.gmail.com>
	<AANLkTimicKT1FS2G3MDtVha5AWLp_wV2rtW35MfHFro6@mail.gmail.com>
Date: Tue, 20 Jul 2010 17:16:52 +0400
Message-ID: <AANLkTikk6EAI4TTvm2YJCkDnEiwRDp-4km1TKQ8yomvx@mail.gmail.com>
Subject: Re: obex-client: doesn't allways closes socket
From: Vitja Makarov <vitja.makarov@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/7/20 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi,
>
> On Tue, Jul 20, 2010 at 2:46 PM, Vitja Makarov <vitja.makarov@gmail.com> wrote:
>> 2010/7/20 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>>> Hi,
>>>
>>> On Tue, Jul 20, 2010 at 10:12 AM, Vitja Makarov <vitja.makarov@gmail.com> wrote:
>>>> Hi!
>>>>
>>>> Recently I've found that obex client doesn't allways close socket, I
>>>> was using obexd-0.29...
>>>> Even more sometimes it closes same socket twice using
>>>> g_io_channel_unref() and close()
>>>
>>> I guess the real ones are gw_obex_close and close, so both end up
>>> closing the same fd.
>>>
>>>> When it comes to client/session.c:rfcomm_connect() with error,
>>>> session->sock is not set and socket is not closed on
>>>> session_shutdown()
>>>> Don't know why g_io_channel_unref() isn't called for that socket..
>>>
>>> Yep, there is no much point on storing the fd on session->sock in the
>>> other hand the io that bt_io_connect gives is the one causing the
>>> problem here, either we release this reference and then we have to set
>>> not to close the fd or we just keep the io reference and store it on
>>> session so we can actually cancel the connection attempt.
>>>
>>
>> My application does send files using obex-client to all available
>> devices, after 4-5 hours obex client can't create sockets anymore  (it
>> fails with ENFILE, Too many open files), making obex-client absolutely
>> unusable.
>>
>> As workaround I set session->fd even if error was detected, then
>> socket will be properly closed.
>> It seems to me that here is memory leak also.
>>
>> vitja.
>>
>
> Can you check if the patch bellow fix those issues:
>
> diff --git a/client/session.c b/client/session.c
> index 334ade4..d761bfb 100644
> --- a/client/session.c
> +++ b/client/session.c
> @@ -173,8 +173,10 @@ static void session_free(struct session_data *session)
>        if (session->obex != NULL)
>                gw_obex_close(session->obex);
>
> -       if (session->sock > 2)
> -               close(session->sock);
> +       if (session->io != NULL) {
> +               g_io_channel_shutdown(session->io, TRUE, NULL);
> +               g_io_channel_unref(session->io);
> +       }
>
>        if (session->path)
>                session_unregistered(session);
> @@ -215,13 +217,17 @@ static void rfcomm_callback(GIOChannel *io,
> GError *err, gpointer user_data)
>                goto done;
>        }
>
> +       /* do not close when gw_obex is using the fd */
> +       g_io_channel_set_close_on_unref(session->io, FALSE);
> +       g_io_channel_unref(session->io);
> +       session->io = NULL;
> +
>        fd = g_io_channel_unix_get_fd(io);
>
>        obex = gw_obex_setup_fd(fd, session->target,
>                        session->target_len, NULL, NULL);
>
> -       callback->session->sock = fd;
> -       callback->session->obex = obex;
> +       session->obex = obex;
>
>  done:
>        callback->func(callback->session, callback->data);
> @@ -231,9 +237,9 @@ done:
>        g_free(callback);
>  }
>
> -static int rfcomm_connect(const bdaddr_t *src,
> -                               const bdaddr_t *dst, uint8_t channel,
> -                                       BtIOConnect function, gpointer user_data)
> +static GIOChannel *rfcomm_connect(const bdaddr_t *src, const bdaddr_t *dst,
> +                                       uint8_t channel, BtIOConnect function,
> +                                       gpointer user_data)
>  {
>        GIOChannel *io;
>        GError *err = NULL;
> @@ -245,11 +251,11 @@ static int rfcomm_connect(const bdaddr_t *src,
>                                BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
>                                BT_IO_OPT_INVALID);
>        if (io != NULL)
> -               return 0;
> +               return io;
>
>        error("%s", err->message);
>        g_error_free(err);
> -       return -EIO;
> +       return NULL;
>  }
>
>  static void search_callback(uint8_t type, uint16_t status,
> @@ -309,8 +315,11 @@ static void search_callback(uint8_t type, uint16_t status,
>
>        callback->session->channel = channel;
>
> -       if (rfcomm_connect(&callback->session->src, &callback->session->dst,
> -                                       channel, rfcomm_callback, callback) == 0) {
> +       callback->session->io = rfcomm_connect(&callback->session->src,
> +                                               &callback->session->dst,
> +                                               channel, rfcomm_callback,
> +                                               callback);
> +       if (callback->session->io != NULL) {
>                sdp_close(callback->sdp);
>                return;
>        }
> @@ -418,7 +427,6 @@ struct session_data *session_create(const char *source,
>                return NULL;
>
>        session->refcount = 1;
> -       session->sock = -1;
>        session->channel = channel;
>
>        session->conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
> @@ -465,8 +473,11 @@ struct session_data *session_create(const char *source,
>        callback->data = user_data;
>
>        if (session->channel > 0) {
> -               err = rfcomm_connect(&session->src, &session->dst,
> -                               session->channel, rfcomm_callback, callback);
> +               session->io = rfcomm_connect(&session->src, &session->dst,
> +                                                       session->channel,
> +                                                       rfcomm_callback,
> +                                                       callback);
> +               err = (session->io == NULL) ? -EINVAL : 0;
>        } else {
>                callback->sdp = service_connect(&session->src, &session->dst,
>                                                service_callback, callback);
> diff --git a/client/session.h b/client/session.h
> index 73337cd..9451c25 100644
> --- a/client/session.h
> +++ b/client/session.h
> @@ -40,10 +40,10 @@ struct session_data {
>        int target_len;
>        uuid_t uuid;            /* Bluetooth Service Class */
>        gchar *path;            /* Session path */
> -       int sock;
>        DBusConnection *conn;
>        DBusMessage *msg;
>        GwObex *obex;
> +       GIOChannel *io;
>        struct agent_data *agent;
>        struct session_callback *callback;
>        gchar *owner;           /* Session owner */
>
>
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>

This seems to work, thanks
