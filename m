Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA536308D
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145535; cv=pass; b=JAD6oz+/Pm4Mgm5BtN90iGTZ0eD/rlD+MJenNQHNicahnkwXYaDOVS911jjLkH652DN/Y9MNkLn7M6V7ogMmG9SG88nVcG1gvnrdZMwsXxcZCdePs3dt84eRo7glky2n6/DwF6tlG3/8OOeASbVBfjkJ6hysGCnCsVvtveOrPC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145535; c=relaxed/simple;
	bh=Su4sLdvSJBT7ZeII9URKpP/rZipdxhVGhrTuAbSk0Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6kZD8IUX64erIWLdRDUKxeprgHqnEdYNI0OdLbW7nA2KxdZ46xgEMFE143XhOfiD3TXWRqIXku6K3FOHZeuV9EllmLXS2MvMbpFBJjZjzaxpUCfKsqYF9BGPRYOg7qzRfQg/hAkSzT6xFT9I0hGok1jO0bMoInG6F+YDd0LnBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUQi9mHV; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUQi9mHV"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-650182d19e0so1240547d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 08:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775145529; cv=none;
        d=google.com; s=arc-20240605;
        b=cXXCYp2e4UsNyxzWSNbQxDT4qjeuaWCekEmPGqtBovg2spB7Dyj12t6OLdSDsvc791
         aDASpWlQk2Ki9WqFtaphRcY7wpEdTIC4fjQLzkzkn72tphTx6kOd+pkv2KvMnIUGc3OG
         kM4tH8igNGHTAaTBJqp8V0z0qhhErR465gxCPwENWYnEWYk2oXA4knMPZEPY/VM44KIy
         yLqcy46WW1v1LKFYBL5NVHrCzFIjqaZ/Lr3YKJZzbFg5rQ50d0889urSpG1kjBebOdMq
         bJ0F9wS3POPlS6Qlezxcheb3CeY+u3Srg+bXz3fI2f9DggQAESAvRG7phMSe9kqhQ2dq
         l7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x+AfFfXg1A7OpaCJpFgBn6YU2anppL75qL+/tR3jr/4=;
        fh=8vmOwSm9QheBlSAtzpU2h+vPN6vqZAy+khabkFtSFIk=;
        b=X4JJti+OvK2Kx/l4QFiXmewSU/LoHsi0W6eNWMSvkcu3a6wCiaRsaPhKYucyxh5POm
         HFwQcmGSubgzJFyAhNdn9lvRgrlFDSb31+26JpnnqXl9WspWk0LuRdDMV3WX3mpF9KAV
         A4UFQpv+wCSioM9N3PYcEJqqAHJpg6yLjKUjlrkyLk16fRAEEU88HQ1iQPMuzjHeKAHA
         W/26D8mKZy1M2+80bPEIz+6G8Gv5P98CTMcrD2chUMWssCXbqMpO4xZTew9sVfZK+hFj
         t3sNBNSZkMxc9Iez1SSmHo7clbG2M1GWSmt9qSS0q9Y4/33l7aXfgPvh/6KpvUEayyxV
         fVzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775145529; x=1775750329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+AfFfXg1A7OpaCJpFgBn6YU2anppL75qL+/tR3jr/4=;
        b=sUQi9mHVc+IYeV8dmRYXtN4YyDs8aFINYJ3xM6X+GfuqGXb0UBrnL89AltsRvRhLi2
         2UblZeAOGR/OIHn3lE/gyV4DU6vDHuwgeWsXX9iUvvvU9N9uqkzawR+oyhXvXBdxzct4
         uKhzRQwpiU3L4epujetWbdbzPA7z+aW2j1K08aTWNOGxMalDRt6nQ9vi8cZcn/4agtCS
         op4TYRAqSO4oVdxBn3MjepMQdKA28ZikJdVK+oH2nwqvwI9olscc6BnjS/mJ2P9XaxgK
         fiiPi6VN+ejqRPGZCxeGMaFCdkg5+SqIE35RTXAM7XAMa/N8FCbuNrqcVDKOfCDKcb/9
         7TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145529; x=1775750329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+AfFfXg1A7OpaCJpFgBn6YU2anppL75qL+/tR3jr/4=;
        b=dKJWfW90LMsz5kPZVjCFTAXBQjgp4mOYTMFVzGiqCIH0MxNaaiosER+E8FothG6Hvw
         7OFy5rfsweMjws1sl5jiXPa116qZ0cNyGrle2beqk5fc58JIwwE9bfEu2pwHwezGnE78
         8Z/0+YU6mMoW9JfKn12EmVyXNrp2nG+CVhTZqE5pEix7km4kWCsJmD80hHTZKaxNoS9M
         faafPQl1skra4nMXuuBVdNsBHg9WZSh3nffVvi+8hIab3bZSpZh+55FNEaqkgcEjHgjS
         zJ3tUneZ+m4m+BPZMNhVOeNGx0fPhmfV8BYx4QZ/duWI6VrtbQgS22ooXcL6ID7D0rIc
         vh3w==
