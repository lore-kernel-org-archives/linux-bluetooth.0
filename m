Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2680DC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Apr 2021 17:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AB7610CB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Apr 2021 17:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhDHRIs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhDHRIq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Apr 2021 13:08:46 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A645C061760
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Apr 2021 10:08:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x2so2918508oiv.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Apr 2021 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0TBK/yQGPfjTSuYWZdBNPGBEy+upjulNl6hjA/Vpi4=;
        b=rcFAJ5VPfkh2HoIyBgmRVyVmGkyyhMBx3RM+XKytPivtFPs2CH2QM62R4adDxXzWih
         HucS0u5Pgy4W9mfj2gsIIEx7ENHiuWRkUHFT2SU4X0Rqdo/Odunl070UsdUPgre9yMHN
         ykNspw+pP7tici0oyOQjatmA0RyEX1YjIMkg28C+nBNSPm2wAgmEZpQonE4qZQR15vDa
         cTq/Caj4x0crLp4vZOpShm6Ne7EYcDi1aYuNAZGQ50gO9nn7XvkKHuHW7NU3MqQdfyPJ
         60Fxyp+mQsGlqzJdDQeyhyGpZ6pX8ECXb250Wdx4YoVe6siT/4jTKIbmet81Kp16De7L
         IUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0TBK/yQGPfjTSuYWZdBNPGBEy+upjulNl6hjA/Vpi4=;
        b=t4d33WrupvCJG13SJt97ICxhZK1VkYcc6qyf0P1EdbCHDBdXAOcADcAmecdDwo9Xcf
         CKj0kJ+U9w8Ju4AsKKQfVxQP7Grq4A9cuzIkLJ5oUbV8eOkGgqDSeCvod6rV2BVm1fHd
         jeT/Cz9qs+WSRQUGp6CdYxwQITcKuJfQ6EQep+JBlptI4FmZjMophGVGulTWfCMYG47D
         tm/dI0zlRakfqOD/r9oA4+3e3sGNtZ81khUjljyaMh7J71f+mlXggPmPnKWPvjj8Tv9P
         AXExeaERzPrBkN6v1Il2v3GzkqIwi8ZTgYn4Q2wIN8f3/HuFpxaX1AAPKpFnE63nQSGq
         /O0Q==
X-Gm-Message-State: AOAM533lKDxcVRI3z3hC+BzgFMBeIELis9/MW9uL6udaRlnzpLf5LZnx
        xVlPU3z+A1dcJlByJn9rqwArrWNF8nmaB6TcQe3M0LbwTKM=
X-Google-Smtp-Source: ABdhPJxkJdXFs0dxdZEE5xolz20Tlb9Yz24EKsb7Ng8pZDLM4EaIchiVK9Cy9Fu2r92DkFRuH1L8Ntiwr26pWkwhDvw=
X-Received: by 2002:a05:6808:10c5:: with SMTP id s5mr6834676ois.58.1617901711833;
 Thu, 08 Apr 2021 10:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210407163723.Bluez.v2.1.I4ff127dde9bc6adb2a07507af2bf2cc6b6bcf0f2@changeid>
In-Reply-To: <20210407163723.Bluez.v2.1.I4ff127dde9bc6adb2a07507af2bf2cc6b6bcf0f2@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 8 Apr 2021 10:08:21 -0700
Message-ID: <CABBYNZ+LE=vGstOBLXOmpZvwnawiag-EApKKR+_J3_YKG8eQeA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] input/hog: support multiple variable length notification
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, Apr 7, 2021 at 1:38 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> Processing Multiple Variable Length Notification is mandatory if EATT
> is enabled (Core Spec Vol 3 Part G Sec 4.2).
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> ---
>
> Changes in v2:
> * fix compilation error
>
>  attrib/att.h             |   1 +
>  profiles/input/hog-lib.c | 109 ++++++++++++++++++++++++++++-----------
>  src/attrib-server.c      |   1 +
>  3 files changed, 81 insertions(+), 30 deletions(-)
>
> diff --git a/attrib/att.h b/attrib/att.h
> index 13a0c3a31f..0dbfb14b83 100644
> --- a/attrib/att.h
> +++ b/attrib/att.h
> @@ -42,6 +42,7 @@
>  #define ATT_OP_HANDLE_NOTIFY           0x1B
>  #define ATT_OP_HANDLE_IND              0x1D
>  #define ATT_OP_HANDLE_CNF              0x1E
> +#define ATT_OP_HANDLE_NOTIFY_MULTI     0x23
>  #define ATT_OP_SIGNED_WRITE_CMD                0xD2

I rather not keep adding support for the attrib directory since we
want to get rid of it at some point and actually the main reason it
was not removed yet is because hog was not converted to use
bt_gatt_client so I'd say this would be a good time for bite the
bullet and make the conversion so we can proceed to remove it.

