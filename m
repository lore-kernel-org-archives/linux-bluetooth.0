Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A328C25C810
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376038; cv=none; b=sY4nE18J3P4+HFR9sHLACselu1KVinnHXfJ2wH4XHVbWEYy3lmVOEQfK3a03fUjEzXaoFgxPejQbD9t4gO+Zmp2FZ5jZ/hE+o+sMSnqQRq7223yh5SCTStydeTGLySlBOfPSyy3wq10Nq3OanSg9BhVPt9ClhsE9c09VBLKHoxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376038; c=relaxed/simple;
	bh=iQGTgqEDqCoj6nzbPy74uJ0R8PfP/NlWZijRsRxt1cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AObRvEN0oU/MeXz6xJ+/DhRO7MVZs6Zfs+69VqrFufblbjJNpxtF0i+T3z9aJVriRII9Ib2p6CNyWeG3f71KLfCJAqqtvqxVB3MbidSQzk1wm4A/8sDePsV6aYcE3FhWLe3FDNSYw6SfXODsj3RoGGrviwIkvfgM/qYp78jvAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHK6rjof; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHK6rjof"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36295d53a10so35441641fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 10:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760376034; x=1760980834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBgzhbQXG/u8sTcecWq3uN855wN9/L4wk3bFfnL/Luo=;
        b=WHK6rjofqhnjY7L/03Af4rF1GGuf+cASpswY+dfadAAw8MJ83TpNNz1qj841gh47+F
         398GRzSJ1c6uiOxD1VDh1JvU6I2X7AySeWwZg2kWEoHNQUopNlGF2BKPF1YGOBrUrYCz
         7hfcvDtVW5IYx4uJttImiqU0PkxUoFJH2B64yJ42oZco5WO27B1VQAHd3zqopDO7RK8l
         pcYCIFcgu9Rjft2H29hEVutRzuJSg3X31MEGaLfQe90QiFsgCIlPfSd2fWnVlEA1YXVn
         iRuAVNtrG5WhiI4sXjG/HpVOxu6l490H3YHPJs+gbu2KbtOdq5Jg/tsc5vuHvu5UqwS7
         nS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760376034; x=1760980834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBgzhbQXG/u8sTcecWq3uN855wN9/L4wk3bFfnL/Luo=;
        b=kbHE1te7/iWgE7b3B597sQ8Qe1/i+e9C14js2VgvFr0tgqBYr/KPzrAI82S3tx2zDB
         CbxyFBt/iPPM0Z5apEHzSQs04hBGSMHLQoYOYGUkUsMTKwEjjAs+dpqZenc9U5GpYb4j
         4coGWsjiDPYcY9TGFXd5/Rr8UgLzie/C1k8VBfXjYIWgYlD/fdC1uzZvzfHQyUVlji1U
         U46ficpfYxuvpcAHbUQweP5g2wQqWvH9fOyD/HUo3O7xfL1K7GWcbJXxvqgEXhDiHYel
         3LarO4p3dsKRdsF/bu0xG4NMTW9ChqLNKlBWyteXuB97dGShlp72QjaDKnzHQVR1O6O2
         nHKw==
X-Gm-Message-State: AOJu0YyLXuiU5Pdv74lWZZ5b0HbP6OW5oCgspz1gl4UgT70DN1dnclYD
	yDs9MPCEa1lrUL5VhMf5sOw9L6fIoGsU3o3mtrBQTE/UhuLnSLIzFXr4+MgWbm+/1TSJWdQI+IU
	KV+h1vV8fymMIpmeGkiCA9UdiwTBhNdk/yewM
X-Gm-Gg: ASbGnctoTQtX0gieLwNRGpOFRFg/shjJXBsNigED3J8a2wKlNHSk79IJj6ENjkrSKcD
	wBHooYf0DsbdDXN3iILh6nuggi19sabtJqi8sH1HmhB57HkVDPc/W8+rWJV9vZyAG7lS/h3+LQn
	IiBdnVjAlQa8QfdRR6hTI45DUcPU4gTKb4jss3701WGE74niuXtYGSxmMyx0AH4UCvM6qply9TY
	DUd+IdR0/IRXJQ87W3+uY0o
