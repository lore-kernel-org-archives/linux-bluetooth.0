Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E7CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 21:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiAUVGX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 16:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiAUVGV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 16:06:21 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909B4C06173B
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 13:06:20 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id k31so29466110ybj.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 13:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkbMYQXhd338dpDrU7mW2HwLe87GQRxP5K4nOI+uo2Q=;
        b=LxrRvZAWKFGHDfPiXNzw3l/rWO3Q66EKZef6eFwP6K2ktcq+DxK+fDdGgl+gCa6krk
         EYB+dxidowZHQw2aLzJ+mudPRbKdxYgA4y+dZRuGoaQJ1bi1hprSVgbSAmuAgUUUxBqH
         kACIYwQ1K6Vj9Ingtd33ZNmW9jtLgdj5duZ1PgZRRwzTQG4Zevifclfa+4dGGfqAdpTy
         siJZS34X3gk/kEZGsd/VabJeviyDQ8ghrGQxrQtLDMVrhvuHuwrV/jlFW5YTtVmbFJ8J
         zp6WgB6iTTiKlbdRq9st7scMm9Fnrm/FH0WNfmTVAc+yCBHF3kWOC8qAk7eTWo0TGZAw
         DUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkbMYQXhd338dpDrU7mW2HwLe87GQRxP5K4nOI+uo2Q=;
        b=6DPWto/Kb3/UicZNDb660YZKnCi3UG+j5bcGTasnYNz7GXMKs/uTXm6IAGk/W9EEH3
         FMBPnJPlUOvIeapm7TmxAySvuQLfzVjqchF2ncB1RJGvmQZih4fBYoPWgnr073BtyeM0
         mEVVR/awfW8Ljuu0jofI2ptdBM0D5JC1FxBYkLT43/cXus/DpBBkSsjsE7uj35QpPOst
         jS6GVJrKbjCQ7zJ9HJO22UyGxY7ryZ9nM7xFjw0ycMlG0WHMi3yIsLn+EbwL5tOdYECw
         iHUF6zgmC484hnsjQLkPGu8JbVF2Ba7V7+U8gL42M1qO9Cx7a4jf81SfMJNwnyMFwR+N
         FtSA==
X-Gm-Message-State: AOAM5317G4CRGrAidEg2/yIkSOjgHZmVUGzhHgq70EQaMKBUEpzju1vz
        GLvysMVQ1wt4B04gjGehg6XgnlHP/yHGE5oquto=
X-Google-Smtp-Source: ABdhPJym2aOPZRirqD4Cea/dwzTuldwFESdTFrpACemBhKZGZLcSKmr+F7aESu70QamX15Qqe9kUlqhetP4QAmuU8vs=
X-Received: by 2002:a25:3dc2:: with SMTP id k185mr8076882yba.733.1642799179568;
 Fri, 21 Jan 2022 13:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20220121192352.BlueZ.v1.1.Ie4d1be8ced51f0aa92ee6d8eacf9666a121a1292@changeid>
