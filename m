Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F352C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 17:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4EF206DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 17:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUDAF1Wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgFERCS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFERCR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 13:02:17 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89462C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 10:02:16 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id e8so2113672ooi.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ub2mFn1e3PpinmNCfKGHpmSMjOB958lNg2r86EloFHE=;
        b=vUDAF1WgqzO87NlbEwZDGanBjQPSFpd8jX/xQYpuVGodeokQ6czW0A1yB2ZkFYxhFf
         IXLxSmen5+juFQm1FykEjzVAtx4UmHvrZYDDCjx0BoyS16Vp73MH8adVkEF55AIGiYCI
         7Xb0jkcgmoDJZRIRbDEPwQGr1vVyDHMeMhxCZmLACZ7stXN3aLCGoJWonIrwRQSPYLt4
         VvhFAyb9MX3/ErevZTFD8BqWkM5lAc2iSwN1Ynpv3PM+XN6ahJn1zbB8J0loBdDnz6Md
         r1wxeNFq3nNHip0wF2tM1aeEQarpx8uIhVFeGjwp/JPFq6vSs/qi2mX4UrqPz9NdCVOF
         GM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ub2mFn1e3PpinmNCfKGHpmSMjOB958lNg2r86EloFHE=;
        b=MtiCXkBttB14WmmK8TaUECi7Goet7LZ0UUeIIUcj9tvbKDHQpdyD9Pn/QHq+d9CRmK
         /wJupa0jojSJIPFYZLczQ4FkZ7STA0Xz6MeMQUn60TvhyFauKxNMY5R/g3oHF+rruyHE
         BfSr4cGMX0mdwzbWjbscHe6j91nfo455Nix6sveqEpic8zzzIEYc15tfjTXf56JCXHiB
         sfi36YzXRhUBoIiARhQ9UmFXgXepWGB+MVgXsIOxpMV/m/PK1sVuoeV+n0M72Fh74Kza
         AnsAzp+lfnhzLj5qoB3LOepWouIz2FVp4A77O+405lhVmxThYv0ERiTYGmOoxq8TOT4C
         hMnw==
X-Gm-Message-State: AOAM5327EqStGLh/CTmS5pm0BN9+ddAFacpsqCyk7RylilYuBlMh57dr
        M5ulOgctnXB3IED5RTkqCSXjYL99p3ae1tPKlpxpPg==
X-Google-Smtp-Source: ABdhPJxGrlEZ7OVspT/fASCmPVyxbUpVk0VmQY+dBDFeNUDX6PtByvq5XSJcwmP+dQ5AWtqoHQ2VBkvMIH115oOYLWQ=
X-Received: by 2002:a4a:980d:: with SMTP id y13mr8533332ooi.35.1591376535564;
 Fri, 05 Jun 2020 10:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200605142541.28412-1-amitx.k.singh@intel.com> <20200605142541.28412-3-amitx.k.singh@intel.com>
In-Reply-To: <20200605142541.28412-3-amitx.k.singh@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Jun 2020 10:02:03 -0700
Message-ID: <CABBYNZL_y5sBtWJFk-3b-oHRyq967ju=NNqn2i2+ySqQqe9-4A@mail.gmail.com>
Subject: Re: [PATCH] bluetoothctl:Add support for read characteristics value
To:     Amitsi5x <amitx.k.singh@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

