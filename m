Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4965DC54E94
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 21:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjAXVxG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 16:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjAXVxF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 16:53:05 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2267F4B8BB
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 13:53:04 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a37so18316136ljq.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 13:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vTD048Lcti0u/VYSwsc/kY1QvRXX43EljYqjFePfnjU=;
        b=Ga/dNPVgashzwIxE+YsRcuBAIWY6yBqOVsHYsR190X3GXaxB0zfWp4niugdcI4+EYI
         ThaeZQPjyERvmN7lJo5DSoUe9lX2i0zRdwBZKu8jtEs8muamTyKVQSk1oe5U0n0Tx4IE
         Lo33slIpQIdIqhnaVAt8gJ4PPTxhL38q9XHgtlgdaOqqkbQpcLV0hgrgVhKJskHWdO47
         lLHjtmjgBb1QpFoorjlytZroz9S9gz3SxGuL6v4quzZWDYNKNgvXQTZNyYuBWN73JHuj
         ZNe8lUSW4Vl/xX8ozO0wCkiAFUv8iatzLDvvNl4foviJ02zlsXrw/vGyUyD+0+3sgxZQ
         BOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTD048Lcti0u/VYSwsc/kY1QvRXX43EljYqjFePfnjU=;
        b=bMgnpXNGm7IjhP/Rbx26EY4LW5VVaGtSmjXiyJ/3flfSiDJ5VkWZr+FPaPdToBkBzh
         LERUhpcBHax8YS1V0ZOp+5e2lsIM0DHUEaGNfhIsX+4IKN+PF3RDD6scugLCJ/lFAOeJ
         rFzbNoYDOS4HbHUUiGIsOnrZFhp8aU5Mq/a4mBkyuyPsKATc1F0+ZLBdC7dZpWQJbIQu
         z7DTYLcXJw+Si8N2ncap9BrdJDzMU+logBGXN10yB/VZRFWOjXG5R20HzFGXYLyxlfMK
         i+H2FOF3vyiRS7clV105FLIyxCg+PLQTnISR178Zjw0hiCTP5grxLgCYsNz5O5oY8/aa
         PFtg==
X-Gm-Message-State: AFqh2kq/KU77duABtfKQuKr2QogX6ssWhmhlJmrKhXdHe6FypOd1DB86
        Z10zsozgd5U70jq/fxoZEloSw1tRauWLHkZcw1gZgFWM
X-Google-Smtp-Source: AMrXdXudbBhsTvsD1rEexR/6ajNsWJGriKzUeT19kxdFDcOKhFw0dC7IpFsDPor6JgycMAJ6rhs310UglBCwdZEHV54=
X-Received: by 2002:a2e:b176:0:b0:286:4fb:2531 with SMTP id
 a22-20020a2eb176000000b0028604fb2531mr2904000ljm.161.1674597182162; Tue, 24
 Jan 2023 13:53:02 -0800 (PST)
MIME-Version: 1.0
References: <20230124202616.310544-1-brian.gix@gmail.com> <20230124202616.310544-8-brian.gix@gmail.com>
In-Reply-To: <20230124202616.310544-8-brian.gix@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 Jan 2023 13:52:50 -0800
Message-ID: <CABBYNZK2bzPTp79TYz-wy3X3Ow-w8d-Lu4OrPNi9EKw+OP2+CA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 07/13] mesh: Add Mesh Private Beacon server
To:     Brian Gix <brian.gix@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Brian Gix <brian.gix@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Tue, Jan 24, 2023 at 12:28 PM Brian Gix <brian.gix@gmail.com> wrote:
>
> From: Brian Gix <brian.gix@intel.com>
>
> This initial server supports only the Mesh Private Beacon and returns
> "Not Suppoerted" for Get/Set of Private GATT Proxy and Private Node
> Identity beacons.
> ---
>  Makefile.mesh         |   1 +
>  mesh/prv-beacon.h     |  36 +++++++++++++
>  mesh/prvbeac-server.c | 123 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+)
>  create mode 100644 mesh/prv-beacon.h
>  create mode 100644 mesh/prvbeac-server.c
>
> diff --git a/Makefile.mesh b/Makefile.mesh
> index e18a169eb..63f085de1 100644
> --- a/Makefile.mesh
> +++ b/Makefile.mesh
> @@ -36,6 +36,7 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
>                                 mesh/pb-adv.h mesh/pb-adv.c \
>                                 mesh/keyring.h mesh/keyring.c \
>                                 mesh/rpl.h mesh/rpl.c \
> +                               mesh/prv-beacon.h mesh/prvbeac-server.c \

Have the .c follow the same naming convention e.g. prv-beacon.c, we
can actually work out the client vs server internally.

>                                 mesh/mesh-defs.h
>  pkglibexec_PROGRAMS += mesh/bluetooth-meshd
>
> diff --git a/mesh/prv-beacon.h b/mesh/prv-beacon.h
> new file mode 100644
> index 000000000..7be7a01c8
> --- /dev/null
> +++ b/mesh/prv-beacon.h
> @@ -0,0 +1,36 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2020  Intel Corporation. All rights reserved.