In-Reply-To: <20220121192352.BlueZ.v1.1.Ie4d1be8ced51f0aa92ee6d8eacf9666a121a1292@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Jan 2022 13:06:08 -0800
Message-ID: <CABBYNZ+ybtNDtawZS9FkkajQz84jp9BNMNw2GXXjHD7PpW81sg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1 1/2] adapter: support AOSP MGMT_EV_QUALITY_REPORT
To:     Joseph Hwang <josephsih@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Joseph Hwang <josephsih@google.com>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Fri, Jan 21, 2022 at 3:24 AM Joseph Hwang <josephsih@chromium.org> wrote:
>
> This patch supports a new MGMT event of AOSP bluetooth quality report.
>
> An AOSP quality report looks like:
>
> AOSP Quality Report
>   quality_report_id 1
>   packet_type 23
>   conn_handle 2
>   conn_role 1
>   tx_power_level 5
>   rssi -36
>   snr 0
>   unused_afh_channel_count 0
>   afh_select_unideal_channel_count 0
>   lsto 20000.00
>   conn_piconet_clock 63486046.56
>   retransmission_count 1638
>   no_rx_count 1638
>   nak_count 0
>   last_tx_ack_timestamp 115636.25
>   flow_off_count 0
>   last_flow_on_timestamp 63368203.12
>   buffer_overflow_bytes 0
>   buffer_underflow_bytes 0
>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
>
>  Makefile.am       |   3 +-
>  lib/mgmt.h        |  10 ++++
>  src/adapter.c     |  58 ++++++++++++++++++++++
>  src/adapter.h     |   2 +
>  src/shared/aosp.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/aosp.h |  57 +++++++++++++++++++++
>  6 files changed, 253 insertions(+), 1 deletion(-)
>  create mode 100644 src/shared/aosp.c
>  create mode 100644 src/shared/aosp.h
>
> diff --git a/Makefile.am b/Makefile.am
> index e391d7ae8..baab40369 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -230,7 +230,8 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
>                         src/shared/gatt-db.h src/shared/gatt-db.c \
>                         src/shared/gap.h src/shared/gap.c \
>                         src/shared/log.h src/shared/log.c \
> -                       src/shared/tty.h
> +                       src/shared/tty.h \
> +                       src/shared/aosp.h src/shared/aosp.c
>
>  if READLINE
>  shared_sources += src/shared/shell.c src/shared/shell.h
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 922a24367..1caecc43e 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -1032,6 +1032,16 @@ struct mgmt_ev_adv_monitor_device_lost {
>         struct mgmt_addr_info addr;
>  } __packed;
>
> +#define MGMT_EV_QUALITY_REPORT                 0x0031
> +#define QUALITY_SPEC_NA                                0x0
> +#define QUALITY_SPEC_INTEL_TELEMETRY           0x1
> +#define QUALITY_SPEC_AOSP_BQR                  0x2
> +struct mgmt_ev_quality_report {
> +       uint8_t quality_spec;
> +       uint8_t report_len;
> +       uint8_t report[0];
> +} __packed;
> +

This should probably be introduced separately, and I do expect it to
be properly decoded by the likes of btmon.