On Fri, Jun 5, 2020 at 7:30 AM Amitsi5x <amitx.k.singh@intel.com> wrote:
>
> From: amit <amitx.k.singh@intel.com>
>
> Changes made to add support for read charateristic value
> by uuid in bluetoothctl.
>
> Signed-off-by: amit <amitx.k.singh@intel.com>
> ---
>  client/gatt.c            | 70 ++++++++++++++++++++++++++++++++
>  client/gatt.h            |  1 +
>  client/main.c            | 18 +++++++++
>  src/gatt-client.c        | 70 ++++++++++++++++++++++++++++++++
>  src/shared/gatt-client.c | 86 +++++++++++++++++++++++++++++++++++++++-
>  src/shared/gatt-client.h |  5 +++
>  6 files changed, 249 insertions(+), 1 deletion(-)
>
> diff --git a/client/gatt.c b/client/gatt.c
> index 53f875050..8c2844ed6 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -681,6 +681,76 @@ void gatt_read_attribute(GDBusProxy *proxy, int argc, char *argv[])
>         return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  }
>
> +static void charreadbyuuid_reply(DBusMessage *message, void *user_data)
> +{
> +       DBusError error;
> +       DBusMessageIter iter, array;
> +       uint8_t *value;
> +       int len;
> +
> +       dbus_error_init(&error);
> +
> +       if (dbus_set_error_from_message(&error, message) == TRUE) {
> +               bt_shell_printf("Failed to read: %s\n", error.name);
> +               dbus_error_free(&error);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       dbus_message_iter_init(message, &iter);
> +
> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
> +               bt_shell_printf("Invalid response to read\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       dbus_message_iter_recurse(&iter, &array);
> +       dbus_message_iter_get_fixed_array(&array, &value, &len);
> +
> +       if (len < 0) {
> +               bt_shell_printf("Unable to parse value\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bt_shell_hexdump(value, len);
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void charreadbyuuid_setup(DBusMessageIter *iter, void *user_data)
> +{
> +       char *uuid = user_data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
> +}
> +
> +static void charreadbyuuid_attribute(GDBusProxy *proxy, char *uuid)
> +{
> +       if (g_dbus_proxy_method_call(proxy, "CharReadByUUID", charreadbyuuid_setup, charreadbyuuid_reply,
> +                                               uuid, NULL) == FALSE) {
> +               bt_shell_printf("Failed to set uuid\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bt_shell_printf("Attempting to read service handle %s\n", g_dbus_proxy_get_path(proxy));
> +}
> +
> +void gatt_charreadbyuuid_attribute(GDBusProxy *proxy, int argc, char *argv[])
> +{
> +       const char *iface;
> +
> +       iface = g_dbus_proxy_get_interface(proxy);
> +
> +       if (!strcmp(iface, "org.bluez.GattCharacteristic1")) {
> +               charreadbyuuid_attribute(proxy, argv[1]);
> +               return;
> +       }
> +
> +       bt_shell_printf("Unable to read attribute %s\n",
> +                                               g_dbus_proxy_get_path(proxy));
> +
> +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +}
> +
>  static void charbyuuid_reply(DBusMessage *message, void *user_data)
>  {
>         DBusError error;
> diff --git a/client/gatt.h b/client/gatt.h
> index 692fb5758..8f96d8665 100644
> --- a/client/gatt.h
> +++ b/client/gatt.h
> @@ -35,6 +35,7 @@ GDBusProxy *gatt_select_attribute(GDBusProxy *parent, const char *path);
>  char *gatt_attribute_generator(const char *text, int state);
>  void gatt_servbyuuid_attribute(GDBusProxy *proxy, int argc, char *argv[]);
>  void gatt_charbyuuid_attribute(GDBusProxy *proxy, int argc, char *argv[]);
> +void gatt_charreadbyuuid_attribute(GDBusProxy *proxy, int argc, char *argv[]);
>  void gatt_read_attribute(GDBusProxy *proxy, int argc, char *argv[]);
>  void gatt_write_attribute(GDBusProxy *proxy, int argc, char *argv[]);
>  void gatt_notify_attribute(GDBusProxy *proxy, bool enable);
> diff --git a/client/main.c b/client/main.c
> index 10e64e17b..4dd1e593a 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2071,6 +2071,22 @@ static void cmd_attribute_info(int argc, char *argv[])
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> +static void cmd_char_read_by_uuid(int argc, char *argv[])
> +{
> +       GDBusProxy *proxy;
> +
> +       proxy = find_attribute(argc, argv);
> +
> +       set_default_attribute(proxy);
> +
> +       if (!default_attr) {
> +               bt_shell_printf("No attribute selected\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       gatt_charreadbyuuid_attribute(default_attr, argc, argv);
> +}
> +
>  static void cmd_char_by_uuid(int argc, char *argv[])
>  {
>         GDBusProxy *proxy;
> @@ -2718,6 +2734,8 @@ static const struct bt_shell_menu gatt_menu = {
>                                 "Discover Primary Services by UUID" },
>         { "char-by-uuid", "[UUID]", cmd_char_by_uuid,
>                                 "Discover Characteristic Services by UUID" },
> +       { "char-read-by-uuid", "[UUID]", cmd_char_read_by_uuid,
> +                               "Read Characteristic by UUID" },
>         { "select-attribute", "<attribute/UUID>",  cmd_select_attribute,
>                                 "Select attribute", attribute_generator },
>         { "attribute-info", "[attribute/UUID]",  cmd_attribute_info,
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index da811ea4f..cd6d6dfde 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -444,6 +444,27 @@ static struct async_dbus_op *async_dbus_op_new(DBusMessage *msg, void *data)
>         return op;
>  }
>
> +static struct async_dbus_op *fetch_char_read_by_uuid(struct bt_gatt_client *gatt,
> +                                       DBusMessage *msg,
> +                                       char *uuid,
> +                                       bt_gatt_client_char_by_uuid_callback_t callback,
> +                                       void *data)
> +{
> +       struct async_dbus_op *op;
> +
> +       op = async_dbus_op_new(msg, data);
> +       op->id = bt_gatt_client_char_read_by_uuid(gatt, uuid, callback,
> +                                               async_dbus_op_ref(op),
> +                                               async_dbus_op_unref);
> +
> +       if (op->id)
> +               return op;
> +
> +       async_dbus_op_free(op);
> +
> +       return NULL;
> +}
> +
>  static struct async_dbus_op *fetch_char_by_uuid(struct bt_gatt_client *gatt,
>                                         DBusMessage *msg,
>                                         char *uuid,
> @@ -972,6 +993,52 @@ fail:
>         chrc->read_op = NULL;
>  }
>
> +static void char_read_by_uuid_cb(bool success, uint8_t att_ecode, const uint8_t *value,
> +                                       uint16_t length, void *user_data)
> +{
> +       struct async_dbus_op *op = user_data;
> +       struct characteristic *opchar = op->data;
> +
> +       if (!success)
> +               goto fail;
> +
> +       async_dbus_op_reply(op, att_ecode, value, length);
> +
> +       return;
> +
> +fail:
> +       async_dbus_op_reply(op, att_ecode, NULL, 0);
> +
> +       opchar->type_op = NULL;
> +}
> +
> +static DBusMessage *char_read_by_uuid(DBusConnection *conn,
> +                                       DBusMessage *msg, void *user_data)
> +{
> +       struct characteristic *chardata = user_data;
> +       struct bt_gatt_client *gatt = chardata->service->client->gatt;
> +       DBusMessageIter iter;
> +
> +       char *uuid = 0;
> +
> +       if (!gatt)
> +               return btd_error_failed(msg, "Not connected");
> +
> +       dbus_message_iter_init(msg, &iter);
> +
> +       if (dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_STRING)
> +               dbus_message_iter_get_basic(&iter,&uuid);
> +       else
> +               return NULL;
> +
> +       chardata->type_op = fetch_char_read_by_uuid(gatt, msg,uuid, char_read_by_uuid_cb, chardata);
> +
> +       if (!chardata->type_op)
> +               return btd_error_failed(msg, "Failed to send read request");
> +
> +       return NULL;
> +}
> +
>  static void characteristic_by_uuid_cb(bool success, uint8_t att_ecode, const uint8_t *value,
>                                         uint16_t length, void *user_data)
>  {
> @@ -1786,6 +1853,9 @@ static const GDBusMethodTable characteristic_methods[] = {
>         { GDBUS_ASYNC_METHOD("CharByUUID", GDBUS_ARGS({ "options", "s" }),
>                                         GDBUS_ARGS({ "value", "ay" }),
>                                         chardiscover_by_uuid) },
> +       { GDBUS_ASYNC_METHOD("CharReadByUUID", GDBUS_ARGS({ "options", "s" }),
> +                                       GDBUS_ARGS({ "value", "ay" }),
> +                                       char_read_by_uuid) },

It would have helped if you had communicated that you would be looking
into add support for this type of operation, these procedures
obviously cannot be part of Characteristic interface since that is
only available after the discovery procedure then you can just lookup
internally in the cache. So this type of procedure will probably need
to be under a Device object and lets please agree on the documentation
first before we move forward.

>         { GDBUS_ASYNC_METHOD("ReadValue", GDBUS_ARGS({ "options", "a{sv}" }),
>                                         GDBUS_ARGS({ "value", "ay" }),
>                                         characteristic_read_value) },
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 8a696c77f..7c9d25ec3 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -2725,6 +2725,90 @@ done:
>                 op->callback(success, att_ecode, value, length, op->user_data);
>  }
>
> +unsigned int bt_gatt_client_char_read_by_uuid(struct bt_gatt_client *client,
> +                                               char *uuid,
> +                                               bt_gatt_client_char_by_uuid_callback_t callback,
> +                                               void *user_data,
> +                                               bt_gatt_client_destroy_func_t destroy)
> +{
> +       struct request *req;
> +       struct char_by_uuid_op *op;
> +       unsigned char *pdu;
> +       uint16_t len ;
> +       uint16_t start_handle = 0x0001;
> +       uint16_t end_handle = 0xffff;
> +       bt_uuid_t btuuid;
> +       uint8_t uuid128[16];
> +
> +       /* Length of pdu will be vary according to uuid type
> +       for 2 byte uuid total length  is 8 (start handle(2) + end handle(2)  + uuid(2))
> +       for 16 byte uuid total length  is 22 (start handle(2) + end handle(2)  + uuid(16))
> +       */
> +       uint16_t pdu_len_16bit_uuid = 6;
> +       uint16_t pdu_len_128bit_uuid = 20;
> +
> +       if (bt_string_to_uuid(&btuuid, uuid) < 0) {
> +               return 0;
> +       }
> +
> +       if (btuuid.type == BT_UUID16){
> +               pdu = (unsigned char *) malloc(pdu_len_16bit_uuid);
> +               len = pdu_len_16bit_uuid;
> +       } else {
> +               pdu = (unsigned char *) malloc(pdu_len_128bit_uuid);
> +               len = pdu_len_128bit_uuid;
> +       }
> +
> +       if (!client)
> +               return 0;
> +
> +       op = new0(struct char_by_uuid_op, 1);
> +       req = request_create(client);
> +       if (!req) {
> +               free(op);
> +               return 0;
> +       }
> +       if (!client)
> +               return 0;
> +
> +       op = new0(struct char_by_uuid_op, 1);
> +       req = request_create(client);
> +
> +       if (!req) {
> +               free(op);
> +               return 0;
> +       }
> +
> +       op->callback = callback;
> +       op->user_data = user_data;
> +       op->destroy = destroy;
> +       req->data = op;
> +       req->destroy = destroy_char_by_uuid_op;
> +
> +       put_le16(start_handle, pdu);
> +       put_le16(end_handle, pdu+2);
> +
> +       if (btuuid.type == BT_UUID16)
> +               put_le16(btuuid.value.u16, pdu+4);
> +       else {
> +               bswap_128(&btuuid.value.u128.data[0], &uuid128[0]);
> +               memcpy(pdu + 4, uuid128, 16);
> +       }
> +
> +       req->att_id = bt_att_send(client->att, BT_ATT_OP_READ_BY_TYPE_REQ,
> +                                                       pdu, len,
> +                                                       char_by_uuid_cb, req,
> +                                                       request_unref);
> +
> +       if (!req->att_id) {
> +               op->destroy = NULL;
> +               request_unref(req);
> +               return 0;
> +       }
> +
> +       return req->id;
> +}
> +
>  unsigned int bt_gatt_client_char_by_uuid(struct bt_gatt_client *client,
>                                                char *uuid,
>                                                bt_gatt_client_char_by_uuid_callback_t callback,
> @@ -2754,7 +2838,7 @@ unsigned int bt_gatt_client_char_by_uuid(struct bt_gatt_client *client,
>         if (btuuid.type == BT_UUID16){
>                 pdu = (unsigned char *) malloc(pdu_len_16bit_uuid);
>                 len = pdu_len_16bit_uuid;
> -       } else {
> +       }else {
>                 pdu = (unsigned char *) malloc(pdu_len_128bit_uuid);
>                 len = pdu_len_128bit_uuid;
>         }
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index f5d5169ce..50859ce52 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -97,6 +97,11 @@ unsigned int bt_gatt_client_char_by_uuid(struct bt_gatt_client *client,
>                                         bt_gatt_client_read_callback_t callback,
>                                         void *user_data,
>                                         bt_gatt_client_destroy_func_t destroy);
> +unsigned int bt_gatt_client_char_read_by_uuid(struct bt_gatt_client *client,
> +                                       char *uuid,
> +                                       bt_gatt_client_read_callback_t callback,
> +                                       void *user_data,
> +                                       bt_gatt_client_destroy_func_t destroy);
>  unsigned int bt_gatt_client_read_value(struct bt_gatt_client *client,
>                                         uint16_t value_handle,
>                                         bt_gatt_client_read_callback_t callback,
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
