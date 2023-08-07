Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7692C001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 23:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjHGXOc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 19:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHGXOb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 19:14:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB03172B
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 16:14:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe55d70973so5468528e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Aug 2023 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691450061; x=1692054861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj3EoWojRb0zIv3+DwfqbNZ7Ms0bSwEv37qH6R3gxF0=;
        b=leMi/vI6VdzKCBsYvShj0tj6BcRh4xCaOHpQy6+wQWevW9VvXuVUbRq7RwuMicWr0O
         j5Wc+elNhKpXo2sNfuV53KbRUOkUG+0TAgFqQjXLfp7Jk6PjXGugMgDc+Ab6vgYMrfJ2
         86qAzd1RIP3wSAk1JcYfs4lnwdk5O5X09xYa6tCyH8Y0YJnxGcLL5KIe2XDtZY1+MtkR
         0iWhYdglDL0nnDwsE7Jaz1W07RpT8qZicxi1hJFfzx5RYXL3okK1LDHo4HyUkhct7KoO
         DBwO4mSfsrT1GRrGZH/Xpf+MCOQGcfbuoXfada69ZloPns7HyqktUnaqTtMSYlRc1VKx
         hujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691450061; x=1692054861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nj3EoWojRb0zIv3+DwfqbNZ7Ms0bSwEv37qH6R3gxF0=;
        b=HC2NerfApaOrLjXrt/5ZmS7tmbAkGL1y442pTsFZ2kRAXoq1tBzuRidDwPEwaI5QJ0
         WlClCoFCq5EMEsMHDZzr0DP4eIM6wB52Nx9viM9SmThKDoAeB0BIk8haAl6doO92jSlm
         1XuHKbpdLrfWysQw8Dko3Ku/Wso9zkxTTTCFiFfndNNOyJy1ykAjRQpHCnI26kKRrexz
         atZSuI1xYYXqz3yszMdk6OSgFODy1erS+5a0g+H25dnU6WxiGeShqk6XB8iLGDLOvZ3S
         8ShExZmIKNgRWEbaDROnwM5M9rNFpidLwDlwxeHmWkEc8AcEq4pRy5jSvMTVjbognqD5
         n9bA==
X-Gm-Message-State: AOJu0YwAJH69SdJ3L3iQavpHB/LgmmROL3XlGbLkDrYtBk1eGVjik1u9
        r6qUTivDub8Aohhm6JExnn4fWn9d7mDKTMLWoRaC/FKt
X-Google-Smtp-Source: AGHT+IH1InM0s5x2UELZY2wdbzrqeBeVMYxkutvPC62CoTMFJ4TPuFwTDXLroFMw/V1+GTxTWPrFddKck5PWKwf0R1c=
X-Received: by 2002:a05:6512:39c3:b0:4fe:28cd:b3f with SMTP id
 k3-20020a05651239c300b004fe28cd0b3fmr2468177lfu.5.1691450060823; Mon, 07 Aug
 2023 16:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230803072011.191449-1-mahesh.talewad@nxp.com> <20230803072011.191449-4-mahesh.talewad@nxp.com>
In-Reply-To: <20230803072011.191449-4-mahesh.talewad@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Aug 2023 16:14:08 -0700
Message-ID: <CABBYNZLcPQLyOWf36PgwDzXiZaKeDHeNtW4WDD=Ts3qV39qVhA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 3/3] unit/test-micp: Add unit test code for
 testing MICP-MICS
To:     Mahesh Talewad <mahesh.talewad@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mahesh,

On Thu, Aug 3, 2023 at 12:21=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp.=
com> wrote:
>
> -Implemented UNIT Testcases for MICS[test-micp.c] and MICP[test-mics.c].

Not sure why you had decided to go with 2 files instead of one, but
you can still test both server and client and possibly share some
definition between the 2 sides.

