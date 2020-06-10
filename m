Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DA9C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7650A206F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfZw0Yn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgFJUZF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgFJUZE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 16:25:04 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE63C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:25:04 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e5so2764077ote.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lvED4AjYSQozjXwlpC8nBIbkjDyy0JoAp2dVmO/VsaI=;
        b=EfZw0Yn6rS2lVHTIsII9ct1Ye+yc/dJAjFJegwGz0sjh4Wj9q0e/hJl5g60yTFb3Rj
         O0qtabFk8XyuPSmDcRNo/3bUdUsSVneo0Eq5nkccEAOfA6HsXRthzsrE+20u4XcBUDOi
         tiZwH6nDmJC8ywjWXjWtLLw9k8qluJSKCb8JaeK0q17HOa11t4dlOQLx6Tr2B9T/mYdZ
         16Hyj+NyPJWoQAskxArvT/bcwmiCccUtR5sxAU2wB/Tf2qqTcPpT6goJpeSgmIZyjPpZ
         4TX2Du8ZuOTzt+Pm5yo4DDvHegUDqSbHk8nhb49JiW0opBOEAzWnPbvecLpiMy7aR3DX
         SpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lvED4AjYSQozjXwlpC8nBIbkjDyy0JoAp2dVmO/VsaI=;
        b=E0p8KkXT/OduOo5CMtXyw1fvYSfhgDa0o2HrgplkmQDFY8GJCd0JQUxYA1ilMBKFTm
         DPkGoFa2sZUEsynPQzdHULA0qZoihTRbOxz8cq/4mvAgMn8RZzVfX9Cgt57k2cqzZVly
         vvByIJ6tIVD3gAOSnG+8JIsS7GW0LGblzWrqXxwMyGCmI56tajUGnCqRAanPzFjJqD2I
         8lLoO03Ol+TWpMRAwbWURp6d3wXmVr/X8n43FSoHVu3zI1RtKasd5/OlvC/HsfDrYkS8
         gE7SYI4Fr2WFJC7JJ4Yltlgs39OAJ/ia12Hp9+NiB273XNuRqkz9cKAxy8r86xXIiGoF
         EeqQ==
X-Gm-Message-State: AOAM532XqEB3FcJgzWb4vkTTY0ayQSYbsauVzzofR31B0VU+lezVwdjE
        g0c92uUtJQJtnvuF1EwZw9j3hW1vTSGAt+xhEFx2GQ==
X-Google-Smtp-Source: ABdhPJyMST3IYLmVtgtEWY26WW0w2Z0gjqR7mjSG1ufnlz0/1NdfIOVezjzgXjCfI2d/Wv2QLxPdQBGCXhe4w+zBdi4=
X-Received: by 2002:a05:6830:1d76:: with SMTP id l22mr3734097oti.177.1591820703116;
 Wed, 10 Jun 2020 13:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200608202628.875833-1-luiz.dentz@gmail.com>
