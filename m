Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415741987-22272-4-git-send-email-armansito@chromium.org>
References: <1415741987-22272-1-git-send-email-armansito@chromium.org>
	<1415741987-22272-4-git-send-email-armansito@chromium.org>
Date: Wed, 12 Nov 2014 15:00:05 +0200
Message-ID: <CABBYNZJvJ5EmKwXKBSGTooXLRrbNyYt=m7MR4-fVnfEa9fHy+w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/8] tools/btgatt-server: Populate the database.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Nov 11, 2014 at 11:39 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch populates the GATT database with the GAP and GATT services.
> ---
>  tools/btgatt-server.c | 230 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 230 insertions(+)
>
> diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
> index bee6275..9e94b3e 100644
> --- a/tools/btgatt-server.c
> +++ b/tools/btgatt-server.c
> @@ -42,6 +42,8 @@
>
>  #define ATT_CID 4
>
> +#define UUID_GAP 0x1800
> +
>  #define PRLOG(...) \
>         do { \
>                 printf(__VA_ARGS__); \
> @@ -57,12 +59,19 @@
>  #define COLOR_BOLDGRAY "\x1B[1;30m"
>  #define COLOR_BOLDWHITE        "\x1B[1;37m"
>
> +static const char test_device_name[] = "Very Long Test Device Name For Testing "
> +                               "ATT Protocol Operations On GATT Server";
>  static bool verbose = false;
>
>  struct server {
>         int fd;
>         struct gatt_db *db;
>         struct bt_gatt_server *gatt;
> +
> +       uint8_t *device_name;
> +       size_t name_len;
> +
> +       bool svc_chngd_enabled;
>  };
>
>  static void print_prompt(void)
> @@ -93,10 +102,216 @@ static void gatt_debug_cb(const char *str, void *user_data)
>         PRLOG(COLOR_GREEN "%s%s\n" COLOR_OFF, prefix, str);
>  }
>
> +static void gap_appearance_cb(struct gatt_db_attribute *attrib, unsigned int id,
> +                                       uint16_t offset, uint8_t opcode,
> +                                       bdaddr_t *bdaddr, void *user_data)
> +{
> +       uint16_t appearance = 128;
> +       uint8_t value[2];
> +
> +       put_le16(appearance, value);
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, value, 2);

Lets use sizeof whenever possible.

> +}
> +
> +
> +static void gap_device_name_read_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
> +                                       void *user_data)
> +{
> +       struct server *server = user_data;
> +       uint8_t error = 0;
> +       size_t len = 0;
> +       const uint8_t *value = NULL;
> +
> +       PRLOG("GAP Device Name Read called\n");
> +
> +       len = server->name_len;
> +
> +       if (offset > len) {
> +               error = BT_ATT_ERROR_INVALID_OFFSET;
> +               goto done;
> +       }
> +
> +       len -= offset;
> +       value = len ? &server->device_name[offset] : NULL;
> +
> +done:
> +       gatt_db_attribute_read_result(attrib, id, error, value, len);
> +}
> +
> +static void gap_device_name_write_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       const uint8_t *value, size_t len,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
> +                                       void *user_data)
> +{
> +       struct server *server = user_data;
> +       uint8_t error = 0;
> +
> +       PRLOG("GAP Device Name Write called\n");
> +
> +       /* Implement this as a variable length attribute value. */
> +       if (offset > server->name_len) {
> +               error = BT_ATT_ERROR_INVALID_OFFSET;
> +               goto done;
> +       }
> +
> +       if (offset + len != server->name_len) {
> +               uint8_t *name;
> +
> +               name = realloc(server->device_name, offset + len);
> +               if (!name) {
> +                       error = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
> +                       goto done;
> +               }
> +
> +               memcpy(name, server->device_name,
> +                                       MIN(offset + len, server->name_len));
> +               server->device_name = name;
> +               server->name_len = offset + len;
> +       }
> +
> +       if (value)
> +               memcpy(server->device_name + offset, value, len);
> +
> +done:
> +       gatt_db_attribute_write_result(attrib, id, error);
> +}
> +
> +static void gap_device_name_ext_prop_read_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
> +                                       void *user_data)
> +{
> +       uint8_t value[2];
> +
> +       PRLOG("Device Name Extended Properties Read called\n");
> +
> +       value[0] = BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE;
> +       value[1] = 0;
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, value, 2);

Above as well.