> ---
>  Makefile.am       |  13 ++
>  src/shared/micp.c |  26 ++++
>  src/shared/micp.h |   2 +
>  unit/test-micp.c  | 357 ++++++++++++++++++++++++++++++++++++++++++++++
>  unit/test-mics.c  | 290 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 688 insertions(+)
>  create mode 100644 unit/test-micp.c
>  create mode 100644 unit/test-mics.c
>
> diff --git a/Makefile.am b/Makefile.am
> index 6f40f2a74..cde55bebf 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -573,6 +573,19 @@ unit_test_gattrib_LDADD =3D src/libshared-glib.la \
>                                 lib/libbluetooth-internal.la \
>                                 $(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt
>
> +unit_tests +=3D unit/test-micp
> +
> +unit_test_micp_SOURCES =3D unit/test-micp.c
> +
> +unit_test_micp_LDADD =3D src/libshared-glib.la \
> +                       lib/libbluetooth-internal.la $(GLIB_LIBS)
> +
> +unit_tests +=3D unit/test-mics
> +
> +unit_test_mics_SOURCES =3D unit/test-mics.c
> +unit_test_mics_LDADD =3D src/libshared-glib.la \
> +                               lib/libbluetooth-internal.la $(GLIB_LIBS)
> +
>  unit_tests +=3D unit/test-bap
>
>  unit_test_bap_SOURCES =3D unit/test-bap.c
> diff --git a/src/shared/micp.c b/src/shared/micp.c
> index c5b814d98..bb71999be 100644
> --- a/src/shared/micp.c
> +++ b/src/shared/micp.c
> @@ -1042,3 +1042,29 @@ void micp_char_write_value(uint16_t handle)
>
>  }
>  #endif /*MICP_MICS_PTS_FLAG*/
> +
> +static void micp_write_cb1(bool success, uint8_t att_ecode, void *user_d=
ata)
> +{
> +       if (success)
> +               printf("MICP Write successful\n");
> +       else
> +               printf("\nWrite failed: 0x%02x\n", att_ecode);
> +}
> +
> +void micp_write_value(struct bt_micp *micp, void *user_data)
> +{
> +       struct bt_mics *mics =3D micp_get_mics(micp);
> +       uint16_t        value_handle;
> +       int ret;
> +       const uint16_t value =3D 0x0001;
> +
> +       gatt_db_attribute_get_char_data(mics->ms, NULL, &value_handle,
> +                                                       NULL, NULL, NULL)=
;
> +
> +       printf("%s handle: %x\n", __func__, value_handle);
> +       ret =3D bt_gatt_client_write_value(micp->client, value_handle,
> +               (void *)&value, sizeof(value), micp_write_cb1, NULL, NULL=
);
> +       if (!ret)
> +               printf("bt_gatt_client_write_value() : Write FAILED");
> +
> +}

I'd expect you to fixup the original commit when introducing changes
to the shared library, that said I am not sure what this is for?

> diff --git a/src/shared/micp.h b/src/shared/micp.h
> index 4a9807ed4..f20d46c9c 100644
> --- a/src/shared/micp.h
> +++ b/src/shared/micp.h
> @@ -52,3 +52,5 @@ void micp_discover_mute_char(void);
>  void mics_mute_char_read(uint16_t handle);
>  void micp_char_write_value(uint16_t handle);
>  #endif /*MICP_MICS_PTS_FLAG*/
> +
> +void micp_write_value(struct bt_micp *micp, void *user_data);

This should probably start with bt_ prefix, also I do expect that
anything that is needed by the tests shall also be available to the
likes of MediaTransport.Volume, but I haven't found any change
handling the Volume changes.