>  static const char *mgmt_op[] = {
>         "<0x0000>",
>         "Read Version",
> diff --git a/src/adapter.c b/src/adapter.c
> index 9772e843a..03f0e1ca6 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -47,6 +47,7 @@
>  #include "src/shared/att.h"
>  #include "src/shared/gatt-db.h"
>  #include "src/shared/timeout.h"
> +#include "src/shared/aosp.h"
>
>  #include "btio/btio.h"
>  #include "btd.h"
> @@ -9312,6 +9313,30 @@ static void controller_resume_callback(uint16_t index, uint16_t length,
>         controller_resume_notify(adapter);
>  }
>
> +static void quality_report_callback(uint16_t index, uint16_t length,
> +                                       const void *param, void *user_data)
> +{
> +       const struct mgmt_ev_quality_report *ev = param;
> +       struct btd_adapter *adapter = user_data;
> +
> +       if (!ev)
> +               return;
> +
> +       if (length < sizeof(*ev)) {
> +               btd_error(adapter->dev_id,
> +                               "MGMT_EV_QUALITY_REPORT event too small");
> +               return;
> +       }
> +
> +       if (ev->quality_spec == QUALITY_SPEC_AOSP_BQR) {
> +               if (!process_aosp_quality_report(ev))
> +                       error("processing aosp quality report");
> +       } else {
> +               error("quality report spec %u not supported.",
> +                       ev->quality_spec);
> +       }
> +}
> +
>  static void device_blocked_callback(uint16_t index, uint16_t length,
>                                         const void *param, void *user_data)
>  {
> @@ -9727,6 +9752,19 @@ static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
>                                 (void *)le_simult_central_peripheral_uuid.val);
>  }
>
> +static bool is_exp_feature_uuid_the_same(const void *data,
> +                                                       const void *match_data)
> +{
> +       return memcmp(data, match_data,
> +                       sizeof(((struct mgmt_exp_uuid *)NULL)->val)) == 0;
> +}
> +
> +bool is_quality_report_supported(struct btd_adapter *adapter)
> +{
> +       return queue_find(adapter->exps, is_exp_feature_uuid_the_same,
> +                               (void *)quality_report_uuid.val) != NULL;
> +}
> +
>  static void quality_report_func(struct btd_adapter *adapter, uint8_t action)
>  {
>         if (action)
> @@ -9882,6 +9920,18 @@ static void read_exp_features(struct btd_adapter *adapter)
>         btd_error(adapter->dev_id, "Failed to read exp features info");
>  }
>
> +static void quality_report_debug(const char *str, void *user_data)
> +{
> +       const char *prefix = user_data;
> +
> +       info("%s%s", prefix, str);
> +}
> +
> +static void quality_set_debug(struct btd_adapter *adapter)
> +{
> +       aosp_set_debug(quality_report_debug, "quality: ");
> +}
> +
>  static void read_info_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_data)
>  {
> @@ -10110,6 +10160,11 @@ static void read_info_complete(uint8_t status, uint16_t length,
>                                                 controller_resume_callback,
>                                                 adapter, NULL);
>
> +       mgmt_register(adapter->mgmt, MGMT_EV_QUALITY_REPORT,
> +                                               adapter->dev_id,
> +                                               quality_report_callback,
> +                                               adapter, NULL);
> +
>         set_dev_class(adapter);
>
>         set_name(adapter, btd_adapter_get_name(adapter));
> @@ -10137,6 +10192,9 @@ static void read_info_complete(uint8_t status, uint16_t length,
>         if (btd_adapter_get_powered(adapter))
>                 adapter_start(adapter);
>
> +       if (is_quality_report_supported(adapter) && getenv("QUALITY_DEBUG"))
> +               quality_set_debug(adapter);
> +
>         return;
>
>  failed:
> diff --git a/src/adapter.h b/src/adapter.h
> index 35deb1d11..c199e358a 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -266,6 +266,8 @@ enum kernel_features {
>
>  bool btd_has_kernel_features(uint32_t feature);
>
> +bool is_quality_report_supported(struct btd_adapter *adapter);
> +
>  bool btd_adapter_set_allowed_uuids(struct btd_adapter *adapter,
>                                                         struct queue *uuids);
>  bool btd_adapter_is_uuid_allowed(struct btd_adapter *adapter,
> diff --git a/src/shared/aosp.c b/src/shared/aosp.c
> new file mode 100644
> index 000000000..132389600
> --- /dev/null
> +++ b/src/shared/aosp.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2021 Google LLC
> + *
> + *
> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + */
> +
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +
> +#include "lib/bluetooth.h"
> +#include "lib/mgmt.h"
> +
> +#include "src/shared/aosp.h"
> +#include "src/shared/util.h"
> +
> +static struct {
> +       aosp_debug_func_t callback;
> +       void *data;
> +} aosp_debug;
> +
> +void aosp_set_debug(aosp_debug_func_t callback, void *user_data)
> +{
> +       aosp_debug.callback = callback;
> +       aosp_debug.data = user_data;
> +}
> +
> +static void debug(const char *format, ...)
> +{
> +       va_list ap;
> +       char str[256];
> +
> +       if (!aosp_debug.callback || !aosp_debug.data)
> +               return;
> +
> +       va_start(ap, format);
> +       vsnprintf(str, sizeof(str), format, ap);
> +       aosp_debug.callback(str, aosp_debug.data);
> +       va_end(ap);
> +}
> +
> +static void print_quality_report_evt(const struct aosp_bqr *bqr)
> +{
> +       debug("AOSP Quality Report");
> +       debug("  quality_report_id %u", bqr->quality_report_id);
> +       debug("  packet_type %u", bqr->packet_type);
> +       debug("  conn_handle %u", bqr->conn_handle);
> +       debug("  conn_role %u", bqr->conn_role);
> +       debug("  tx_power_level %d", bqr->tx_power_level);
> +       debug("  rssi %d", bqr->rssi);
> +       debug("  snr %u", bqr->snr);
> +       debug("  unused_afh_channel_count %u", bqr->unused_afh_channel_count);
> +       debug("  afh_select_unideal_channel_count %u",
> +                                       bqr->afh_select_unideal_channel_count);
> +       debug("  lsto %.2f", bqr->lsto * 0.625);
> +       debug("  conn_piconet_clock %.2f", bqr->conn_piconet_clock * 0.3125);
> +       debug("  retransmission_count %u", bqr->retransmission_count);
> +       debug("  no_rx_count %u", bqr->no_rx_count);
> +       debug("  nak_count %u", bqr->nak_count);
> +       debug("  last_tx_ack_timestamp %.2f", bqr->last_tx_ack_timestamp *
> +                                       0.3125);
> +       debug("  flow_off_count %u", bqr->flow_off_count);
> +       debug("  last_flow_on_timestamp %.2f", bqr->last_flow_on_timestamp *
> +                                       0.3125);
> +       debug("  buffer_overflow_bytes %u", bqr->buffer_overflow_bytes);
> +       debug("  buffer_underflow_bytes %u", bqr->buffer_underflow_bytes);
> +}

There is util_debug for this sort of debugging, please use that
instead of reinventing it.

> +bool process_aosp_quality_report(const struct mgmt_ev_quality_report *ev)
> +{
> +       const struct aosp_bqr *ev_report;
> +       struct aosp_bqr bqr;
> +
> +       if (ev->report_len < sizeof(struct aosp_bqr)) {
> +               debug("error: AOSP report size %u too small (expect >= %u).",
> +                               ev->report_len, sizeof(struct aosp_bqr));
> +               return false;
> +       }
> +
> +       ev_report = (struct aosp_bqr *)ev->report;
> +
> +       /* Ignore the Vendor Specific Parameter (VSP) field for now
> +        * due to the lack of standard way of reading it.
> +        */
> +       bqr.quality_report_id = ev_report->quality_report_id;
> +       bqr.packet_type = ev_report->packet_type;
> +       bqr.conn_handle = btohs(ev_report->conn_handle);
> +       bqr.conn_role = ev_report->conn_role;
> +       bqr.tx_power_level = ev_report->tx_power_level;
> +       bqr.rssi = ev_report->rssi;
> +       bqr.snr = ev_report->snr;
> +       bqr.unused_afh_channel_count = ev_report->unused_afh_channel_count;
> +       bqr.afh_select_unideal_channel_count =
> +                               ev_report->afh_select_unideal_channel_count;
> +       bqr.lsto = btohs(ev_report->lsto);
> +       bqr.conn_piconet_clock = btohl(ev_report->conn_piconet_clock);
> +       bqr.retransmission_count = btohl(ev_report->retransmission_count);
> +       bqr.no_rx_count = btohl(ev_report->no_rx_count);
> +       bqr.nak_count = btohl(ev_report->nak_count);
> +       bqr.last_tx_ack_timestamp = btohl(ev_report->last_tx_ack_timestamp);
> +       bqr.flow_off_count = btohl(ev_report->flow_off_count);
> +       bqr.last_flow_on_timestamp = btohl(ev_report->last_flow_on_timestamp);
> +       bqr.buffer_overflow_bytes = btohl(ev_report->buffer_overflow_bytes);
> +       bqr.buffer_underflow_bytes = btohl(ev_report->buffer_underflow_bytes);
> +
> +       print_quality_report_evt(&bqr);
> +
> +       return true;
> +}

If this is just logging the event we are much better off supporting it
directly inside the likes of btmon, or you do plan to make some use of
it other than just print out the fields?

> diff --git a/src/shared/aosp.h b/src/shared/aosp.h
> new file mode 100644
> index 000000000..e7b13f41f
> --- /dev/null
> +++ b/src/shared/aosp.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2021 Google LLC
> + *
> + *
> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + */
> +
> +#ifndef __AOSP_H
> +#define __AOSP_H
> +
> +#include <stdbool.h>
> +
> +struct mgmt_ev_quality_report;
> +
> +struct aosp_bqr {
> +       uint8_t quality_report_id;
> +       uint8_t packet_type;
> +       uint16_t conn_handle;
> +       uint8_t conn_role;
> +       int8_t tx_power_level;                  /* -30  to 20 dbm */
> +       int8_t rssi;                            /* -127 to 20 dbm */
> +       uint8_t snr;                            /* db */
> +       uint8_t unused_afh_channel_count;
> +       uint8_t afh_select_unideal_channel_count;
> +       uint16_t lsto;
> +       uint32_t conn_piconet_clock;
> +       uint32_t retransmission_count;
> +       uint32_t no_rx_count;
> +       uint32_t nak_count;
> +       uint32_t last_tx_ack_timestamp;
> +       uint32_t flow_off_count;
> +       uint32_t last_flow_on_timestamp;
> +       uint32_t buffer_overflow_bytes;
> +       uint32_t buffer_underflow_bytes;
> +
> +       uint8_t vsp[0];                 /* Vendor Specific Parameter */
> +} __packed;
> +
> +typedef void (*aosp_debug_func_t)(const char *str, void *user_data);
> +void aosp_set_debug(aosp_debug_func_t callback, void *user_data);
> +
> +bool process_aosp_quality_report(const struct mgmt_ev_quality_report *ev);
> +
> +#endif /* __AOSP_H */
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>


-- 
Luiz Augusto von Dentz