>  /* Error codes for Error response PDU */
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index e5e3d3e7f5..aa6c64a3f2 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -65,7 +65,6 @@
>
>  #define HOG_REPORT_MAP_MAX_SIZE        512
>  #define HID_INFO_SIZE                  4
> -#define ATT_NOTIFICATION_HEADER_SIZE   3
>
>  struct bt_hog {
>         int                     ref_count;
> @@ -112,7 +111,8 @@ struct report {
>         uint16_t                value_handle;
>         uint8_t                 properties;
>         uint16_t                ccc_handle;
> -       guint                   notifyid;
> +       guint                   notify_id;
> +       guint                   notify_multi_id;
>         uint16_t                len;
>         uint8_t                 *value;
>  };
> @@ -283,22 +283,14 @@ static void find_included(struct bt_hog *hog, GAttrib *attrib,
>         free(req);
>  }
>
> -static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
> +static void process_notification(struct report *report, guint16 len,
> +                                                       const uint8_t *data)
>  {
> -       struct report *report = user_data;
>         struct bt_hog *hog = report->hog;
>         struct uhid_event ev;
>         uint8_t *buf;
>         int err;
>
> -       if (len < ATT_NOTIFICATION_HEADER_SIZE) {
> -               error("Malformed ATT notification");
> -               return;
> -       }
> -
> -       pdu += ATT_NOTIFICATION_HEADER_SIZE;
> -       len -= ATT_NOTIFICATION_HEADER_SIZE;
> -
>         memset(&ev, 0, sizeof(ev));
>         ev.type = UHID_INPUT;
>         buf = ev.u.input.data;
> @@ -306,19 +298,78 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
>         if (hog->has_report_id) {
>                 buf[0] = report->id;
>                 len = MIN(len, sizeof(ev.u.input.data) - 1);
> -               memcpy(buf + 1, pdu, len);
> -               ev.u.input.size = ++len;
> +               memcpy(buf + 1, data, len);
> +               ev.u.input.size = len + 1;
>         } else {
>                 len = MIN(len, sizeof(ev.u.input.data));
> -               memcpy(buf, pdu, len);
> +               memcpy(buf, data, len);
>                 ev.u.input.size = len;
>         }
>
>         err = bt_uhid_send(hog->uhid, &ev);
> -       if (err < 0) {
> +       if (err < 0)
>                 error("bt_uhid_send: %s (%d)", strerror(-err), -err);
> -               return;
> +}
> +
> +static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
> +{
> +       struct report *report = user_data;
> +       uint8_t opcode = pdu[0];
> +       guint16 report_len;
> +       guint16 header_len;
> +
> +       /* Skip opcode field */
> +       pdu += 1;
> +       len -= 1;
> +
> +       if (opcode == ATT_OP_HANDLE_NOTIFY_MULTI)
> +               header_len = 4;
> +       else
> +               header_len = 2;
> +
> +       if (len < header_len)
> +               goto fail;
> +
> +       while (len >= header_len) {
> +               /* Skip first 2 bytes (handle) */
> +               pdu += 2;
> +               len -= 2;
> +
> +               if (opcode == ATT_OP_HANDLE_NOTIFY_MULTI) {
> +                       report_len = get_le16(pdu);
> +                       pdu += 2;
> +                       len -= 2;
> +
> +                       if (report_len > len)
> +                               goto fail;
> +               } else {
> +                       report_len = len;
> +               }
> +
> +               process_notification(report, report_len, pdu);
> +
> +               pdu += report_len;
> +               len -= report_len;
>         }
> +
> +       if (len == 0)
> +               return;
> +
> +fail:
> +       error("Malformed ATT notification");
> +}
> +
> +static void register_notify_handler(struct bt_hog *hog, struct report *report)
> +{
> +       report->notify_id = g_attrib_register(hog->attrib,
> +                                       ATT_OP_HANDLE_NOTIFY,
> +                                       report->value_handle,
> +                                       report_value_cb, report, NULL);
> +
> +       report->notify_multi_id = g_attrib_register(hog->attrib,
> +                                       ATT_OP_HANDLE_NOTIFY_MULTI,
> +                                       report->value_handle,
> +                                       report_value_cb, report, NULL);
>  }
>
>  static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
> @@ -336,13 +387,10 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
>                 return;
>         }
>
> -       if (report->notifyid)
> +       if (report->notify_id)
>                 return;
>
> -       report->notifyid = g_attrib_register(hog->attrib,
> -                                       ATT_OP_HANDLE_NOTIFY,
> -                                       report->value_handle,
> -                                       report_value_cb, report, NULL);
> +       register_notify_handler(hog, report);
>
>         DBG("Report characteristic descriptor written: notifications enabled");
>  }
> @@ -1711,13 +1759,10 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>         for (l = hog->reports; l; l = l->next) {
>                 struct report *r = l->data;
>
> -               if (r->notifyid)
> +               if (r->notify_id)
>                         continue;
>
> -               r->notifyid = g_attrib_register(hog->attrib,
> -                                       ATT_OP_HANDLE_NOTIFY,
> -                                       r->value_handle,
> -                                       report_value_cb, r, NULL);
> +               register_notify_handler(hog, r);
>         }
>
>         return true;
> @@ -1764,9 +1809,13 @@ void bt_hog_detach(struct bt_hog *hog)
>         for (l = hog->reports; l; l = l->next) {
>                 struct report *r = l->data;
>
> -               if (r->notifyid > 0) {
> -                       g_attrib_unregister(hog->attrib, r->notifyid);
> -                       r->notifyid = 0;
> +               if (r->notify_id > 0) {
> +                       g_attrib_unregister(hog->attrib, r->notify_id);
> +                       r->notify_id = 0;
> +               }
> +               if (r->notify_multi_id > 0) {
> +                       g_attrib_unregister(hog->attrib, r->notify_multi_id);
> +                       r->notify_multi_id = 0;
>                 }
>         }
>
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 5a178f95ea..fb11d3db2d 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -1085,6 +1085,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
>                 return;
>         case ATT_OP_HANDLE_IND:
>         case ATT_OP_HANDLE_NOTIFY:
> +       case ATT_OP_HANDLE_NOTIFY_MULTI:
>                 /* The attribute client is already handling these */
>                 return;
>         case ATT_OP_READ_MULTI_REQ:
> --
> 2.31.0.208.g409f899ff0-goog
>


-- 
Luiz Augusto von Dentz
