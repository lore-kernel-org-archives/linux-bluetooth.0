Return-Path: <SRS0=ORc3=EC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3B9C4363A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 17:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C735B21D42
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 17:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UedX9FQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767624AbgJ0RMJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:12:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35238 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786275AbgJ0RMF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Oct 2020 13:12:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id n11so1798382ota.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2020 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ex3xCNV9yF/fWy62DDAjClDEr6D3k5CfiU74gTfNBss=;
        b=UedX9FQbGdmwQEcyZrpcZhP5ispse50S5hMdzPHWEKZjMICuBtrM8vLydVNmySTpbe
         3Qc22Bs58Z7GEVehuq0WQmUDaULvFhKJABGfiU0ayyOYYsI5QjWyW+XXfzWlL9q94bXr
         crMrJuEwlye/2PKxaPeBiKq4g2kFlLjbc3emxR92mkwdiNum/1yuL5lBuu6tQc4diulT
         CsKlwGlWxLxR99KwqP9R0g3XsA1ShS48BC1ahWbSxPK+m7V3rCs/UaFuVLzJFBT1DO8H
         GEaINnyw6TXjzTszDaycEOXmJ9/xDqGy01sUxsxS7z6kTq9FM6vawqtvysswB481QwXk
         /Zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ex3xCNV9yF/fWy62DDAjClDEr6D3k5CfiU74gTfNBss=;
        b=NH/3cwaQm0+zfB6qHlLxbvLaM8C7KRtUvtKqUV7Wgaa9GEpUnFEYIegtGoiaFZOdXW
         eKzt9Ftx6B/+EdxzxU2tHJd6RRQUdIhu+ezXlJFxQyMkWttdHAc3gRORF1d4p503Xw9m
         S4KI36rIwoYus8kUcAJ5ovSER4hWPe3ZJMmMEhwHXc+9n0/PhHM7U0blfiZ49wK/obsv
         hbVyCl4ykhachMoWsoUc+OXkp8My8H6+ZZ8ppXbC/RE+OSdtl9j3E+AI25tdVwS6Z12d
         ptKbw6YPg8Nfl6mdIX/mXwzeLGr0sSSeGIqdVm0lmSDeOzKFUy2zxII1/kqLT7SIdfVa
         nsKQ==
X-Gm-Message-State: AOAM531shubG+pxXxuBdzIUW0FAp6587+DPp0EUWGUztCB8lOn8wVmxu
        3sfr814IIo4i1RDbJNPvNQPzy7co9HzTgf9jDsk=
X-Google-Smtp-Source: ABdhPJy0E6WJ7QMX657dIKlwAI5aiNY7ytCwDyBlbk8lgVpDpbHTPguXOm+5tvL8sp27Gx17xmrw/dnRjJ1k56hl9VE=
X-Received: by 2002:a9d:6a0a:: with SMTP id g10mr2260339otn.44.1603818722235;
 Tue, 27 Oct 2020 10:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201026182010.BlueZ.v3.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
 <CABBYNZKSyR-YthZHzdbAN+8SMedousDoBAx7sNGAG7oMr-BrHA@mail.gmail.com> <CAPHZWUciYfej-S3qvHQXsx6qLOmAiB5HvgKnPXQE9w7n20Kgmw@mail.gmail.com>
In-Reply-To: <CAPHZWUciYfej-S3qvHQXsx6qLOmAiB5HvgKnPXQE9w7n20Kgmw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Oct 2020 10:11:51 -0700
Message-ID: <CABBYNZKO2bn-Q4YTEvFF_SKF4YxgcpJ1WFPE792dhTE673DxCQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] core: Add support of variable length params in mgmt_config
To:     Yun-hao Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yun-hao,