> diff --git a/unit/test-micp.c b/unit/test-micp.c
> new file mode 100644
> index 000000000..3db32a4f7
> --- /dev/null
> +++ b/unit/test-micp.c
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2023  NXP Semiconductors. All rights reserved.
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +#include <fcntl.h>
> +
> +
> +#include <glib.h>
> +
> +#include "lib/bluetooth.h"
> +#include "lib/uuid.h"
> +#include "src/shared/util.h"
> +#include "src/shared/tester.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/shared/gatt-server.h"
> +#include "src/shared/micp.h"
> +
> +struct test_data {
> +       struct gatt_db *db;
> +       struct bt_micp *micp;
> +       struct bt_gatt_server *server;
> +       struct bt_gatt_client *client;
> +       struct queue *ccc_states;
> +       size_t iovcnt;
> +       struct iovec *iov;
> +       struct test_config *cfg;
> +};
> +
> +struct ccc_state {
> +       uint16_t handle;
> +       uint16_t value;
> +};
> +
> +struct notify {
> +       uint16_t handle, ccc_handle;
> +       uint8_t *value;
> +       uint16_t len;
> +       bt_gatt_server_conf_func_t conf;
> +       void *user_data;
> +};
> +
> +#define iov_data(args...) ((const struct iovec[]) { args })
> +
> +#define define_test(name, function, _cfg, args...)             \
> +       do {                                                    \
> +               const struct iovec iov[] =3D { args };            \
> +               static struct test_data data;                   \
> +               data.cfg =3D _cfg;                                \
> +               data.iovcnt =3D ARRAY_SIZE(iov_data(args));       \
> +               data.iov =3D util_iov_dup(iov, ARRAY_SIZE(iov_data(args))=
); \
> +               tester_add(name, &data, NULL, function, \
> +                               test_teardown);                 \
> +       } while (0)
> +
> +static void print_debug(const char *str, void *user_data)
> +{
> +       const char *prefix =3D user_data;
> +
> +       if (tester_use_debug())
> +               tester_debug("%s%s", prefix, str);
> +}
> +
> +static void test_teardown(const void *user_data)
> +{
> +       struct test_data *data =3D (void *)user_data;
> +
> +       bt_micp_unref(data->micp);
> +       bt_gatt_server_unref(data->server);
> +       util_iov_free(data->iov, data->iovcnt);
> +       gatt_db_unref(data->db);
> +
> +       queue_destroy(data->ccc_states, free);
> +
> +       tester_teardown_complete();
> +}
> +
> +static void test_complete_cb(const void *user_data)
> +{
> +       tester_test_passed();
> +}
> +
> +static bool ccc_state_match(const void *a, const void *b)
> +{
> +       const struct ccc_state *ccc =3D a;
> +       uint16_t handle =3D PTR_TO_UINT(b);
> +
> +       return ccc->handle =3D=3D handle;
> +}
> +
> +static struct ccc_state *find_ccc_state(struct test_data *data,
> +                               uint16_t handle)
> +{
> +       return queue_find(data->ccc_states, ccc_state_match,
> +                               UINT_TO_PTR(handle));
> +}
> +
> +static struct ccc_state *get_ccc_state(struct test_data *data, uint16_t =
handle)
> +{
> +       struct ccc_state *ccc;
> +
> +       ccc =3D find_ccc_state(data, handle);
> +       if (ccc)
> +               return ccc;
> +
> +       ccc =3D new0(struct ccc_state, 1);
> +       ccc->handle =3D handle;
> +       queue_push_tail(data->ccc_states, ccc);
> +
> +       return ccc;
> +}
> +
> +static void gatt_notify_cb(struct gatt_db_attribute *attrib,
> +                                       struct gatt_db_attribute *ccc,
> +                                       const uint8_t *value, size_t len,
> +                                       struct bt_att *att, void *user_da=
ta)
> +{
> +       struct test_data *data =3D user_data;
> +       struct notify notify;
> +
> +       memset(&notify, 0, sizeof(notify));
> +
> +       notify.handle =3D gatt_db_attribute_get_handle(attrib);
> +       notify.ccc_handle =3D gatt_db_attribute_get_handle(ccc);
> +       notify.value =3D (void *) value;
> +       notify.len =3D len;
> +
> +       printf("%s: notify.value:%d notify->len:%d\n", __func__,
> +               (int)*(notify.value), notify.len);
> +       if (!bt_gatt_server_send_notification(data->server,
> +                       notify.handle, notify.value,
> +                       notify.len, false))
> +               printf("%s: Failed to send notification\n", __func__);
> +}
> +
> +static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       uint8_t opcode, struct bt_att *at=
t,
> +                                       void *user_data)
> +{
> +       struct test_data *data =3D user_data;
> +       struct ccc_state *ccc;
> +       uint16_t handle;
> +       uint8_t ecode =3D 0;
> +       const uint8_t *value =3D NULL;
> +       size_t len =3D 0;
> +
> +       handle =3D gatt_db_attribute_get_handle(attrib);
> +
> +       ccc =3D get_ccc_state(data, handle);
> +       if (!ccc) {
> +               ecode =3D BT_ATT_ERROR_UNLIKELY;
> +               goto done;
> +       }
> +
> +       len =3D sizeof(ccc->value);
> +       value =3D (void *) &ccc->value;
> +
> +done:
> +       gatt_db_attribute_read_result(attrib, id, ecode, value, len);
> +}
> +
> +static void test_server(const void *user_data)
> +{
> +       struct test_data *data =3D (void *)user_data;
> +       struct bt_att *att;
> +       struct io *io;
> +
> +       io =3D tester_setup_io(data->iov, data->iovcnt);
> +       g_assert(io);
> +
> +       tester_io_set_complete_func(test_complete_cb);
> +
> +       att =3D bt_att_new(io_get_fd(io), false);
> +       g_assert(att);
> +
> +       bt_att_set_debug(att, BT_ATT_DEBUG, print_debug, "bt_att:", NULL)=
;
> +
> +       data->db =3D gatt_db_new();
> +       g_assert(data->db);
> +
> +       gatt_db_ccc_register(data->db, gatt_ccc_read_cb, NULL,
> +                                       gatt_notify_cb, data);
> +
> +       data->micp =3D bt_micp_new(data->db, NULL);
> +       g_assert(data->micp);
> +
> +       data->server =3D bt_gatt_server_new(data->db, att, 64, 0);
> +       g_assert(data->server);
> +
> +       bt_gatt_server_set_debug(data->server, print_debug, "bt_gatt_serv=
er:",
> +                                       NULL);
> +
> +       data->ccc_states =3D queue_new();
> +
> +       tester_io_send();
> +
> +       bt_att_unref(att);
> +}
> +
> +#define EXCHANGE_MTU   IOV_DATA(0x02, 0x40, 0x00), \
> +                                               IOV_DATA(0x03, 0x40, 0x00=
)
> +
> +#define        MICS_MUTE_WRITE_VAL_00 \
> +                       IOV_DATA(0x12, 0x03, 0x00, 0x00), \
> +                       IOV_DATA(0x13)
> +
> +#define        MICS_MUTE_WRITE_VAL_01 \
> +                       IOV_DATA(0x12, 0x03, 0x00, 0x01), \
> +                       IOV_DATA(0x13)
> +
> +#define        MICS_MUTE_READ \
> +                       IOV_DATA(0x0a, 0x03, 0x00), \
> +                       IOV_DATA(0x0b, 0x01)
> +
> +#define DISCOVER_PRIM_SERV_NOTIF \
> +               IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28), \
> +               IOV_DATA(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x4d, 0x18),=
 \
