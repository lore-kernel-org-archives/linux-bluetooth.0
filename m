Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1447708112-12695-5-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1447708112-12695-1-git-send-email-lukasz.rymanowski@codecoup.pl>
	<1447708112-12695-5-git-send-email-lukasz.rymanowski@codecoup.pl>
Date: Tue, 17 Nov 2015 16:22:23 +0100
Message-ID: <CABD6X-+OA_n7wX7Lx5RE=XibTQHv8Pi_t87uka+UuUWwgTX2hA@mail.gmail.com>
Subject: Re: [PATCH 4/4] shared/gatt-server: Cancel remaining write exec on
 error in the middle
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On 16 November 2015 at 22:08, Łukasz Rymanowski
<lukasz.rymanowski@codecoup.pl> wrote:
> If one execute write fail, server sends error response to the client.
> All characteristics before the failing one has been written and we cannot
> do anything about that. All the following characteristics will be
> canceled with this patch.
>
> According to the spec BT Core 4.2, Vol.3, Part F, chapter 3.4.6.3.
> in case of error, state of attributes is not defined, which makes
> this behavior ok.
> ---
>  src/shared/gatt-server.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 931d619..3cd5190 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -1158,6 +1158,22 @@ error:
>
>  }
>
> +static void exec_write_cancel(void *data, void *user_data)
> +{
> +       uint16_t handle = PTR_TO_UINT(data);
> +       struct bt_gatt_server *server = user_data;
> +       struct gatt_db_attribute *attr;
> +       uint8_t cancel = 0;
> +
> +       attr = gatt_db_get_attribute(server->db, PTR_TO_UINT(handle));
> +       if (!attr) {
> +               return;
> +       }
> +
> +       gatt_db_attribute_write(attr, 0, &cancel , 1, BT_ATT_OP_EXEC_WRITE_REQ,
> +                                               server->att, NULL, NULL);
gatt_db_attribute_write() returns if callback is not provided. I
assume exec write req is mainly to inform app that exec write has
finished or has been canceled, so maybe you should just ignore exec
write responses as application already checked if value is valid in
prepare writes?
> +}
> +
>  static void exec_next_write(struct bt_gatt_server *server);
>
>  static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
> @@ -1167,6 +1183,7 @@ static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
>         uint16_t handle = gatt_db_attribute_get_handle(attr);
>
>         if (err) {
> +               queue_foreach(server->exec_queue, exec_write_cancel, server);
>                 queue_remove_all(server->exec_queue, NULL, NULL, NULL);
>                 bt_att_send_error_rsp(server->att, BT_ATT_OP_EXEC_WRITE_REQ,
>                                                                 handle, err);
> @@ -1178,6 +1195,7 @@ static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
>  static void exec_next_write(struct bt_gatt_server *server)
>  {
>         uint16_t *handle;
> +       uint8_t execute = 1;
>         struct gatt_db_attribute *attr;
>         bool status;
>         int err;
> @@ -1194,7 +1212,7 @@ static void exec_next_write(struct bt_gatt_server *server)
>                 goto error;
>         }
>
> -       status = gatt_db_attribute_write(attr, 0, NULL , 0,
> +       status = gatt_db_attribute_write(attr, 0, &execute , 1,
>                                                 BT_ATT_OP_EXEC_WRITE_REQ,
>                                                 server->att,
>                                                 exec_write_complete_cb, server);
> @@ -1204,6 +1222,8 @@ static void exec_next_write(struct bt_gatt_server *server)
>         err = BT_ATT_ERROR_UNLIKELY;
>
>  error:
> +
> +       queue_foreach(server->exec_queue, exec_write_cancel, server);
>         queue_remove_all(server->exec_queue, NULL, NULL, NULL);
>         bt_att_send_error_rsp(server->att, BT_ATT_OP_EXEC_WRITE_REQ,
>                                                 PTR_TO_UINT(handle), err);
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
BR
Marcin Kraglak
