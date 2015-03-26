Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427352803-9264-1-git-send-email-hychao@chromium.org>
References: <1427352803-9264-1-git-send-email-hychao@chromium.org>
Date: Thu, 26 Mar 2015 11:24:22 +0200
Message-ID: <CABBYNZLCHorFryAg6fj=+rYb0kbdDrEDzHtjsFB4T_dpwdWo+g@mail.gmail.com>
Subject: Re: [PATCH] src/profile: Set service to connecting in ext_connect
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hsin-Yu Chao <hychao@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Arman Uguray <armansito@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Mar 26, 2015 at 8:53 AM, Hsin-Yu Chao <hychao@chromium.org> wrote:
> For the profile connection initiated by remote device,
> ext_connect() function is triggered without advance the state
> of device's service to BTD_SERVICE_STATE_DISCONNECTING.
> This is causing a problems when the later 'NewConnection'
> dbus method call is made to registered application. If
> the remote device gets disconnected during the period of
> time waiting for the reply of 'NewConnection' method, the
> btd_service_disconnect() call will fail at the service state

This part is not very clean to me, where do we call
btd_service_disconnect? Maybe if you have calltrace or something would
be better.

> check and never handle the profile disconnection due to that
> state was incorrectly left as BTD_SERVICE_STATE_DISCONNECTED.
> Fix the problem by adding additional call in ext_connect()
> to assure the service state has changed. Also modify the logic
> of service state check in btd_service_connecting_complete()
> to prevent the problem when the 'NewConnect' reply changes
> service state to BTD_SERVICE_STATE_CONNECTED while the device
> has already disconnected before it arrives.

We should be able to cancel the pending call it gets disconnected in
the meantime.

> Change-Id: If02af58f65480c35c697739c5a545c59d1088fdb

Upstream has no idea about your Change-Id so please remove it.

> ---
>  src/profile.c |  5 ++++-
>  src/service.c | 11 +++++++++--
>  src/service.h |  1 +
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/src/profile.c b/src/profile.c
> index ca1dfec..31740b0 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -1036,8 +1036,11 @@ static void ext_connect(GIOChannel *io, GError *err, gpointer user_data)
>                                                                         conn);
>         }
>
> -       if (send_new_connection(ext, conn))
> +       if (send_new_connection(ext, conn)) {
> +               if (conn->service)
> +                       btd_service_connecting_start(conn->service);

What you doing here is basically forcing the state to change to
CONNECTING, IMO we should notify the driver so I thing we should call
service_accept here and change the state there if the driver accepts
it then proceed to send the new connection.

>                 return;
> +       }
>
>  drop:
>         if (conn->service)
> diff --git a/src/service.c b/src/service.c
> index 4d1f1cb..15a5b0d 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -334,10 +334,17 @@ bool btd_service_remove_state_cb(unsigned int id)
>         return false;
>  }
>
> +void btd_service_connecting_start(struct btd_service *service)
> +{
> +       if (service->state != BTD_SERVICE_STATE_DISCONNECTED)
> +               return;
> +
> +       change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
> +}

This should not be needed, just add change_state(service,
BTD_SERVICE_STATE_CONNECTING, 0); to service_accept.

>  void btd_service_connecting_complete(struct btd_service *service, int err)
>  {
> -       if (service->state != BTD_SERVICE_STATE_DISCONNECTED &&
> -                               service->state != BTD_SERVICE_STATE_CONNECTING)
> +       if (service->state != BTD_SERVICE_STATE_CONNECTING)
>                 return;
>
>         if (err == 0)
> diff --git a/src/service.h b/src/service.h
> index c1f97f6..0967249 100644
> --- a/src/service.h
> +++ b/src/service.h
> @@ -65,6 +65,7 @@ unsigned int btd_service_add_state_cb(btd_service_state_cb cb,
>  bool btd_service_remove_state_cb(unsigned int id);
>
>  /* Functions used by profile implementation */
> +void btd_service_connecting_start(struct btd_service *service);
>  void btd_service_connecting_complete(struct btd_service *service, int err);
>  void btd_service_disconnecting_complete(struct btd_service *service, int err);
>  void btd_service_set_user_data(struct btd_service *service, void *user_data);
> --
> 2.1.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
