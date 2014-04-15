Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397027234-12003-12-git-send-email-marcin.kraglak@tieto.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
	<1397027234-12003-12-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 15 Apr 2014 09:57:49 -0300
Message-ID: <CAKT1EBdoOwfCLw58PhRJA09Bsgxittw3vNOu_2t9ztmDeTDMTw@mail.gmail.com>
Subject: Re: [RFC 11/16] android/gatt: Add characteristic implementation
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Apr 9, 2014 at 4:07 AM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> It will add characteristic declaration and value attributes to local database.
> ---
>  android/gatt.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index 10e3dfd..25cd7f1 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -2763,11 +2763,45 @@ failed:
>
>  static void handle_server_add_characteristic(const void *buf, uint16_t len)
>  {
> +       const struct hal_cmd_gatt_server_add_characteristic *cmd = buf;
> +       struct hal_ev_gatt_server_characteristic_added ev;
> +       struct gatt_server *server;
> +       bt_uuid_t uuid;
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
> +       android2uuid(cmd->uuid, &uuid);
> +
> +       ev.char_handle = gatt_db_new_characteristic(gatt_db,
> +                                                       cmd->service_handle,
> +                                                       &uuid, cmd->permissions,
> +                                                       cmd->properties,
> +                                                       NULL, NULL, NULL);

Read & Write callbacks missing.

> +       if (!ev.char_handle)
> +               status = HAL_STATUS_FAILED;
> +       else
> +               status = HAL_STATUS_SUCCESS;
> +
> +failed:
> +       ev.srvc_handle = cmd->service_handle;
> +       ev.status = status;
> +       ev.server_if = cmd->server_if;
> +       ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;

Use conversion helper (hal ->gatt) ?

> +       memcpy(ev.uuid, cmd->uuid, sizeof(cmd->uuid));
> +
> +       ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> +                               HAL_EV_GATT_SERVER_CHAR_ADDED, sizeof(ev), &ev);
> +
>         ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
>                                         HAL_OP_GATT_SERVER_ADD_CHARACTERISTIC,
> -                                       HAL_STATUS_FAILED);
> +                                       status);
>  }
>
>  static void handle_server_add_descriptor(const void *buf, uint16_t len)
> --
> 1.8.5.3

Claudio
