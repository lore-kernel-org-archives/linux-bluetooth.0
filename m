Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071C3D9024
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089320; cv=pass; b=q92aRzrRQ5McvvXepZjrmlJ74pL0fQZZbXsTRY3ZmMpZ3KOE86X4Cd6YlZBicfVGCfinENqL8CxsqQIx7Hv/ubCEjvGAEnaAlkJquXXbQ/MppBMlsu3qis+RndqghZKcYUxsp27gIjCO7TDRe12o0NfMDD/lLwDUNlYOL5IFDME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089320; c=relaxed/simple;
	bh=BrmOhYtTcQyuQy7I/iFQVtoHBNcnlPYsFGqMZY77wgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWQpDEDCjIbTJl1NgNuq/fJoHyk+W4eYccyfxUWlJ3aqLgYzGn2K9p202/lwl7G2LiDixd3IncQqbxaJbH+FUjXHVNLTyScqaP//CVY5JFV/lWbUlTzw2KzhdkcHdA1bG9MWi3oLlLEpbAVKEtrxHsuxsH6vG0+Nuvwdd7d6ghw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddN+aSGS; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddN+aSGS"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6501d242e2fso4266577d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 07:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776089311; cv=none;
        d=google.com; s=arc-20240605;
        b=SKR3anVyk9BL51Rj+Kg0djq4lBuTmSQqyCcsy4M6hm5IHNvQ+waWmsHnuj3WO8OQu5
         Iwa4lBtQTkyhtzvU/4smIa6HoGsjl5T9jybCzJSx1BPI6dKlK2u49FkFxhtE0VvCtnnU
         lUdBhwXubPoMY6zfUzjRG/Mz9verRL0pnrv6ivHHUt4KJ/ykO5b/cSThNonl6orgmTs9
         QikXSkTFpFPMjjh2cxf75NHShz6r/f6MLExM3yDgETcvEu2YvkooqVb4Vd1kPaXylEJW
         xAQihg4T/1ftVjHz826Lsfj9IeSNkwAunvOQ92Cn9mTamwBVJ9zUGxY6YGWpvk6Nk/9y
         Dnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gh56kguYFedQr4KCiXqQVHKql9YGfN0xMWKRKOJhDU0=;
        fh=8vmOwSm9QheBlSAtzpU2h+vPN6vqZAy+khabkFtSFIk=;
        b=SpdKGNuVdQuIrU7bCVYA4WhRS6oPpAXcV6mtgoL5sGwQOubYJ4fcqFIA5b3NfQWtY1
         3RzATHW5yfDhD4TFK0rvjfKU4kYsm/eEdD+cjkVcQroqms6v2e15E4SGFGXlC5pA6x6r
         d5MqZ6QaezN7fEd/effM2pt4sPmUtwOD3NwY4TrK8SLQQeQoKCmvgtqO4gtGEd3IUAUA
         s1wdyldLl+TJP2nj/97FniWaCQUQ36D+tyHZIF3JcA3r/4xgEBzGYY5ZkFrDmX9OfSeT
         hcnN9PCa4/52Tv2nmrj0dMd0HjKV9jDCfXOBjnbQKbNio2lTz5nWitzsPJNF91mu00zc
         x6GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776089311; x=1776694111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gh56kguYFedQr4KCiXqQVHKql9YGfN0xMWKRKOJhDU0=;
        b=ddN+aSGSchAf1OjPBpUyvIxifvZu7yM8S94nSiOLHQQ3pNyTqfhT/rQY0kZr4rFwcM
         5K+AOf49hFqvFGP6RF6ukh4D9qFbDNg8CB+P3dAvXH+an662kHa8SNFtYQkFHLsXqVep
         3YqDwEG8FQ0E99Lgc6WbZesyh9hL5SSsgNYzRqW7ckzTOxJ8RZ6h1pDXj6JxyyLnUk6x
         cUtcQVbpaRmgBXbFMEcUMdfrDEEDL8ZGgH6Neee+Ft8eNKGNPxub7t6r2rsnU8lQSzqa
         jrTRgrudXtjZTruEk1eIFN7np+3TANfjk5T8txL5u4a5N1bwegMCzWG4pEgtGygZPFF+
         fouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089311; x=1776694111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gh56kguYFedQr4KCiXqQVHKql9YGfN0xMWKRKOJhDU0=;
        b=STKZRkoCVzpl0lSuhOMyWYAGFpT86AhUBg92B/ZG0q7KWGKsYyNawmOXWupytdBp5H
         3pbPsg2sJcqlj8Pozvsqvrk53EypgC2tLc0q3au1v5MDcrFMeVSVpKCnWY95ntWFrw0O
         dw7uXbmnoUQgwXZSr3i175+g14a8haTF6VTX5fVxQN/3gIJKXF2Nd1Y4yFWwbNyWEXaq
         zfuA2wrZXf8X0AYVjvPR+D0Yjl9dT0Ldd0NXHpa/D6UgJ0B+hN7ktFMdQ05R5S8vVY9j
         S089QuTpSYxoKhh/lKtN77JuOLJ1RI6nA4RGOTAz8fE2rnWoKEn0P3SBfNtE9dc/D5KD
         a1gQ==
X-Gm-Message-State: AOJu0Yw6YhgjK1OYBZRVTsaRaVo3BxrVfr2y/V3CpZp9kDxnhszbra5c
	NctqAUeNOeRF5l+STuwftGt11MUOJdrRA5vnLE862sf4eXCf99hk6vb3Yf0O1mF2qqkIg/phma/
	Tn6+FyaE0FTJ3pY27TN+pHzUu7e2wr3HYRNA+7APLyg==
X-Gm-Gg: AeBDieufa6YRA52CKtf0zChLIFbRwGqkcIT/Q4CsgevE09Ybk72yJdJHpbVUSr8WtWU
	QH3MQy5uXbzxfSdYO3VUg46Iz+6hI5jsWg0Alt5vOquhOKC7ySf1zmZEBWmcFuSdUBhUcE7B0XK
	DtuxmIQ4qwgC4KUNED12F6LLEFEfR7gpJ7qO2FwaGMjZWrmab09SJOZEWY82MjdEpCPO6GsGceP
	0M9sS3nPIXFwv9bt1Eog1Zme+XAkggj+zJ0RAW3tvD0icwps4l8M/9cl9mDeQHfPZ5PQPn2Radh
	PjkoVj1fPXYvfULoDApIFRRMUSgUKKa4I81401vjDSxlyz24LwHH/Nmmc5vZYMO0SmIsijUEMlU
	rMUCj
X-Received: by 2002:a53:ac84:0:b0:651:cfec:fce4 with SMTP id
 956f58d0204a3-651cfed0557mr2537283d50.28.1776089310797; Mon, 13 Apr 2026
 07:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413104116.1605357-1-naga.akella@oss.qualcomm.com> <20260413104116.1605357-4-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260413104116.1605357-4-naga.akella@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2026 10:08:19 -0400
X-Gm-Features: AQROBzBA12eWtI6dqhFZkcEKrtePdNE7OzqYFjBeY-oVui7_ExIS86Nvl-GI7B8
Message-ID: <CABBYNZJoF1X0Rs+CV441to=xv8--C2XOwkBSa6MigfF-+q86Mg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 3/3] profiles: ranging: Add HCI LE Event Handling
 in Reflector role
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	prathibha.madugonde@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Mon, Apr 13, 2026 at 6:41=E2=80=AFAM Naga Bhavani Akella
<naga.akella@oss.qualcomm.com> wrote:
>
> Open RAW HCI Channel for CS Event Handling
> Parse the following HCI LE CS Events in reflector role
> and route the events to RAP Profile.
>  1. HCI_EVT_LE_CS_READ_RMT_SUPP_CAP_COMPLETE
>  2. HCI_EVT_LE_CS_CONFIG_COMPLETE
>  3. HCI_EVT_LE_CS_SECURITY_ENABLE_COMPLETE
>  4. HCI_EVT_LE_CS_PROCEDURE_ENABLE_COMPLETE
>  5. HCI_EVT_LE_CS_SUBEVENT_RESULT
>  6. HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE
> Send HCI_OP_LE_CS_SET_DEFAULT_SETTINGS to the controller
> with default settings selected by the user.
> Map connection handle received to device connection
> ---
>  Makefile.plugins           |    3 +-
>  profiles/ranging/rap.c     |   83 ++-
>  profiles/ranging/rap_hci.c | 1288 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1367 insertions(+), 7 deletions(-)
>  create mode 100644 profiles/ranging/rap_hci.c
>
> diff --git a/Makefile.plugins b/Makefile.plugins
> index c9efadb45..ac667beda 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -89,7 +89,8 @@ builtin_modules +=3D battery
>  builtin_sources +=3D profiles/battery/battery.c
>
>  builtin_modules +=3D rap
> -builtin_sources +=3D profiles/ranging/rap.c
> +builtin_sources +=3D profiles/ranging/rap.c \
> +               profiles/ranging/rap_hci.c
>
>  if SIXAXIS
>  builtin_modules +=3D sixaxis
> diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
> index f03454c72..63682e318 100644
> --- a/profiles/ranging/rap.c
> +++ b/profiles/ranging/rap.c
> @@ -17,6 +17,7 @@
>  #include "gdbus/gdbus.h"
>
>  #include "bluetooth/bluetooth.h"
> +#include "bluetooth/l2cap.h"
>  #include "bluetooth/uuid.h"
>
>  #include "src/plugin.h"
> @@ -34,12 +35,17 @@
>  #include "src/shared/rap.h"
>  #include "attrib/att.h"
>  #include "src/log.h"
> +#include "src/btd.h"
>
> +#define USE_BT_HCI_RAW_CHANNEL 1

