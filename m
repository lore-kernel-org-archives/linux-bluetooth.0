Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413838861-29956-3-git-send-email-armansito@chromium.org>
References: <1413838861-29956-1-git-send-email-armansito@chromium.org>
	<1413838861-29956-3-git-send-email-armansito@chromium.org>
Date: Fri, 24 Oct 2014 12:31:07 +0300
Message-ID: <CABBYNZ+rxN6GrQTi1Fh5NYdRb9FXgf-w5cQrb+LEBdVZpSzjWg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/8] shared/gatt-db: Add complete callback to gatt_db_read.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Oct 21, 2014 at 12:00 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch introduces a completion callback parameter to gatt_db_read,
> which is meant to be used by a gatt_db_read_t implementation to signal
> the end of an asynchronous read operation performed in the upper layer.
> ---
>  android/gatt.c           | 21 ++++++++++++++++++---
>  src/shared/gatt-db.c     |  7 +++++--
>  src/shared/gatt-db.h     |  9 ++++++++-
>  src/shared/gatt-server.c |  4 ++--
>  4 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index ea20941..e2aa686 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4694,7 +4694,8 @@ static void read_requested_attributes(void *data, void *user_data)
>                                                 resp_data->offset,
>                                                 process_data->opcode,
>                                                 &process_data->device->bdaddr,
> -                                               &value, &value_len))
> +                                               &value, &value_len,
> +                                               NULL, NULL))
>                 error = ATT_ECODE_UNLIKELY;
>
>         /* We have value here already if no callback will be called */
> @@ -4744,7 +4745,10 @@ static struct pending_trans_data *conn_add_transact(struct app_connection *conn,
>  }
>
>  static void read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
> -                                       bdaddr_t *bdaddr, void *user_data)
> +                                       bdaddr_t *bdaddr,
> +                                       gatt_db_read_complete_t complete_func,
> +                                       void *complete_data,
> +                                       void *user_data)
>  {
>         struct pending_trans_data *transaction;
>         struct hal_ev_gatt_server_request_read ev;
> @@ -6266,7 +6270,10 @@ static struct gap_srvc_handles gap_srvc_data;
>  #define PERIPHERAL_PRIVACY_DISABLE 0x00
>
>  static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
> -                                       bdaddr_t *bdaddr, void *user_data)
> +                                       bdaddr_t *bdaddr,
> +                                       gatt_db_read_complete_t complete_func,
> +                                       void *complete_data,
> +                                       void *user_data)
>  {
>         struct pending_request *entry;
>         struct gatt_device *dev;
> @@ -6373,6 +6380,8 @@ static void register_gap_service(void)
>
>  static void device_info_read_cb(uint16_t handle, uint16_t offset,
>                                         uint8_t att_opcode, bdaddr_t *bdaddr,
> +                                       gatt_db_read_complete_t complete_func,
> +                                       void *complete_data,
>                                         void *user_data)
>  {
>         struct pending_request *entry;
> @@ -6406,6 +6415,8 @@ done:
>
>  static void device_info_read_system_id_cb(uint16_t handle, uint16_t offset,
>                                         uint8_t att_opcode, bdaddr_t *bdaddr,
> +                                       gatt_db_read_complete_t complete_func,
> +                                       void *complete_data,
>                                         void *user_data)
>  {
>         struct pending_request *entry;
> @@ -6438,6 +6449,8 @@ done:
>
>  static void device_info_read_pnp_id_cb(uint16_t handle, uint16_t offset,
>                                         uint8_t att_opcode, bdaddr_t *bdaddr,
> +                                       gatt_db_read_complete_t complete_func,
> +                                       void *complete_data,
>                                         void *user_data)
>  {
>         struct pending_request *entry;
> @@ -6602,6 +6615,8 @@ static void gatt_srvc_change_write_cb(uint16_t handle, uint16_t offset,
>
>  static void gatt_srvc_change_read_cb(uint16_t handle, uint16_t offset,
>                                         uint8_t att_opcode, bdaddr_t *bdaddr,
> +                                       gatt_db_read_complete_t complete_func,
> +                                       void *complete_data,
>                                         void *user_data)
>  {
>         struct pending_request *entry;
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index b3f95d2..c342e32 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -638,7 +638,9 @@ static bool find_service_for_handle(const void *data, const void *user_data)
>
>  bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
>                                 uint8_t att_opcode, bdaddr_t *bdaddr,
> -                               uint8_t **value, int *length)
> +                               uint8_t **value, int *length,
> +                               gatt_db_read_complete_t complete_func,
> +                               void *complete_data)
>  {
>         struct gatt_db_service *service;
>         uint16_t service_handle;
> @@ -665,7 +667,8 @@ bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
>         if (a->read_func) {
>                 *value = NULL;
>                 *length = -1;
> -               a->read_func(handle, offset, att_opcode, bdaddr, a->user_data);
> +               a->read_func(handle, offset, att_opcode, bdaddr, complete_func,
> +                                               complete_data, a->user_data);
>         } else {
>                 if (offset > a->value_len)
>                         return false;
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 8d18434..1c8739e 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -30,8 +30,13 @@ uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
>                                         bool primary, uint16_t num_handles);
>  bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
>
> +typedef void (*gatt_db_read_complete_t)(uint16_t handle, uint16_t att_ecode,
> +                                       const uint8_t *value, size_t len,
> +                                       void *complete_data);
>  typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t offset,
>                                         uint8_t att_opcode, bdaddr_t *bdaddr,
> +                                       gatt_db_read_complete_t complete_func,
> +                                       void *complete_data,
>                                         void *user_data);
>
>  typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t offset,
> @@ -81,7 +86,9 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
>
>  bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
>                                         uint8_t att_opcode, bdaddr_t *bdaddr,
> -                                       uint8_t **value, int *length);
> +                                       uint8_t **value, int *length,
> +                                       gatt_db_read_complete_t complete_func,
> +                                       void *complete_data);

Lets remove value and length here and make it always return via
callback, we can probably use a idle callback if there is a problem to
return the values immediately.

>  bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
>                                         const uint8_t *value, size_t len,
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 657b564..3233b21 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -114,8 +114,8 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
>                  */
>                 if (!gatt_db_read(db, start_handle, 0,
>                                                 BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
> -                                               NULL, &value,
> -                                               &value_len) || value_len < 0)
> +                                               NULL, &value, &value_len,
> +                                               NULL, NULL) || value_len < 0)
>                         return false;
>
>                 /*
> --
> 2.1.0.rc2.206.gedb03e5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
