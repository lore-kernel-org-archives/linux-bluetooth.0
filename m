Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309210781-2674-5-git-send-email-dmitriy.paliy@nokia.com>
References: <1309210781-2674-1-git-send-email-dmitriy.paliy@nokia.com>
	<1309210781-2674-5-git-send-email-dmitriy.paliy@nokia.com>
Date: Tue, 28 Jun 2011 10:42:36 +0300
Message-ID: <BANLkTink+LcWd1NtP2TjPahXpi7CYnM9=g@mail.gmail.com>
Subject: Re: [PATCH 4/6] Add adapter ReleaseSession to obex-client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitriy Paliy <dmitriy.paliy@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Jun 28, 2011 at 12:39 AM, Dmitriy Paliy <dmitriy.paliy@gmail.com> wrote:
> Release of adapter session is added to obex-client upon closing OBEX
> transfer.
> ---
>  client/session.c |   38 +++++++++++++++++++++++++++++++++++++-
>  1 files changed, 37 insertions(+), 1 deletions(-)
>
> diff --git a/client/session.c b/client/session.c
> index 75cd32e..423eb8c 100644
> --- a/client/session.c
> +++ b/client/session.c
> @@ -302,9 +302,34 @@ static struct pending_req *send_method_call(DBusConnection *connection,
>        return req;
>  }
>
> +static void adapter_release_reply(DBusPendingCall *call, void *user_data)
> +{
> +       DBusError err;
> +       DBusMessage *reply;
> +       struct session_data *session = user_data;
> +       struct pending_req *req = find_session_request(session, call);
> +
> +       reply = dbus_pending_call_steal_reply(call);
> +
> +       dbus_error_init(&err);
> +       if (dbus_set_error_from_message(&err, reply)) {
> +               error("manager replied with an error: %s, %s",
> +                               err.name, err.message);
> +               dbus_error_free(&err);
> +       }
> +
> +       dbus_message_unref(reply);
> +
> +       session->pending_calls = g_slist_remove(session->pending_calls, req);
> +       pending_req_finalize(req);
> +
> +       session_free(session);
> +}
> +
>  void session_unref(struct session_data *session)
>  {
>        gboolean ret;
> +       struct pending_req *req;
>
>        ret = g_atomic_int_dec_and_test(&session->refcount);
>
> @@ -313,7 +338,18 @@ void session_unref(struct session_data *session)
>        if (ret == FALSE)
>                return;
>
> -       session_free(session);
> +       req = send_method_call(session->conn_system,
> +                               BT_BUS_NAME, session->adapter,
> +                               BT_ADAPTER_IFACE, "ReleaseSession",
> +                               adapter_release_reply, session,
> +                               DBUS_TYPE_INVALID);
> +       if (!req) {
> +               g_free(session->adapter);
> +               session_free(session);
> +               return;
> +       }
> +
> +       session->pending_calls = g_slist_prepend(session->pending_calls, req);
>  }
>
>  static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
> --
> 1.7.4.1
>
>

I don't think this is really necessary since you basically gonna
disconnect from system bus on session_free, so calling ReleaseSession
and wait for the reply will only add complexity and it also leaves the
session with 0 refcount which I don't think is a good idea. In the
other hand we may want to stay connected to the system bus so that we
don't have to reconnect every time when creating a new session, in
that case you would need to call ReleaseSession but I wouldn't bother
waiting for the reply since ReleaseSession only fails in case the
process doesn't own any session which is still fine since it doesn't
leave anything behind.

-- 
Luiz Augusto von Dentz
