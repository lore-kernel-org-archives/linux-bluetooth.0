Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A03BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 20:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E66E6108E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 20:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhJRUHz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhJRUHv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 16:07:51 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F47BC06161C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 13:05:39 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id u5so9418763uao.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JO4xZFW2dLIeIGe8G6d8LvXqiJRtJNgoiqKajxdKxi0=;
        b=DAPmXx190yeX0BlovHXSwoaz897iEdyfUqYJe3XotQAibG6xm2mw64+88bAWHMNVS+
         ZrLAlR7cgBRZ00rIb/+rP+Ec5Ad0mFxjmYq2OO35Nof93uCsTyGTudSYULkgt9fwSYMM
         LBHobQ4qlMVK9WmAbWce4o+ZZPlMu1cbgRyZB3aqt80INL0ii7fqF3WCXgj+Gv/4uJKS
         k/7nLI/3B7G/8/nAvTn3l3kwaKVUD0LHhxTQy3zGW7d8vNCY3q9Tftg1lYGExeuKNdZQ
         xQj/RsjxxBlDOb6zvLm5ytUywPfq0zgpTpuJ2qrYH2jfRpMwgXt5Jn+28QDMN4DwaU8T
         I5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JO4xZFW2dLIeIGe8G6d8LvXqiJRtJNgoiqKajxdKxi0=;
        b=OGWLqRXXTaXcXGtFWBiK9Qdohl92N6hCkJnM8otlZh2b2GZ7sz8b+N6uyb2PtMH+g1
         +/X1jWCl4MLIIHS7WDBVPaMM9CBSS5wVlsm3WHJa/CtgcKkzaz6THRJ6YoApuoHnujdJ
         RzBtRZMWKML/pTTf9rMY9g//cawN13Rt2iOyKmTDzaoFnzteeVhALV77zZMgMH/APOOe
         DdoOIZrU21RW9pAaFld5WVw56epqO8/WzowlHto84J6/Vn3CG5lzZmdMfXBvEGHyZZet
         +wXcNSMrygEowzX1O5cIf/SWvRxamO+iUogd8Wk21PNX0noz1kJ/Cb/gvxvy10xSMcpY
         hTzQ==
X-Gm-Message-State: AOAM5337Q+cx/h8zzlkO0cnvtQos2nBEWSr8UWrTJ07PWQVhC6u/s3FP
        9SescBCww7R09/SOabcPCiDGFKoGLjCqk7tc8OM6LpyZ
X-Google-Smtp-Source: ABdhPJwbxoF+1gqHDwJChWyaD6Fx3Iiil42tgJhxZtmgFmix96z5CigYhua/hL9v/eheRapxpS2cAIZQQ89M/1hW3vs=
X-Received: by 2002:a05:6102:4af:: with SMTP id r15mr30218587vsa.10.1634587538473;
 Mon, 18 Oct 2021 13:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211015050929.3130100-1-luiz.dentz@gmail.com>
 <CAGPPCLDFYFeiwfiyRX=6PquYYQ-Fp_LpN4Gw2745jyWzQKEBRQ@mail.gmail.com> <CABBYNZJVLD1gw062NepifuHssKfekk9LHEx+xu5XSX6AwWts_w@mail.gmail.com>