X-Gm-Message-State: AOJu0YxcKJWOmsO9/sgFURl3+od4ESEW4yFiqBNsJ9GBt6nkFFWrj7/g
	5OqIaE+Zcn9KXaOwOMQ7xI3wGMP+648v+esTlUaJWJJazuV1z3fM+8YNaZZk6lyGwgzAeVIseYa
	QI4QJDTlznH+BaiH0x0QNEd/81Kw0IQo=
X-Gm-Gg: AeBDieuW4dyO1HuQvQzfq9IaXL6sZ5M8VNpVLVEGaWjHJ6efWaEoVTUIwfRpRP6QsuU
	hGunb0ST1ZYrHi2nLthwPtCltGOOo3KP1Zj3vaCyFrl0p9tM5/95ZXpn1+H4pP+hADYDzb/eO7O
	6RFnjs7gC/voupKtyQnKUU9sol3wcqRHFcbtKgkUYlfkZF161G5LP90IPdvotI58kgnb8terpZO
	HiNoRjFJW2qIkJAMOJJ+S+ZkV1J6s8XmEwd95H3STLtqubty9kE6TuaNAwvHdeBOOhfmshYhi1D
	hpSVoCP8YalPq0lX0GVqkLdcbwH+efkagdbGJZf2W9x4Iccq592EPtpoLLydoEdv/m5adg==
X-Received: by 2002:a53:ac9d:0:b0:650:aec:4e93 with SMTP id
 956f58d0204a3-6502fdc12camr8076216d50.20.1775145528801; Thu, 02 Apr 2026
 08:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402103900.310778-1-naga.akella@oss.qualcomm.com> <20260402103900.310778-4-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260402103900.310778-4-naga.akella@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Apr 2026 11:58:37 -0400
X-Gm-Features: AQROBzDNj_OGlP9jB0Ug8gLi-mTxcUhFTb1bAWelevSTYGJN_KrexRhd7zOyfaM
Message-ID: <CABBYNZJ9TrrHFfeBTW4=MxSserovskivHXbPwqRSo5kKmet7YA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 3/3] profiles: ranging: Add HCI LE Event Handling
 in Reflector role
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	prathibha.madugonde@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Thu, Apr 2, 2026 at 6:39=E2=80=AFAM Naga Bhavani Akella
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
> ---
>  Makefile.plugins           |    3 +-
>  profiles/ranging/rap.c     |   27 +
>  profiles/ranging/rap_hci.c | 1296 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1325 insertions(+), 1 deletion(-)
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
> index f03454c72..1b144b471 100644
> --- a/profiles/ranging/rap.c
> +++ b/profiles/ranging/rap.c
> @@ -34,12 +34,17 @@
>  #include "src/shared/rap.h"
>  #include "attrib/att.h"
>  #include "src/log.h"
> +#include "src/btd.h"
>
> +#define USE_BT_HCI_RAW_CHANNEL 1
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
> @@ -95,6 +100,12 @@ static void rap_data_free(struct rap_data *data)
>         }
>
>         bt_rap_ready_unregister(data->rap, data->ready_id);
> +#if USE_BT_HCI_RAW_CHANNEL
> +       if (data->hci) {
> +               bt_rap_hci_sm_cleanup();
> +               bt_hci_unref(data->hci);
> +       }
> +#endif
>         bt_rap_unref(data->rap);
>         free(data);
>  }
> @@ -194,6 +205,22 @@ static int rap_probe(struct btd_service *service)
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
> +       } else {
> +               error("HCI raw channel not available (may be in use)");
> +       }
> +#else /* USE_BT_HCI_RAW_CHANNEL */
> +       DBG("MGMT Events");
> +#endif /* USE_BT_HCI_RAW_CHANNEL */
>
>         rap_data_add(data);
>
> diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
> new file mode 100644
> index 000000000..5d1aba8f2
> --- /dev/null
> +++ b/profiles/ranging/rap_hci.c
> @@ -0,0 +1,1296 @@
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
> +#include "src/shared/rap.h"
> +#include "src/shared/hci.h"
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
> +       struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete ev;
> +       struct iovec iov;
> +       uint8_t status;
> +       uint16_t handle;
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