X-Google-Smtp-Source: AGHT+IGXXwcT/KAQqt+UYXi9NHhVBL52tcE/x8etv006TMBSLs9TH8ztO8IjhR94NhDmc2Pk1rPIE41mOi6psrj/+pA=
X-Received: by 2002:a2e:8593:0:b0:365:253e:535a with SMTP id
 38308e7fff4ca-37609efefc7mr67448481fa.41.1760376033221; Mon, 13 Oct 2025
 10:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759702519.git.pav@iki.fi> <18bb47ec42d457e4e08ce04c1a3cb9ef35acc4fa.1759702519.git.pav@iki.fi>
In-Reply-To: <18bb47ec42d457e4e08ce04c1a3cb9ef35acc4fa.1759702519.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Oct 2025 13:20:18 -0400
X-Gm-Features: AS18NWBrW1T9gfQUrfvAYEAnZM7s-906cjCtQ1rGLQXbzekIsTufXsVSjMZDDlY
Message-ID: <CABBYNZJOOu9zBx6sV16VS6gndHWQvkRigrO1H1bnw3uBuCZd1w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/4] tools: add 6lowpan-tester
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Oct 5, 2025 at 6:18=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add 6lowpan smoke testing. It only exercises the kernel 6lowpan L2CAP
> connection handling, ipv6 testing is mostly out of scope for the tester.
>
> Add tests:
>
> Basic Framework - Success
> Client Connect - Terminate
> Client Connect - Disable
> Client Connect - Disconnect
> Client Recv Dgram - Success
> Client Recv Raw - Success
> ---
>  Makefile.tools         |  12 +-
>  tools/6lowpan-tester.c | 657 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 668 insertions(+), 1 deletion(-)
>  create mode 100644 tools/6lowpan-tester.c
>
> diff --git a/Makefile.tools b/Makefile.tools
> index e60c31b1d..561b03d0b 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -87,7 +87,8 @@ noinst_PROGRAMS +=3D emulator/btvirt emulator/b1ee emul=
ator/hfp \
>                                         tools/smp-tester tools/hci-tester=
 \
