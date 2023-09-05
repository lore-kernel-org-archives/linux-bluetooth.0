Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F65CA0FF7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 18:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjIESmP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 14:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjIESmO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 14:42:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B5D184
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 11:41:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-500b66f8b27so4768896e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Sep 2023 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693939229; x=1694544029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umaS/wfb2xeDrthu/zEVKRqiktR8vRpzivDeHXYRUn4=;
        b=aTPQANNuVJLIV2cA1zEY1gnmD2N97wdRreKaGHJSD4iRZxXJqLVJBljLsLKxK5uVWE
         vh1C5rvVnirzS++C32n06qktqi3iy/dVeCIfQTE83OfeLYc8vVuxtpS2kTkbKhDdcS63
         wooDCreoYDMrssWFUcl1rPU+2diDPGIGNLZ2q807zX8I1j0S388mpNH7HRxDBuhpBS/j
         Cf92ilUA5HyhlQ9rc3KUYumPCiad0kMkYm+ksqKL8gZabPtA54J921sCKOzPXcGi7B0d
         6V7YkuPWong3JFJWoB/DK4ovoods4ouPwBKFn0QZJoQv+6NY551QNEGlsiDzRbTmQWRk
         Alwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693939229; x=1694544029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umaS/wfb2xeDrthu/zEVKRqiktR8vRpzivDeHXYRUn4=;
        b=E1IOk3oUMYjyicg3Df6/hFuGVxd/Bjr5nviKFVRHA9+Q+N49/5Yovxb4JqRA7BdfXa
         ubmLSQSh/s+dmHSS3kynyT05BZt0EIUJsjaMNNif7CVDSY6zaYKBvXvBDspGqK6xKmiL
         8zc7ds+DhW/e736NKSH/k/p7e7KOjq1q+BrLDkWVqVwW6kVJLHYY+izSSuItC3CJJK21
         MbWcS6dJDEqdcL4ruGi7rDNMjCGb9GmQYg6podnymvCTK0uec+etNHYEjL30hlpzZ3ui
         /xJ6HL7bHmh29OaY/59p9Wo1302dc28jTkHQKiNRP30Tjud7dN30qtA0LoBQcGE7ItBt
         pOXA==
X-Gm-Message-State: AOJu0Yzhr8cmihNL5pJKKieSGr7+TWCQa2Nz0mewsMbcjGkFa7W/CX4n
        1T/SNgKo7vx2X2THlRZ9KVdNFiJnvzWMnuiKknA2z9xCngU=
X-Google-Smtp-Source: AGHT+IHHdHssYgPOLuywJq95UBWPvqUlBxmx+znqwn90RYZVWT2KtdLHaYYJv+cA9cL19USpHNX4ZVzNJvvCgnUZdJg=
X-Received: by 2002:a2e:7204:0:b0:2bc:fb79:d165 with SMTP id
 n4-20020a2e7204000000b002bcfb79d165mr467043ljc.39.1693938321375; Tue, 05 Sep
 2023 11:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230905070912.82340-1-nitin.jadhav@nxp.com> <20230905070912.82340-5-nitin.jadhav@nxp.com>
In-Reply-To: <20230905070912.82340-5-nitin.jadhav@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 5 Sep 2023 11:25:09 -0700
Message-ID: <CABBYNZ+4hmX4QDbSoeZfAm=Kwyk96mAiQKMb+KU67pr-bHphdg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/4] unit/test-micp-test-mics: To implement unit
 tester code
To:     Nitin Jadhav <nitin.jadhav@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        mahesh.talewad@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nitin,

On Tue, Sep 5, 2023 at 12:09=E2=80=AFAM Nitin Jadhav <nitin.jadhav@nxp.com>=
 wrote:
>
> Implemented Unit Testcases for MICS[test-micp.c] and MICP[test-mics.c].

Let's have the server and client test on the same file in test-micp.

> Co-developed-by: Mahesh Talewad <mahesh.talewad@nxp.com>
> Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
> Signed-off-by: Nitin Jadhav <nitin.jadhav@nxp.com>
> ---
>  Makefile.am      |  13 ++
>  unit/test-micp.c | 357 +++++++++++++++++++++++++++++++++++++++++++++++
>  unit/test-mics.c | 317 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 687 insertions(+)
>  create mode 100644 unit/test-micp.c
>  create mode 100644 unit/test-mics.c

I was expecting the test cases to work:

unit/test-micp:

MICS/SR/SPE/BI-02-C - init
MICS/SR/SPE/BI-02-C - setup
MICS/SR/SPE/BI-02-C - setup complete
MICS/SR/SPE/BI-02-C - run
**
ERROR:src/shared/tester.c:954:test_io_recv: assertion failed:
(memcmp(buf, iov->iov_base, len) =3D=3D 0)
Bail out! ERROR:src/shared/tester.c:954:test_io_recv: assertion
failed: (memcmp(buf, iov->iov_base, len) =3D=3D 0)

unit/test-mics just hangs so these seem to need some work.

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

Please have the PDU definition with a proper description e.g. use
btmon to collect them while running e.g. sudo unit/test-micp -m
packets are forwarded to btmon.

Also please be consistent with the tab alignment, sometimes it is just
one tab sometimes it is many.

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
> index 000000000..7a7d70bf3
> --- /dev/null
> +++ b/unit/test-mics.c
> @@ -0,0 +1,317 @@
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
> +       struct bt_mics *mics;
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
> +static void micp_write_cb(bool success, uint8_t att_ecode, void *user_da=
ta)
> +{
> +       if (success)
> +               printf("MICP Write successful\n");
> +       else
> +               printf("\nWrite failed: 0x%02x\n", att_ecode);
> +}
> +
> +static void micp_write_value(struct bt_micp *micp, void *user_data)
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
> +               (void *)&value, sizeof(value), micp_write_cb, NULL, NULL)=
;
> +
> +       if (!ret)
> +               printf("bt_gatt_client_write_value() : Write FAILED");
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
