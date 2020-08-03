Return-Path: <SRS0=SB5R=BN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53482C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 20:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F071022CA1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 20:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5hZ7y5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgHCUBN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgHCUBN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Aug 2020 16:01:13 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCCFC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2020 13:01:12 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id v21so21580354otj.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Aug 2020 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hlg5svWlsRE4MtXofp3Yd6rbfJDIbDN8Va86Lsz6+o=;
        b=R5hZ7y5QwI9miGU3E3zobKw6F63dJa1lRzSiT8OI7bF3i89YKWdRP7shKkHbpB7eaW
         4qSp+g2CdBpdCUevm46VojJ0KL47abYMYvCsm713CWIlK7jc+3toxk6wDk1HKfCId4R+
         4WqJBVxT5nM9+1ppLL/Xqnf959rgYHnzHwFfP9geGoQ7Q2Lz1RCe8hDLxgOoYLBZ4OHV
         +srMiRiHTBgS+2baCSLh3dx21cLKMp5X57coUFO+q7LvMAySxp4i3DkLRBwO1K2G9kAf
         36pqNWdkpVs5bPJwzEilu376O/iLaQO+xy64Zfv03Th+UxdRBmWfGhLkXgMi+9HhD5Eq
         9Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hlg5svWlsRE4MtXofp3Yd6rbfJDIbDN8Va86Lsz6+o=;
        b=K2wET//74FFAeU1WfliUK2Qk13jxKljBGoCR9iKm83fCdJnQf81PvKJPCc43B6R/i7
         P52VAOlthHngaxw9xIYMVTnb1RzYJXqEtyX2soXqu2+NB0gIynMJ+OCYFCfwtktOAdQk
         B358QbGmu3HchURfUwpJg+pCGLHmMGV7BbV3ozkTzkk67nT73emjoJAfdf4nmlbZUOHu
         N/bycSLL7S8k4EE2PYI8czIfnQAHoWGSi9hbiKLAtL41l5lgfdLz0lFc0U3caeO84fqE
         yaDw5njgUs5FE+QXCbwbEhP7ycT6Satb/Ow89Nu4Y98YzhcjvnAg9g2tvGJITt6lcK1d
         3k8g==
X-Gm-Message-State: AOAM531en2WEbx5zSSZWhP3HdRrRGf/rGMwxSf4v22EOqkOYvt1vbG35
        L0s9JT+peKgrTAebBzHDrdxwCAvLgZXvWPwvt/o=
X-Google-Smtp-Source: ABdhPJzroe1s8rxne+IDicgWMu+ARSf45mE2pObgb0IE9yaZmpaXllvs4MYj8OpLOP3uwXVgx3G7iqgDnh8fSE9Clw8=
X-Received: by 2002:a9d:6053:: with SMTP id v19mr14557878otj.362.1596484871899;
 Mon, 03 Aug 2020 13:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200803145200.Bluez.v2.1.Ibf5508171632eebb66a6cd0ed2fa87bfac078f74@changeid>
