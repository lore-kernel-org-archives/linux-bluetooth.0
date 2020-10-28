Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50B6C5517A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 01:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECC42076C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 01:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o465uPzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgJ1WDB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbgJ1WB4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 18:01:56 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F845C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 15:01:56 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x203so1145570oia.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgF1Kx1tQ2xUoJcd4hp5vgaUNU3mfSzaiHf4fkJ3CWY=;
        b=o465uPzrrD4HC+s9kJaFNYwqqsEPJO0HDT9IMTeJTFKrsbpUuaQR8/I6nA0hczbFHD
         Lk03+WAIrk/xPPJCLREvb9oC7WBVVoJkN6gNfzp90M0EGN4TeFiJ1hMBqPGrmlt3xSXo
         SYFlzqpkgsMK3VC8K12/Pogk6g5jU8w/mBY/sTer4Lx9S+Chn+wp/qAXVx7m25r7GhBS
         Ex4jw6u4mbAyjn9FAYupw4IO6+ztcsI6cGptSVgh3S4UpG0li1iuM34PMrXVT8XcJzHj
         1Eaz9VAw/Zk0KJwMSEfb7IVdZjlNeUgEDABhbivQqnQh4/5eeLChXt+xtsg+s2aIar/u
         r2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgF1Kx1tQ2xUoJcd4hp5vgaUNU3mfSzaiHf4fkJ3CWY=;
        b=gJOBB6BF7SEdRcI02r8kNT+z4bLjCNf7X8Ib7bdLzhhpc2mK9aFEBLtp+YjMYdXWv+
         4rCalS9Ah1pHKuZFJBi34Ocj2r8yGrPDrN/jRGCnPzzUELWffYnQmQKBUh/Szg56sNHo
         2n4D3ImecKJgPUBMlAKt/FmXKiqVd674FBKdn/XOlkOhLct9vnzZa/3+R1jm2kzVEbQH
         6MRBEEWj+paVev9IHNB+hQcUykG8/5TnKD2+9VUDRoucpDUeiHJEPCZiTdNPx3D0e76Y
         tMIZo2Jn0hv5f+W/FTHCrBuJ1A6k0CT+YxNogw2Id6eUaif3+X266IpV32I5rKAJG7DR
         nyEg==
X-Gm-Message-State: AOAM533mJ/d2B7R8DFlMjZybqqKHUM2cHLmUSn1nossG2Ts1KH6u8TXh
        TibS/zrm/orLMDVgXRRZaZ93Vi9XifvRROvlJHY=
X-Google-Smtp-Source: ABdhPJw5RGYn7v9CZzi/Vd5+/+83bwZ0AK7d10/FDMKSE9j5mrOFm4wGjYeCzy7601VABAisaVVY3BCoP9SNQ3JFVZU=
X-Received: by 2002:aca:cdd8:: with SMTP id d207mr769782oig.64.1603922515382;
 Wed, 28 Oct 2020 15:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201028195132.BlueZ.v5.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
 <20201028195132.BlueZ.v5.2.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