> +}
> +
> +static void gatt_service_changed_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
> +                                       void *user_data)
> +{
> +       PRLOG("Service Changed Read called\n");
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, NULL, 0);
> +}
> +
> +static void gatt_svc_chngd_ccc_read_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
> +                                       void *user_data)
> +{
> +       struct server *server = user_data;
> +       uint8_t value[2];
> +
> +       PRLOG("Service Changed CCC Read called\n");
> +
> +       value[0] = server->svc_chngd_enabled ? 0x02 : 0x00;
> +       value[1] = 0x00;
> +
> +       gatt_db_attribute_read_result(attrib, id, 0, value, 2);

And here.

> +}
> +
> +static void gatt_svc_chngd_ccc_write_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       const uint8_t *value, size_t len,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
> +                                       void *user_data)
> +{
> +       struct server *server = user_data;
> +       uint8_t ecode = 0;
> +
> +       PRLOG("Service Changed CCC Write called\n");
> +
> +       if (!value || len != 2) {
> +               ecode = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
> +               goto done;
> +       }
> +
> +       if (offset) {
> +               ecode = BT_ATT_ERROR_INVALID_OFFSET;
> +               goto done;
> +       }
> +
> +       if (value[0] == 0x00)
> +               server->svc_chngd_enabled = false;
> +       else if (value[0] == 0x02)
> +               server->svc_chngd_enabled = true;
> +       else
> +               ecode = 0x80;
> +
> +       PRLOG("Service Changed Enabled: %s\n",
> +                               server->svc_chngd_enabled ? "true" : "false");
> +
> +done:
> +       gatt_db_attribute_write_result(attrib, id, ecode);
> +}
> +
> +static void populate_db(struct server *server)
> +{
> +       bt_uuid_t uuid;
> +       struct gatt_db_attribute *attr;
> +
> +       /* Add the GAP service */
> +       bt_uuid16_create(&uuid, UUID_GAP);
> +       attr = gatt_db_add_service(server->db, &uuid, true, 6);
> +
> +       /* Device Name characteristic */
> +       bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
> +       gatt_db_service_add_characteristic(attr, &uuid,
> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> +                                       BT_GATT_CHRC_PROP_READ,
> +                                       gap_device_name_read_cb,
> +                                       gap_device_name_write_cb,
> +                                       server);
> +
> +       bt_uuid16_create(&uuid, GATT_CHARAC_EXT_PROPER_UUID);
> +       gatt_db_service_add_descriptor(attr, &uuid, BT_ATT_PERM_READ,
> +                                       gap_device_name_ext_prop_read_cb,
> +                                       NULL, server);
> +
> +       /* Appearance characteristic */
> +       bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
> +       gatt_db_service_add_characteristic(attr, &uuid, BT_ATT_PERM_READ,
> +                                                       BT_GATT_CHRC_PROP_READ,
> +                                                       gap_appearance_cb,
> +                                                       NULL, server);
> +
> +       gatt_db_service_set_active(attr, true);
> +
> +       /* Add the GATT service */
> +       bt_uuid16_create(&uuid, 0x1801);
> +       attr = gatt_db_add_service(server->db, &uuid, true, 4);
> +
> +       bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
> +       gatt_db_service_add_characteristic(attr, &uuid, BT_ATT_PERM_READ,
> +                       BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_INDICATE,
> +                       gatt_service_changed_cb,
> +                       NULL, server);
> +
> +       bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
> +       gatt_db_service_add_descriptor(attr, &uuid,
> +                               BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
> +                               gatt_svc_chngd_ccc_read_cb,
> +                               gatt_svc_chngd_ccc_write_cb, server);
> +
> +       gatt_db_service_set_active(attr, true);

Perhaps we could have one, or a few, that are actually stored in the
db itself for testing, the attributes that are not context sensitive
and don't have CCC are probably good candidates.

> +}
> +
>  static struct server *server_create(int fd, uint16_t mtu)
>  {
>         struct server *server;
>         struct bt_att *att;
> +       size_t name_len = strlen(test_device_name);
>
>         server = new0(struct server, 1);
>         if (!server) {
> @@ -126,10 +341,22 @@ static struct server *server_create(int fd, uint16_t mtu)
>                 return NULL;
>         }
>
> +       server->name_len = name_len + 1;
> +       server->device_name = malloc(name_len + 1);
> +       if (!server->device_name) {
> +               bt_att_unref(att);
> +               free(server);
> +               return NULL;
> +       }
> +
> +       memcpy(server->device_name, test_device_name, name_len);
> +       server->device_name[name_len] = '\0';
> +
>         server->fd = fd;
>         server->db = gatt_db_new();
>         if (!server->db) {
>                 fprintf(stderr, "Failed to create GATT database\n");
> +               free(server->device_name);
>                 bt_att_unref(att);
>                 free(server);
>                 return NULL;
> @@ -139,6 +366,7 @@ static struct server *server_create(int fd, uint16_t mtu)
>         if (!server->gatt) {
>                 fprintf(stderr, "Failed to create GATT server\n");
>                 gatt_db_destroy(server->db);
> +               free(server->device_name);
>                 bt_att_unref(att);
>                 free(server);
>                 return NULL;
> @@ -153,6 +381,8 @@ static struct server *server_create(int fd, uint16_t mtu)
>         /* bt_gatt_server already holds a reference */
>         bt_att_unref(att);
>
> +       populate_db(server);
> +
>         return server;
>  }
>
> --
> 2.1.0.rc2.206.gedb03e5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