Ok, so we got a connection handle; how will we map it back to the
device/ATT connection? I guess that needs to be worked out first,
perhaps with HCIGETCONNLIST so we can resolve the handle. That
actually has some limitation since there is no bdaddr type we cannot
resolve if it is a RPA for example. Since this is considered a
temporary solution maybe that can be worked out. We might want to
build helpers for ioctls into bt_hci e.g. bt_hci_get_conn_list, to
make it simpler to submit commands.

> +
> +       ev.status =3D status;
> +       ev.handle =3D handle;
> +
> +       DBG("[EVENT] Remote Capabilities Complete\n");
> +       DBG("status=3D0x%02X, handle=3D0x%04X\n", ev.status, ev.handle);
> +
> +       if (ev.status =3D=3D 0) {
> +               uint8_t u8_val;
> +               uint16_t u16_val;
> +
> +               /* Parse remaining fields only if status is success */
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.num_config_supported =3D u8_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.max_consecutive_procedures_supported =3D u16_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.num_antennas_supported =3D u8_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.max_antenna_paths_supported =3D u8_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.roles_supported =3D u8_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.modes_supported =3D u8_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.rtt_capability =3D u8_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.rtt_aa_only_n =3D u8_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.rtt_sounding_n =3D u8_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.rtt_random_payload_n =3D u8_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.nadm_sounding_capability =3D u16_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.nadm_random_capability =3D u16_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.cs_sync_phys_supported =3D u8_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.subfeatures_supported =3D u16_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.t_ip1_times_supported =3D u16_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.t_ip2_times_supported =3D u16_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.t_fcs_times_supported =3D u16_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.t_pm_times_supported =3D u16_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +               ev.t_sw_time_supported =3D u8_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse fields\n");
> +                       cs_set_state(sm, CS_STOPPED);

I would rather use a goto failed and handle these in a single place.

> +                       return;
> +               }
> +
> +               DBG("[EVENT] Remote Capabilities: num_config=3D%u, ",
> +                       ev.num_config_supported);
> +               DBG("max_consecutive_proc=3D%u, num_antennas=3D%u, ",
> +                       ev.max_consecutive_procedures_supported,
> +                       ev.num_antennas_supported);
> +               DBG("max_antenna_paths=3D%u, roles=3D0x%02X, modes=3D0x%0=
2X\n",
> +                       ev.max_antenna_paths_supported,
> +                       ev.roles_supported,
> +                       ev.modes_supported);
> +
> +               rap_send_hci_def_settings_command(sm, &ev);
> +               cs_set_state(sm, CS_INIT);
> +       } else {
> +               /* Error - transition to stopped */
> +               DBG("[ERROR] Remote capabilities failed with status 0x%02=
X\n",
> +                       ev.status);
> +               cs_set_state(sm, CS_STOPPED);
> +       }
> +}
> +
> +static void rap_cs_config_cmplt_evt(const uint8_t *data, uint8_t size,
> +                                   void *user_data)
> +{
> +       struct cs_state_machine_t *sm =3D (struct cs_state_machine_t *)us=
er_data;
> +       struct rap_ev_cs_config_cmplt rap_ev;
> +       struct iovec iov;
> +       uint8_t status;
> +       uint16_t handle;
> +       uint8_t i;
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
> +       if (rap_ev.status =3D=3D 0) {
> +               /* Parse remaining fields only if status is success */
> +               if (!util_iov_pull_u8(&iov, &rap_ev.config_id) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.action) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.main_mode_type) |=
|
> +                       !util_iov_pull_u8(&iov, &rap_ev.sub_mode_type) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.min_main_mode_ste=
ps) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.max_main_mode_ste=
ps) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.main_mode_rep) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.mode_0_steps) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.role) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.rtt_type) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.cs_sync_phy)) {
> +                       DBG("[ERROR] Failed to parse config fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }

If it is not a variable length you just pull the entire struct at once
rather than doing it one by one.

> +
> +               /* Store rtt_type in global options */
> +               cs_opt.rtt_type =3D rap_ev.rtt_type;
> +
> +               /* Parse Channel_Map (10 bytes) */
> +               for (i =3D 0; i < 10; i++) {
> +                       if (!util_iov_pull_u8(&iov, &rap_ev.channel_map[i=
])) {
> +                               DBG("[ERROR] Failed to parse Channel_Map[=
%u]\n",
> +                                       i);
> +                               cs_set_state(sm, CS_STOPPED);
> +                               return;
> +                       }
> +               }
> +
> +               /* Parse remaining fields */
> +               if (!util_iov_pull_u8(&iov, &rap_ev.channel_map_rep) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.channel_sel_type)=
 ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.ch3c_shape) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.ch3c_jump) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.reserved) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.t_ip1_time) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.t_ip2_time) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.t_fcs_time) ||