>                                         tools/rfcomm-tester tools/bnep-te=
ster \
>                                         tools/userchan-tester tools/iso-t=
ester \
> -                                       tools/mesh-tester tools/ioctl-tes=
ter
> +                                       tools/mesh-tester tools/ioctl-tes=
ter \
> +                                       tools/6lowpan-tester
>
>  emulator_btvirt_SOURCES =3D emulator/main.c monitor/bt.h \
>                                 emulator/serial.h emulator/serial.c \
> @@ -221,6 +222,15 @@ tools_ioctl_tester_SOURCES =3D tools/ioctl-tester.c =
monitor/bt.h \
>                                 emulator/smp.c
>  tools_ioctl_tester_LDADD =3D lib/libbluetooth-internal.la \
>                                 src/libshared-glib.la $(GLIB_LIBS)
> +
> +tools_6lowpan_tester_SOURCES =3D tools/6lowpan-tester.c monitor/bt.h \
> +                               emulator/hciemu.h emulator/hciemu.c \
> +                               emulator/vhci.h emulator/vhci.c \
> +                               emulator/btdev.h emulator/btdev.c \
> +                               emulator/bthost.h emulator/bthost.c \
> +                               emulator/smp.c
> +tools_6lowpan_tester_LDADD =3D lib/libbluetooth-internal.la \
> +                               src/libshared-glib.la $(GLIB_LIBS)
>  endif
>
>  if TOOLS
> diff --git a/tools/6lowpan-tester.c b/tools/6lowpan-tester.c
> new file mode 100644
> index 000000000..89ed9277e
> --- /dev/null
> +++ b/tools/6lowpan-tester.c
> @@ -0,0 +1,657 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
> + *
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +
> +#include <net/if.h>
> +#include <linux/if_packet.h>
> +#include <sys/ioctl.h>
> +
> +#include <glib.h>
> +
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
> +
> +#include "monitor/bt.h"
> +#include "emulator/bthost.h"
> +#include "emulator/hciemu.h"
> +
> +#include "src/shared/tester.h"
> +#include "src/shared/mgmt.h"
> +#include "src/shared/util.h"
> +
> +#include "tester.h"
> +
> +
> +#define L2CAP_PSM_IPSP         0x0023 /* 6LoWPAN */
> +
> +struct test_data {
> +       const void *test_data;
> +       struct mgmt *mgmt;
> +       uint16_t mgmt_index;
> +       struct hciemu *hciemu;
> +       uint16_t handle;
> +       uint16_t dcid;
> +       unsigned int io_id;
> +       int packet_fd;
> +};
> +
> +struct client_data {
> +       /* Skip test by default if set */
> +       const char *skip_by_default_reason;
> +
> +       /* Send disconnect command after L2CAP connection */
> +       bool disconnect;
> +
> +       /* Terminate L2CAP connection immediately */
> +       bool terminate_l2cap;
> +
> +       /* Disable 6lowpan immediately on L2CAP connection */
> +       bool disable_on_connect;
> +
> +       /* Data to send to kernel client after L2CAP connect */
> +       const void *send_data;
> +       uint16_t send_data_len;
> +
> +       /* Interface listener socket type, SOCK_RAW / DGRAM */
> +       int sk_type;
> +};
> +
> +static void print_debug(const char *str, void *user_data)
> +{
> +       const char *prefix =3D user_data;
> +
> +       tester_print("%s%s", prefix, str);
> +}
> +
> +static void read_info_callback(uint8_t status, uint16_t length,
> +                                       const void *param, void *user_dat=
a)
> +{
> +       struct test_data *data =3D tester_get_data();
> +       const struct mgmt_rp_read_info *rp =3D param;
> +       char addr[18];
> +       uint16_t manufacturer;
> +       uint32_t supported_settings, current_settings;
> +
> +       tester_print("Read Info callback");
> +       tester_print("  Status: 0x%02x", status);
> +
> +       if (status || !param) {
> +               tester_pre_setup_failed();
> +               return;
> +       }
> +
> +       ba2str(&rp->bdaddr, addr);
> +       manufacturer =3D btohs(rp->manufacturer);
> +       supported_settings =3D btohl(rp->supported_settings);
> +       current_settings =3D btohl(rp->current_settings);
> +
> +       tester_print("  Address: %s", addr);
> +       tester_print("  Version: 0x%02x", rp->version);
> +       tester_print("  Manufacturer: 0x%04x", manufacturer);
> +       tester_print("  Supported settings: 0x%08x", supported_settings);
> +       tester_print("  Current settings: 0x%08x", current_settings);
> +       tester_print("  Class: 0x%02x%02x%02x",
> +                       rp->dev_class[2], rp->dev_class[1], rp->dev_class=
[0]);
> +       tester_print("  Name: %s", rp->name);
> +       tester_print("  Short name: %s", rp->short_name);
> +
> +       if (strcmp(hciemu_get_address(data->hciemu), addr)) {
> +               tester_pre_setup_failed();
> +               return;
> +       }
> +
> +       tester_pre_setup_complete();
> +}
> +
> +static void index_added_callback(uint16_t index, uint16_t length,
> +                                       const void *param, void *user_dat=
a)
> +{
> +       struct test_data *data =3D tester_get_data();
> +
> +       tester_print("Index Added callback");
> +       tester_print("  Index: 0x%04x", index);
> +
> +       data->mgmt_index =3D index;
> +
> +       mgmt_send(data->mgmt, MGMT_OP_READ_INFO, data->mgmt_index, 0, NUL=
L,
> +                                       read_info_callback, NULL, NULL);
> +}
> +
> +static void index_removed_callback(uint16_t index, uint16_t length,
> +                                       const void *param, void *user_dat=
a)
> +{
> +       struct test_data *data =3D tester_get_data();
> +
> +       tester_print("Index Removed callback");
> +       tester_print("  Index: 0x%04x", index);
> +
> +       if (index !=3D data->mgmt_index)
> +               return;
> +
> +       mgmt_unregister_index(data->mgmt, data->mgmt_index);
> +
> +       mgmt_unref(data->mgmt);
> +       data->mgmt =3D NULL;
> +
> +       tester_post_teardown_complete();
> +}
> +
> +static void read_index_list_callback(uint8_t status, uint16_t length,
> +                                       const void *param, void *user_dat=
a)
> +{
> +       struct test_data *data =3D tester_get_data();
> +
> +       tester_print("Read Index List callback");
> +       tester_print("  Status: 0x%02x", status);
> +
> +       if (status || !param) {
> +               tester_pre_setup_failed();
> +               return;
> +       }
> +
> +       mgmt_register(data->mgmt, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
> +                                       index_added_callback, NULL, NULL)=
;
> +
> +       mgmt_register(data->mgmt, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
> +                                       index_removed_callback, NULL, NUL=
L);
> +
> +       data->hciemu =3D hciemu_new(HCIEMU_TYPE_LE);
> +       if (!data->hciemu) {
> +               tester_warn("Failed to setup HCI emulation");
> +               tester_pre_setup_failed();
> +               return;
> +       }
> +
> +       if (tester_use_debug())
> +               hciemu_set_debug(data->hciemu, print_debug, "hciemu: ", N=
ULL);
> +
> +       tester_print("New hciemu instance created");
> +}
> +
> +static int write_6lowpan(const char *filename, const char *fmt, ...)
> +{
> +       va_list ap;
> +       char path[PATH_MAX];
> +       char cmd[512];
> +       int fd, ret, len;
> +
> +       va_start(ap, fmt);
> +       len =3D vsnprintf(cmd, sizeof(cmd), fmt, ap);
> +       va_end(ap);
> +
> +       if (len < 0 || (size_t)len >=3D sizeof(cmd))
> +               return -ENOSPC;
> +
> +       tester_debug("%s < %s", filename, cmd);
> +
> +       snprintf(path, sizeof(path), "/sys/kernel/debug/bluetooth/%s", fi=
lename);
> +
> +       fd =3D open(path, O_WRONLY);
> +       if (fd < 0)
> +               return -EIO;
> +
> +       ret =3D write(fd, cmd, len);
> +       if (ret =3D=3D len)
> +               tester_print("%s: OK", filename);
> +       else
> +               tester_warn("%s: %m", filename);
> +
> +       close(fd);
> +       return ret =3D=3D len ? 0 : -EIO;
> +}
> +
> +static void test_pre_setup(const void *test_data)
> +{
> +       struct test_data *data =3D tester_get_data();
> +       const struct client_data *cdata =3D data->test_data;
> +       int ret;
> +
> +       if (cdata && cdata->skip_by_default_reason) {
> +               tester_warn("Skip test: %s", cdata->skip_by_default_reaso=
n);
> +               if (tester_pre_setup_skip_by_default())
> +                       return;
> +       }
> +
> +       ret =3D write_6lowpan("6lowpan_enable", "1");
> +       if (ret < 0) {
> +               tester_warn("Failed to enable 6lowpan");
> +               tester_pre_setup_failed();
> +               return;
> +       }
> +
> +       data->mgmt =3D mgmt_new_default();
> +       if (!data->mgmt) {
> +               tester_warn("Failed to setup management interface");
> +               tester_pre_setup_failed();
> +               return;
> +       }
> +
> +       if (tester_use_debug())
> +               mgmt_set_debug(data->mgmt, print_debug, "mgmt: ", NULL);
> +
> +       mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0=
, NULL,
> +                                       read_index_list_callback, NULL, N=
ULL);
> +}
> +
> +static void test_post_teardown(const void *test_data)
> +{
> +       struct test_data *data =3D tester_get_data();
> +       int ret;
> +
> +       if (data->io_id > 0) {
> +               g_source_remove(data->io_id);
> +               data->io_id =3D 0;
> +       }
> +
> +       if (data->packet_fd > 0) {
> +               close(data->packet_fd);
> +               data->packet_fd =3D -1;
> +       }
> +
> +       ret =3D write_6lowpan("6lowpan_enable", "0");
> +       if (ret < 0) {
> +               tester_warn("Failed to disable 6lowpan");
> +               tester_post_teardown_failed();
> +               return;
> +       }
> +
> +       hciemu_unref(data->hciemu);
> +       data->hciemu =3D NULL;
> +}
> +
> +static void test_data_free(void *test_data)
> +{
> +       struct test_data *data =3D test_data;
> +
> +       free(data);
> +}
> +
> +#define test_6lowpan_full(name, data, setup, func) \
> +       do { \
> +               struct test_data *user; \
> +               user =3D calloc(1, sizeof(struct test_data)); \
> +               if (!user) \
> +                       break; \
> +               user->test_data =3D data; \
> +               tester_add_full(name, data, \
> +                               test_pre_setup, setup, func, NULL, \
> +                               test_post_teardown, 5, user, test_data_fr=
ee); \
> +       } while (0)
> +
> +#define test_6lowpan(name, data, setup, func) \
> +       test_6lowpan_full(name, data, setup, func)
> +
> +static const struct client_data client_connect_terminate =3D {
> +       .terminate_l2cap =3D true,
> +};
> +
> +static const struct client_data client_connect_disable =3D {
> +       .disable_on_connect =3D true,
> +};
> +
> +static const struct client_data client_connect_disconnect =3D {
> +       .disconnect =3D true,
> +};
> +
> +static const uint8_t dgram_data[64+1] =3D {
> +       0x41, /* LOWPAN_DISPATCH_IPV6 */
> +       0xde, 0xad, 0xbe, 0xef /* some payload, not actually ipv6 */
> +};
> +
> +static const struct client_data client_recv_dgram =3D {
> +       .send_data =3D dgram_data,
> +       .send_data_len =3D sizeof(dgram_data),
> +       .sk_type =3D SOCK_DGRAM,
> +       .disconnect =3D true,
> +};
> +
> +static const struct client_data client_recv_raw =3D {
> +       .send_data =3D dgram_data,
> +       .send_data_len =3D sizeof(dgram_data),
> +       .sk_type =3D SOCK_RAW,
> +       .disconnect =3D true,
> +       .skip_by_default_reason =3D "kernel BUG at net/core/skbuff.c:212"
> +};
> +
> +static void client_cmd_complete(uint16_t opcode, uint8_t status,
> +                                       const void *param, uint8_t len,
> +                                       void *user_data)
> +{
> +       switch (opcode) {
> +       case BT_HCI_CMD_LE_SET_ADV_ENABLE:
> +               tester_print("Client set adv enable status 0x%02x", statu=
s);
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       if (status)
> +               tester_setup_failed();
> +       else
> +               tester_setup_complete();
> +}
> +
> +static void setup_powered_client_callback(uint8_t status, uint16_t lengt=
h,
> +                                       const void *param, void *user_dat=
a)
> +{
> +       struct test_data *data =3D tester_get_data();
> +       struct bthost *bthost;
> +
> +       if (status !=3D MGMT_STATUS_SUCCESS) {
> +               tester_setup_failed();
> +               return;
> +       }
> +
> +       tester_print("Controller powered on");
> +
> +       bthost =3D hciemu_client_get_host(data->hciemu);
> +       bthost_set_cmd_complete_cb(bthost, client_cmd_complete, user_data=
);
> +       bthost_set_adv_enable(bthost, 0x01);
> +}
> +
> +static void setup_powered_common(void)
> +{
> +       struct test_data *data =3D tester_get_data();
> +       unsigned char param[] =3D { 0x01 };
> +
> +       mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
> +                               sizeof(param), param, NULL, NULL, NULL);
> +
> +       mgmt_send(data->mgmt, MGMT_OP_SET_BONDABLE, data->mgmt_index,
> +                               sizeof(param), param, NULL, NULL, NULL);
> +}
> +
> +static void setup_powered_client(const void *test_data)
> +{
> +       struct test_data *data =3D tester_get_data();
> +       unsigned char param[] =3D { 0x01 };
> +
> +       tester_print("Powering on controller");
> +
> +       setup_powered_common();
> +
> +       mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
> +                               sizeof(param), param,
> +                               setup_powered_client_callback, NULL, NULL=
);
> +
> +       tester_print("OK");
> +}
> +
> +static void test_framework(const void *test_data)
> +{
> +       tester_test_passed();
> +}
> +
> +static int open_iface(const char *ifname, int sk_type)
> +{
> +       int sk =3D -1;
> +       struct sockaddr_ll sa;
> +       struct ifreq ifr;
> +       struct packet_mreq mr;
> +       int err;
> +       socklen_t len;
> +
> +       /* Open socket that receives all rx/tx on interface */
> +
> +       if (!sk_type)
> +               sk_type =3D SOCK_RAW;
> +
> +       sk =3D socket(PF_PACKET, sk_type, htons(ETH_P_ALL));
> +       if (sk < 0) {
> +               tester_print("socket: %m");
> +               goto error;
> +       }
> +
> +       memset(&ifr, 0, sizeof(ifr));
> +       strncpy(ifr.ifr_name, ifname, IF_NAMESIZE);
> +       if (ioctl(sk, SIOCGIFINDEX, &ifr) =3D=3D -1) {
> +               tester_print("SIOCGIFINDEX: %s: %m", ifname);
> +                goto error;
> +        }
> +
> +       sa.sll_family =3D AF_PACKET;
> +       sa.sll_ifindex =3D ifr.ifr_ifindex;
> +       sa.sll_protocol =3D 0;
> +       if (bind(sk, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
> +               tester_print("bind: %m");
> +               goto error;
> +       }
> +
> +       memset(&mr, 0, sizeof(mr));
> +       mr.mr_ifindex =3D ifr.ifr_ifindex;
> +       mr.mr_type =3D PACKET_MR_PROMISC;
> +       if (setsockopt(sk, SOL_PACKET, PACKET_ADD_MEMBERSHIP,
> +                                               &mr, sizeof(mr)) < 0) {
> +               tester_print("PACKET_ADD_MEMBERSHIP: %m");
> +               goto error;
> +       }
> +
> +       len =3D sizeof(err);
> +       if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &err, &len) < 0) {
> +               tester_print("getsockopt: %m");
> +                goto error;
> +       }
> +
> +       if (err) {
> +               tester_print("SO_ERROR: %d", err);
> +               goto error;
> +       }
> +
> +       return sk;
> +
> +error:
> +       if (sk >=3D 0)
> +               close(sk);
> +       return -EIO;
> +}
> +
> +static gboolean client_do_disconnect(gpointer user_data)
> +{
> +       struct test_data *data =3D user_data;
> +       const uint8_t *client_bdaddr;
> +       char addr[18];
> +
> +       data->io_id =3D 0;
> +
> +       client_bdaddr =3D hciemu_get_client_bdaddr(data->hciemu);
> +       ba2str((void *) client_bdaddr, addr);
> +
> +       /* XXX: sic - 6lowpan connect takes BDADDR_LE_* but disconnect ta=
kes
> +        * XXX: ADDR_LE_DEV_* address type value.
> +        * XXX: This is probably a bug in 6lowpan.c
> +        */
> +       if (write_6lowpan("6lowpan_control", "disconnect %s 0", addr))
> +               tester_test_failed();
> +
> +       return FALSE;
> +}
> +
> +static gboolean recv_iface_packet(GIOChannel *io, GIOCondition cond,
> +                                                       gpointer user_dat=
a)
> +{
> +       struct test_data *data =3D user_data;
> +       const struct client_data *cdata =3D data->test_data;
> +       uint8_t buf[256];
> +       int fd;
> +       ssize_t ret;
> +       int phy_hdr_size =3D (cdata->sk_type =3D=3D SOCK_DGRAM) ? 1 : 0;
> +
> +       if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
> +               return FALSE;
> +
> +       fd =3D g_io_channel_unix_get_fd(io);
> +       ret =3D recv(fd, buf, sizeof(buf), 0);
> +       if (ret < 0) {
> +               tester_print("recv failed");
> +               tester_test_failed();
> +               return FALSE;
> +       }
> +
> +       tester_print("Recv %d bytes", (int)ret);
> +
> +       if (ret !=3D cdata->send_data_len - phy_hdr_size)
> +               return TRUE;
> +       if (memcmp(buf, cdata->send_data + phy_hdr_size, ret))
> +               return TRUE;
> +
> +       tester_print("Received sent packet");
> +
> +       if (cdata->disconnect)
> +               return client_do_disconnect(user_data);
> +
> +       tester_test_passed();
> +       return FALSE;
> +}
> +
> +static gboolean client_open_iface(gpointer user_data)
> +{
> +       struct test_data *data =3D user_data;
> +       const struct client_data *cdata =3D data->test_data;
> +
> +       data->io_id =3D 0;
> +
> +       data->packet_fd =3D open_iface("bt0", cdata->sk_type);
> +       if (data->packet_fd < 0) {
> +               tester_print("Wait for interface...");
> +               data->io_id =3D g_timeout_add(500, client_open_iface, dat=
a);
> +               return FALSE;
> +       }
> +
> +       if (cdata->send_data) {
> +               struct bthost *bthost;
> +               GIOChannel *io;
> +
> +               bthost =3D hciemu_client_get_host(data->hciemu);
> +
> +               io =3D g_io_channel_unix_new(data->packet_fd);
> +               data->io_id =3D g_io_add_watch(io,
> +                                       G_IO_IN | G_IO_ERR | G_IO_HUP | G=
_IO_NVAL,
> +                                       recv_iface_packet, data);
> +               g_io_channel_unref(io);
> +
> +               tester_debug("Send %u+1 bytes", cdata->send_data_len - 1)=
;
> +               bthost_send_cid(bthost, data->handle, data->dcid, cdata->=
send_data,
> +                               cdata->send_data_len);
> +       } else if (cdata->disconnect) {
> +               data->io_id =3D g_idle_add(client_do_disconnect, data);
> +       }
> +
> +       return FALSE;
> +}
> +
> +static void client_l2cap_connect_cb(uint16_t handle, uint16_t cid,
> +                                                       void *user_data)
> +{
> +       struct test_data *data =3D user_data;
> +       const struct client_data *cdata =3D data->test_data;
> +
> +       tester_debug("Client connect CID 0x%04x handle 0x%04x", cid, hand=
le);
> +
> +       data->handle =3D handle;
> +       data->dcid =3D cid;
> +
> +       if (cdata->terminate_l2cap) {
> +               struct bthost *bthost;
> +               struct bt_l2cap_pdu_disconn_req req;
> +
> +               bthost =3D hciemu_client_get_host(data->hciemu);
> +
> +               memset(&req, 0, sizeof(req));
> +               req.scid =3D cpu_to_le16(cid);
> +               req.dcid =3D cpu_to_le16(cid);
> +
> +               bthost_l2cap_req(bthost, handle, BT_L2CAP_PDU_DISCONN_REQ=
,
> +                               &req, sizeof(req), NULL, NULL);
> +       }
> +
> +       /* Wait until kernel handles L2CAP connect RSP */
> +       if (cdata->send_data || cdata->disconnect)
> +               data->io_id =3D g_idle_add(client_open_iface, data);
> +
> +       if (cdata->disable_on_connect) {
> +               if (write_6lowpan("6lowpan_enable", "0"))
> +                       tester_test_failed();
> +               else
> +                       tester_test_passed();
> +       }
> +}
> +
> +static void client_l2cap_disconnect_cb(uint16_t handle, uint16_t cid,
> +                                                       void *user_data)
> +{
> +       struct test_data *data =3D user_data;
> +       const struct client_data *cdata =3D data->test_data;
> +
> +       tester_debug("Client disconnect CID 0x%04x handle 0x%04x", cid, h=
andle);
> +
> +       if ((cdata->terminate_l2cap || cdata->disconnect) &&
> +                               handle =3D=3D data->handle && cid =3D=3D =
data->dcid)
> +               tester_test_passed();
> +}
> +
> +static void test_connect(const void *test_data)
> +{
> +       struct test_data *data =3D tester_get_data();
> +       struct bthost *bthost =3D hciemu_client_get_host(data->hciemu);
> +       const uint8_t *client_bdaddr;
> +       char addr[18];
> +
> +       bthost_add_l2cap_server_custom(bthost, L2CAP_PSM_IPSP,
> +                               1280, 1280, 1,
> +                               client_l2cap_connect_cb,
> +                               client_l2cap_disconnect_cb,
> +                               data);
> +
> +       client_bdaddr =3D hciemu_get_client_bdaddr(data->hciemu);
> +       ba2str((void *) client_bdaddr, addr);
> +
> +       if (write_6lowpan("6lowpan_control", "connect %s 1", addr))
> +               tester_test_failed();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       tester_init(&argc, &argv);
> +
> +       test_6lowpan("Basic Framework - Success", NULL, setup_powered_cli=
ent,
> +                                                       test_framework);
> +
> +       test_6lowpan("Client Connect - Terminate", &client_connect_termin=
ate,
> +                                                       setup_powered_cli=
ent,
> +                                                       test_connect);
> +
> +       test_6lowpan("Client Connect - Disable", &client_connect_disable,
> +                                                       setup_powered_cli=
ent,
> +                                                       test_connect);
> +
> +       test_6lowpan("Client Connect - Disconnect", &client_connect_disco=
nnect,
> +                                                       setup_powered_cli=
ent,
> +                                                       test_connect);
> +
> +       test_6lowpan("Client Recv Dgram - Success", &client_recv_dgram,
> +                                                       setup_powered_cli=
ent,
> +                                                       test_connect);
> +
> +       test_6lowpan("Client Recv Raw - Success", &client_recv_raw,
> +                                                       setup_powered_cli=
ent,
> +                                                       test_connect);
> +
> +       return tester_run();
> +}
> --
> 2.51.0