> +               IOV_DATA(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28), \
> +               IOV_DATA(0x01, 0x10, 0x05, 0x00, 0x0a)
> +
> +/* ATT: Read By Type Request (0x08) len 6
> + *   Handle range: 0x0001-0x0009
> + *   Attribute type: Characteristic (0x2803)
> + * ATT: Read By Type Response (0x09) len 22
> + * Attribute data length: 7
> + *   Handle: 0x0002
> + *   Value: 1a0300c82b
> + *   Properties: 0x1a
> + *   Value Handle: 0x0003
> + *   Value UUID: Mute (0x2bc3)
> + */
> +#define DISC_MICS_CHAR_1 \
> +       IOV_DATA(0x08, 0x01, 0x00, 0x05, 0x00, 0x03, 0x28), \
> +       IOV_DATA(0x09, 0x07, \
> +               0x02, 0x00, 0x1a, 0x03, 0x00, 0xc3, 0x2b), \
> +       IOV_DATA(0x08, 0x05, 0x00, 0x05, 0x00, 0x03, 0x28), \
> +       IOV_DATA(0x01, 0x08, 0x05, 0x00, 0x0a)
> +
> +
> +#define MICS_FIND_BY_TYPE_VALUE \
> +       IOV_DATA(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x4d, 0x18), \
> +       IOV_DATA(0x07, 0x01, 0x00, 0x04, 0x00), \
> +       IOV_DATA(0x06, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28, 0x4d, 0x18), \
> +       IOV_DATA(0x01, 0x06, 0x05, 0x00, 0x0a)
> +
> +#define DISC_MICS_CHAR_AFTER_TYPE \
> +       IOV_DATA(0x08, 0x01, 0x00, 0x05, 0x00, 0x03, 0x28), \
> +       IOV_DATA(0x09, 0x07, \
> +               0x02, 0x00, 0x1a, 0x03, 0x00, 0xc3, 0x2b), \
> +       IOV_DATA(0x08, 0x03, 0x00, 0x05, 0x00, 0x03, 0x28), \
> +       IOV_DATA(0x01, 0x08, 0x03, 0x00, 0x0a)
> +
> +#define MICS_WRITE_CCD \
> +       IOV_DATA(0x12, 0x04, 0x00, 0x00, 0x00), \
> +       IOV_DATA(0x13), \
> +       IOV_DATA(0x12, 0x04, 0x00, 0x01, 0x00), \
> +       IOV_DATA(0x13)
> +
> +#define MICS_FIND_INFO \
> +       IOV_DATA(0x04, 0x04, 0x00, 0x05, 0x00), \
> +       IOV_DATA(0x05, 0x01, 0x04, 0x00, 0x02, 0x29), \
> +       IOV_DATA(0x04, 0x05, 0x00, 0x05, 0x00), \
> +       IOV_DATA(0x01, 0x04, 0x05, 0x00, 0x0a)
> +
> +#define MICS_SR_SPN_BV_01_C \
> +                       EXCHANGE_MTU, \
> +                       DISCOVER_PRIM_SERV_NOTIF, \
> +                       DISC_MICS_CHAR_1, \
> +                       MICS_FIND_BY_TYPE_VALUE, \
> +                       DISC_MICS_CHAR_AFTER_TYPE, \
> +                       MICS_FIND_INFO, \
> +                       MICS_WRITE_CCD, \
> +                       IOV_DATA(0x0a, 0x03, 0x00), \
> +                       IOV_DATA(0x0b, 0x01), \
> +                       MICS_MUTE_WRITE_VAL_00, \
> +                       IOV_DATA(0x1b, 0x03, 0x00, 0x00), \
> +                       MICS_MUTE_WRITE_VAL_01, \
> +                       IOV_DATA(0x1b, 0x03, 0x00, 0x01), \
> +                       IOV_DATA(0x0a, 0x03, 0x00), \
> +                       IOV_DATA(0x0b, 0x01)
> +
> +#define MICS_SR_SGGIT_SER_BV_01_C \
> +                                               EXCHANGE_MTU, \
> +                                               DISCOVER_PRIM_SERV_NOTIF,=
 \