This should probably be 2023

> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + */
> +
> +struct mesh_node;
> +
> +#define PRV_BEACON_SRV_MODEL   SET_ID(SIG_VENDOR, 0x0008)
> +#define PRV_BEACON_CLI_MODEL   SET_ID(SIG_VENDOR, 0x0009)
> +
> +/* Private Beacon opcodes */
> +#define OP_PRIVATE_BEACON_GET                  0x8060
> +#define OP_PRIVATE_BEACON_SET                  0x8061
> +#define OP_PRIVATE_BEACON_STATUS               0x8062
> +#define OP_PRIVATE_GATT_PROXY_GET              0x8063
> +#define OP_PRIVATE_GATT_PROXY_SET              0x8064
> +#define OP_PRIVATE_GATT_PROXY_STATUS           0x8065
> +#define OP_PRIVATE_NODE_ID_GET                 0x8066
> +#define OP_PRIVATE_NODE_ID_SET                 0x8067
> +#define OP_PRIVATE_NODE_ID_STATUS              0x8068
> +
> +void prv_beacon_server_init(struct mesh_node *node, uint8_t ele_idx);
> diff --git a/mesh/prvbeac-server.c b/mesh/prvbeac-server.c
> new file mode 100644
> index 000000000..78ab94eb3
> --- /dev/null
> +++ b/mesh/prvbeac-server.c
> @@ -0,0 +1,123 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2020  Intel Corporation. All rights reserved.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <sys/time.h>
> +#include <ell/ell.h>
> +
> +#include "mesh/mesh-defs.h"
> +#include "mesh/node.h"
> +#include "mesh/net.h"
> +#include "mesh/appkey.h"
> +#include "mesh/model.h"
> +#include "mesh/mesh-config.h"
> +#include "mesh/prv-beacon.h"
> +
> +#define NOT_SUPPORTED 0x02
> +
> +static bool prvbec_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
> +                               uint16_t net_idx, const uint8_t *data,
> +                               uint16_t size, const void *user_data)
> +{
> +       struct mesh_node *node = (struct mesh_node *) user_data;
> +       const uint8_t *pkt = data;
> +       uint32_t opcode;
> +       uint8_t msg[5];
> +       uint16_t n;
> +       uint8_t period = 0;
> +
> +       if (app_idx != APP_IDX_DEV_LOCAL)
> +               return false;
> +
> +       if (mesh_model_opcode_get(pkt, size, &opcode, &n)) {
> +               size -= n;
> +               pkt += n;
> +       } else
> +               return false;
> +
> +       l_debug("PRV-BEAC-SRV-opcode 0x%x size %u idx %3.3x", opcode, size,
> +                                                               net_idx);
> +
> +       n = 0;
> +
> +       switch (opcode) {
> +       default:
> +               return false;
> +
> +       case OP_PRIVATE_BEACON_SET:
> +               if (size == 1)
> +                       period = 0xff;
> +               else if (size == 2)
> +                       period = pkt[1];
> +               else
> +                       return true;
> +
> +               /* fall through */
> +
> +       case OP_PRIVATE_BEACON_GET:
> +               n = mesh_model_opcode_set(OP_PRIVATE_BEACON_STATUS, msg);
> +
> +               msg[n++] = NOT_SUPPORTED;
> +               msg[n++] = period;
> +
> +               l_debug("Get/Set Private Beacon (%d)", msg[n-2]);
> +               break;
> +
> +       case OP_PRIVATE_GATT_PROXY_SET:
> +               /* fall through */
> +       case OP_PRIVATE_GATT_PROXY_GET:
> +               n = mesh_model_opcode_set(OP_PRIVATE_GATT_PROXY_STATUS, msg);
> +               msg[n++] = NOT_SUPPORTED;
> +               break;
> +
> +       case OP_PRIVATE_NODE_ID_SET:
> +               /* fall through */
> +       case OP_PRIVATE_NODE_ID_GET:
> +               n = mesh_model_opcode_set(OP_PRIVATE_NODE_ID_STATUS, msg);
> +               msg[n++] = NOT_SUPPORTED;
> +               break;
> +       }
> +
> +       if (n)
> +               mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx,
> +                                               DEFAULT_TTL, false, n, msg);
> +
> +       return true;
> +}
> +
> +static void prvbec_srv_unregister(void *user_data)
> +{
> +}
> +
> +static const struct mesh_model_ops ops = {
> +       .unregister = prvbec_srv_unregister,
> +       .recv = prvbec_srv_pkt,
> +       .bind = NULL,
> +       .sub = NULL,
> +       .pub = NULL
> +};
> +
> +void prv_beacon_server_init(struct mesh_node *node, uint8_t ele_idx)
> +{
> +       l_debug("%2.2x", ele_idx);
> +       mesh_model_register(node, ele_idx, PRV_BEACON_SRV_MODEL, &ops, node);
> +}
> --
> 2.39.1
>


-- 
Luiz Augusto von Dentz