In-Reply-To: <20201028195132.BlueZ.v5.2.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 28 Oct 2020 15:01:44 -0700
Message-ID: <CABBYNZ+WJzqHUhmyqY7x-KN6mpxMx801LM4oZHxi5QiOLZNAWg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5 2/2] core: Add support of variable length params
 in mgmt_config
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Wed, Oct 28, 2020 at 4:53 AM Howard Chung <howardchung@google.com> wrote:
>
> This adds support of variable length parameters in mgmt_config.
> Also fixed the endian issue.
>
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> Changes in v5:
> - use mgmt_tlv api
>
> Changes in v4:
> - fix type of buf_len
>
> Changes in v3:
> - use iovec to fill buffer
>
> Changes in v2:
> - fix multiple line dereference issue
>
>  src/adapter.c | 264 +++++++++++++++++++-------------------------------
>  src/main.c    |  35 ++++++-
>  2 files changed, 130 insertions(+), 169 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index c0053000ac19..62b7bfbae021 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4165,267 +4165,197 @@ static void probe_devices(void *user_data)
>
>  static void load_default_system_params(struct btd_adapter *adapter)
>  {
> -       struct {
> -               struct mgmt_tlv entry;
> -               union {
> -                       uint16_t u16;
> -               };
> -       } __packed *params;
> -       uint16_t i = 0;
> -       size_t len = 0;
> -       unsigned int err;
> +       struct mgmt_tlv_list *tlv_list;
> +       unsigned int err = 0;
>
>         if (!main_opts.default_params.num_entries ||
>             !btd_has_kernel_features(KERNEL_SET_SYSTEM_CONFIG))
>                 return;
>
> -       params = malloc0(sizeof(*params) *
> -                       main_opts.default_params.num_entries);
> -
> -       len = sizeof(params->entry) * main_opts.default_params.num_entries;
> +       tlv_list = mgmt_tlv_list_new();
>
>         if (main_opts.default_params.br_page_scan_type != 0xFFFF) {
> -               params[i].entry.type = 0x0000;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.br_page_scan_type;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0000,
> +                       sizeof(main_opts.default_params.br_page_scan_type),
> +                       &main_opts.default_params.br_page_scan_type);
>         }
>
>         if (main_opts.default_params.br_page_scan_interval) {
> -               params[i].entry.type = 0x0001;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.br_page_scan_interval;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0001,
> +                       sizeof(main_opts.default_params.br_page_scan_interval),
> +                       &main_opts.default_params.br_page_scan_interval);
>         }
>
>         if (main_opts.default_params.br_page_scan_win) {
> -               params[i].entry.type = 0x0002;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.br_page_scan_win;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0002,
> +                       sizeof(main_opts.default_params.br_page_scan_win),
> +                       &main_opts.default_params.br_page_scan_win);
>         }
>
>         if (main_opts.default_params.br_scan_type != 0xFFFF) {
> -               params[i].entry.type = 0x0003;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.br_scan_type;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0003,
> +                       sizeof(main_opts.default_params.br_scan_type),
> +                       &main_opts.default_params.br_scan_type);
>         }
>
>         if (main_opts.default_params.br_scan_interval) {
> -               params[i].entry.type = 0x0004;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.br_scan_interval;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0004,
> +                       sizeof(main_opts.default_params.br_scan_interval),
> +                       &main_opts.default_params.br_scan_interval);
>         }
>
>         if (main_opts.default_params.br_scan_win) {
> -               params[i].entry.type = 0x0005;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.br_scan_win;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0005,
> +                       sizeof(main_opts.default_params.br_scan_win),
> +                       &main_opts.default_params.br_scan_win);
>         }
>
>         if (main_opts.default_params.br_link_supervision_timeout) {
> -               params[i].entry.type = 0x0006;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 =
> -                       main_opts.default_params.br_link_supervision_timeout;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0006,
> +                       sizeof(main_opts.default_params.br_link_supervision_timeout),
> +                       &main_opts.default_params.br_link_supervision_timeout);
>         }
>
>         if (main_opts.default_params.br_page_timeout) {
> -               params[i].entry.type = 0x0007;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.br_page_timeout;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0007,
> +                       sizeof(main_opts.default_params.br_page_timeout),
> +                       &main_opts.default_params.br_page_timeout);
>         }
>
>         if (main_opts.default_params.br_min_sniff_interval) {
> -               params[i].entry.type = 0x0008;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.br_min_sniff_interval;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0008,
> +                       sizeof(main_opts.default_params.br_min_sniff_interval),
> +                       &main_opts.default_params.br_min_sniff_interval);
>         }
>
>         if (main_opts.default_params.br_max_sniff_interval) {
> -               params[i].entry.type = 0x0009;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.br_max_sniff_interval;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0009,
> +                       sizeof(main_opts.default_params.br_max_sniff_interval),
> +                       &main_opts.default_params.br_max_sniff_interval);
>         }
>
>         if (main_opts.default_params.le_min_adv_interval) {
> -               params[i].entry.type = 0x000a;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.le_min_adv_interval;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x000a,
> +                       sizeof(main_opts.default_params.le_min_adv_interval),
> +                       &main_opts.default_params.le_min_adv_interval);
>         }
>
>         if (main_opts.default_params.le_max_adv_interval) {
> -               params[i].entry.type = 0x000b;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.le_max_adv_interval;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x000b,
> +                       sizeof(main_opts.default_params.le_max_adv_interval),
> +                       &main_opts.default_params.le_max_adv_interval);
>         }
>
>         if (main_opts.default_params.le_multi_adv_rotation_interval) {
> -               params[i].entry.type = 0x000c;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 =
> -                       main_opts.default_params.le_multi_adv_rotation_interval;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x000c,
> +                       sizeof(main_opts.default_params.le_multi_adv_rotation_interval),
> +                       &main_opts.default_params.le_multi_adv_rotation_interval);
>         }
>
>         if (main_opts.default_params.le_scan_interval_autoconnect) {
> -               params[i].entry.type = 0x000d;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 =
> -                       main_opts.default_params.le_scan_interval_autoconnect;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x000d,
> +                       sizeof(main_opts.default_params.le_scan_interval_autoconnect),
> +                       &main_opts.default_params.le_scan_interval_autoconnect);
>         }
>
>         if (main_opts.default_params.le_scan_win_autoconnect) {
> -               params[i].entry.type = 0x000e;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 =
> -                       main_opts.default_params.le_scan_win_autoconnect;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x000e,
> +                       sizeof(main_opts.default_params.le_scan_win_autoconnect),
> +                       &main_opts.default_params.le_scan_win_autoconnect);
>         }
>
>         if (main_opts.default_params.le_scan_interval_suspend) {
> -               params[i].entry.type = 0x000f;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 =
> -                       main_opts.default_params.le_scan_interval_suspend;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x000f,
> +                       sizeof(main_opts.default_params.le_scan_interval_suspend),
> +                       &main_opts.default_params.le_scan_interval_suspend);
>         }
>
>         if (main_opts.default_params.le_scan_win_suspend) {
> -               params[i].entry.type = 0x0010;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.le_scan_win_suspend;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0010,
> +                       sizeof(main_opts.default_params.le_scan_win_suspend),
> +                       &main_opts.default_params.le_scan_win_suspend);
>         }
>
>         if (main_opts.default_params.le_scan_interval_discovery) {
> -               params[i].entry.type = 0x0011;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 =
> -                       main_opts.default_params.le_scan_interval_discovery;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0011,
> +                       sizeof(main_opts.default_params.le_scan_interval_discovery),
> +                       &main_opts.default_params.le_scan_interval_discovery);
>         }
>
>         if (main_opts.default_params.le_scan_win_discovery) {
> -               params[i].entry.type = 0x0012;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 =
> -                       main_opts.default_params.le_scan_win_discovery;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0012,
> +                       sizeof(main_opts.default_params.le_scan_win_discovery),
> +                       &main_opts.default_params.le_scan_win_discovery);
>         }
>
>         if (main_opts.default_params.le_scan_interval_adv_monitor) {
> -               params[i].entry.type = 0x0013;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 =
> -                       main_opts.default_params.le_scan_interval_adv_monitor;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0013,
> +                       sizeof(main_opts.default_params.le_scan_interval_adv_monitor),
> +                       &main_opts.default_params.le_scan_interval_adv_monitor);
>         }
>
>         if (main_opts.default_params.le_scan_win_adv_monitor) {
> -               params[i].entry.type = 0x0014;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 =
> -                       main_opts.default_params.le_scan_win_adv_monitor;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0014,
> +                       sizeof(main_opts.default_params.le_scan_win_adv_monitor),
> +                       &main_opts.default_params.le_scan_win_adv_monitor);
>         }
>
>         if (main_opts.default_params.le_scan_interval_connect) {
> -               params[i].entry.type = 0x0015;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 =
> -                       main_opts.default_params.le_scan_interval_connect;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0015,
> +                       sizeof(main_opts.default_params.le_scan_interval_connect),
> +                       &main_opts.default_params.le_scan_interval_connect);
>         }
>
>         if (main_opts.default_params.le_scan_win_connect) {
> -               params[i].entry.type = 0x0016;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.le_scan_win_connect;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0016,
> +                       sizeof(main_opts.default_params.le_scan_win_connect),
> +                       &main_opts.default_params.le_scan_win_connect);
>         }
>
>         if (main_opts.default_params.le_min_conn_interval) {
> -               params[i].entry.type = 0x0017;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.le_min_conn_interval;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0017,
> +                       sizeof(main_opts.default_params.le_min_conn_interval),
> +                       &main_opts.default_params.le_min_conn_interval);
>         }
>
>         if (main_opts.default_params.le_max_conn_interval) {
> -               params[i].entry.type = 0x0018;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.le_max_conn_interval;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0018,
> +                       sizeof(main_opts.default_params.le_max_conn_interval),
> +                       &main_opts.default_params.le_max_conn_interval);
>         }
>
>         if (main_opts.default_params.le_conn_latency) {
> -               params[i].entry.type = 0x0019;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.le_conn_latency;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x0019,
> +                       sizeof(main_opts.default_params.le_conn_latency),
> +                       &main_opts.default_params.le_conn_latency);
>         }
>
>         if (main_opts.default_params.le_conn_lsto) {
> -               params[i].entry.type = 0x001a;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.le_conn_lsto;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x001a,
> +                       sizeof(main_opts.default_params.le_conn_lsto),
> +                       &main_opts.default_params.le_conn_lsto);
>         }
>
>         if (main_opts.default_params.le_autoconnect_timeout) {
> -               params[i].entry.type = 0x001b;
> -               params[i].entry.length = sizeof(params[i].u16);
> -               params[i].u16 = main_opts.default_params.le_autoconnect_timeout;
> -               ++i;
> -               len += sizeof(params[i].u16);
> +               err |= !mgmt_tlv_add(tlv_list, 0x001b,
> +                       sizeof(main_opts.default_params.le_autoconnect_timeout),
> +                       &main_opts.default_params.le_autoconnect_timeout);
> +       }
> +
> +       if (err) {
> +               btd_error(adapter->dev_id, "Failed to add tlv to list");
> +               goto done;
>         }
>
> -       err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
> -                       adapter->dev_id, len, params, NULL, NULL, NULL);
> +       err = mgmt_send_tlv(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
> +                       adapter->dev_id, tlv_list, NULL, NULL, NULL);
> +
>         if (!err)
>                 btd_error(adapter->dev_id,
>                                 "Failed to set default system config for hci%u",
>                                 adapter->dev_id);
> -
> -       free(params);
> +done:
> +       mgmt_tlv_list_free(tlv_list);
>  }
>
>  static void load_devices(struct btd_adapter *adapter)
> diff --git a/src/main.c b/src/main.c
> index 77be776686a8..b83f7bffb485 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -305,120 +305,149 @@ static void parse_controller_config(GKeyFile *config)
>  {
>         static const struct {
>                 const char * const val_name;
> -               uint16_t * const val;
> +               void * const val;
> +               const size_t size;
>                 const uint16_t min;
>                 const uint16_t max;
>         } params[] = {
>                 { "BRPageScanType",
>                   &main_opts.default_params.br_page_scan_type,
> +                 sizeof(main_opts.default_params.br_page_scan_type),
>                   0,
>                   1},
>                 { "BRPageScanInterval",
>                   &main_opts.default_params.br_page_scan_interval,
> +                 sizeof(main_opts.default_params.br_page_scan_interval),
>                   0x0012,
>                   0x1000},
>                 { "BRPageScanWindow",
>                   &main_opts.default_params.br_page_scan_win,
> +                 sizeof(main_opts.default_params.br_page_scan_win),
>                   0x0011,
>                   0x1000},
>                 { "BRInquiryScanType",
>                   &main_opts.default_params.br_scan_type,
> +                 sizeof(main_opts.default_params.br_scan_type),
>                   0,
>                   1},
>                 { "BRInquiryScanInterval",
>                   &main_opts.default_params.br_scan_interval,
> +                 sizeof(main_opts.default_params.br_scan_interval),
>                   0x0012,
>                   0x1000},
>                 { "BRInquiryScanWindow",
>                   &main_opts.default_params.br_scan_win,
> +                 sizeof(main_opts.default_params.br_scan_win),
>                   0x0011,
>                   0x1000},
>                 { "BRLinkSupervisionTimeout",
>                   &main_opts.default_params.br_link_supervision_timeout,
> +                 sizeof(main_opts.default_params.br_link_supervision_timeout),
>                   0x0001,
>                   0xFFFF},
>                 { "BRPageTimeout",
>                   &main_opts.default_params.br_page_timeout,
> +                 sizeof(main_opts.default_params.br_page_scan_win),
>                   0x0001,
>                   0xFFFF},
>                 { "BRMinSniffInterval",
>                   &main_opts.default_params.br_min_sniff_interval,
> +                 sizeof(main_opts.default_params.br_min_sniff_interval),
>                   0x0001,
>                   0xFFFE},
>                 { "BRMaxSniffInterval",
>                   &main_opts.default_params.br_max_sniff_interval,
> +                 sizeof(main_opts.default_params.br_max_sniff_interval),
>                   0x0001,
>                   0xFFFE},
>                 { "LEMinAdvertisementInterval",
>                   &main_opts.default_params.le_min_adv_interval,
> +                 sizeof(main_opts.default_params.le_min_adv_interval),
>                   0x0020,
>                   0x4000},
>                 { "LEMaxAdvertisementInterval",
>                   &main_opts.default_params.le_max_adv_interval,
> +                 sizeof(main_opts.default_params.le_max_adv_interval),
>                   0x0020,
>                   0x4000},
>                 { "LEMultiAdvertisementRotationInterval",
>                   &main_opts.default_params.le_multi_adv_rotation_interval,
> +                 sizeof(main_opts.default_params.le_multi_adv_rotation_interval),
>                   0x0001,
>                   0xFFFF},
>                 { "LEScanIntervalAutoConnect",
>                   &main_opts.default_params.le_scan_interval_autoconnect,
> +                 sizeof(main_opts.default_params.le_scan_interval_autoconnect),
>                   0x0004,
>                   0x4000},
>                 { "LEScanWindowAutoConnect",
>                   &main_opts.default_params.le_scan_win_autoconnect,
> +                 sizeof(main_opts.default_params.le_scan_win_autoconnect),
>                   0x0004,
>                   0x4000},
>                 { "LEScanIntervalSuspend",
>                   &main_opts.default_params.le_scan_interval_suspend,
> +                 sizeof(main_opts.default_params.le_scan_interval_suspend),
>                   0x0004,
>                   0x4000},
>                 { "LEScanWindowSuspend",
>                   &main_opts.default_params.le_scan_win_suspend,
> +                 sizeof(main_opts.default_params.le_scan_win_suspend),
>                   0x0004,
>                   0x4000},
>                 { "LEScanIntervalDiscovery",
>                   &main_opts.default_params.le_scan_interval_discovery,
> +                 sizeof(main_opts.default_params.le_scan_interval_discovery),
>                   0x0004,
>                   0x4000},
>                 { "LEScanWindowDiscovery",
>                   &main_opts.default_params.le_scan_win_discovery,
> +                 sizeof(main_opts.default_params.le_scan_win_discovery),
>                   0x0004,
>                   0x4000},
>                 { "LEScanIntervalAdvMonitor",
>                   &main_opts.default_params.le_scan_interval_adv_monitor,
> +                 sizeof(main_opts.default_params.le_scan_interval_adv_monitor),
>                   0x0004,
>                   0x4000},
>                 { "LEScanWindowAdvMonitor",
>                   &main_opts.default_params.le_scan_win_adv_monitor,
> +                 sizeof(main_opts.default_params.le_scan_win_adv_monitor),
>                   0x0004,
>                   0x4000},
>                 { "LEScanIntervalConnect",
>                   &main_opts.default_params.le_scan_interval_connect,
> +                 sizeof(main_opts.default_params.le_scan_interval_connect),
>                   0x0004,
>                   0x4000},
>                 { "LEScanWindowConnect",
>                   &main_opts.default_params.le_scan_win_connect,
> +                 sizeof(main_opts.default_params.le_scan_win_connect),
>                   0x0004,
>                   0x4000},
>                 { "LEMinConnectionInterval",
>                   &main_opts.default_params.le_min_conn_interval,
> +                 sizeof(main_opts.default_params.le_min_conn_interval),
>                   0x0006,
>                   0x0C80},
>                 { "LEMaxConnectionInterval",
>                   &main_opts.default_params.le_max_conn_interval,
> +                 sizeof(main_opts.default_params.le_max_conn_interval),
>                   0x0006,
>                   0x0C80},
>                 { "LEConnectionLatency",
>                   &main_opts.default_params.le_conn_latency,
> +                 sizeof(main_opts.default_params.le_conn_latency),
>                   0x0000,
>                   0x01F3},
>                 { "LEConnectionSupervisionTimeout",
>                   &main_opts.default_params.le_conn_lsto,
> +                 sizeof(main_opts.default_params.le_conn_lsto),
>                   0x000A,
>                   0x0C80},
>                 { "LEAutoconnecttimeout",
>                   &main_opts.default_params.le_autoconnect_timeout,
> +                 sizeof(main_opts.default_params.le_autoconnect_timeout),
>                   0x0001,
>                   0x4000},
>         };
> @@ -439,7 +468,9 @@ static void parse_controller_config(GKeyFile *config)
>
>                         val = MAX(val, params[i].min);
>                         val = MIN(val, params[i].max);
> -                       *params[i].val = val;
> +
> +                       val = htobl(val);
> +                       memcpy(params[i].val, &val, params[i].size);
>                         ++main_opts.default_params.num_entries;
>                 }
>         }
> --
> 2.29.0.rc2.309.g374f81d7ae-goog

Ive sent a patch-set based on your changes, Im start changing it to
split the BR/EDR to LE since BlueZ actually supports single mode it
makes more sense to have them handled by different groups, that said
it will affect how we expose them in main.conf.


-- 
Luiz Augusto von Dentz