This one has quite a few problems:

Applying: tools: add 6lowpan-tester
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#240: FILE: tools/6lowpan-tester.c:204:
+    snprintf(path, sizeof(path), "/sys/kernel/debug/bluetooth/%s", filenam=
e);

WARNING:STRNCPY: Prefer strscpy, strscpy_pad, or __nonstring over
strncpy - see: https://github.com/KSPP/linux/issues/90
#459: FILE: tools/6lowpan-tester.c:423:
+    strncpy(ifr.ifr_name, ifname, IF_NAMESIZE);

ERROR:CODE_INDENT: code indent should use tabs where possible
#462: FILE: tools/6lowpan-tester.c:426:
+                goto error;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#462: FILE: tools/6lowpan-tester.c:426:
+                goto error;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#463: FILE: tools/6lowpan-tester.c:427:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#463: FILE: tools/6lowpan-tester.c:427:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#485: FILE: tools/6lowpan-tester.c:449:
+                goto error;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#485: FILE: tools/6lowpan-tester.c:449:
+                goto error;$

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#581: FILE: tools/6lowpan-tester.c:545:
+                    G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#586: FILE: tools/6lowpan-tester.c:550:
+        bthost_send_cid(bthost, data->handle, data->dcid, cdata->send_data=
,


Only the second I think is not really valid since that appears to be a
kernel only function not available in userspace.

--=20
Luiz Augusto von Dentz
