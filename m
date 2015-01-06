Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLXB9TTGQGjwHP=5QOL5og+1g8sbSLP5PDnqaGEk+wzVA@mail.gmail.com>
References: <1420509816-1376-1-git-send-email-armansito@chromium.org>
	<1420509816-1376-5-git-send-email-armansito@chromium.org>
	<CABBYNZLXB9TTGQGjwHP=5QOL5og+1g8sbSLP5PDnqaGEk+wzVA@mail.gmail.com>
Date: Tue, 6 Jan 2015 10:58:28 -0800
Message-ID: <CAHrH25Qaf+-yj1TgQJ1Mnn2mr+CYCB_WnV+CH7uPzRjoWS=7bA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 4/8] shared/gatt-db: Add truncate argument to write
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Tue, Jan 6, 2015 at 5:09 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Tue, Jan 6, 2015 at 12:03 AM, Arman Uguray <armansito@chromium.org> wrote:
>> This patch adds the "truncate" argument to gatt_db_attribute_write. This
>> allows users to specify if the cached value should be truncated when the
>> write value length is shorter than what is stored in the database. This
>> allows client code to correctly store a remote attribute value when the
>> database is used as a client-role cache.
>> ---
>>  android/gatt.c           | 17 +++++++++--------
>>  src/gatt-client.c        |  6 +++---
>>  src/shared/gatt-db.c     | 18 ++++++++++++++++--
>>  src/shared/gatt-db.h     |  1 +
>>  src/shared/gatt-server.c |  6 ++++--
>>  tools/btgatt-server.c    |  8 ++++----
>>  unit/test-gatt.c         |  6 +++---
>>  7 files changed, 40 insertions(+), 22 deletions(-)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index 3a35bd6..7f765e0 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -6349,7 +6349,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
>>                 return;
>>
>>         gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0], &dev->bdaddr,
>> -                                                       write_confirm, NULL);
>> +                                               false, write_confirm, NULL);
>>  }
>>
>>  static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
>> @@ -6421,7 +6421,8 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
>>                 /* Signature OK, proceed with write */
>>                 bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK, r_sign_cnt);
>>                 gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
>> -                                       &dev->bdaddr, write_confirm, NULL);
>> +                                                       &dev->bdaddr, false,
>> +                                                       write_confirm, NULL);
>>         }
>>  }
>>
>> @@ -6481,8 +6482,8 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
>>         }
>>
>>         if (!gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
>> -                                       &dev->bdaddr, attribute_write_cb,
>> -                                       data)) {
>> +                                               &dev->bdaddr, false,
>> +                                               attribute_write_cb, data)) {
>>                 queue_remove(dev->pending_requests, data);
>>                 free(data);
>>                 return ATT_ECODE_UNLIKELY;
>> @@ -6541,8 +6542,8 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
>>         data->length = vlen;
>>
>>         if (!gatt_db_attribute_write(attrib, offset, value, vlen, cmd[0],
>> -                                       &dev->bdaddr, attribute_write_cb,
>> -                                       data)) {
>> +                                               &dev->bdaddr, false,
>> +                                               attribute_write_cb, data)) {
>>                 queue_remove(dev->pending_requests, data);
>>                 g_free(data->value);
>>                 free(data);
>> @@ -6805,7 +6806,7 @@ static void register_gap_service(void)
>>                 value = cpu_to_le16(APPEARANCE_GENERIC_PHONE);
>>                 gatt_db_attribute_write(gap_srvc_data.appear, 0,
>>                                                 (void *) &value, sizeof(value),
>> -                                               ATT_OP_WRITE_REQ, NULL,
>> +                                               ATT_OP_WRITE_REQ, NULL, false,
>>                                                 write_confirm, NULL);
>>         }
>>
>> @@ -6822,7 +6823,7 @@ static void register_gap_service(void)
>>                 value = PERIPHERAL_PRIVACY_DISABLE;
>>                 gatt_db_attribute_write(gap_srvc_data.priv, 0,
>>                                                 &value, sizeof(value),
>> -                                               ATT_OP_WRITE_REQ, NULL,
>> +                                               ATT_OP_WRITE_REQ, NULL, false,
>>                                                 write_confirm, NULL);
>>         }
>>
>> diff --git a/src/gatt-client.c b/src/gatt-client.c
>> index 1edbafc..79e1d26 100644
>> --- a/src/gatt-client.c
>> +++ b/src/gatt-client.c
>> @@ -349,7 +349,7 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
>>                 return;
>>         }
>>
>> -       gatt_db_attribute_write(desc->attr, 0, value, length, 0, NULL,
>> +       gatt_db_attribute_write(desc->attr, 0, value, length, 0, NULL, true,
>>                                                 write_descriptor_cb, desc);
>>
>>         /*
>> @@ -764,7 +764,7 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
>>         }
>>
>>         gatt_db_attribute_write(chrc->attr, 0, value, length, op->offset, NULL,
>> -                                               write_characteristic_cb, chrc);
>> +                                       true, write_characteristic_cb, chrc);
>
>
> I think it would be better to have some means to truncate the value
> separately, e.g. gatt_db_attribute_truncate.
>

Would this just truncate the value to the specified length? Or would
we want a "set_value" function that works like write but truncates it
if needed?

>>         /*
>>          * If the value length is exactly MTU-1, then we may not have read the
>> @@ -1020,7 +1020,7 @@ static void notify_cb(uint16_t value_handle, const uint8_t *value,
>>          * signal so that we propagate the notification/indication to
>>          * applications.
>>          */
>> -       gatt_db_attribute_write(chrc->attr, 0, value, length, 0, NULL,
>> +       gatt_db_attribute_write(chrc->attr, 0, value, length, 0, NULL, true,
>>                                                 write_characteristic_cb, chrc);
>>  }
>>
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index 74c3e70..87e77d1 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -1440,9 +1440,24 @@ static bool write_timeout(void *user_data)
>>         return false;
>>  }
>>
>> +static bool should_resize_value(struct gatt_db_attribute *attrib, size_t len,
>> +                                                               uint16_t offset,
>> +                                                               bool truncate)
>> +{
>> +       unsigned diff;
>> +
>> +       if (!attrib->value || offset >= attrib->value_len)
>> +               return true;
>> +
>> +       diff = attrib->value_len - offset;
>> +
>> +       return truncate ? len != diff : len > diff;
>> +}
>> +
>>  bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>>                                         const uint8_t *value, size_t len,
>>                                         uint8_t opcode, bdaddr_t *bdaddr,
>> +                                       bool truncate,
>>                                         gatt_db_attribute_write_t func,
>>                                         void *user_data)
>>  {
>> @@ -1471,8 +1486,7 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>>         }
>>
>>         /* For values stored in db allocate on demand */
>> -       if (!attrib->value || offset >= attrib->value_len ||
>> -                               len > (unsigned) (attrib->value_len - offset)) {
>> +       if (should_resize_value(attrib, len, offset, truncate)) {
>>                 void *buf;
>>
>>                 buf = realloc(attrib->value, len + offset);
>> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
>> index f188944..2467852 100644
>> --- a/src/shared/gatt-db.h
>> +++ b/src/shared/gatt-db.h
>> @@ -193,6 +193,7 @@ typedef void (*gatt_db_attribute_write_t) (struct gatt_db_attribute *attrib,
>>  bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>>                                         const uint8_t *value, size_t len,
>>                                         uint8_t opcode, bdaddr_t *bdaddr,
>> +                                       bool truncate,
>>                                         gatt_db_attribute_write_t func,
>>                                         void *user_data);
>>
>> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
>> index 00f36fd..2af7cf1 100644
>> --- a/src/shared/gatt-server.c
>> +++ b/src/shared/gatt-server.c
>> @@ -723,7 +723,8 @@ static void write_cb(uint8_t opcode, const void *pdu,
>>         server->pending_write_op = op;
>>
>>         if (gatt_db_attribute_write(attr, 0, pdu + 2, length - 2, opcode,
>> -                                               NULL, write_complete_cb, op))
>> +                                                       NULL, false,
>> +                                                       write_complete_cb, op))
>>                 return;
>>
>>         if (op)
>> @@ -1008,7 +1009,8 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
>>         status = gatt_db_attribute_write(attr, next->offset,
>>                                                 next->value, next->length,
>>                                                 BT_ATT_OP_EXEC_WRITE_REQ, NULL,
>> -                                               exec_write_complete_cb, server);
>> +                                               false, exec_write_complete_cb,
>> +                                               server);
>>
>>         prep_write_data_destroy(next);
>>
>> diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
>> index f6ad8c3..393a071 100644
>> --- a/tools/btgatt-server.c
>> +++ b/tools/btgatt-server.c
>> @@ -446,8 +446,8 @@ static void populate_gap_service(struct server *server)
>>         gatt_db_attribute_write(tmp, 0, (void *) &appearance,
>>                                                         sizeof(appearance),
>>                                                         BT_ATT_OP_WRITE_REQ,
>> -                                                       NULL, confirm_write,
>> -                                                       NULL);
>> +                                                       NULL, true,
>> +                                                       confirm_write, NULL);
>>
>>         gatt_db_service_set_active(service, true);
>>  }
>> @@ -514,8 +514,8 @@ static void populate_hr_service(struct server *server)
>>                                                 NULL, NULL, server);
>>         gatt_db_attribute_write(body, 0, (void *) &body_loc, sizeof(body_loc),
>>                                                         BT_ATT_OP_WRITE_REQ,
>> -                                                       NULL, confirm_write,
>> -                                                       NULL);
>> +                                                       NULL, true,
>> +                                                       confirm_write, NULL);
>>
>>         /* HR Control Point Characteristic */
>>         bt_uuid16_create(&uuid, UUID_HEART_RATE_CTRL);
>> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
>> index 169fbd3..7a5081d 100644
>> --- a/unit/test-gatt.c
>> +++ b/unit/test-gatt.c
>> @@ -654,8 +654,8 @@ static struct gatt_db_attribute *add_char_with_value(struct gatt_db *db,
>>
>>         g_assert(attrib != NULL);
>>
>> -       gatt_db_attribute_write(attrib, 0, value, len, 0x00, NULL, att_write_cb,
>> -                                                                       NULL);
>> +       gatt_db_attribute_write(attrib, 0, value, len, 0x00, NULL, true,
>> +                                                       att_write_cb, NULL);
>>
>>         return attrib;
>>  }
>> @@ -670,7 +670,7 @@ add_desc_with_value(struct gatt_db_attribute *att, bt_uuid_t *uuid,
>>         desc_att = gatt_db_service_add_descriptor(att, uuid, att_perms, NULL,
>>                                                                 NULL, NULL);
>>
>> -       gatt_db_attribute_write(desc_att, 0, value, len, 0x00, NULL,
>> +       gatt_db_attribute_write(desc_att, 0, value, len, 0x00, NULL, true,
>>                                                         att_write_cb, NULL);
>>
>>         return desc_att;
>> --
>> 2.2.0.rc0.207.ga3a616c
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz

Cheers,
Arman