On Mon, Oct 26, 2020 at 7:27 PM Yun-hao Chung <howardchung@google.com> wrote:
>
> Hi Luiz,
>
> Thanks for the reply.
>
> On Tue, Oct 27, 2020 at 1:31 AM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>
>> Hi Howard,
>>
>> On Mon, Oct 26, 2020 at 3:20 AM Howard Chung <howardchung@google.com> wrote:
>> >
>> > This adds support of variable length parameters in mgmt_config.
>> > Also fixed the endian issue.
>> >
>> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
>> > ---
>> >
>> > Changes in v3:
>> > - use iovec to fill buffer
>> >
>> > Changes in v2:
>> > - fix multiple line dereference issue
>> >
>> >  src/adapter.c     | 300 +++++++++++++++++++++-------------------------
>> >  src/main.c        |  35 +++++-
>> >  src/shared/mgmt.c |  42 +++++++
>> >  src/shared/mgmt.h |   4 +
>> >  4 files changed, 213 insertions(+), 168 deletions(-)
>> >
>> > diff --git a/src/adapter.c b/src/adapter.c
>> > index c0053000ac19..561737bebd33 100644
>> > --- a/src/adapter.c
>> > +++ b/src/adapter.c
>> > @@ -4163,269 +4163,237 @@ static void probe_devices(void *user_data)
>> >         device_probe_profiles(device, btd_device_get_uuids(device));
>> >  }
>> >
>> > +static void set_mgmt_tlv(struct iovec *iov, uint16_t type, uint8_t length,
>> > +                                                               void *value)
>> > +{
>> > +       struct mgmt_tlv *entry;
>> > +       size_t iov_size;
>> > +
>> > +       iov_size = sizeof(struct mgmt_tlv) + length;
>> > +       iov->iov_base = g_malloc(iov_size);
>> > +       iov->iov_len = iov_size;
>> > +
>> > +       entry = (struct mgmt_tlv *)iov->iov_base;
>> > +       entry->type = htobs(type);
>> > +       entry->length = length;
>> > +       memcpy(entry->value, value, length);
>>
>> Perhaps it is better to have such helper in mgmt.c  e.g. mgmt_tlv_new,
>> mgmt_tlv_free, etc.
>>
>> > +}
>> > +
>> >  static void load_default_system_params(struct btd_adapter *adapter)
>> >  {
>> > -       struct {
>> > -               struct mgmt_tlv entry;
>> > -               union {
>> > -                       uint16_t u16;
>> > -               };
>> > -       } __packed *params;
>> > -       uint16_t i = 0;
>> > -       size_t len = 0;
>> > +       struct iovec iovs[main_opts.default_params.num_entries];
>> > +       int cnt = 0, i;
>> >         unsigned int err;
>> >
>> >         if (!main_opts.default_params.num_entries ||
>> >             !btd_has_kernel_features(KERNEL_SET_SYSTEM_CONFIG))
>> >                 return;
>> >
>> > -       params = malloc0(sizeof(*params) *
>> > -                       main_opts.default_params.num_entries);
>> > -
>> > -       len = sizeof(params->entry) * main_opts.default_params.num_entries;
>> > -
>> >         if (main_opts.default_params.br_page_scan_type != 0xFFFF) {
>> > -               params[i].entry.type = 0x0000;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.br_page_scan_type;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0000,
>> > +                       sizeof(main_opts.default_params.br_page_scan_type),
>> > +                       &main_opts.default_params.br_page_scan_type);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.br_page_scan_interval) {
>> > -               params[i].entry.type = 0x0001;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.br_page_scan_interval;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0001,
>> > +                       sizeof(main_opts.default_params.br_page_scan_interval),
>> > +                       &main_opts.default_params.br_page_scan_interval);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.br_page_scan_win) {
>> > -               params[i].entry.type = 0x0002;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.br_page_scan_win;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0002,
>> > +                       sizeof(main_opts.default_params.br_page_scan_win),
>> > +                       &main_opts.default_params.br_page_scan_win);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.br_scan_type != 0xFFFF) {
>> > -               params[i].entry.type = 0x0003;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.br_scan_type;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0003,
>> > +                       sizeof(main_opts.default_params.br_scan_type),
>> > +                       &main_opts.default_params.br_scan_type);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.br_scan_interval) {
>> > -               params[i].entry.type = 0x0004;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.br_scan_interval;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0004,
>> > +                       sizeof(main_opts.default_params.br_scan_interval),
>> > +                       &main_opts.default_params.br_scan_interval);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.br_scan_win) {
>> > -               params[i].entry.type = 0x0005;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.br_scan_win;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0005,
>> > +                       sizeof(main_opts.default_params.br_scan_win),
>> > +                       &main_opts.default_params.br_scan_win);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.br_link_supervision_timeout) {
>> > -               params[i].entry.type = 0x0006;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 =
>> > -                       main_opts.default_params.br_link_supervision_timeout;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0006,
>> > +                       sizeof(main_opts.default_params.br_link_supervision_timeout),
>> > +                       &main_opts.default_params.br_link_supervision_timeout);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.br_page_timeout) {
>> > -               params[i].entry.type = 0x0007;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.br_page_timeout;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0007,
>> > +                       sizeof(main_opts.default_params.br_page_timeout),
>> > +                       &main_opts.default_params.br_page_timeout);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.br_min_sniff_interval) {
>> > -               params[i].entry.type = 0x0008;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.br_min_sniff_interval;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0008,
>> > +                       sizeof(main_opts.default_params.br_min_sniff_interval),
>> > +                       &main_opts.default_params.br_min_sniff_interval);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.br_max_sniff_interval) {
>> > -               params[i].entry.type = 0x0009;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.br_max_sniff_interval;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0009,
>> > +                       sizeof(main_opts.default_params.br_max_sniff_interval),
>> > +                       &main_opts.default_params.br_max_sniff_interval);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_min_adv_interval) {
>> > -               params[i].entry.type = 0x000a;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.le_min_adv_interval;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x000a,
>> > +                       sizeof(main_opts.default_params.le_min_adv_interval),
>> > +                       &main_opts.default_params.le_min_adv_interval);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_max_adv_interval) {
>> > -               params[i].entry.type = 0x000b;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.le_max_adv_interval;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x000b,
>> > +                       sizeof(main_opts.default_params.le_max_adv_interval),
>> > +                       &main_opts.default_params.le_max_adv_interval);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_multi_adv_rotation_interval) {
>> > -               params[i].entry.type = 0x000c;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 =
>> > -                       main_opts.default_params.le_multi_adv_rotation_interval;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x000c,
>> > +                       sizeof(main_opts.default_params.le_multi_adv_rotation_interval),
>> > +                       &main_opts.default_params.le_multi_adv_rotation_interval);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_scan_interval_autoconnect) {
>> > -               params[i].entry.type = 0x000d;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 =
>> > -                       main_opts.default_params.le_scan_interval_autoconnect;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x000d,
>> > +                       sizeof(main_opts.default_params.le_scan_interval_autoconnect),
>> > +                       &main_opts.default_params.le_scan_interval_autoconnect);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_scan_win_autoconnect) {
>> > -               params[i].entry.type = 0x000e;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 =
>> > -                       main_opts.default_params.le_scan_win_autoconnect;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x000e,
>> > +                       sizeof(main_opts.default_params.le_scan_win_autoconnect),
>> > +                       &main_opts.default_params.le_scan_win_autoconnect);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_scan_interval_suspend) {
>> > -               params[i].entry.type = 0x000f;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 =
>> > -                       main_opts.default_params.le_scan_interval_suspend;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x000f,
>> > +                       sizeof(main_opts.default_params.le_scan_interval_suspend),
>> > +                       &main_opts.default_params.le_scan_interval_suspend);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_scan_win_suspend) {
>> > -               params[i].entry.type = 0x0010;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.le_scan_win_suspend;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0010,
>> > +                       sizeof(main_opts.default_params.le_scan_win_suspend),
>> > +                       &main_opts.default_params.le_scan_win_suspend);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_scan_interval_discovery) {
>> > -               params[i].entry.type = 0x0011;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 =
>> > -                       main_opts.default_params.le_scan_interval_discovery;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0011,
>> > +                       sizeof(main_opts.default_params.le_scan_interval_discovery),
>> > +                       &main_opts.default_params.le_scan_interval_discovery);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_scan_win_discovery) {
>> > -               params[i].entry.type = 0x0012;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 =
>> > -                       main_opts.default_params.le_scan_win_discovery;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0012,
>> > +                       sizeof(main_opts.default_params.le_scan_win_discovery),
>> > +                       &main_opts.default_params.le_scan_win_discovery);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_scan_interval_adv_monitor) {
>> > -               params[i].entry.type = 0x0013;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 =
>> > -                       main_opts.default_params.le_scan_interval_adv_monitor;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0013,
>> > +                       sizeof(main_opts.default_params.le_scan_interval_adv_monitor),
>> > +                       &main_opts.default_params.le_scan_interval_adv_monitor);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_scan_win_adv_monitor) {
>> > -               params[i].entry.type = 0x0014;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 =
>> > -                       main_opts.default_params.le_scan_win_adv_monitor;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0014,
>> > +                       sizeof(main_opts.default_params.le_scan_win_adv_monitor),
>> > +                       &main_opts.default_params.le_scan_win_adv_monitor);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_scan_interval_connect) {
>> > -               params[i].entry.type = 0x0015;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 =
>> > -                       main_opts.default_params.le_scan_interval_connect;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0015,
>> > +                       sizeof(main_opts.default_params.le_scan_interval_connect),
>> > +                       &main_opts.default_params.le_scan_interval_connect);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_scan_win_connect) {
>> > -               params[i].entry.type = 0x0016;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.le_scan_win_connect;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0016,
>> > +                       sizeof(main_opts.default_params.le_scan_win_connect),
>> > +                       &main_opts.default_params.le_scan_win_connect);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_min_conn_interval) {
>> > -               params[i].entry.type = 0x0017;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.le_min_conn_interval;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0017,
>> > +                       sizeof(main_opts.default_params.le_min_conn_interval),
>> > +                       &main_opts.default_params.le_min_conn_interval);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_max_conn_interval) {
>> > -               params[i].entry.type = 0x0018;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.le_max_conn_interval;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0018,
>> > +                       sizeof(main_opts.default_params.le_max_conn_interval),
>> > +                       &main_opts.default_params.le_max_conn_interval);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_conn_latency) {
>> > -               params[i].entry.type = 0x0019;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.le_conn_latency;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x0019,
>> > +                       sizeof(main_opts.default_params.le_conn_latency),
>> > +                       &main_opts.default_params.le_conn_latency);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_conn_lsto) {
>> > -               params[i].entry.type = 0x001a;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.le_conn_lsto;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x001a,
>> > +                       sizeof(main_opts.default_params.le_conn_lsto),
>> > +                       &main_opts.default_params.le_conn_lsto);
>> > +               cnt++;
>> >         }
>> >
>> >         if (main_opts.default_params.le_autoconnect_timeout) {
>> > -               params[i].entry.type = 0x001b;
>> > -               params[i].entry.length = sizeof(params[i].u16);
>> > -               params[i].u16 = main_opts.default_params.le_autoconnect_timeout;
>> > -               ++i;
>> > -               len += sizeof(params[i].u16);
>> > +               set_mgmt_tlv(iovs + cnt, 0x001b,
>> > +                       sizeof(main_opts.default_params.le_autoconnect_timeout),
>> > +                       &main_opts.default_params.le_autoconnect_timeout);
>> > +               cnt++;
>> >         }
>> >
>> > -       err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
>> > -                       adapter->dev_id, len, params, NULL, NULL, NULL);
>> > +       err = mgmt_sendv(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
>> > +                       adapter->dev_id, cnt, iovs, NULL, NULL, NULL);
>> >         if (!err)
>> >                 btd_error(adapter->dev_id,
>> >                                 "Failed to set default system config for hci%u",
>> >                                 adapter->dev_id);
>> >
>> > -       free(params);
>> > +       for (i = 0; i < cnt; i++)
>> > +               g_free(iovs[i].iov_base);
>> >  }
>> >
>> >  static void load_devices(struct btd_adapter *adapter)
>> > diff --git a/src/main.c b/src/main.c
>> > index 77be776686a8..b83f7bffb485 100644
>> > --- a/src/main.c
>> > +++ b/src/main.c
>> > @@ -305,120 +305,149 @@ static void parse_controller_config(GKeyFile *config)
>> >  {
>> >         static const struct {
>> >                 const char * const val_name;
>> > -               uint16_t * const val;
>> > +               void * const val;
>> > +               const size_t size;
>> >                 const uint16_t min;
>> >                 const uint16_t max;
>> >         } params[] = {
>> >                 { "BRPageScanType",
>> >                   &main_opts.default_params.br_page_scan_type,
>> > +                 sizeof(main_opts.default_params.br_page_scan_type),
>> >                   0,
>> >                   1},
>> >                 { "BRPageScanInterval",
>> >                   &main_opts.default_params.br_page_scan_interval,
>> > +                 sizeof(main_opts.default_params.br_page_scan_interval),
>> >                   0x0012,
>> >                   0x1000},
>> >                 { "BRPageScanWindow",
>> >                   &main_opts.default_params.br_page_scan_win,
>> > +                 sizeof(main_opts.default_params.br_page_scan_win),
>> >                   0x0011,
>> >                   0x1000},
>> >                 { "BRInquiryScanType",
>> >                   &main_opts.default_params.br_scan_type,
>> > +                 sizeof(main_opts.default_params.br_scan_type),
>> >                   0,
>> >                   1},
>> >                 { "BRInquiryScanInterval",
>> >                   &main_opts.default_params.br_scan_interval,
>> > +                 sizeof(main_opts.default_params.br_scan_interval),
>> >                   0x0012,
>> >                   0x1000},
>> >                 { "BRInquiryScanWindow",
>> >                   &main_opts.default_params.br_scan_win,
>> > +                 sizeof(main_opts.default_params.br_scan_win),
>> >                   0x0011,
>> >                   0x1000},
>> >                 { "BRLinkSupervisionTimeout",
>> >                   &main_opts.default_params.br_link_supervision_timeout,
>> > +                 sizeof(main_opts.default_params.br_link_supervision_timeout),
>> >                   0x0001,
>> >                   0xFFFF},
>> >                 { "BRPageTimeout",
>> >                   &main_opts.default_params.br_page_timeout,
>> > +                 sizeof(main_opts.default_params.br_page_scan_win),
>> >                   0x0001,
>> >                   0xFFFF},
>> >                 { "BRMinSniffInterval",
>> >                   &main_opts.default_params.br_min_sniff_interval,
>> > +                 sizeof(main_opts.default_params.br_min_sniff_interval),
>> >                   0x0001,
>> >                   0xFFFE},
>> >                 { "BRMaxSniffInterval",
>> >                   &main_opts.default_params.br_max_sniff_interval,
>> > +                 sizeof(main_opts.default_params.br_max_sniff_interval),
>> >                   0x0001,
>> >                   0xFFFE},
>> >                 { "LEMinAdvertisementInterval",
>> >                   &main_opts.default_params.le_min_adv_interval,
>> > +                 sizeof(main_opts.default_params.le_min_adv_interval),
>> >                   0x0020,
>> >                   0x4000},
>> >                 { "LEMaxAdvertisementInterval",
>> >                   &main_opts.default_params.le_max_adv_interval,
>> > +                 sizeof(main_opts.default_params.le_max_adv_interval),
>> >                   0x0020,
>> >                   0x4000},
>> >                 { "LEMultiAdvertisementRotationInterval",
>> >                   &main_opts.default_params.le_multi_adv_rotation_interval,
>> > +                 sizeof(main_opts.default_params.le_multi_adv_rotation_interval),
>> >                   0x0001,
>> >                   0xFFFF},
>> >                 { "LEScanIntervalAutoConnect",
>> >                   &main_opts.default_params.le_scan_interval_autoconnect,
>> > +                 sizeof(main_opts.default_params.le_scan_interval_autoconnect),
>> >                   0x0004,
>> >                   0x4000},
>> >                 { "LEScanWindowAutoConnect",
>> >                   &main_opts.default_params.le_scan_win_autoconnect,
>> > +                 sizeof(main_opts.default_params.le_scan_win_autoconnect),
>> >                   0x0004,
>> >                   0x4000},
>> >                 { "LEScanIntervalSuspend",
>> >                   &main_opts.default_params.le_scan_interval_suspend,
>> > +                 sizeof(main_opts.default_params.le_scan_interval_suspend),
>> >                   0x0004,
>> >                   0x4000},
>> >                 { "LEScanWindowSuspend",
>> >                   &main_opts.default_params.le_scan_win_suspend,
>> > +                 sizeof(main_opts.default_params.le_scan_win_suspend),
>> >                   0x0004,
>> >                   0x4000},
>> >                 { "LEScanIntervalDiscovery",
>> >                   &main_opts.default_params.le_scan_interval_discovery,
>> > +                 sizeof(main_opts.default_params.le_scan_interval_discovery),
>> >                   0x0004,
>> >                   0x4000},
>> >                 { "LEScanWindowDiscovery",
>> >                   &main_opts.default_params.le_scan_win_discovery,
>> > +                 sizeof(main_opts.default_params.le_scan_win_discovery),
>> >                   0x0004,
>> >                   0x4000},
>> >                 { "LEScanIntervalAdvMonitor",
>> >                   &main_opts.default_params.le_scan_interval_adv_monitor,
>> > +                 sizeof(main_opts.default_params.le_scan_interval_adv_monitor),
>> >                   0x0004,
>> >                   0x4000},
>> >                 { "LEScanWindowAdvMonitor",
>> >                   &main_opts.default_params.le_scan_win_adv_monitor,
>> > +                 sizeof(main_opts.default_params.le_scan_win_adv_monitor),
>> >                   0x0004,
>> >                   0x4000},
>> >                 { "LEScanIntervalConnect",
>> >                   &main_opts.default_params.le_scan_interval_connect,
>> > +                 sizeof(main_opts.default_params.le_scan_interval_connect),
>> >                   0x0004,
>> >                   0x4000},
>> >                 { "LEScanWindowConnect",
>> >                   &main_opts.default_params.le_scan_win_connect,
>> > +                 sizeof(main_opts.default_params.le_scan_win_connect),
>> >                   0x0004,
>> >                   0x4000},
>> >                 { "LEMinConnectionInterval",
>> >                   &main_opts.default_params.le_min_conn_interval,
>> > +                 sizeof(main_opts.default_params.le_min_conn_interval),
>> >                   0x0006,
>> >                   0x0C80},
>> >                 { "LEMaxConnectionInterval",
>> >                   &main_opts.default_params.le_max_conn_interval,
>> > +                 sizeof(main_opts.default_params.le_max_conn_interval),
>> >                   0x0006,
>> >                   0x0C80},
>> >                 { "LEConnectionLatency",
>> >                   &main_opts.default_params.le_conn_latency,
>> > +                 sizeof(main_opts.default_params.le_conn_latency),
>> >                   0x0000,
>> >                   0x01F3},
>> >                 { "LEConnectionSupervisionTimeout",
>> >                   &main_opts.default_params.le_conn_lsto,
>> > +                 sizeof(main_opts.default_params.le_conn_lsto),
>> >                   0x000A,
>> >                   0x0C80},
>> >                 { "LEAutoconnecttimeout",
>> >                   &main_opts.default_params.le_autoconnect_timeout,
>> > +                 sizeof(main_opts.default_params.le_autoconnect_timeout),
>> >                   0x0001,
>> >                   0x4000},
>> >         };
>> > @@ -439,7 +468,9 @@ static void parse_controller_config(GKeyFile *config)
>> >
>> >                         val = MAX(val, params[i].min);
>> >                         val = MIN(val, params[i].max);
>> > -                       *params[i].val = val;
>> > +
>> > +                       val = htobl(val);
>> > +                       memcpy(params[i].val, &val, params[i].size);
>> >                         ++main_opts.default_params.num_entries;
>> >                 }
>> >         }
>> > diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
>> > index b327b4088c6f..c6560e9c265b 100644
>> > --- a/src/shared/mgmt.c
>> > +++ b/src/shared/mgmt.c
>> > @@ -558,6 +558,48 @@ static struct mgmt_request *create_request(uint16_t opcode, uint16_t index,
>> >         return request;
>> >  }
>> >
>> > +unsigned int mgmt_sendv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
>> > +                               int count, void *iovecs,
>> > +                               mgmt_request_func_t callback,
>> > +                               void *user_data, mgmt_destroy_func_t destroy)
>> > +{
>> > +       FILE *ptr = NULL;
>> > +       int fd;
>> > +       uint8_t *buf = NULL;
>> > +       uint16_t buf_len;
>> > +       unsigned int ret = 0;
>> > +
>> > +       ptr = tmpfile();
>>
>> Not sure what is the intent with the tempory file here, we can in fact
>> use writev/sendmsg with the MGMT socket directly, in fact we do use
>> io_send that takes an iov but it looks like we would have to copy the
>> iovs since it does the transfer asynchronously in that case perhaps it
>> is not efficient to pass an iov array, except if we do want to check
>> if we can write right away thus avoiding the alloc + memcpy
>> everywhere.
>>
>> To make the API perhaps have all the TLVs combined in a single iov,
>> e.g. mgmt_tlv_add(iov), to make it simpler to copy if we cannot send
>
>
> If we combined all the TLV in a single iov, then I guess that makes no
> difference than using a buffer to accommodate each entry manually.
> How about we store each TLV in a different iov and simply call
> mgmt_tlv_add(iov) for each TLV?

Like I said this wouldn't avoid the memcpy which was why I suggested
using iovec in the first place, but moving the TLV logic to mgmt.c is
probably a good idea anyway since it makes it easier to be shared with
the likes of btmgmt, etc.

>>
>> the message directly, also please split the mgmt.c chances from the
>> daemon changes.
>>
>> > +
>> > +       if (!ptr)
>> > +               goto done;
>> > +
>> > +       fd = fileno(ptr);
>> > +       buf_len = writev(fd, (struct iovec *)iovecs, count);
>> > +
>> > +       if (buf_len < 0)
>> > +               goto done;
>> > +
>> > +       buf = malloc(buf_len);
>> > +
>> > +       if (!buf)
>> > +               goto done;
>> > +
>> > +       rewind(ptr);
>> > +       if (fread(buf, 1, buf_len, ptr) < buf_len)
>> > +               goto done;
>> > +
>> > +       ret = mgmt_send(mgmt, opcode, index, buf_len, buf, callback, user_data,
>> > +                                                               destroy);
>> > +
>> > +done:
>> > +       if (ptr)
>> > +               fclose(ptr);
>> > +       if (buf)
>> > +               free(buf);
>> > +       return ret;
>> > +}
>> > +
>> >  unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
>> >                                 uint16_t length, const void *param,
>> >                                 mgmt_request_func_t callback,
>> > diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
>> > index 6608faa7ed0f..87158ebc3774 100644
>> > --- a/src/shared/mgmt.h
>> > +++ b/src/shared/mgmt.h
>> > @@ -33,6 +33,10 @@ bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close);
>> >  typedef void (*mgmt_request_func_t)(uint8_t status, uint16_t length,
>> >                                         const void *param, void *user_data);
>> >
>> > +unsigned int mgmt_sendv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
>> > +                               int count, void *iovecs,
>> > +                               mgmt_request_func_t callback,
>> > +                               void *user_data, mgmt_destroy_func_t destroy);
>> >  unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
>> >                                 uint16_t length, const void *param,
>> >                                 mgmt_request_func_t callback,
>> > --
>> > 2.29.0.rc1.297.gfa9743e501-goog
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
