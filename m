Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08568C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 21:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF9861075
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 21:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhCaVtG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Mar 2021 17:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhCaVtD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Mar 2021 17:49:03 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F69C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 14:49:03 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso288913otq.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 14:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/D+i753YKWVJvx5V2jIxA7xCxtP+lqXtQP5sJ7fGBhE=;
        b=gSqhukv3hSwwxtXr1PmPvX0+2BBvZbCEIQ9XmGuQ1xbvKgRM/X+5jQgHGl9x8pAw+Y
         9LkQ9Sv5Mh6Ne/XjyLsdz/BnsCGmWz6EBWunP2bgl/OCyjLof3W3bSKU7LT9yYur/AQb
         MYDwmCVgX0LgzWWcVu23zaPEBGV2xOdb+unPZPLNj55BYEssER64QeWML6EnO4tilc/L
         O1E5Pb49ZlC6z4ZGG6NhYnmT4embdYWaQLGlDfRnjpaR2O60Vws03jEOBcxTucqTp+sX
         2lDEacpazX5H+IkODdVCP98DjshhTqB985YXFnI0TimsEsE4O3mneRsXQvBfij1uQEeG
         E/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/D+i753YKWVJvx5V2jIxA7xCxtP+lqXtQP5sJ7fGBhE=;
        b=Y1jdZn9/cPZgFU7PCqJruVri71SZg4ssdJKkB/4QZtm/wKr5c5iMeY7kg76V1rjGmn
         jVLvh6wnngIxy+rXHphmS0IWa4yIDRiXx8H3sjjIKQWTtGvTLCMAeKg0r6PCs6oPlqjr
         XDQXK1I/dpnlERBQQRpOOLP7mpWi6XS8Y8m4wl5LXeQFs29bOabnB92scmyV6R2fgTIF
         jc74oI5uVgYnNpricu8dShA45Dt6qgo8D6w3GrSxtfcetsXqm4QO3uU8i+kpR2WEmUSl
         MuXiJXeEUhJ1eW36JqVB0zoswZ8qWzJgxUuR8VbDGzafb/JeEyymp6wqRmMfWfjP/e9v
         K0Hg==
X-Gm-Message-State: AOAM530e7nCyLsTujMS2x6dsIpYlJBPppFz2vhOhsQMg0fAV9mFvCjnP
        ITsb9G9rFEh60swdy+iRMRwWY/U73IOy+aA2ngg5kVVB9tU=
X-Google-Smtp-Source: ABdhPJz8DrAqFUkHjDtbGKQHiTKJmuskA8Q4aHbM2IrA4xD8ftGMY6ZM5Ye3H+oZdGXtUFUpzFJiSkWNemDxpg4qQEE=
X-Received: by 2002:a9d:21a5:: with SMTP id s34mr4482542otb.240.1617227342529;
 Wed, 31 Mar 2021 14:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210322201616.3118617-1-luiz.dentz@gmail.com>
In-Reply-To: <20210322201616.3118617-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 31 Mar 2021 14:48:51 -0700
Message-ID: <CABBYNZ+vLParkSME-vDw6=GQTGBTRrq0ESRGZE+8qSFu8ZEx5w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] hog-lib: Fix crash when receiving UHID_GET_REPORT
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Mar 22, 2021 at 1:16 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If UHID_GET_REPORT is received but a report cannot be found, etc, the
> would pass bt_hog as user_data instead of report to get_report_cb
> leading to a crash.
>
> Fixes https://github.com/bluez/bluez/issues/112
> ---
>  profiles/input/hog-lib.c | 49 ++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 6ac14e401..e5e3d3e7f 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -786,11 +786,9 @@ fail:
>         set_report_cb(err, NULL, 0, hog);
>  }
>
> -static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
> -                                                       gpointer user_data)
> +static void report_reply(struct bt_hog *hog, uint8_t status, uint8_t id,
> +                                uint16_t len, const uint8_t *data)
>  {
> -       struct report *report = user_data;
> -       struct bt_hog *hog = report->hog;
>         struct uhid_event rsp;
>         int err;
>
> @@ -800,6 +798,31 @@ static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
>         rsp.type = UHID_GET_REPORT_REPLY;
>         rsp.u.get_report_reply.id = hog->getrep_id;
>
> +       if (status)
> +               goto done;
> +
> +       if (hog->has_report_id && len > 0) {
> +               rsp.u.get_report_reply.size = len + 1;
> +               rsp.u.get_report_reply.data[0] = id;
> +               memcpy(&rsp.u.get_report_reply.data[1], data, len);
> +       } else {
> +               rsp.u.get_report_reply.size = len;
> +               memcpy(rsp.u.get_report_reply.data, data, len);
> +       }
> +
> +done:
> +       rsp.u.get_report_reply.err = status;
> +       err = bt_uhid_send(hog->uhid, &rsp);
> +       if (err < 0)
> +               error("bt_uhid_send: %s", strerror(-err));
> +}
> +
> +static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
> +                                                       gpointer user_data)
> +{
> +       struct report *report = user_data;
> +       struct bt_hog *hog = report->hog;
> +
>         if (status != 0) {
>                 error("Error reading Report value: %s", att_ecode2str(status));
>                 goto exit;
> @@ -820,20 +843,8 @@ static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
>         --len;
>         ++pdu;
>
> -       if (hog->has_report_id && len > 0) {
> -               rsp.u.get_report_reply.size = len + 1;
> -               rsp.u.get_report_reply.data[0] = report->id;
> -               memcpy(&rsp.u.get_report_reply.data[1], pdu, len);
> -       } else {
> -               rsp.u.get_report_reply.size = len;
> -               memcpy(rsp.u.get_report_reply.data, pdu, len);
> -       }
> -
>  exit:
> -       rsp.u.get_report_reply.err = status;
> -       err = bt_uhid_send(hog->uhid, &rsp);
> -       if (err < 0)
> -               error("bt_uhid_send: %s", strerror(-err));
> +       report_reply(hog, status, report->id, len, pdu);
>  }
>
>  static void get_report(struct uhid_event *ev, void *user_data)
> @@ -868,8 +879,8 @@ static void get_report(struct uhid_event *ev, void *user_data)
>         return;
>
>  fail:
> -       /* cancel the request on failure */
> -       get_report_cb(err, NULL, 0, hog);
> +       /* reply with an error on failure */
> +       report_reply(hog, err, 0, 0, NULL);
>  }
>
>  static bool get_descriptor_item_info(uint8_t *buf, ssize_t blen, ssize_t *len,
> --
> 2.30.2

Applied.

-- 
Luiz Augusto von Dentz
