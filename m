Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1447708112-12695-4-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1447708112-12695-1-git-send-email-lukasz.rymanowski@codecoup.pl>
	<1447708112-12695-4-git-send-email-lukasz.rymanowski@codecoup.pl>
Date: Tue, 17 Nov 2015 10:45:54 +0100
Message-ID: <CAMv5GbdLBcwbyzbps6OzCLDi8prUWGokBTL036jAwWuw84Ai-g@mail.gmail.com>
Subject: Re: [PATCH 3/4] shared/gatt-server: Improve long write session handling
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On 16 November 2015 at 22:08, Łukasz Rymanowski
<lukasz.rymanowski@codecoup.pl> wrote:
>
> With current implementation application layer has no idea when
> long write session ends as it gets write callback with execute
> write for each prepare write data.
> With this patch, after data are completly received by gatt-server it
> starts to call write callback in proper order with opcode
> BT_ATT_OP_PREP_WRITE_REQ. After that, each characteristic gets
> BT_ATT_OP_EXEC_WRITE_REQ so it knows that complete characteristic value
> has been received and data can be marked as valid.
> ---
>  src/shared/gatt-server.c | 78 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 73 insertions(+), 5 deletions(-)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 329f53f..931d619 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -104,6 +104,8 @@ struct bt_gatt_server {
>         struct queue *prep_queue;
>         unsigned int max_prep_queue_len;
>
> +       struct queue *exec_queue;
> +
>         struct async_read_op *pending_read_op;
>         struct async_write_op *pending_write_op;
>
> @@ -137,6 +139,7 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
>                 server->pending_write_op->server = NULL;
>
>         queue_destroy(server->prep_queue, prep_write_data_destroy);
> +       queue_destroy(server->exec_queue, NULL);
>
>         gatt_db_unref(server->db);
>         bt_att_unref(server->att);
> @@ -1155,10 +1158,61 @@ error:
>
>  }
>
> +static void exec_next_write(struct bt_gatt_server *server);
> +
> +static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
> +                                                               void *user_data)
> +{
> +       struct bt_gatt_server *server = user_data;
> +       uint16_t handle = gatt_db_attribute_get_handle(attr);
> +
> +       if (err) {
> +               queue_remove_all(server->exec_queue, NULL, NULL, NULL);
> +               bt_att_send_error_rsp(server->att, BT_ATT_OP_EXEC_WRITE_REQ,
> +                                                               handle, err);
> +       }
> +
> +       exec_next_write(server);
> +}
> +
> +static void exec_next_write(struct bt_gatt_server *server)
> +{
> +       uint16_t *handle;
> +       struct gatt_db_attribute *attr;
> +       bool status;
> +       int err;
> +
> +       handle = queue_pop_head(server->exec_queue);
> +       if (!handle) {
> +               bt_att_send(server->att, BT_ATT_OP_EXEC_WRITE_RSP, NULL, 0,
> +                                                       NULL, NULL, NULL);
> +       }

Single command "ifs" don't require brackets.
>
> +
> +       attr = gatt_db_get_attribute(server->db, PTR_TO_UINT(handle));
> +       if (!attr) {
> +               err = BT_ATT_ERROR_UNLIKELY;
> +               goto error;
> +       }
> +
> +       status = gatt_db_attribute_write(attr, 0, NULL , 0,
> +                                               BT_ATT_OP_EXEC_WRITE_REQ,
> +                                               server->att,
> +                                               exec_write_complete_cb, server);
> +       if (status)
> +               return;
> +
> +       err = BT_ATT_ERROR_UNLIKELY;
> +
> +error:
> +       queue_remove_all(server->exec_queue, NULL, NULL, NULL);
> +       bt_att_send_error_rsp(server->att, BT_ATT_OP_EXEC_WRITE_REQ,
> +                                               PTR_TO_UINT(handle), err);
> +}
> +
>  static void exec_next_prep_write(struct bt_gatt_server *server,
>                                                 uint16_t ehandle, int err);
>
> -static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
> +static void prep_write_complete_cb(struct gatt_db_attribute *attr, int err,
>                                                                 void *user_data)
>  {
>         struct bt_gatt_server *server = user_data;
> @@ -1167,6 +1221,11 @@ static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
>         exec_next_prep_write(server, handle, err);
>  }
>
> +static bool match_attribute_handle(const void *data, const void *match_data)
> +{
> +       return PTR_TO_UINT(data) == PTR_TO_UINT(match_data);
> +}
> +
>  static void exec_next_prep_write(struct bt_gatt_server *server,
>                                                 uint16_t ehandle, int err)
>  {
> @@ -1177,10 +1236,17 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
>         if (err)
>                 goto error;
>
> +       /*
> +        *  Remember to which handles we need to send execute after reliable
> +        *  or long write session is done
> +        */
> +       if (ehandle && !queue_find(server->exec_queue,  match_attribute_handle,
> +                                                       UINT_TO_PTR(ehandle)))
> +               queue_push_tail(server->exec_queue, UINT_TO_PTR(ehandle));
> +
>         next = queue_pop_head(server->prep_queue);
>         if (!next) {
> -               bt_att_send(server->att, BT_ATT_OP_EXEC_WRITE_RSP, NULL, 0,
> -                                                       NULL, NULL, NULL);
> +               exec_next_write(server);
>                 return;
>         }
>
> @@ -1192,9 +1258,9 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
>
>         status = gatt_db_attribute_write(attr, next->offset,
>                                                 next->value, next->length,
> -                                               BT_ATT_OP_EXEC_WRITE_REQ,
> +                                               BT_ATT_OP_PREP_WRITE_REQ,
>                                                 server->att,
> -                                               exec_write_complete_cb, server);
> +                                               prep_write_complete_cb, server);
>
>         prep_write_data_destroy(next);
>
> @@ -1396,6 +1462,8 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
>         server->max_prep_queue_len = DEFAULT_MAX_PREP_QUEUE_LEN;
>         server->prep_queue = queue_new();
>
> +       server->exec_queue = queue_new();
> +
>         if (!gatt_server_register_att_handlers(server)) {
>                 bt_gatt_server_free(server);
>                 return NULL;
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


BR,
Grzegorz