In-Reply-To: <20200803145200.Bluez.v2.1.Ibf5508171632eebb66a6cd0ed2fa87bfac078f74@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 3 Aug 2020 13:01:02 -0700
Message-ID: <CABBYNZ+enHjri-aMrWcur5V+EWDRWj9b5Zmwp4v4ijDpYN7m4A@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 1/3] input/device: Replace UHID_FEATURE with UHID_GET_REPORT
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Sun, Aug 2, 2020 at 11:52 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> According to kernel's uhid.h, UHID_FEATURE is obsolete and is
> replaced with UHID_GET_REPORT.
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
> Changes in v2:
> -Split into three patches, now this only handles UHID_GET_REPORT
>
>  profiles/input/device.c    | 41 +++++++++++++++++++-------------------
>  profiles/input/hidp_defs.h |  2 +-
>  2 files changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index ee0b2404a..ac4487f63 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -220,7 +220,7 @@ static bool hidp_send_intr_message(struct input_device *idev, uint8_t hdr,
>         return hidp_send_message(idev->intr_io, hdr, data, size);
>  }
>
> -static bool uhid_send_feature_answer(struct input_device *idev,
> +static bool uhid_send_get_report_reply(struct input_device *idev,
>                                         const uint8_t *data, size_t size,
>                                         uint32_t id, uint16_t err)
>  {
> @@ -230,8 +230,8 @@ static bool uhid_send_feature_answer(struct input_device *idev,
>         if (data == NULL)
>                 size = 0;
>
> -       if (size > sizeof(ev.u.feature_answer.data))
> -               size = sizeof(ev.u.feature_answer.data);
> +       if (size > sizeof(ev.u.get_report_reply.data))
> +               size = sizeof(ev.u.get_report_reply.data);
>
>         if (!idev->uhid_created) {
>                 DBG("HID report (%zu bytes) dropped", size);
> @@ -239,13 +239,13 @@ static bool uhid_send_feature_answer(struct input_device *idev,
>         }
>
>         memset(&ev, 0, sizeof(ev));
> -       ev.type = UHID_FEATURE_ANSWER;
> -       ev.u.feature_answer.id = id;
> -       ev.u.feature_answer.err = err;
> -       ev.u.feature_answer.size = size;
> +       ev.type = UHID_GET_REPORT_REPLY;
> +       ev.u.get_report_reply.id = id;
> +       ev.u.get_report_reply.err = err;
> +       ev.u.get_report_reply.size = size;
>
>         if (size > 0)
> -               memcpy(ev.u.feature_answer.data, data, size);
> +               memcpy(ev.u.get_report_reply.data, data, size);
>
>         ret = bt_uhid_send(idev->uhid, &ev);
>         if (ret < 0) {
> @@ -399,7 +399,7 @@ static void hidp_recv_ctrl_handshake(struct input_device *idev, uint8_t param)
>         case HIDP_HSHK_ERR_FATAL:
>                 if (pending_req_type == HIDP_TRANS_GET_REPORT) {
>                         DBG("GET_REPORT failed (%u)", param);
> -                       uhid_send_feature_answer(idev, NULL, 0,
> +                       uhid_send_get_report_reply(idev, NULL, 0,
>                                                 idev->report_rsp_id, EIO);
>                         pending_req_complete = true;
>                 } else if (pending_req_type == HIDP_TRANS_SET_REPORT) {
> @@ -460,8 +460,8 @@ static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t param,
>         switch (param) {
>         case HIDP_DATA_RTYPE_FEATURE:
>         case HIDP_DATA_RTYPE_INPUT:
> -       case HIDP_DATA_RTYPE_OUPUT:
> -               uhid_send_feature_answer(idev, data + 1, size - 1,
> +       case HIDP_DATA_RTYPE_OUTPUT:
> +               uhid_send_get_report_reply(idev, data + 1, size - 1,
>                                                         idev->report_rsp_id, 0);
>                 break;
>
> @@ -626,7 +626,7 @@ static void hidp_send_set_report(struct uhid_event *ev, void *user_data)
>                 break;
>         case UHID_OUTPUT_REPORT:
>                 /* Send DATA on interrupt channel */
> -               hdr = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
> +               hdr = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUTPUT;
>                 hidp_send_intr_message(idev, hdr, ev->u.output.data,
>                                                         ev->u.output.size);
>                 break;
> @@ -646,13 +646,13 @@ static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
>
>         if (idev->report_req_pending) {
>                 DBG("Old GET_REPORT or SET_REPORT still pending");
> -               uhid_send_feature_answer(idev, NULL, 0, ev->u.feature.id,
> +               uhid_send_get_report_reply(idev, NULL, 0, ev->u.get_report.id,
>                                                                         EBUSY);
>                 return;
>         }
>
>         /* Send GET_REPORT on control channel */
> -       switch (ev->u.feature.rtype) {
> +       switch (ev->u.get_report.rtype) {
>         case UHID_FEATURE_REPORT:
>                 hdr = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_FEATURE;
>                 break;
> @@ -660,21 +660,21 @@ static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
>                 hdr = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_INPUT;
>                 break;
>         case UHID_OUTPUT_REPORT:
> -               hdr = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_OUPUT;
> +               hdr = HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_OUTPUT;
>                 break;
>         default:
> -               DBG("Unsupported HID report type %u", ev->u.feature.rtype);
> +               DBG("Unsupported HID report type %u", ev->u.get_report.rtype);
>                 return;
>         }
>
> -       sent = hidp_send_ctrl_message(idev, hdr, &ev->u.feature.rnum,
> -                                               sizeof(ev->u.feature.rnum));
> +       sent = hidp_send_ctrl_message(idev, hdr, &ev->u.get_report.rnum,
> +                                               sizeof(ev->u.get_report.rnum));
>         if (sent) {
>                 idev->report_req_pending = hdr;
>                 idev->report_req_timer =
>                         g_timeout_add_seconds(REPORT_REQ_TIMEOUT,
>                                                 hidp_report_req_timeout, idev);
> -               idev->report_rsp_id = ev->u.feature.id;
> +               idev->report_rsp_id = ev->u.get_report.id;
>         }
>  }
>
> @@ -909,7 +909,8 @@ static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
>         }
>
>         bt_uhid_register(idev->uhid, UHID_OUTPUT, hidp_send_set_report, idev);
> -       bt_uhid_register(idev->uhid, UHID_FEATURE, hidp_send_get_report, idev);
> +       bt_uhid_register(idev->uhid, UHID_GET_REPORT, hidp_send_get_report,
> +                                                                       idev);
>
>         idev->uhid_created = true;
>
> diff --git a/profiles/input/hidp_defs.h b/profiles/input/hidp_defs.h
> index 5dc479acf..bb9231dbb 100644
> --- a/profiles/input/hidp_defs.h
> +++ b/profiles/input/hidp_defs.h
> @@ -63,7 +63,7 @@
>  #define HIDP_DATA_RSRVD_MASK                   0x0c
>  #define HIDP_DATA_RTYPE_OTHER                  0x00
>  #define HIDP_DATA_RTYPE_INPUT                  0x01
> -#define HIDP_DATA_RTYPE_OUPUT                  0x02
> +#define HIDP_DATA_RTYPE_OUTPUT                 0x02
>  #define HIDP_DATA_RTYPE_FEATURE                        0x03
>
>  /* HIDP protocol header parameters */
> --
> 2.28.0.163.g6104cc2f0b6-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