> +                       !util_iov_pull_u8(&iov, &rap_ev.t_pm_time)) {
> +                       DBG("[ERROR] Failed to parse timing fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       return;
> +               }
> +
> +               DBG("[EVENT] Config Complete: config_id=3D%u, action=3D%u=
, ",
> +                       rap_ev.config_id, rap_ev.action);
> +               DBG("main_mode=3D%u, sub_mode=3D%u, role=3D%u, rtt_type=
=3D%u\n",
> +                       rap_ev.main_mode_type, rap_ev.sub_mode_type,
> +                       rap_ev.role, rap_ev.rtt_type);
> +
> +               /* Success - proceed to Security enable complete */
> +               cs_set_state(sm, CS_WAIT_SEC_CMPLT);
> +
> +               /* Reflector role */
> +               DBG("Waiting for security enable event...\n");
> +               /* TODO: Initiator role - Send CS Security enable cmd */
> +       } else {
> +               /* Error - transition to stopped */
> +               DBG("[ERROR] Configuration failed with status 0x%02X\n",
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
> +       struct rap_ev_cs_proc_enable_cmplt rap_ev;
> +       struct iovec iov;
> +       uint8_t status;
> +       uint16_t handle;
> +       uint8_t i;
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
> +
> +       /* State Check */
> +       if (cs_get_current_state(sm) !=3D CS_WAIT_PROC_CMPLT) {
> +               DBG("Event received in Wrong State!! ");
> +               DBG("Expected : CS_WAIT_PROC_CMPLT");
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
> +       if (rap_ev.status =3D=3D 0) {
> +               uint8_t u8_val;
> +               uint16_t u16_val;
> +
> +               /* Parse remaining fields only if status is success */
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse ");
> +                       DBG("procedure enable fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       sm->procedure_active =3D false;
> +                       return;
> +               }
> +               rap_ev.config_id =3D u8_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse ");
> +                       DBG("procedure enable fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       sm->procedure_active =3D false;
> +                       return;
> +               }
> +               rap_ev.state =3D u8_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse ");
> +                       DBG("procedure enable fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       sm->procedure_active =3D false;
> +                       return;
> +               }
> +               rap_ev.tone_ant_config_sel =3D u8_val;
> +
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse ");
> +                       DBG("procedure enable fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       sm->procedure_active =3D false;
> +                       return;
> +               }
> +
> +               rap_ev.sel_tx_pwr =3D u8_val;
> +
> +               /* Parse Subevent_Len (3 bytes) */
> +               for (i =3D 0; i < 3; i++) {
> +                       if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                               DBG("[ERROR]Failed to parse Subevent_Len[=
%u]\n",
> +                                       i);
> +                               cs_set_state(sm, CS_STOPPED);
> +                               sm->procedure_active =3D false;
> +                               return;
> +                       }
> +                       rap_ev.sub_evt_len[i] =3D u8_val;
> +               }
> +
> +               /* Parse remaining fields */
> +               if (!util_iov_pull_u8(&iov, &u8_val)) {
> +                       DBG("[ERROR] Failed to parse ");
> +                       DBG("procedure timing fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       sm->procedure_active =3D false;
> +                       return;
> +               }
> +               rap_ev.sub_evts_per_evt =3D u8_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse ");
> +                       DBG("procedure timing fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       sm->procedure_active =3D false;
> +                       return;
> +               }
> +               rap_ev.sub_evt_intrvl =3D u16_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse ");
> +                       DBG("procedure timing fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       sm->procedure_active =3D false;
> +                       return;
> +               }
> +               rap_ev.evt_intrvl =3D u16_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse ");
> +                       DBG("procedure timing fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       sm->procedure_active =3D false;
> +                       return;
> +               }
> +               rap_ev.proc_intrvl =3D u16_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse ");
> +                       DBG("procedure timing fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       sm->procedure_active =3D false;
> +                       return;
> +               }
> +               rap_ev.proc_counter =3D u16_val;
> +
> +               if (!util_iov_pull_le16(&iov, &u16_val)) {
> +                       DBG("[ERROR] Failed to parse ");
> +                       DBG("procedure timing fields\n");
> +                       cs_set_state(sm, CS_STOPPED);
> +                       sm->procedure_active =3D false;
> +                       return;
> +               }
> +
> +               DBG("[EVENT] Procedure Enable: config_id=3D%u, state=3D%u=
, ",
> +                       rap_ev.config_id, rap_ev.state);
> +               DBG("sub_evts_per_evt=3D%u, evt_intrvl=3D%u, proc_intrvl=
=3D%u\n",
> +                       rap_ev.sub_evts_per_evt, rap_ev.evt_intrvl,
> +                       rap_ev.proc_intrvl);
> +
> +               /* Success - procedure started */
> +               cs_set_state(sm, CS_STARTED);
> +               sm->procedure_active =3D true;
> +       } else {
> +               /* Error - transition to stopped */
> +               DBG("[ERROR] Procedure enable failed with status 0x%02X\n=
",
> +                       rap_ev.status);
> +               cs_set_state(sm, CS_STOPPED);
> +               sm->procedure_active =3D false;
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
> +
> +       /* Reconstruct 24-bit buffer from 3 bytes */
> +       buffer =3D (uint32_t)bytes[0] | ((uint32_t)bytes[1] << 8) |
> +                               ((uint32_t)bytes[2] << 16);
> +       i12 =3D  buffer        & 0x0FFFU;   /* bits 0..11 */
> +       q12 =3D (buffer >> 12) & 0x0FFFU;   /* bits 12..23 */
> +
> +       /* Sign-extend 12-bit values to 16-bit */
> +       *i_sample =3D (int16_t)((int32_t)(i12 << 20) >> 20);
> +       *q_sample =3D (int16_t)((int32_t)(q12 << 20) >> 20);
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
> +/* HCI Event Registration */
> +static void rap_handle_hci_events(const void *data, uint8_t size,
> +                               void *user_data)
> +{
> +       struct iovec iov;
> +       uint8_t subevent;
> +
> +       /* Initialize iovec with the event data */
> +       iov.iov_base =3D (void *)data;
> +       iov.iov_len =3D size;
> +
> +       /* Pull the subevent code */
> +       if (!util_iov_pull_u8(&iov, &subevent))
> +               return;
> +
> +       /* Now iov points to the payload, and iov_len is the payload leng=
th */
> +       switch (subevent) {
> +       case BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE:
> +               rap_rd_rmt_supp_cap_cmplt_evt(iov.iov_base,
> +                                       iov.iov_len, user_data);
> +               break;
> +       case BT_HCI_EVT_LE_CS_CONFIG_COMPLETE:
> +               rap_cs_config_cmplt_evt(iov.iov_base,
> +                                       iov.iov_len, user_data);
> +               break;
> +       case BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE:
> +               rap_cs_sec_enable_cmplt_evt(iov.iov_base,
> +                                       iov.iov_len, user_data);
> +               break;
> +       case BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE:
> +               rap_cs_proc_enable_cmplt_evt(iov.iov_base,
> +                                       iov.iov_len, user_data);
> +               break;
> +       case BT_HCI_EVT_LE_CS_SUBEVENT_RESULT:
> +               rap_cs_subevt_result_evt(iov.iov_base,
> +                                       iov.iov_len, user_data);
> +               break;
> +       case BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE:
> +               rap_cs_subevt_result_cont_evt(iov.iov_base,
> +                                       iov.iov_len, user_data);
> +               break;

I'd probably recommend creating a subevent table with subevent op, min
and max length and a callback. That table can then check if there is
enough data and call the callback.

> +       default:
> +               break;
> +       }
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
> --
>


--=20
Luiz Augusto von Dentz
