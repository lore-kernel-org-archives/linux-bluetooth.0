Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397027234-12003-10-git-send-email-marcin.kraglak@tieto.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
	<1397027234-12003-10-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 15 Apr 2014 09:55:22 -0300
Message-ID: <CAKT1EBdEQ2o_+zpu0gc1BmKLyCurHVKLYe8ATHbJfDwUBofwEA@mail.gmail.com>
Subject: Re: [RFC 09/16] android/gatt: Add implementation of delete service
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Apr 9, 2014 at 4:07 AM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> It will delete saervice from local database
> ---
>  android/gatt.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index 76753a8..5f054c7 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -2767,10 +2767,38 @@ static void handle_server_stop_service(const void *buf, uint16_t len)
>
>  static void handle_server_delete_service(const void *buf, uint16_t len)
>  {
> +       const struct hal_cmd_gatt_server_delete_service *cmd = buf;
> +       struct hal_ev_gatt_server_service_deleted ev;
> +       struct gatt_server *server;
> +       uint8_t status;
> +

"status" could be initialized to "HAL_STATUS_FAILED"

>         DBG("");
>
> +       memset(&ev, 0, sizeof(ev));
> +
> +       server = find_server_by_id(cmd->server_if);
> +       if (!server) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       if (!gatt_db_remove_service(gatt_db, cmd->service_handle)) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       status = HAL_STATUS_SUCCESS;
> +
> +failed:
> +       ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;

Same comment of the previous patch.

> +       ev.srvc_handle = cmd->service_handle;
> +       ev.server_if = cmd->server_if;
> +
> +       ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> +               HAL_EV_GATT_SERVER_SERVICE_DELETED, sizeof(ev), &ev);
> +
>         ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
> -                       HAL_OP_GATT_SERVER_DELETE_SERVICE, HAL_STATUS_FAILED);
> +                       HAL_OP_GATT_SERVER_DELETE_SERVICE, status);
>  }
>
>  static void handle_server_send_indication(const void *buf, uint16_t len)

Claudio
