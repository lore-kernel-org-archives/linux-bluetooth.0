Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397027234-12003-15-git-send-email-marcin.kraglak@tieto.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
	<1397027234-12003-15-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 15 Apr 2014 09:59:00 -0300
Message-ID: <CAKT1EBeqsmk5ZJxB8T9dFrc7pPeGca=iF01jFvRRWnog_NT0fQ@mail.gmail.com>
Subject: Re: [RFC 14/16] android/gatt: Add handling of start service command
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Apr 9, 2014 at 4:07 AM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> It will start service added to local database.
> ---
>  android/gatt.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index acaa2a9..edcb7aa 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -2846,10 +2846,37 @@ failed:
>
>  static void handle_server_start_service(const void *buf, uint16_t len)
>  {
> +       const struct hal_cmd_gatt_server_start_service *cmd = buf;
> +       struct hal_ev_gatt_server_service_started ev;
> +       struct gatt_server *server;
> +       uint8_t status;

"status" could be initialized to "HAL_STATUS_FAILED"

> +
>         DBG("");
>
> +       server = find_server_by_id(cmd->server_if);
> +       if (!server) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       if (!gatt_db_start_service(gatt_db, cmd->service_handle)) {
> +               /* we ignore service now */
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       status = HAL_STATUS_SUCCESS;
> +
> +failed:
> +       ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;

Use conversion helper (hal ->gatt)?

> +       ev.server_if = cmd->server_if;
> +       ev.srvc_handle = cmd->service_handle;
> +
> +       ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> +               HAL_EV_GATT_SERVER_SERVICE_STARTED, sizeof(ev), &ev);
> +
>         ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
> -                       HAL_OP_GATT_SERVER_START_SERVICE, HAL_STATUS_FAILED);
> +                               HAL_OP_GATT_SERVER_START_SERVICE, status);
>  }
>
>  static void handle_server_stop_service(const void *buf, uint16_t len)
> --
> 1.8.5.3
>

Claudio
