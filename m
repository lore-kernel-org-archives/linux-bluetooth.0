Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397027234-12003-13-git-send-email-marcin.kraglak@tieto.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
	<1397027234-12003-13-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 15 Apr 2014 09:58:21 -0300
Message-ID: <CAKT1EBcepxWStjQNvM-JzhM8MV624K2Ow_2O0Sb_1kQGWaH8JQ@mail.gmail.com>
Subject: Re: [RFC 12/16] android/gatt: Add descriptor implementation
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Apr 9, 2014 at 4:07 AM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> It will add characteristic descriptor attribute to local database.
> ---
>  android/gatt.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index 25cd7f1..acaa2a9 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -2806,10 +2806,42 @@ failed:
>
>  static void handle_server_add_descriptor(const void *buf, uint16_t len)
>  {
> +       const struct hal_cmd_gatt_server_add_descriptor *cmd = buf;
> +       struct hal_ev_gatt_server_descriptor_added ev;
> +       struct gatt_server *server;
> +       bt_uuid_t uuid;
> +       uint8_t status;

"status" could be initialized to " HAL_STATUS_FAILED"

> +
>         DBG("");
>
> +       server = find_server_by_id(cmd->server_if);
> +       if (!server) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       android2uuid(cmd->uuid, &uuid);
> +
> +       ev.descr_handle = gatt_db_new_char_descriptor(gatt_db,
> +                                                       cmd->service_handle,
> +                                                       &uuid, cmd->permissions,
> +                                                       NULL, NULL, NULL);

Read & Write callbacks are not informed here.

> +       if (!ev.descr_handle)
> +               status = HAL_STATUS_FAILED;
> +       else
> +               status = HAL_STATUS_SUCCESS;
> +
> +failed:
> +       ev.server_if = cmd->server_if;
> +       ev.srvc_handle = cmd->service_handle;
> +       memcpy(ev.uuid, cmd->uuid, sizeof(cmd->uuid));
> +       ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;

Use conversion helper (hal ->gatt) ?

> +
> +       ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> +                       HAL_EV_GATT_SERVER_DESCRIPTOR_ADDED, sizeof(ev), &ev);
> +
>         ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
> -                       HAL_OP_GATT_SERVER_ADD_DESCRIPTOR, HAL_STATUS_FAILED);
> +                               HAL_OP_GATT_SERVER_ADD_DESCRIPTOR, status);
>  }
>
>  static void handle_server_start_service(const void *buf, uint16_t len)
> --
> 1.8.5.3

Claudio