In-Reply-To: <CABBYNZJVLD1gw062NepifuHssKfekk9LHEx+xu5XSX6AwWts_w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 18 Oct 2021 13:05:27 -0700
Message-ID: <CABBYNZJBYi_tTHY+j9f=6-tBi-VoCkY9zzVVJDZw126Ocj1E9Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/7] monitor: Add packet definitions for MSFT extension
To:     Manish Mandlik <mmandlik@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Oct 18, 2021 at 9:24 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Manish,
>
> On Mon, Oct 18, 2021 at 7:53 AM Manish Mandlik <mmandlik@google.com> wrote:
> >
> > Hi Luiz,
> >
> > On Fri, Oct 15, 2021 at 1:09 AM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> >>
> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>
> >> This adds proper packet definitions for command and response of MSFT
> >> extension.
> >> ---
> >>  monitor/msft.h | 148 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 148 insertions(+)
> >>
> >> diff --git a/monitor/msft.h b/monitor/msft.h
> >> index a268f4bc7..90a64117a 100644
> >> --- a/monitor/msft.h
> >> +++ b/monitor/msft.h
> >> @@ -24,6 +24,154 @@
> >>
> >>  #include <stdint.h>
> >>
> >> +#define MSFT_SUBCMD_READ_SUPPORTED_FEATURES    0x00
> >> +
> >> +struct msft_cmd_read_supported_features {
> >> +       uint8_t subcmd;
> >> +} __attribute__((packed));
> >> +
> >> +struct msft_rsp_read_supported_features {
> >> +       uint8_t  status;
> >> +       uint8_t  subcmd;
> >> +       uint8_t  features[8];
> >> +       uint8_t  evt_prefix_len;
> >> +       uint8_t  evt_prefix[];
> >> +} __attribute__((packed));
> >> +
> >> +#define MSFT_SUBCMD_MONITOR_RSSI               0x01
> >> +
> >> +struct msft_cmd_monitor_rssi {
> >> +       uint8_t  subcmd;
> >> +       uint16_t handle;
> >> +       int8_t   rssi_high;
> >> +       int8_t   rssi_low;
> >> +       uint8_t  rssi_low_interval;
> >> +       uint8_t  rssi_period;
> >> +} __attribute__((packed));
> >> +
> >> +struct msft_rsp_monitor_rssi {
> >> +       uint8_t  status;
> >> +       uint8_t  subcmd;
> >> +} __attribute__((packed));
> >> +
> >> +#define MSFT_SUBCMD_CANCEL_MONITOR_RSSI                0x02
> >> +
> >> +struct msft_cmd_cancel_monitor_rssi {
> >> +       uint8_t  subcmd;
> >> +       uint16_t handle;
> >> +} __attribute__((packed));
> >> +
> >> +struct msft_rsp_cancel_monitor_rssi {
> >> +       uint8_t  status;
> >> +       uint8_t  subcmd;
> >> +} __attribute__((packed));
> >> +
> >> +#define MSFT_SUBCMD_LE_MONITOR_ADV             0x03
> >> +
> >> +struct msft_le_monitor_pattern {
> >> +       uint8_t  len;
> >> +       uint8_t  type;
> >> +       uint8_t  start;
> >> +       uint8_t  data[];
> >> +} __attribute__((packed));
> >> +
> >
> >
> > +    #define MSFT_COND_LE_MONITOR_ADV_PATTERN                0x01
> >>
> >> +struct msft_le_monitor_adv_pattern_type {
> >> +       uint8_t num_patterns;
> >> +       struct msft_le_monitor_pattern data[];
> >> +} __attribute__((packed));
> >> +
> >
> >
> > +    #define MSFT_COND_LE_MONITOR_ADV_UUID                0x02
> >>
> >> +struct msft_le_monitor_adv_uuid_type {
> >> +       uint8_t  type;
> >> +       union {
> >> +               uint16_t u16;
> >> +               uint32_t u32;
> >> +               uint8_t  u128[8];
> >> +       } value;
> >> +} __attribute__((packed));
> >> +
> >
> >
> > +   #define MSFT_COND_LE_MONITOR_ADV_IRK                0x03
> >>
> >> +struct msft_le_monitor_adv_irk_type {
> >> +       uint8_t  irk[8];
> >> +} __attribute__((packed));
> >> +
> >> +#define MSFT_SUBCMD_LE_MONITOR_ADV_ADDR                0x04
> >
> > I think this is not a subcommand. Instead, it is a condition type. So we can rename this to something else, e.g. MSFT_COND_LE_MONITOR_ADV_ADDR.
> > Similarly, we'll have to define other three condition types as well for msft_le_monitor_adv_pattern_type, msft_le_monitor_adv_uuid_type and msft_le_monitor_adv_irk_type as mentioned above.
>
> Right I will fix it since the intent was to have it as conditions,
> thanks for reviewing.
>
> >> +struct msft_le_monitor_adv_addr {
> >> +       uint8_t  type;
> >> +       uint8_t  addr[6];
> >> +} __attribute__((packed));
> >> +
> >> +struct msft_cmd_le_monitor_adv {
> >> +       uint8_t  subcmd;
> >> +       int8_t   rssi_low;
> >> +       int8_t   rssi_high;
> >
> > Order should be:
> > +       int8_t   rssi_high;
> > +       int8_t   rssi_low;
> >>
> >> +       uint8_t  rssi_low_interval;
> >> +       uint8_t  rssi_period;
> >> +       uint8_t  type;
> >> +       uint8_t  data[];
> >> +} __attribute__((packed));
> >> +
> >> +struct msft_rsp_le_monitor_adv {
> >> +       uint8_t  status;
> >> +       uint8_t  subcmd;
> >> +       uint8_t  handle;
> >> +} __attribute__((packed));
> >> +
> >> +#define MSFT_SUBCMD_LE_CANCEL_MONITOR_ADV      0x04
> >> +
> >> +struct msft_cmd_le_cancel_monitor_adv {
> >> +       uint8_t  subcmd;
> >> +       uint8_t  handle;
> >> +} __attribute__((packed));
> >> +
> >> +struct msft_rsp_le_cancel_monitor_adv {
> >> +       uint8_t  status;
> >> +       uint8_t  subcmd;
> >> +} __attribute__((packed));
> >> +
> >> +#define MSFT_SUBCMD_LE_MONITOR_ADV_ENABLE      0x05
> >> +
> >> +struct msft_cmd_le_monitor_adv_enable {
> >> +       uint8_t  subcmd;
> >> +       uint8_t  enable;
> >> +} __attribute__((packed));
> >> +
> >> +struct msft_rsp_le_monitor_adv_enable {
> >> +       uint8_t  status;
> >> +       uint8_t  subcmd;
> >> +} __attribute__((packed));
> >> +
> >> +#define MSFT_SUBCMD_READ_ABS_RSSI              0x06
> >> +
> >> +struct msft_cmd_read_abs_rssi {
> >> +       uint8_t  subcmd;
> >> +       uint16_t handle;
> >> +} __attribute__((packed));
> >> +
> >> +struct msft_rsp_read_abs_rssi {
> >> +       uint8_t  status;
> >> +       uint8_t  subcmd;
> >> +       uint16_t handle;
> >> +       uint8_t  rssi;
>
> Ack.
>
> > 'int8_t rssi' instead of 'uint8_t rssi'
> >
> >> +} __attribute__((packed));
> >> +
> >> +#define MSFT_SUBEVT_RSSI                       0x01
> >> +
> >> +struct msft_evt_rssi {
> >> +       uint8_t  subevt;
> >> +       uint8_t  status;
> >> +       uint16_t handle;
> >> +       uint8_t  rssi;
> >
> > same as above - 'int8_t rssi' instead of 'uint8_t rssi'
>
> Ack.
>
> >
> >> +} __attribute__((packed));
> >> +
> >> +#define MSFT_SUBEVT_MONITOR_DEVICE             0x02
> >> +
> >> +struct msft_evt_monitor_device {
> >> +       uint8_t  subevt;
> >> +       uint8_t  addr_type;
> >> +       uint8_t  addr[6];
> >> +       uint8_t  handle;
> >> +       uint8_t  state;
> >> +} __attribute__((packed));
> >> +
> >>  struct vendor_ocf;
> >>  struct vendor_evt;
> >>
> >> --
> >> 2.31.1
> >>
> >
> > Rest of the changes look good to me.
> >
> > Thanks,
> > Manish.
>
>
>
> --
> Luiz Augusto von Dentz

Pushed after making the suggested changes.

-- 
Luiz Augusto von Dentz