> +                                               MICS_FIND_BY_TYPE_VALUE
> +
> +#define MICS_SR_SGGIT_CHA_BV_01_C \
> +                                               EXCHANGE_MTU, \
> +                                               DISCOVER_PRIM_SERV_NOTIF,=
 \
> +                                               MICS_FIND_BY_TYPE_VALUE, =
\
> +                                               DISC_MICS_CHAR_AFTER_TYPE
> +
> +#define MICS_WRITE_MUTE_CHAR_INVALID \
> +                       IOV_DATA(0x12, 0x03, 0x00, 0x02), \
> +                       IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x13), \
> +                       IOV_DATA(0x12, 0x03, 0x00, 0x05), \
> +                       IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x13)
> +
> +#define MICS_SR_SPE_BI_1_C     \
> +                                               EXCHANGE_MTU, \
> +                                               DISCOVER_PRIM_SERV_NOTIF,=
 \
> +                                               MICS_FIND_BY_TYPE_VALUE, =
\
> +                                               MICS_WRITE_MUTE_CHAR_INVA=
LID
> +
> +#define        MICS_MUTE_READ_INVALID \
> +                       IOV_DATA(0x0a, 0x03, 0x00), \
> +                       IOV_DATA(0x0b, 0x02)
> +
> +#define        MICS_MUTE_WRITE_1 \
> +                       IOV_DATA(0x12, 0x03, 0x00, 0x01), \
> +                       IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x80)
> +
> +#define        MICS_MUTE_WRITE_0 \
> +                       IOV_DATA(0x12, 0x03, 0x00, 0x00), \
> +                       IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x80)
> +
> +#define MICS_SR_SPE_BI_02_C    \
> +                                               EXCHANGE_MTU, \
> +                                               DISCOVER_PRIM_SERV_NOTIF,=
 \