Didn't I already comment that we shouldn't use the likes of if
USE_BT_HCI_RAW_CHANNEL?

>  struct rap_data {
>         struct btd_device *device;
>         struct btd_service *service;
>         struct bt_rap *rap;
>         unsigned int ready_id;
> +#if USE_BT_HCI_RAW_CHANNEL
> +       struct bt_hci *hci;
> +#endif
>  };
>
>  static struct queue *sessions;
> @@ -61,10 +67,10 @@ static void rap_debug(const char *str, void *user_dat=
a)
>
>  static void rap_data_add(struct rap_data *data)
>  {
> -       DBG("%p", data);
> +       DBG("%p", (void *)data);
>
>         if (queue_find(sessions, NULL, data)) {
> -               error("data %p already added", data);
> +               error("data %p already added", (void *)data);

No idea why you are casting to void * on %p?

>                 return;
>         }
>
> @@ -95,13 +101,21 @@ static void rap_data_free(struct rap_data *data)
>         }
>
>         bt_rap_ready_unregister(data->rap, data->ready_id);
> +#if USE_BT_HCI_RAW_CHANNEL
> +       if (data->hci) {
> +               bt_rap_hci_sm_cleanup();
> +               bt_hci_unref(data->hci);
> +       }
> +#endif
> +       /* Clean up HCI connection mappings */
> +       bt_rap_detach_hci(data->rap);
>         bt_rap_unref(data->rap);
>         free(data);
>  }
>
>  static void rap_data_remove(struct rap_data *data)
>  {
> -       DBG("%p", data);
> +       DBG("%p", (void *)data);
>
>         if (!queue_remove(sessions, data))
>                 return;
> @@ -118,7 +132,7 @@ static void rap_detached(struct bt_rap *rap, void *us=
er_data)
>  {
>         struct rap_data *data;
>
> -       DBG("%p", rap);
> +       DBG("%p", (void *)rap);
>
>         data =3D queue_find(sessions, match_data, rap);
>         if (!data) {
> @@ -131,7 +145,7 @@ static void rap_detached(struct bt_rap *rap, void *us=
er_data)
>
>  static void rap_ready(struct bt_rap *rap, void *user_data)
>  {
> -       DBG("%p", rap);
> +       DBG("%p", (void *)rap);
>  }
>
>  static void rap_attached(struct bt_rap *rap, void *user_data)
> @@ -140,7 +154,7 @@ static void rap_attached(struct bt_rap *rap, void *us=
er_data)
>         struct bt_att *att;
>         struct btd_device *device;
>
> -       DBG("%p", rap);
> +       DBG("%p", (void *)rap);
>
>         data =3D queue_find(sessions, match_data, rap);
>         if (data) {
> @@ -194,6 +208,22 @@ static int rap_probe(struct btd_service *service)
>                 free(data);
>                 return -EINVAL;
>         }
> +#if USE_BT_HCI_RAW_CHANNEL
> +       int16_t hci_index =3D btd_adapter_get_index(adapter);
> +
> +       data->hci =3D bt_hci_new_raw_device(hci_index);
> +       if (bt_rap_attach_hci(data->rap, data->hci)) {
> +               DBG("HCI raw channel initialized, hci%d", hci_index);
> +               bt_rap_hci_set_le_bcs_options(
> +                                       btd_opts.defaults.bcs.role,
> +                                       btd_opts.defaults.bcs.cs_sync_ant=
_sel,
> +                                       btd_opts.defaults.bcs.max_tx_powe=
r);

BCS? Id called just bt_rap_set_options

> +       } else {
> +               error("HCI raw channel not available (may be in use)");
> +       }
> +#else /* USE_BT_HCI_RAW_CHANNEL */
> +       DBG("MGMT Events");
> +#endif /* USE_BT_HCI_RAW_CHANNEL */
>
>         rap_data_add(data);
>
> @@ -228,6 +258,10 @@ static int rap_accept(struct btd_service *service)
>         struct btd_device *device =3D btd_service_get_device(service);
>         struct bt_gatt_client *client =3D btd_device_get_gatt_client(devi=
ce);
>         struct rap_data *data =3D btd_service_get_user_data(service);
> +       struct bt_att *att;
> +       const bdaddr_t *bdaddr;
> +       uint8_t bdaddr_type;
> +       uint16_t handle;
>         char addr[18];
>
>         ba2str(device_get_address(device), addr);
> @@ -243,6 +277,43 @@ static int rap_accept(struct btd_service *service)
>                 return -EINVAL;
>         }
>
> +       /* Set up connection handle mapping for CS event routing */
> +       att =3D bt_rap_get_att(data->rap);
> +       bdaddr =3D device_get_address(device);
> +       bdaddr_type =3D device_get_le_address_type(device);
> +
> +       if (att && data->hci) {
> +               /* Use bt_hci_get_conn_info to find the connection handle
> +                * by iterating through all connections and matching bdad=
dr
> +                */
> +               struct bt_hci_conn_info conn_info;
> +               bool found =3D false;
> +
> +               /* Try handles from 0x0001 to 0x0EFF
> +                * (valid LE connection handle range)
> +                */
> +               for (handle =3D 0x0001; handle <=3D 0x0EFF; handle++) {
> +                       if (bt_hci_get_conn_info(data->hci, handle,
> +                               &conn_info)) {
> +                               /* Check if bdaddr matches */
> +                               if (memcmp(conn_info.bdaddr, bdaddr, 6) =
=3D=3D 0) {
> +                                       found =3D true;
> +                                       DBG("Found conn handle 0x%04X", h=
andle);
> +                                       break;
> +                               }
> +                       }
> +               }

Please no, we should use something like HCIGETCONNLIST, not mindlessly
iterate through all handles to check the connection handle.

> +
> +               if (found) {
> +                       DBG("Setting up handle mapping: handle=3D0x%04X",=
 handle);
> +                       bt_rap_set_conn_handle(data->rap, handle,
> +                                               (const uint8_t *)bdaddr,
> +                                               bdaddr_type);
> +               } else {
> +                       error("Failed to find connection handle for devic=
e");
> +               }
> +       }
> +
>         btd_service_connecting_complete(service, 0);
>
>         return 0;
> diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
> new file mode 100644
> index 000000000..b00719ae2
> --- /dev/null
> +++ b/profiles/ranging/rap_hci.c
> @@ -0,0 +1,1288 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <endian.h>
> +
> +#include "lib/bluetooth/bluetooth.h"
> +#include "src/shared/util.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/rap.h"
> +#include "src/log.h"
> +#include "monitor/bt.h"
> +
> +#ifndef MIN
> +#define MIN(a, b) ((a) < (b) ? (a) : (b))
> +#endif
> +
> +/*  CS State Definitions */
> +enum cs_state_t {
> +       CS_INIT,
> +       CS_STOPPED,
> +       CS_STARTED,
> +       CS_WAIT_CONFIG_CMPLT,
> +       CS_WAIT_SEC_CMPLT,
> +       CS_WAIT_PROC_CMPLT,
> +       CS_HOLD,
> +       CS_UNSPECIFIED
> +};
> +
> +const char *state_names[] =3D {
> +       "CS_INIT",
> +       "CS_STOPPED",
> +       "CS_STARTED",
> +       "CS_WAIT_CONFIG_CMPLT",
> +       "CS_WAIT_SEC_CMPLT",
> +       "CS_WAIT_PROC_CMPLT",
> +       "CS_HOLD",
> +       "CS_UNSPECIFIED"
> +};
> +
> +/* Callback Function Type */
> +typedef void (*cs_callback_t)(uint16_t length,
> +                       const void *param, void *user_data);
> +
> +/* State Machine Context */
> +struct cs_state_machine_t {
> +       enum cs_state_t current_state;
> +       enum cs_state_t old_state;
> +       struct bt_hci *hci;
> +       struct bt_rap *rap;
> +       unsigned int event_id;
> +       bool initiator;
> +       bool procedure_active;
> +};
> +
> +struct cs_callback_map_t {
> +       enum cs_state_t state;
> +       cs_callback_t callback;
> +};
> +
> +struct cs_callback_map_t cs_callback_map[] =3D {
> +       { CS_WAIT_CONFIG_CMPLT, bt_rap_hci_cs_config_complete_callback },
> +       { CS_WAIT_SEC_CMPLT, bt_rap_hci_cs_sec_enable_complete_callback }=
,
> +       { CS_WAIT_PROC_CMPLT, bt_rap_hci_cs_procedure_enable_complete_cal=
lback }
> +};
> +
> +#define CS_CALLBACK_MAP_SIZE ARRAY_SIZE(cs_callback_map)
> +
> +struct bt_rap_hci_cs_options cs_opt;
> +struct cs_state_machine_t *sm;
> +
> +/* Connection Handle Mapping */
> +struct rap_conn_mapping {
> +       uint16_t handle;
> +       uint8_t bdaddr[6];
> +       uint8_t bdaddr_type;
> +       struct bt_att *att;
> +       struct bt_rap *rap;
> +};
> +
> +static struct queue *conn_mappings;
> +
> +/* Connection Mapping Helper Functions */
> +static void mapping_free(void *data)
> +{
> +       struct rap_conn_mapping *mapping =3D data;
> +
> +       if (!mapping)
> +               return;
> +
> +       free(mapping);
> +}
> +
> +static bool match_mapping_handle(const void *a, const void *b)
> +{
> +       const struct rap_conn_mapping *mapping =3D a;
> +       uint16_t handle =3D PTR_TO_UINT(b);
> +
> +       return mapping->handle =3D=3D handle;
> +}
> +
> +static bool match_mapping_rap(const void *a, const void *b)
> +{
> +       const struct rap_conn_mapping *mapping =3D a;
> +       const struct bt_rap *rap =3D b;
> +
> +       return mapping->rap =3D=3D rap;
> +}
> +
> +static struct rap_conn_mapping *find_mapping_by_handle(uint16_t handle)
> +{
> +       if (!conn_mappings)
> +               return NULL;
> +
> +       return queue_find(conn_mappings, match_mapping_handle,
> +                               UINT_TO_PTR(handle));
> +}
> +
> +static bool add_conn_mapping(uint16_t handle, const uint8_t *bdaddr,
> +                               uint8_t bdaddr_type, struct bt_att *att,
> +                               struct bt_rap *rap)
> +{
> +       struct rap_conn_mapping *mapping;
> +
> +       if (!conn_mappings) {
> +               conn_mappings =3D queue_new();
> +               if (!conn_mappings)
> +                       return false;
> +       }
> +
> +       /* Check if mapping already exists */
> +       mapping =3D find_mapping_by_handle(handle);
> +       if (mapping) {
> +               /* Update existing mapping */
> +               if (bdaddr)
> +                       memcpy(mapping->bdaddr, bdaddr, 6);
> +               mapping->bdaddr_type =3D bdaddr_type;
> +               mapping->att =3D att;
> +               mapping->rap =3D rap;
> +               return true;
> +       }
> +
> +       /* Create new mapping */
> +       mapping =3D new0(struct rap_conn_mapping, 1);
> +       if (!mapping)
> +               return false;
> +
> +       mapping->handle =3D handle;
> +       if (bdaddr)
> +               memcpy(mapping->bdaddr, bdaddr, 6);
> +       mapping->bdaddr_type =3D bdaddr_type;
> +       mapping->att =3D att;
> +       mapping->rap =3D rap;
> +
> +       return queue_push_tail(conn_mappings, mapping);
> +}
> +
> +static void remove_conn_mapping(uint16_t handle)
> +{
> +       struct rap_conn_mapping *mapping;
> +
> +       if (!conn_mappings)
> +               return;
> +
> +       mapping =3D queue_remove_if(conn_mappings, match_mapping_handle,
> +                                       UINT_TO_PTR(handle));
> +       if (mapping)
> +               mapping_free(mapping);
> +}
> +
> +static void remove_rap_mappings(struct bt_rap *rap)
> +{
> +       if (!conn_mappings)
> +               return;
> +
> +       queue_remove_all(conn_mappings, match_mapping_rap, rap,
> +                               mapping_free);
> +}
> +
> +static struct bt_rap *resolve_handle_to_rap(uint16_t handle,
> +                                               struct bt_hci *hci)
> +{
> +       struct rap_conn_mapping *mapping;
> +       struct bt_hci_conn_info conn_info;
> +
> +       /* First try to find in mapping cache */
> +       mapping =3D find_mapping_by_handle(handle);
> +       if (mapping && mapping->rap) {
> +               DBG("Found handle 0x%04X in mapping cache", handle);
> +               return mapping->rap;
> +       }
> +
> +       /* Fallback: Try to get connection info via ioctl */
> +       if (hci && bt_hci_get_conn_info(hci, handle, &conn_info)) {
> +               DBG("Got connection info via ioctl for handle 0x%04X:", h=
andle);
> +               DBG("  bdaddr=3D%02x:%02x:%02x:%02x:%02x:%02x link_type=
=3D0x%02x",
> +                       conn_info.bdaddr[5], conn_info.bdaddr[4],
> +                       conn_info.bdaddr[3], conn_info.bdaddr[2],
> +                       conn_info.bdaddr[1], conn_info.bdaddr[0],
> +                       conn_info.type);
> +               DBG("  Note: Cannot determine RAP instance from ioctl alo=
ne");

Not sure what this is for? If it cannot be resolved with just the
handle then why are you doing it?

> +       }
> +
> +       /* Profile layer should have called bt_rap_set_conn_handle() duri=
ng
> +        * connection establishment. If we reach here, the mapping was no=
t set.
> +        */
> +       DBG("No mapping found for handle 0x%04X", handle);
> +       DBG("Profile layer should call bt_rap_set_conn_handle() on connec=
t");
> +
> +       return NULL;
> +}
> +
> +/*  State Machine Functions */
> +void cs_state_machine_init(struct cs_state_machine_t *sm, struct bt_rap =
*rap,
> +                               struct bt_hci *hci)
> +{
> +       if (!sm)
> +               return;
> +
> +       memset(sm, 0, sizeof(struct cs_state_machine_t));
> +       sm->current_state =3D CS_UNSPECIFIED;
> +       sm->rap =3D rap;
> +       sm->hci =3D hci;
> +       sm->initiator =3D false;
> +       sm->procedure_active =3D false;
> +}
> +
> +void bt_rap_hci_sm_cleanup(void)
> +{
> +       if (!sm)
> +               return;
> +
> +       if (sm->event_id)
> +               bt_hci_unregister(sm->hci, sm->event_id);
> +
> +       sm->current_state =3D CS_UNSPECIFIED;
> +       sm->rap =3D NULL;
> +       sm->hci =3D NULL;
> +       sm->procedure_active =3D false;
> +
> +       free(sm);
> +}
> +
> +void bt_rap_hci_set_le_bcs_options(uint8_t role, uint8_t cs_sync_ant_sel=
,
> +                                       int8_t max_tx_power)
> +{
> +       cs_opt.role =3D role;
> +       cs_opt.cs_sync_ant_sel =3D cs_sync_ant_sel;
> +       cs_opt.max_tx_power =3D max_tx_power;
> +}
> +
> +/* State Transition Logic */
> +void cs_set_state(struct cs_state_machine_t *sm, enum cs_state_t new_sta=
te)
> +{
> +       if (!sm)
> +               return;
> +
> +       if (sm->current_state =3D=3D new_state)
> +               return;
> +
> +       /* Validate state values before array access */
> +       if (sm->current_state > CS_UNSPECIFIED || new_state > CS_UNSPECIF=
IED) {
> +               DBG("[ERROR] Invalid state transition attempted\n");

There is a error function to print errors.

> +               return;
> +       }
> +
> +       DBG("[STATE] Transition: %s =E2=86=92 %s\n",
> +               state_names[sm->current_state],
> +               state_names[new_state]);
> +
> +       sm->old_state =3D sm->current_state;
> +       sm->current_state =3D new_state;
> +}
> +
> +enum cs_state_t cs_get_current_state(struct cs_state_machine_t *sm)
> +{
> +       return sm ? sm->current_state : CS_UNSPECIFIED;
> +}
> +
> +bool cs_is_procedure_active(const struct cs_state_machine_t *sm)
> +{
> +       return sm ? sm->procedure_active : false;
> +}
> +
> +/* HCI Event Callbacks */
> +static void rap_def_settings_done_cb(const void *data, uint8_t size,
> +                                       void *user_data)
> +{
> +       struct bt_hci_rsp_le_cs_set_def_settings *rp;
> +       struct cs_state_machine_t *sm =3D (struct cs_state_machine_t *)us=
er_data;
> +
> +       if (!sm || !data ||
> +               size < sizeof(struct bt_hci_rsp_le_cs_set_def_settings))
> +               return;
> +
> +       DBG("[EVENT] CS default Setting Complete (size=3D0x%02X)\n", size=
);
> +
> +       rp =3D (struct bt_hci_rsp_le_cs_set_def_settings *)data;
> +
> +       if (cs_get_current_state(sm) !=3D CS_INIT) {
> +               DBG("Event received in Wrong State!! Expected : CS_INIT")=
;
> +               return;
> +       }
> +
> +       if (rp->status =3D=3D 0) {
> +               /* Success - proceed to configuration */
> +               cs_set_state(sm, CS_WAIT_CONFIG_CMPLT);
> +
> +               /* Reflector role */
> +               DBG("Waiting for CS Config Completed event...\n");
> +               /* TODO: Initiator role - Send CS Config complete cmd */
> +       } else {
> +               /* Error - transition to stopped */
> +               DBG("[ERROR]CS Set default setting failed with status 0x%=
02X\n",
> +               rp->status);

User error

> +               cs_set_state(sm, CS_STOPPED);
> +       }
> +}
> +
> +void rap_send_hci_def_settings_command(struct cs_state_machine_t *sm,
> +               struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *ev)
> +{
> +       struct bt_hci_cmd_le_cs_set_def_settings cp;
> +       unsigned int status;
> +
> +       memset(&cp, 0, sizeof(cp));
> +
> +       if (ev->handle)
> +               cp.handle =3D ev->handle;
> +       cp.role_enable =3D cs_opt.role;
> +       cp.cs_sync_antenna_selection =3D cs_opt.cs_sync_ant_sel;
> +       cp.max_tx_power =3D cs_opt.max_tx_power;
> +
> +       if (!sm || !sm->hci) {
> +               DBG("[ERR] Set Def Settings: sm or hci is null");
> +               return;
> +       }
> +
> +       status =3D bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_SET_DEF_SETTINGS=
,
> +                               &cp, sizeof(cp), rap_def_settings_done_cb=
,
> +                               sm, NULL);
> +
> +       DBG("sending set default settings case, status : %d", status);
> +       if (!status)
> +               DBG("Failed to send default settings cmd");
> +}
> +
> +static void rap_rd_rmt_supp_cap_cmplt_evt(const uint8_t *data, uint8_t s=
ize,
> +                                          void *user_data)
> +{
> +       struct cs_state_machine_t *sm =3D (struct cs_state_machine_t *)us=
er_data;
> +       const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *evt;
> +       struct bt_rap *rap;
> +       struct iovec iov;
> +
> +       if (!sm || !data ||
> +               size < sizeof(struct bt_hci_evt_le_cs_rd_rem_supp_cap_com=
plete))
> +               return;
> +
> +       /* Initialize iovec with the event data */
> +       iov.iov_base =3D (void *)data;
> +       iov.iov_len =3D size;
> +
> +       /* Pull the entire structure at once */
> +       evt =3D util_iov_pull_mem(&iov, sizeof(*evt));
> +       if (!evt) {
> +               DBG("[ERROR] Failed to pull remote cap complete struct\n"=
);
> +               return;
> +       }
> +
> +       DBG("[EVENT] Remote Capabilities Complete\n");
> +       DBG("status=3D0x%02X, handle=3D0x%04X\n", evt->status, evt->handl=
e);
> +
> +       /* Check status */
> +       if (evt->status !=3D 0) {
> +               DBG("[ERROR] Remote capabilities failed with status 0x%02=
X\n",
> +                       evt->status);
> +               cs_set_state(sm, CS_STOPPED);
> +               return;
> +       }
> +
> +       /* Resolve handle to RAP instance */
> +       rap =3D resolve_handle_to_rap(evt->handle, sm->hci);
> +       if (!rap) {
> +               DBG("[WARN] Could not resolve handle 0x%04X to RAP instan=
ce\n",
> +                       evt->handle);
> +               /* Continue with state machine RAP for now */
> +               rap =3D sm->rap;
> +       }
> +
> +       DBG("[EVENT] Remote Capabilities: num_config=3D%u, ",
> +               evt->num_config_supported);
> +       DBG("max_consecutive_proc=3D%u, num_antennas=3D%u, ",
> +               evt->max_consecutive_procedures_supported,
> +               evt->num_antennas_supported);
> +       DBG("max_antenna_paths=3D%u, roles=3D0x%02X, modes=3D0x%02X\n",
> +               evt->max_antenna_paths_supported,
> +               evt->roles_supported,
> +               evt->modes_supported);
> +
> +       rap_send_hci_def_settings_command(sm,
> +               (struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *)evt);
> +       cs_set_state(sm, CS_INIT);
> +}
> +
> +static void rap_cs_config_cmplt_evt(const uint8_t *data, uint8_t size,
> +                                   void *user_data)
> +{
> +       struct cs_state_machine_t *sm =3D (struct cs_state_machine_t *)us=
er_data;
> +       const struct bt_hci_evt_le_cs_config_complete *evt;
> +       struct rap_ev_cs_config_cmplt rap_ev;
> +       struct iovec iov;
> +
> +       if (!sm || !data ||
> +               size < sizeof(struct bt_hci_evt_le_cs_config_complete))
> +               return;
> +
> +       /* Initialize iovec with the event data */
> +       iov.iov_base =3D (void *)data;
> +       iov.iov_len =3D size;
> +
> +       DBG("[EVENT] Configuration Complete (size=3D0x%02X)\n", size);
> +
> +       /* State Check */
> +       if (cs_get_current_state(sm) !=3D CS_WAIT_CONFIG_CMPLT) {
> +               DBG("Event received in Wrong State!! ");
> +               DBG("Expected : CS_WAIT_CONFIG_CMPLT");
> +               return;
> +       }
> +
> +       /* Pull the entire structure at once */
> +       evt =3D util_iov_pull_mem(&iov, sizeof(*evt));
> +       if (!evt) {
> +               DBG("[ERROR] Failed to pull config complete struct\n");
> +               return;
> +       }
> +
> +       DBG("status=3D0x%02X, handle=3D0x%04X\n", evt->status, evt->handl=
e);
> +
> +       /* Check status */
> +       if (evt->status !=3D 0) {
> +               DBG("[ERROR] Configuration failed with status 0x%02X\n",
> +                       evt->status);
> +               cs_set_state(sm, CS_STOPPED);
> +               return;
> +       }
> +
> +       /* Copy fields to rap_ev structure */
> +       rap_ev.status =3D evt->status;
> +       rap_ev.conn_hdl =3D cpu_to_le16(evt->handle);
> +       rap_ev.config_id =3D evt->config_id;
> +       rap_ev.action =3D evt->action;
> +       rap_ev.main_mode_type =3D evt->main_mode_type;
> +       rap_ev.sub_mode_type =3D evt->sub_mode_type;
> +       rap_ev.min_main_mode_steps =3D evt->min_main_mode_steps;
> +       rap_ev.max_main_mode_steps =3D evt->max_main_mode_steps;
> +       rap_ev.main_mode_rep =3D evt->main_mode_repetition;
> +       rap_ev.mode_0_steps =3D evt->mode_0_steps;
> +       rap_ev.role =3D evt->role;
> +       rap_ev.rtt_type =3D evt->rtt_type;
> +       rap_ev.cs_sync_phy =3D evt->cs_sync_phy;
> +       memcpy(rap_ev.channel_map, evt->channel_map, 10);
> +       rap_ev.channel_map_rep =3D evt->channel_map_repetition;
> +       rap_ev.channel_sel_type =3D evt->channel_selection_type;
> +       rap_ev.ch3c_shape =3D evt->ch3c_shape;
> +       rap_ev.ch3c_jump =3D evt->ch3c_jump;
> +       rap_ev.reserved =3D evt->reserved;
> +       rap_ev.t_ip1_time =3D evt->t_ip1_time;
> +       rap_ev.t_ip2_time =3D evt->t_ip2_time;
> +       rap_ev.t_fcs_time =3D evt->t_fcs_time;
> +       rap_ev.t_pm_time =3D evt->t_pm_time;
> +
> +       /* Store rtt_type in global options */
> +       cs_opt.rtt_type =3D rap_ev.rtt_type;
> +
> +       DBG("[EVENT] Config Complete: config_id=3D%u, action=3D%u, ",
> +               rap_ev.config_id, rap_ev.action);
> +       DBG("main_mode=3D%u, sub_mode=3D%u, role=3D%u, rtt_type=3D%u\n",
> +               rap_ev.main_mode_type, rap_ev.sub_mode_type,
> +               rap_ev.role, rap_ev.rtt_type);
> +
> +       /* Success - proceed to Security enable complete */
> +       cs_set_state(sm, CS_WAIT_SEC_CMPLT);
> +
> +       /* Reflector role */
> +       DBG("Waiting for security enable event...\n");
> +       /* TODO: Initiator role - Send CS Security enable cmd */
> +
> +       /* Send Callback to RAP Profile */
> +       for (size_t i =3D 0; i < CS_CALLBACK_MAP_SIZE; i++) {
> +               if (cs_callback_map[i].state =3D=3D sm->old_state) {
> +                       cs_callback_map[i].callback(size, &rap_ev, sm->ra=
p);
> +                       return;
> +               }
> +       }
> +}
> +
> +static void rap_cs_sec_enable_cmplt_evt(const uint8_t *data, uint8_t siz=
e,
> +                                        void *user_data)
> +{
> +       struct cs_state_machine_t *sm =3D (struct cs_state_machine_t *)us=
er_data;
> +       struct rap_ev_cs_sec_enable_cmplt rap_ev;
> +       struct iovec iov;
> +       uint8_t status;
> +       uint16_t handle;
> +
> +       if (!sm || !data ||
> +               size < sizeof(struct bt_hci_evt_le_cs_sec_enable_complete=
))
> +               return;
> +
> +       /* Initialize iovec with the event data */
> +       iov.iov_base =3D (void *)data;
> +       iov.iov_len =3D size;
> +
> +       DBG("[EVENT] Security Enable Complete (size=3D0x%02X)\n", size);
> +
> +       /* State Check */
> +       if (cs_get_current_state(sm) !=3D CS_WAIT_SEC_CMPLT) {
> +               DBG("Event received in Wrong State!! ");
> +               DBG("Expected : CS_WAIT_SEC_CMPLT");
> +               return;
> +       }
> +
> +       /* Parse all fields in order using iovec */
> +       if (!util_iov_pull_u8(&iov, &status)) {
> +               DBG("[ERROR] Failed to parse Status\n");
> +               return;
> +       }
> +
> +       if (!util_iov_pull_le16(&iov, &handle)) {
> +               DBG("[ERROR] Failed to parse Connection_Handle\n");
> +               return;
> +       }
> +
> +       rap_ev.status =3D status;
> +       rap_ev.conn_hdl =3D cpu_to_le16(handle);
> +
> +       DBG("[EVENT] Security Enable: status=3D0x%02X, handle=3D0x%04X\n"=
,
> +               rap_ev.status, handle);
> +
> +       if (rap_ev.status =3D=3D 0) {
> +               /* Success - proceed to configuration */
> +               cs_set_state(sm, CS_WAIT_PROC_CMPLT);
> +
> +               /* Reflector role */
> +               DBG("Waiting for CS Proc complete event...\n");
> +               /* TODO: Initiator - Send CS Proc Set Parameter and enabl=
e */
> +       } else {
> +               /* Error - transition to stopped */
> +               DBG("[ERROR] Security enable failed with status 0x%02X\n"=
,
> +                       rap_ev.status);
> +               cs_set_state(sm, CS_STOPPED);
> +       }
> +
> +       /* Send Callback to RAP Profile */
> +       for (size_t i =3D 0; i < CS_CALLBACK_MAP_SIZE; i++) {
> +               if (cs_callback_map[i].state =3D=3D sm->old_state) {
> +                       cs_callback_map[i].callback(size, &rap_ev, sm->ra=
p);
> +                       return;
> +               }
> +       }
> +}
> +
> +static void rap_cs_proc_enable_cmplt_evt(const uint8_t *data, uint8_t si=
ze,
> +                                         void *user_data)
> +{
> +       struct cs_state_machine_t *sm =3D (struct cs_state_machine_t *)us=
er_data;
> +       const struct bt_hci_evt_le_cs_proc_enable_complete *evt;
> +       struct rap_ev_cs_proc_enable_cmplt rap_ev;
> +       struct iovec iov;
> +
> +       if (!sm || !data ||
> +               size < sizeof(struct bt_hci_evt_le_cs_proc_enable_complet=
e))
> +               return;
> +
> +       /* Initialize iovec with the event data */
> +       iov.iov_base =3D (void *)data;
> +       iov.iov_len =3D size;
> +
> +       DBG("[EVENT] Procedure Enable Complete (size=3D0x%02X)\n", size);

DBG already prints the function name, so printing the event name again
sounds repetitive.

> +
> +       /* State Check */
> +       if (cs_get_current_state(sm) !=3D CS_WAIT_PROC_CMPLT) {
> +               DBG("Event received in Wrong State!! ");
> +               DBG("Expected : CS_WAIT_PROC_CMPLT");
> +               return;
> +       }
> +
> +       /* Pull the entire structure at once */
> +       evt =3D util_iov_pull_mem(&iov, sizeof(*evt));
> +       if (!evt) {
> +               DBG("[ERROR] Failed to pull proc enable complete struct\n=
");
> +               return;
> +       }
> +
> +       DBG("status=3D0x%02X, handle=3D0x%04X\n", evt->status, evt->handl=
e);
> +
> +       /* Check status */
> +       if (evt->status !=3D 0) {
> +               DBG("[ERROR] Procedure enable failed with status 0x%02X\n=
",
> +                       evt->status);
> +               cs_set_state(sm, CS_STOPPED);
> +               sm->procedure_active =3D false;
> +               return;
> +       }
> +
> +       /* Copy fields to rap_ev structure */
> +       rap_ev.status =3D evt->status;
> +       rap_ev.conn_hdl =3D cpu_to_le16(evt->handle);
> +       rap_ev.config_id =3D evt->config_id;
> +       rap_ev.state =3D evt->state;
> +       rap_ev.tone_ant_config_sel =3D evt->tone_antenna_config_selection=
;
> +       rap_ev.sel_tx_pwr =3D evt->selected_tx_power;
> +       memcpy(rap_ev.sub_evt_len, evt->subevent_len, 3);
> +       rap_ev.sub_evts_per_evt =3D evt->subevents_per_event;
> +       rap_ev.sub_evt_intrvl =3D evt->subevent_interval;
> +       rap_ev.evt_intrvl =3D evt->event_interval;
> +       rap_ev.proc_intrvl =3D evt->procedure_interval;
> +       rap_ev.proc_counter =3D evt->procedure_count;
> +       rap_ev.max_proc_len =3D evt->max_procedure_len;
> +
> +       DBG("[EVENT] Procedure Enable: config_id=3D%u, state=3D%u, ",
> +               rap_ev.config_id, rap_ev.state);
> +       DBG("sub_evts_per_evt=3D%u, evt_intrvl=3D%u, proc_intrvl=3D%u\n",
> +               rap_ev.sub_evts_per_evt, rap_ev.evt_intrvl,
> +               rap_ev.proc_intrvl);
> +
> +       /* Success - procedure started */
> +       cs_set_state(sm, CS_STARTED);
> +       sm->procedure_active =3D true;
> +
> +       /* Send Callback to RAP Profile */
> +       for (size_t i =3D 0; i < CS_CALLBACK_MAP_SIZE; i++) {
> +               if (cs_callback_map[i].state =3D=3D sm->old_state) {
> +                       cs_callback_map[i].callback(size, &rap_ev, sm->ra=
p);
> +                       return;
> +               }
> +       }
> +}
> +
> +static void parse_i_q_sample(struct iovec *iov, int16_t *i_sample,
> +                               int16_t *q_sample)
> +{
> +       uint8_t bytes[3];
> +       uint32_t buffer;
> +       uint32_t i12;
> +       uint32_t q12;
> +
> +       /* Pull 3 bytes from iovec */
> +       if (!util_iov_pull_u8(iov, &bytes[0]) ||
> +               !util_iov_pull_u8(iov, &bytes[1]) ||
> +               !util_iov_pull_u8(iov, &bytes[2])) {
> +               *i_sample =3D 0;
> +               *q_sample =3D 0;
> +               return;
> +       }

Oh please, use util_iov_pull_le24

> +
> +       /* Reconstruct 24-bit buffer from 3 bytes */
> +       buffer =3D (uint32_t)bytes[0] | ((uint32_t)bytes[1] << 8) |
> +                               ((uint32_t)bytes[2] << 16);

No need to do this; just use util_iov_pull_le24

> +       i12 =3D  buffer        & 0x0FFFU;   /* bits 0..11 */
> +       q12 =3D (buffer >> 12) & 0x0FFFU;   /* bits 12..23 */
>
> +       /* Sign-extend 12-bit values to 16-bit */
> +       *i_sample =3D (int16_t)((int32_t)(i12 << 20) >> 20);
> +       *q_sample =3D (int16_t)((int32_t)(q12 << 20) >> 20);

This sound a little too complicated, please quote the spec why this
needs to be done this way, also this should have a pack/unpack macro
helps for bit manipulation.

> +}
> +
> +/* Parse CS Mode 0 step data */
> +static void parse_mode_zero_data(struct iovec *iov,
> +                                struct cs_mode_zero_data *mode_data,
> +                                uint8_t cs_role)
> +{
> +       uint32_t freq_offset;
> +
> +       if (iov->iov_len < 3) {
> +               DBG("Mode 0: too short (<3)");
> +               return;
> +       }
> +
> +       util_iov_pull_u8(iov, &mode_data->packet_quality);
> +       util_iov_pull_u8(iov, &mode_data->packet_rssi_dbm);
> +       util_iov_pull_u8(iov, &mode_data->packet_ant);
> +       DBG("CS Step mode 0");
> +
> +       if (cs_role =3D=3D CS_INITIATOR && iov->iov_len >=3D 4) {
> +               util_iov_pull_le32(iov, &freq_offset);
> +               mode_data->init_measured_freq_offset =3D freq_offset;
> +       }
> +}
> +
> +/* Parse CS Mode 1 step data */
> +static void parse_mode_one_data(struct iovec *iov,
> +                               struct cs_mode_one_data *mode_data,
> +                               uint8_t cs_role, uint8_t cs_rtt_type)
> +{
> +       uint16_t time_val;
> +
> +       if (iov->iov_len < 4) {
> +               DBG("Mode 1: too short (<4)");
> +               return;
> +       }
> +
> +       DBG("CS Step mode 1");
> +       util_iov_pull_u8(iov, &mode_data->packet_quality);
> +       util_iov_pull_u8(iov, &mode_data->packet_rssi_dbm);
> +       util_iov_pull_u8(iov, &mode_data->packet_ant);
> +       util_iov_pull_u8(iov, &mode_data->packet_nadm);
> +
> +       if (iov->iov_len >=3D 2) {
> +               util_iov_pull_le16(iov, &time_val);
> +               if (cs_role =3D=3D CS_REFLECTOR)
> +                       mode_data->tod_toa_refl =3D time_val;
> +               else
> +                       mode_data->toa_tod_init =3D time_val;
> +       }
> +
> +       if ((cs_rtt_type =3D=3D 0x01 || cs_rtt_type =3D=3D 0x02) &&
> +               iov->iov_len >=3D 6) {
> +               int16_t i_val, q_val;
> +
> +               parse_i_q_sample(iov, &i_val, &q_val);
> +               mode_data->packet_pct1.i_sample =3D i_val;
> +               mode_data->packet_pct1.q_sample =3D q_val;
> +
> +               parse_i_q_sample(iov, &i_val, &q_val);
> +               mode_data->packet_pct2.i_sample =3D i_val;
> +               mode_data->packet_pct2.q_sample =3D q_val;
> +       }
> +}
> +
> +/* Parse CS Mode 2 step data */
> +static void parse_mode_two_data(struct iovec *iov,
> +                               struct cs_mode_two_data *mode_data,
> +                               uint8_t max_paths)
> +{
> +       uint8_t k;
> +
> +       if (iov->iov_len < 1) {
> +               DBG("Mode 2: too short (<1)");
> +               return;
> +       }
> +
> +       util_iov_pull_u8(iov, &mode_data->ant_perm_index);
> +       DBG("CS Step mode 2, max paths : %d", max_paths);
> +
> +       for (k =3D 0; k < max_paths; k++) {
> +               int16_t i_val, q_val;
> +
> +               if (iov->iov_len < 4) {
> +                       DBG("Mode 2: insufficient PCT for path %u (rem=3D=
%zu)",
> +                               k, iov->iov_len);
> +                       break;
> +               }
> +               parse_i_q_sample(iov, &i_val, &q_val);
> +               mode_data->tone_pct[k].i_sample =3D i_val;
> +               mode_data->tone_pct[k].q_sample =3D q_val;
> +
> +               util_iov_pull_u8(iov, &mode_data->tone_quality_indicator[=
k]);
> +               DBG("tone_quality_indicator : %d",
> +                       mode_data->tone_quality_indicator[k]);
> +               DBG("[i, q] : %d, %d",
> +                       mode_data->tone_pct[k].i_sample,
> +                       mode_data->tone_pct[k].q_sample);
> +       }
> +}
> +
> +/* Parse CS Mode 3 step data */
> +static void parse_mode_three_data(struct iovec *iov,
> +                               struct cs_mode_three_data *mode_data,
> +                               uint8_t cs_role, uint8_t cs_rtt_type,
> +                               uint8_t max_paths)
> +{
> +       uint8_t k;
> +       struct cs_mode_one_data *mode_one =3D &mode_data->mode_one_data;
> +       struct cs_mode_two_data *mode_two =3D &mode_data->mode_two_data;
> +
> +       if (iov->iov_len < 4) {
> +               DBG("Mode 3: mode1 too short (<4)");
> +               return;
> +       }
> +
> +       DBG("CS Step mode 3");
> +
> +       /* Parse Mode 1 portion */
> +       parse_mode_one_data(iov, mode_one, cs_role, cs_rtt_type);
> +
> +       /* Parse Mode 2 portion */
> +       if (iov->iov_len >=3D 1) {
> +               util_iov_pull_u8(iov, &mode_two->ant_perm_index);
> +               for (k =3D 0; k < max_paths; k++) {
> +                       int16_t i_val, q_val;
> +
> +                       if (iov->iov_len < 4)
> +                               break;
> +                       parse_i_q_sample(iov, &i_val, &q_val);
> +                       mode_two->tone_pct[k].i_sample =3D i_val;
> +                       mode_two->tone_pct[k].q_sample =3D q_val;
> +
> +                       util_iov_pull_u8(iov,
> +                                        &mode_two->tone_quality_indicato=
r[k]);
> +               }
> +       }
> +}
> +
> +/* Parse a single CS step */
> +static void parse_cs_step(struct iovec *iov, struct cs_step_data *step,
> +                       uint8_t cs_role, uint8_t cs_rtt_type,
> +                       uint8_t max_paths)
> +{
> +       uint8_t mode;
> +       uint8_t chnl;
> +       uint8_t length;
> +
> +       /* Check if we have enough data for the 3-byte header */
> +       if (iov->iov_len < 3) {
> +               DBG("Truncated header for step");
> +               return;
> +       }
> +
> +       /* Read mode, channel, and length (3-byte header) */
> +       if (!util_iov_pull_u8(iov, &mode) ||
> +               !util_iov_pull_u8(iov, &chnl) ||
> +               !util_iov_pull_u8(iov, &length)) {
> +               DBG("Failed to read header for step");
> +               return;
> +       }
> +
> +       DBG("event->step_data_len : %d", length);
> +
> +       step->step_mode =3D mode;
> +       step->step_chnl =3D chnl;
> +       step->step_data_length =3D length;
> +
> +       DBG("Step: mode=3D%u chnl=3D%u data_len=3D%u", mode, chnl, length=
);
> +
> +       if (iov->iov_len < length) {
> +               DBG("Truncated payload for step (need %u, have %zu)",
> +                       length, iov->iov_len);
> +               return;
> +       }
> +
> +       /* Parse step data based on mode */
> +       switch (mode) {
> +       case CS_MODE_ZERO:
> +               parse_mode_zero_data(iov, &step->step_mode_data.mode_zero=
_data,
> +                                       cs_role);
> +               break;
> +       case CS_MODE_ONE:
> +               parse_mode_one_data(iov, &step->step_mode_data.mode_one_d=
ata,
> +                                       cs_role, cs_rtt_type);
> +               break;
> +       case CS_MODE_TWO:
> +               parse_mode_two_data(iov, &step->step_mode_data.mode_two_d=
ata,
> +                                       max_paths);
> +               break;
> +       case CS_MODE_THREE:
> +               parse_mode_three_data(iov,
> +                                       &step->step_mode_data.mode_three_=
data,
> +                                       cs_role, cs_rtt_type, max_paths);
> +               break;
> +       default:
> +               DBG("Unknown step mode %d", mode);
> +               /* Skip the entire step data */
> +               util_iov_pull(iov, length);
> +               break;
> +       }
> +}
> +
> +static void rap_cs_subevt_result_evt(const uint8_t *data, uint8_t size,
> +                               void *user_data)
> +{
> +       struct cs_state_machine_t *sm =3D (struct cs_state_machine_t *)us=
er_data;
> +       struct rap_ev_cs_subevent_result *rap_ev;
> +       struct iovec iov;
> +       uint8_t cs_role;
> +       uint8_t cs_rtt_type;
> +       uint8_t max_paths;
> +       uint8_t steps;
> +       size_t send_len =3D 0;
> +       uint16_t handle;
> +       uint8_t config_id;
> +       uint16_t start_acl_conn_evt_counter;
> +       uint16_t proc_counter;
> +       uint16_t freq_comp;
> +       uint8_t ref_pwr_lvl;
> +       uint8_t proc_done_status;
> +       uint8_t subevt_done_status;
> +       uint8_t abort_reason;
> +       uint8_t num_ant_paths;
> +       uint8_t num_steps_reported;
> +       uint8_t i;
> +
> +       if (!sm || !data ||
> +               size < sizeof(struct bt_hci_evt_le_cs_subevent_result))
> +               return;
> +
> +       /* Initialize iovec with the event data */
> +       iov.iov_base =3D (void *)data;
> +       iov.iov_len =3D size;
> +
> +       /* Check if Procedure is active or not */
> +       if (!sm->procedure_active) {
> +               DBG("Received Subevent event when Procedure is inactive!"=
);
> +               return;
> +       }
> +
> +       /* Parse header fields using iovec */
> +       if (!util_iov_pull_le16(&iov, &handle)) {
> +               DBG("[ERROR] Failed to parse Connection_Handle\n");
> +               return;
> +       }
> +
> +       if (!util_iov_pull_u8(&iov, &config_id) ||
> +               !util_iov_pull_le16(&iov, &start_acl_conn_evt_counter) ||
> +               !util_iov_pull_le16(&iov, &proc_counter) ||
> +               !util_iov_pull_le16(&iov, &freq_comp) ||
> +               !util_iov_pull_u8(&iov, &ref_pwr_lvl) ||
> +               !util_iov_pull_u8(&iov, &proc_done_status) ||
> +               !util_iov_pull_u8(&iov, &subevt_done_status) ||
> +               !util_iov_pull_u8(&iov, &abort_reason) ||
> +               !util_iov_pull_u8(&iov, &num_ant_paths) ||
> +               !util_iov_pull_u8(&iov, &num_steps_reported)) {
> +               DBG("[ERROR] Failed to parse subevent fields\n");
> +               return;
> +       }
> +
> +       cs_role =3D cs_opt.role;
> +       cs_rtt_type =3D cs_opt.rtt_type;
> +       max_paths =3D MIN((num_ant_paths + 1), CS_MAX_ANT_PATHS);
> +       steps =3D MIN(num_steps_reported, CS_MAX_STEPS);
> +       send_len =3D offsetof(struct rap_ev_cs_subevent_result, step_data=
) +
> +                                       steps * sizeof(struct cs_step_dat=
a);
> +       rap_ev =3D (struct rap_ev_cs_subevent_result *)malloc(send_len);
> +       if (!rap_ev) {
> +               DBG("[ERROR] Failed to allocate memory for subevent resul=
t\n");
> +               return;
> +       }
> +
> +       DBG("[EVENT] Subevent Result (length=3D%u)\n", size);
> +       rap_ev->conn_hdl                     =3D le16_to_cpu(handle);
> +       rap_ev->config_id                    =3D config_id;
> +       rap_ev->start_acl_conn_evt_counter   =3D start_acl_conn_evt_count=
er;
> +       rap_ev->proc_counter                 =3D proc_counter;
> +       rap_ev->freq_comp                    =3D freq_comp;
> +       rap_ev->ref_pwr_lvl                  =3D ref_pwr_lvl;
> +       rap_ev->proc_done_status             =3D proc_done_status;
> +       rap_ev->subevt_done_status           =3D subevt_done_status;
> +       rap_ev->abort_reason                 =3D abort_reason;
> +       rap_ev->num_ant_paths                =3D num_ant_paths;
> +       rap_ev->num_steps_reported           =3D steps;
> +
> +       if (num_steps_reported > CS_MAX_STEPS) {
> +               DBG("Too many steps reported: %u (max %u)",
> +                       num_steps_reported, CS_MAX_STEPS);
> +               goto send_event;
> +       }
> +
> +       /* Early exit for error conditions */
> +       if (rap_ev->subevt_done_status =3D=3D 0xF ||
> +           rap_ev->proc_done_status =3D=3D 0xF) {
> +               DBG("CS Procedure/Subevent aborted: ");
> +               DBG("sub evt status =3D %d, proc status =3D %d, reason =
=3D %d",
> +                       rap_ev->subevt_done_status, rap_ev->proc_done_sta=
tus,
> +                       rap_ev->abort_reason);
> +               goto send_event;
> +       }
> +
> +       /* Parse interleaved step data from remaining iovec data */
> +       for (i =3D 0; i < steps; i++)
> +               parse_cs_step(&iov, &rap_ev->step_data[i], cs_role, cs_rt=
t_type,
> +                       max_paths);
> +
> +send_event:
> +       DBG("CS subevent result processed: %zu bytes, ", send_len);
> +       bt_rap_hci_cs_subevent_result_callback(send_len, rap_ev, sm->rap)=
;
> +       free(rap_ev);
> +}
> +
> +static void rap_cs_subevt_result_cont_evt(const uint8_t *data, uint8_t s=
ize,
> +                                       void *user_data)
> +{
> +       struct cs_state_machine_t *sm =3D (struct cs_state_machine_t *)us=
er_data;
> +       struct rap_ev_cs_subevent_result_cont *rap_ev;
> +       struct iovec iov;
> +       uint8_t cs_role;
> +       uint8_t cs_rtt_type;
> +       uint8_t max_paths;
> +       uint8_t steps;
> +       size_t send_len =3D 0;
> +       uint16_t handle;
> +       uint8_t config_id;
> +       uint8_t proc_done_status;
> +       uint8_t subevt_done_status;
> +       uint8_t abort_reason;
> +       uint8_t num_ant_paths;
> +       uint8_t num_steps_reported;
> +       uint8_t i;
> +
> +       if (!sm || !data ||
> +               size < sizeof(struct bt_hci_evt_le_cs_subevent_result_con=
tinue))
> +               return;
> +
> +       /* Initialize iovec with the event data */
> +       iov.iov_base =3D (void *)data;
> +       iov.iov_len =3D size;
> +
> +       /* Check if Procedure is active or not */
> +       if (!sm->procedure_active) {
> +               DBG("Received Subevent when CS Procedure is inactive!");
> +               return;
> +       }
> +
> +       /* Parse header fields using iovec */
> +       if (!util_iov_pull_le16(&iov, &handle)) {
> +               DBG("[ERROR] Failed to parse Connection_Handle\n");
> +               return;
> +       }
> +
> +       if (!util_iov_pull_u8(&iov, &config_id) ||
> +               !util_iov_pull_u8(&iov, &proc_done_status) ||
> +               !util_iov_pull_u8(&iov, &subevt_done_status) ||
> +               !util_iov_pull_u8(&iov, &abort_reason) ||
> +               !util_iov_pull_u8(&iov, &num_ant_paths) ||
> +               !util_iov_pull_u8(&iov, &num_steps_reported)) {
> +               DBG("[ERROR] Failed to parse subevent continue fields ");
> +               return;
> +       }
> +
> +       cs_role =3D cs_opt.role;
> +       cs_rtt_type =3D cs_opt.rtt_type;
> +       max_paths =3D MIN((num_ant_paths + 1), CS_MAX_ANT_PATHS);
> +       steps =3D MIN(num_steps_reported, CS_MAX_STEPS);
> +       send_len =3D offsetof(struct rap_ev_cs_subevent_result_cont, step=
_data) +
> +                                       steps * sizeof(struct cs_step_dat=
a);
> +       rap_ev =3D (struct rap_ev_cs_subevent_result_cont *)malloc(send_l=
en);
> +       if (!rap_ev) {
> +               DBG("[ERROR] Failed to allocate memory for subevent resul=
t\n");
> +               return;
> +       }
> +
> +       DBG("[EVENT] Subevent Result Cont (length=3D%u)\n", size);
> +       rap_ev->conn_hdl                     =3D le16_to_cpu(handle);
> +       rap_ev->config_id                    =3D config_id;
> +       rap_ev->proc_done_status             =3D proc_done_status;
> +       rap_ev->subevt_done_status           =3D subevt_done_status;
> +       rap_ev->abort_reason                 =3D abort_reason;
> +       rap_ev->num_ant_paths                =3D num_ant_paths;
> +       rap_ev->num_steps_reported           =3D steps;
> +
> +       if (num_steps_reported > CS_MAX_STEPS) {
> +               DBG("Too many steps reported: %u (max %u)",
> +                       num_steps_reported, CS_MAX_STEPS);
> +               goto send_event;
> +       }
> +
> +       /* Early exit for error conditions */
> +       if (rap_ev->subevt_done_status =3D=3D 0xF ||
> +           rap_ev->proc_done_status =3D=3D 0xF) {
> +               DBG("CS Procedure/Subevent aborted: ");
> +               DBG("sub evt status =3D %d, proc status =3D %d, reason =
=3D %d",
> +                       rap_ev->subevt_done_status, rap_ev->proc_done_sta=
tus,
> +                       rap_ev->abort_reason);
> +               goto send_event;
> +       }
> +
> +       /* Parse interleaved step data from remaining iovec data */
> +       for (i =3D 0; i < steps; i++)
> +               parse_cs_step(&iov, &rap_ev->step_data[i], cs_role, cs_rt=
t_type,
> +                       max_paths);
> +
> +send_event:
> +       DBG("CS subevent result cont processed: %zu bytes, ", send_len);
> +       bt_rap_hci_cs_subevent_result_cont_callback(send_len, rap_ev, sm-=
>rap);
> +       free(rap_ev);
> +}
> +
> +/* Subevent handler function type */
> +typedef void (*subevent_handler_t)(const uint8_t *data, uint8_t size,
> +                                  void *user_data);
> +
> +/* Subevent table entry */
> +struct subevent_entry {
> +       uint8_t opcode;
> +       uint8_t min_len;
> +       uint8_t max_len;
> +       subevent_handler_t handler;
> +       const char *name;
> +};
> +
> +/* Subevent dispatch table */
> +static const struct subevent_entry subevent_table[] =3D {
> +       {
> +               .opcode =3D BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE,
> +               .min_len =3D sizeof(
> +                       struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete)=
,
> +               .max_len =3D 0xFF,
> +               .handler =3D rap_rd_rmt_supp_cap_cmplt_evt,
> +               .name =3D "CS Read Remote Supported Capabilities Complete=
"
> +       },

Have a macro to define each entry, HCI_EVT(...), that way we don't
need to enter the struct field names.

> +       {
> +               .opcode =3D BT_HCI_EVT_LE_CS_CONFIG_COMPLETE,
> +               .min_len =3D sizeof(struct bt_hci_evt_le_cs_config_comple=
te),
> +               .max_len =3D 0xFF,
> +               .handler =3D rap_cs_config_cmplt_evt,
> +               .name =3D "CS Config Complete"
> +       },
> +       {
> +               .opcode =3D BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE,
> +               .min_len =3D sizeof(struct bt_hci_evt_le_cs_sec_enable_co=
mplete),
> +               .max_len =3D 0xFF,
> +               .handler =3D rap_cs_sec_enable_cmplt_evt,
> +               .name =3D "CS Security Enable Complete"
> +       },
> +       {
> +               .opcode =3D BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE,
> +               .min_len =3D sizeof(struct bt_hci_evt_le_cs_proc_enable_c=
omplete),
> +               .max_len =3D 0xFF,
> +               .handler =3D rap_cs_proc_enable_cmplt_evt,
> +               .name =3D "CS Procedure Enable Complete"
> +       },
> +       {
> +               .opcode =3D BT_HCI_EVT_LE_CS_SUBEVENT_RESULT,
> +               .min_len =3D sizeof(struct bt_hci_evt_le_cs_subevent_resu=
lt),
> +               .max_len =3D 0xFF,
> +               .handler =3D rap_cs_subevt_result_evt,
> +               .name =3D "CS Subevent Result"
> +       },
> +       {
> +               .opcode =3D BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
> +               .min_len =3D sizeof(
> +                       struct bt_hci_evt_le_cs_subevent_result_continue)=
,
> +               .max_len =3D 0xFF,
> +               .handler =3D rap_cs_subevt_result_cont_evt,
> +               .name =3D "CS Subevent Result Continue"
> +       }
> +};
> +
> +#define SUBEVENT_TABLE_SIZE ARRAY_SIZE(subevent_table)
> +
> +/* HCI Event Registration */
> +static void rap_handle_hci_events(const void *data, uint8_t size,
> +                               void *user_data)
> +{
> +       struct iovec iov;
> +       uint8_t subevent;
> +       const struct subevent_entry *entry =3D NULL;
> +       size_t i;
> +
> +       /* Initialize iovec with the event data */
> +       iov.iov_base =3D (void *)data;
> +       iov.iov_len =3D size;
> +
> +       /* Pull the subevent code */
> +       if (!util_iov_pull_u8(&iov, &subevent)) {
> +               DBG("Failed to parse subevent code");
> +               return;
> +       }
> +
> +       /* Find the subevent in the table */
> +       for (i =3D 0; i < SUBEVENT_TABLE_SIZE; i++) {
> +               if (subevent_table[i].opcode =3D=3D subevent) {
> +                       entry =3D &subevent_table[i];
> +                       break;
> +               }
> +       }
> +
> +       /* Check if subevent is supported */
> +       if (!entry) {
> +               DBG("Unknown subevent: 0x%02X", subevent);
> +               return;
> +       }
> +
> +       /* Validate payload length */
> +       if (iov.iov_len < entry->min_len) {
> +               DBG("%s: payload too short (%zu < %u)",
> +                   entry->name, iov.iov_len, entry->min_len);
> +               return;
> +       }
> +
> +       if (entry->max_len !=3D 0xFF && iov.iov_len > entry->max_len) {
> +               DBG("%s: payload too long (%zu > %u)",
> +                   entry->name, iov.iov_len, entry->max_len);
> +               return;
> +       }
> +
> +       /* Call the handler */
> +       DBG("Handling %s (opcode=3D0x%02X, len=3D%zu)",
> +           entry->name, subevent, iov.iov_len);
> +
> +       entry->handler(iov.iov_base, iov.iov_len, user_data);
> +}
> +
> +void bt_rap_hci_register_events(struct bt_rap *rap, struct bt_hci *hci)
> +{
> +       if (!rap || !hci)
> +               return;
> +
> +       sm =3D new0(struct cs_state_machine_t, 1);
> +       if (!sm) {
> +               DBG("[ERROR] Failed to allocate state machine\n");
> +               return;
> +       }
> +
> +       cs_state_machine_init(sm, rap, hci);
> +       sm->event_id =3D bt_hci_register(hci, BT_HCI_EVT_LE_META_EVENT,
> +                                       rap_handle_hci_events, sm, NULL);
> +
> +       DBG("bt_hci_register done, event_id : %d", sm->event_id);
> +
> +       if (!sm->event_id) {
> +               DBG("Error: Failed to register hci le meta events ");
> +               DBG("event_id=3D0x%02X\n", sm->event_id);
> +               free(sm);
> +               return;
> +       }
> +}
> +
> +bool bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci)
> +{
> +       if (!rap)
> +               return false;
> +
> +       if (!hci) {
> +               DBG("Failed to create HCI RAW channel ");
> +               bt_hci_unref(hci);
> +               return false;
> +       }
> +
> +       bt_rap_hci_register_events(rap, hci);
> +
> +       return true;
> +}
> +
> +bool bt_rap_set_conn_handle(struct bt_rap *rap, uint16_t handle,
> +                               const uint8_t *bdaddr, uint8_t bdaddr_typ=
e)
> +{
> +       struct bt_att *att;
> +
> +       if (!rap)
> +               return false;
> +
> +       att =3D bt_rap_get_att(rap);
> +       if (!att)
> +               return false;
> +
> +       DBG("Setting connection mapping: handle=3D0x%04X, ", handle);
> +       if (bdaddr) {
> +               DBG("bdaddr=3D%02x:%02x:%02x:%02x:%02x:%02x type=3D%u",
> +                       bdaddr[5], bdaddr[4], bdaddr[3],
> +                       bdaddr[2], bdaddr[1], bdaddr[0], bdaddr_type);
> +       }
> +
> +       return add_conn_mapping(handle, bdaddr, bdaddr_type, att, rap);
> +}
> +
> +void bt_rap_clear_conn_handle(struct bt_rap *rap, uint16_t handle)
> +{
> +       if (!rap)
> +               return;
> +
> +       DBG("Clearing connection mapping: handle=3D0x%04X", handle);
> +       remove_conn_mapping(handle);
> +}
> +
> +void bt_rap_detach_hci(struct bt_rap *rap)
> +{
> +       if (!rap)
> +               return;
> +
> +       DBG("Detaching RAP from HCI, cleaning up mappings");
> +
> +       /* Remove all mappings associated with this RAP instance */
> +       remove_rap_mappings(rap);
> +}
> --
>


--=20
Luiz Augusto von Dentz