In-Reply-To: <20200608202628.875833-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Jun 2020 13:24:49 -0700
Message-ID: <CABBYNZJhbDDcdZRTh0TMQswJBDqZuQHreiv+yzKEk6h=0=paeg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] a2dp: Use streaming mode when MPS is enabled
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Jun 8, 2020 at 1:26 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If MPS is enabled use L2CAP streaming mode for AVDTP channels.
> ---
>  profiles/audio/a2dp.c  |  8 ++++++++
>  profiles/audio/avdtp.c |  9 +++++++++
>  src/hcid.h             |  7 +++++++
>  src/main.c             | 16 ++++++----------
>  4 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 0a66589b0..f00e5c923 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -43,6 +43,7 @@
>
>  #include "gdbus/gdbus.h"
>
> +#include "src/hcid.h"
>  #include "src/plugin.h"
>  #include "src/adapter.h"
>  #include "src/device.h"
> @@ -2331,14 +2332,21 @@ drop:
>  static bool a2dp_server_listen(struct a2dp_server *server)
>  {
>         GError *err = NULL;
> +       BtIOMode mode;
>
>         if (server->io)
>                 return true;
>
> +       if (main_opts.mps == MPS_OFF)
> +               mode = BT_IO_MODE_BASIC;
> +       else
> +               mode = BT_IO_MODE_STREAMING;
> +
>         server->io = bt_io_listen(NULL, confirm_cb, server, NULL, &err,
>                                 BT_IO_OPT_SOURCE_BDADDR,
>                                 btd_adapter_get_address(server->adapter),
>                                 BT_IO_OPT_PSM, AVDTP_PSM,
> +                               BT_IO_OPT_MODE, mode,
>                                 BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>                                 BT_IO_OPT_MASTER, true,
>                                 BT_IO_OPT_INVALID);
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 45727f01e..e5193f79b 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -42,6 +42,7 @@
>  #include "lib/uuid.h"
>
>  #include "btio/btio.h"
> +#include "src/hcid.h"
>  #include "src/log.h"
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> @@ -2406,9 +2407,15 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
>         GError *err = NULL;
>         GIOChannel *io;
>         const bdaddr_t *src;
> +       BtIOMode mode;
>
>         src = btd_adapter_get_address(device_get_adapter(session->device));
>
> +       if (main_opts.mps == MPS_OFF)
> +               mode = BT_IO_MODE_BASIC;
> +       else
> +               mode = BT_IO_MODE_STREAMING;
> +
>         if (session->phy)
>                 io = bt_io_connect(avdtp_connect_cb, session,
>                                         NULL, &err,
> @@ -2416,6 +2423,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
>                                         BT_IO_OPT_DEST_BDADDR,
>                                         device_get_address(session->device),
>                                         BT_IO_OPT_PSM, AVDTP_PSM,
> +                                       BT_IO_OPT_MODE, mode,
>                                         BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>                                         /* Set Input MTU to 0 to auto-tune */
>                                         BT_IO_OPT_IMTU, 0,
> @@ -2427,6 +2435,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
>                                         BT_IO_OPT_DEST_BDADDR,
>                                         device_get_address(session->device),
>                                         BT_IO_OPT_PSM, AVDTP_PSM,
> +                                       BT_IO_OPT_MODE, mode,
>                                         BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>                                         BT_IO_OPT_INVALID);
>         if (!io) {
> diff --git a/src/hcid.h b/src/hcid.h
> index 56e2b4f31..1b2714b1d 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -41,6 +41,12 @@ enum jw_repairing_t {
>         JW_REPAIRING_ALWAYS,
>  };
>
> +enum mps_mode_t {
> +       MPS_OFF,
> +       MPS_SINGLE,
> +       MPS_MULTIPLE,
> +};
> +
>  struct main_opts {
>         char            *name;
>         uint32_t        class;
> @@ -102,6 +108,7 @@ struct main_opts {
>         bt_gatt_cache_t gatt_cache;
>         uint16_t        gatt_mtu;
>         uint8_t         gatt_channels;
> +       enum mps_mode_t mps;
>
>         uint8_t         key_size;
>
> diff --git a/src/main.c b/src/main.c
> index 50e37e57a..e51f614b3 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -74,12 +74,6 @@ struct main_opts main_opts;
>  static GKeyFile *main_conf;
>  static char *main_conf_file_path;
>
> -static enum {
> -       MPS_OFF,
> -       MPS_SINGLE,
> -       MPS_MULTIPLE,
> -} mps = MPS_OFF;
> -
>  static const char *supported_options[] = {
>         "Name",
>         "Class",
> @@ -583,9 +577,11 @@ static void parse_config(GKeyFile *config)
>                 DBG("MultiProfile=%s", str);
>
>                 if (!strcmp(str, "single"))
> -                       mps = MPS_SINGLE;
> +                       main_opts.mps = MPS_SINGLE;
>                 else if (!strcmp(str, "multiple"))
> -                       mps = MPS_MULTIPLE;
> +                       main_opts.mps = MPS_MULTIPLE;
> +               else
> +                       main_opts.mps = MPS_OFF;
>
>                 g_free(str);
>         }
> @@ -910,8 +906,8 @@ int main(int argc, char *argv[])
>                                                 main_opts.did_version);
>         }
>
> -       if (mps != MPS_OFF)
> -               register_mps(mps == MPS_MULTIPLE);
> +       if (main_opts.mps != MPS_OFF)
> +               register_mps(main_opts.mps == MPS_MULTIPLE);
>
>         /* Loading plugins has to be done after D-Bus has been setup since
>          * the plugins might wanna expose some paths on the bus. However the
> --
> 2.25.3
>

Pushed.

-- 
Luiz Augusto von Dentz