> +                                               MICS_FIND_BY_TYPE_VALUE, =
\
> +                                               MICS_MUTE_READ_INVALID, \
> +                                               MICS_MUTE_WRITE_0, \
> +                                               MICS_MUTE_WRITE_1
> +
> +int main(int argc, char *argv[])
> +{
> +
> +       tester_init(&argc, &argv);
> +
> +       define_test("MICS/SR/SGGIT/SER/BV-01-C", test_server, NULL,
> +                                       MICS_SR_SGGIT_SER_BV_01_C);
> +       define_test("MICS/SR/SGGIT/CHA/BV-01-C", test_server, NULL,
> +                                       MICS_SR_SGGIT_CHA_BV_01_C);
> +       define_test("MICS/SR/SPE/BI-01-C", test_server, NULL,
> +                                       MICS_SR_SPE_BI_1_C);
> +       define_test("MICS/SR/SPE/BI-02-C", test_server, NULL,
> +                                       MICS_SR_SPE_BI_02_C);
> +       define_test("MICS/SR/SPN/BV-01-C", test_server, NULL,
> +                                       MICS_SR_SPN_BV_01_C);
> +
> +       return tester_run();
> +}
> diff --git a/unit/test-mics.c b/unit/test-mics.c
> new file mode 100644
> index 000000000..fe84fb02d
> --- /dev/null
> +++ b/unit/test-mics.c
> @@ -0,0 +1,290 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2023  NXP Semiconductors. All rights reserved.
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +#include <fcntl.h>
> +
> +
> +#include <glib.h>
> +
> +#include "lib/bluetooth.h"
> +#include "lib/uuid.h"
> +#include "btio/btio.h"
> +#include "src/shared/util.h"
> +#include "src/shared/tester.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/shared/gatt-helpers.h"
> +#include "src/shared/micp.h"
> +
> +struct test_data {
> +       struct gatt_db *db;
> +       struct bt_micp *micp;
> +       struct bt_gatt_client *client;
> +       size_t iovcnt;
> +       struct iovec *iov;
> +       struct test_config *cfg;
> +};
> +
> +struct db_attribute_micp_test_data {
> +       struct gatt_db_attribute *match;
> +       bool found;
> +};
> +
> +#define MICP_GATT_CLIENT_MTU   64
> +#define iov_data(args...) ((const struct iovec[]) { args })
> +
> +#define define_test(name, function, _cfg, args...)             \
> +       do {                                                    \
> +               const struct iovec iov[] =3D { args };            \
> +               static struct test_data data;                   \
> +               data.cfg =3D _cfg;                                \
> +               data.iovcnt =3D ARRAY_SIZE(iov_data(args));       \
> +               data.iov =3D util_iov_dup(iov, ARRAY_SIZE(iov_data(args))=
); \
> +               tester_add(name, &data, test_setup, function,   \
> +                               test_teardown);                 \
> +       } while (0)
> +
> +static void print_debug(const char *str, void *user_data)
> +{
> +       const char *prefix =3D user_data;
> +
> +       if (tester_use_debug())
> +               tester_debug("%s %s", prefix, str);
> +}
> +
> +static void test_teardown(const void *user_data)
> +{
> +       struct test_data *data =3D (void *)user_data;
> +
> +       bt_gatt_client_unref(data->client);
> +       util_iov_free(data->iov, data->iovcnt);
> +       gatt_db_unref(data->db);
> +
> +       tester_teardown_complete();
> +}
> +
> +static void test_complete_cb(const void *user_data)
> +{
> +       tester_test_passed();
> +}
> +
> +static void client_ready_cb(bool success, uint8_t att_ecode, void *user_=
data)
> +{
> +
> +       if (!success)
> +               tester_setup_failed();
> +       else
> +               tester_setup_complete();
> +}
> +
> +static void micp_ready(struct bt_micp *micp, void *user_data)
> +{
> +       micp_write_value(micp, user_data);
> +}
> +
> +static void test_client(const void *user_data)
> +{
> +       struct test_data *data =3D (void *)user_data;
> +       struct io *io;
> +
> +       io =3D tester_setup_io(data->iov, data->iovcnt);
> +       g_assert(io);
> +
> +       tester_io_set_complete_func(test_complete_cb);
> +
> +       data->db =3D gatt_db_new();
> +       g_assert(data->db);
> +
> +       data->micp =3D bt_micp_new(data->db, bt_gatt_client_get_db(data->=
client));
> +       g_assert(data->micp);
> +
> +       bt_micp_set_debug(data->micp, print_debug, "bt_mip: ", NULL);
> +
> +       bt_micp_ready_register(data->micp, micp_ready, data, NULL);
> +
> +       bt_micp_attach(data->micp, data->client);
> +}
> +
> +       /* ATT: Exchange MTU Response (0x03) len 2
> +        *   Server RX MTU: 64
> +        */
> +       /* ATT: Exchange MTU Request (0x02) len 2
> +        *    Client RX MTU: 64
> +        */
> +#define ATT_EXCHANGE_MTU       IOV_DATA(0x02, 0x40, 0x00), \
> +                       IOV_DATA(0x03, 0x40, 0x00)
> +
> +/*
> + *      ATT: Read By Type Request (0x08) len 6
> + *        Handle range: 0x0001-0xffff
> + *        Attribute type: Server Supported Features (0x2b3a)
> + */
> +#define MICP_READ_SR_FEATURE   IOV_DATA(0x08, 0x01, 0x00, 0Xff, 0xff, \
> +                       0x3a, 0x2b), \
> +                       IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
> +
> +       /*
> +        * ATT: Read By Group Type Request (0x10) len 6
> +        *   Handle range: 0x0001-0xffff
> +        *   Attribute group type: Primary Service (0x2800)
> +        */
> +
> +/*
> + *     ATT: Read By Group Type Response (0x11) len 7
> + *        Attribute data length: 6
> + *        Attribute group list: 1 entry
> + *        Handle range: 0x00a0-0x00a4
> + *        UUID: Microphone Control (0x184d)
> + */
> +#define MICP_READ_GROUP_TYPE   \
> +                       IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28=
), \
> +                       IOV_DATA(0x11, 0x06, \
> +                               0x01, 0x00, 0x04, 0x00, 0x4d, 0x18), \
> +                       IOV_DATA(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28=
), \
> +                       IOV_DATA(0x01, 0x10, 0x06, 0x00, 0x0a)
> +
> +       /* ATT: Read By Group Type Request (0x10) len 6
> +        *   Handle range: 0x0001-0xffff
> +        *   Attribute group type: Secondary Service (0x2801)
> +        */
> +       /* ATT: Error Response (0x01) len 4
> +        *   Read By Group Type Request (0x10)
> +        *   Handle: 0x0001
> +        *   Error: Attribute Not Found (0x0a)08 01 00 05 00 02 28
> +        */
> +#define MICP_READ_REQ_SECOND_SERVICE   \
> +                       IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28=
), \
> +                       IOV_DATA(0x01, 0x10, 0x01, 0x00, 0x0a)
> +
> +#define MICP_READ_REQ_INCLUDE_SERVICE  \
> +                       IOV_DATA(0x08, 0x01, 0x00, 0x04, 0x00, 0x02, 0x28=
), \
> +                       IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
> +
> +       /* ATT: Read By Type Request (0x08) len 6
> +        *   Handle range: 0x0001-0x0004
> +        *   Attribute type: Characteristic (0x2803)
> +        */
> +
> +/*      ATT: Find Information Request (0x04) len 4
> + *        Handle range: 0x0004-0x0004
> + */
> +#define        MICP_FIND_INFO_REQ      \
> +                       IOV_DATA(0x04, 0x04, 0x00, 0x04, 0x00), \
> +                       IOV_DATA(0x05, 0x01, 0x04, 0x00, 0x02, 0x29)
> +
> +/*
> + *      ATT: Read By Type Request (0x08) len 6
> + *        Handle range: 0x0001-0x0004
> + *        Attribute type: Characteristic (0x2803)
> + */
> +#define        MICP_READ_REQ_CHAR      \
> +                       IOV_DATA(0x08, 0x01, 0x00, 0x04, 0x00, 0x03, 0x28=
),\
> +                       IOV_DATA(0x09, 0x07, \
> +                       0x02, 0x00, 0x1a, 0x03, 0x00, 0xc3, 0x2b), \
> +                       IOV_DATA(0x08, 0x03, 0x00, 0x04, 0x00, 0x03, 0x28=
), \
> +                       IOV_DATA(0x01, 0x08, 0x04, 0x00, 0x0a)
> +
> +#define        MICS_MUTE_READ \
> +                       IOV_DATA(0x0a, 0x03, 0x00), \
> +                       IOV_DATA(0x0b, 0x01)
> +
> +#define        MICS_EN_MUTE_DISCPTR    \
> +                       IOV_DATA(0x12, 0x04, 0x00, 0x01, 0x00), \
> +                       IOV_DATA(0x13)
> +
> +#define        MICS_MUTE_WRITE \
> +                       IOV_DATA(0x12, 0x03, 0x00, 0x01),\
> +                       IOV_DATA(0x13)
> +
> +#define MICP_CL_CGGIT_SER_BV_01_C \
> +                       MICS_MUTE_READ, \
> +                       MICS_EN_MUTE_DISCPTR, \
> +                       IOV_DATA(0x12, 0x03, 0x00, 0x01, 0x00), \
> +                       IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x013)
> +
> +#define        MICP_CL_CGGIT_CHA_BV_01_C       \
> +                       MICS_MUTE_READ, \
> +                       MICS_EN_MUTE_DISCPTR, \
> +                       IOV_DATA(0x12, 0x03, 0x00, 0x06, 0x00), \
> +                       IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x013), \
> +                       MICS_MUTE_READ
> +
> +#define MICP_CL_SPE_BI_01_C    \
> +                       MICS_MUTE_READ, \
> +                       MICS_EN_MUTE_DISCPTR, \
> +                       IOV_DATA(0x12, 0x03, 0x00, 0x01, 0x00), \
> +                       IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x80)
> +
> +/* GATT Discover All procedure */
> +static const struct iovec setup_data[] =3D {
> +                               ATT_EXCHANGE_MTU,
> +                               MICP_READ_SR_FEATURE,
> +                               MICP_READ_GROUP_TYPE,
> +                               MICP_READ_REQ_SECOND_SERVICE,
> +                               MICP_READ_REQ_INCLUDE_SERVICE,
> +                               MICP_READ_REQ_CHAR,
> +                               MICP_FIND_INFO_REQ
> +};
> +
> +static void test_setup(const void *user_data)
> +{
> +       struct test_data *data =3D (void *)user_data;
> +       struct bt_att *att;
> +       struct gatt_db *db;
> +       struct io *io;
> +
> +       io =3D tester_setup_io(setup_data, ARRAY_SIZE(setup_data));
> +       g_assert(io);
> +
> +       att =3D bt_att_new(io_get_fd(io), false);
> +       g_assert(att);
> +
> +       bt_att_set_debug(att, BT_ATT_DEBUG, print_debug, "bt_att:", NULL)=
;
> +
> +       db =3D gatt_db_new();
> +       g_assert(db);
> +
> +
> +       data->client =3D bt_gatt_client_new(db, att, MICP_GATT_CLIENT_MTU=
, 0);
> +       g_assert(data->client);
> +
> +       bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_clie=
nt:",
> +                                               NULL);
> +
> +       bt_gatt_client_ready_register(data->client, client_ready_cb, data=
,
> +                                               NULL);
> +
> +       bt_att_unref(att);
> +       gatt_db_unref(db);
> +}
> +
> +
> +int main(int argc, char *argv[])
> +{
> +
> +       tester_init(&argc, &argv);
> +
> +       define_test("MICP/CL/CGGIT/SER/BV-01-C", test_client, NULL,
> +                                       MICS_MUTE_READ);
> +       define_test("MICP/CL/CGGIT/CHA/BV-01-C", test_client, NULL,
> +                                       MICP_CL_CGGIT_SER_BV_01_C);
> +       define_test("MICP/CL/SPE/BI-01-C", test_client, NULL,
> +                                       MICP_CL_SPE_BI_01_C);
> +
> +       return tester_run();
> +}
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
