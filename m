Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334127438-27617-7-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334127438-27617-7-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 17 Apr 2012 15:33:07 +0300
Message-ID: <CABBYNZKRrjhwaFpEdONN-GAKehpZCJTqmHX+cO9tV2GfjWZrRQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 6/7] media: Enable parallel requests to endpoint
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Apr 11, 2012 at 9:57 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> If endpoint is handling several devices, it should be able to handle
> multiple requests, one per each.
> ---
>  audio/media.c |   46 ++++++++++++++++++++++++----------------------
>  1 files changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/audio/media.c b/audio/media.c
> index 3324103..4384758 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -67,6 +67,7 @@ struct media_adapter {
>  };
>
>  struct endpoint_request {
> +       struct media_endpoint   *endpoint;
>        DBusMessage             *msg;
>        DBusPendingCall         *call;
>        media_endpoint_cb_t     cb;
> @@ -85,7 +86,7 @@ struct media_endpoint {
>        guint                   hs_watch;
>        guint                   ag_watch;
>        guint                   watch;
> -       struct endpoint_request *request;
> +       GSList                  *requests;
>        struct media_adapter    *adapter;
>        GSList                  *transports;
>  };
> @@ -127,15 +128,22 @@ static void endpoint_request_free(struct endpoint_request *request)
>        g_free(request);
>  }
>
> -static void media_endpoint_cancel(struct media_endpoint *endpoint)
> +static void media_endpoint_cancel(struct endpoint_request *request)
>  {
> -       struct endpoint_request *request = endpoint->request;
> +       struct media_endpoint *endpoint = request->endpoint;
>
>        if (request->call)
>                dbus_pending_call_cancel(request->call);
>
> +       endpoint->requests = g_slist_remove(endpoint->requests, request);
> +
>        endpoint_request_free(request);
> -       endpoint->request = NULL;
> +}
> +
> +static void media_endpoint_cancel_all(struct media_endpoint *endpoint)
> +{
> +       while (endpoint->requests != NULL)
> +               media_endpoint_cancel(endpoint->requests->data);
>  }
>
>  static void media_endpoint_destroy(struct media_endpoint *endpoint)
> @@ -150,8 +158,7 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
>        if (endpoint->ag_watch)
>                gateway_remove_state_cb(endpoint->ag_watch);
>
> -       if (endpoint->request)
> -               media_endpoint_cancel(endpoint);
> +       media_endpoint_cancel_all(endpoint);
>
>        g_slist_free_full(endpoint->transports,
>                                (GDestroyNotify) media_transport_destroy);
> @@ -228,8 +235,7 @@ done:
>
>  static void clear_endpoint(struct media_endpoint *endpoint)
>  {
> -       if (endpoint->request)
> -               media_endpoint_cancel(endpoint);
> +       media_endpoint_cancel_all(endpoint);
>
>        while (endpoint->transports != NULL)
>                clear_configuration(endpoint, endpoint->transports->data);
> @@ -237,8 +243,8 @@ static void clear_endpoint(struct media_endpoint *endpoint)
>
>  static void endpoint_reply(DBusPendingCall *call, void *user_data)
>  {
> -       struct media_endpoint *endpoint = user_data;
> -       struct endpoint_request *request = endpoint->request;
> +       struct endpoint_request *request = user_data;
> +       struct media_endpoint *endpoint = request->endpoint;
>        DBusMessage *reply;
>        DBusError err;
>        gboolean value;
> @@ -299,9 +305,8 @@ done:
>        if (request->cb)
>                request->cb(endpoint, ret, size, request->user_data);
>
> -       if (endpoint->request)
> -               endpoint_request_free(endpoint->request);
> -       endpoint->request = NULL;
> +       endpoint->requests = g_slist_remove(endpoint->requests, request);
> +       endpoint_request_free(request);
>  }
>
>  static gboolean media_endpoint_async_call(DBusConnection *conn,
> @@ -313,9 +318,6 @@ static gboolean media_endpoint_async_call(DBusConnection *conn,
>  {
>        struct endpoint_request *request;
>
> -       if (endpoint->request)
> -               return FALSE;
> -
>        request = g_new0(struct endpoint_request, 1);
>
>        /* Timeout should be less than avdtp request timeout (4 seconds) */
> @@ -326,13 +328,16 @@ static gboolean media_endpoint_async_call(DBusConnection *conn,
>                return FALSE;
>        }
>
> -       dbus_pending_call_set_notify(request->call, endpoint_reply, endpoint, NULL);
> +       dbus_pending_call_set_notify(request->call, endpoint_reply, request,
> +                                                                       NULL);
>
> +       request->endpoint = endpoint;
>        request->msg = msg;
>        request->cb = cb;
>        request->destroy = destroy;
>        request->user_data = user_data;
> -       endpoint->request = request;
> +
> +       endpoint->requests = g_slist_append(endpoint->requests, request);
>
>        DBG("Calling %s: name = %s path = %s", dbus_message_get_member(msg),
>                        dbus_message_get_destination(msg),
> @@ -351,9 +356,6 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
>        DBusConnection *conn;
>        DBusMessage *msg;
>
> -       if (endpoint->request != NULL)
> -               return FALSE;
> -
>        conn = endpoint->adapter->conn;
>
>        msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
> @@ -412,7 +414,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
>
>        transport = find_device_transport(endpoint, device);
>
> -       if (transport != NULL || endpoint->request != NULL)
> +       if (transport != NULL)
>                return FALSE;
>
>        conn = endpoint->adapter->conn;
> --
> 1.7.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Ack

-- 
Luiz Augusto von Dentz
