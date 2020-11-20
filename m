Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06986C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 17:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A455E22240
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 17:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH2dHrce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgKTRtu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 12:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgKTRtt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 12:49:49 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A00C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 09:49:49 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id o3so9482191ota.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 09:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxubVbNmjI1o2BaAjPVyU5bVlMVnnFKyzOIhlZaDu18=;
        b=WH2dHrce/AniBNkM9Dmj2Ij/DE/Gqo6/kC25pbIcPZ+RxnuuvSnI3u0NENRHPHtJ7H
         ctmvnZPVBLatpLVuFVCOYWy80ERKdwb+/wW6MHcGxTxbYj8lY/reJ//SdV0D/JwNHd8l
         047ibGtxbRhANqI3vi2bChFwoCOC4rrKv3+V/lox0iByxgb/LN20VwSmh6kE6ZiORsBP
         i3Z7CbClexdumEXk3WcPTPeK9d9GGaAczOu7FX5JUWUN0qzEs9zzSANhHTOXcQuKRspq
         IM4+HqpU0hDOisgzfuEqJn173atFlSV1hdqcNHYYHH6MlS56EAhQ+yv/NDD7OBZSLQun
         L7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxubVbNmjI1o2BaAjPVyU5bVlMVnnFKyzOIhlZaDu18=;
        b=L3Z+re7twQoMuQQibVLHBVYnZaIDwDctYsfB/bWJr9FYG8gcF1ffbu9BEaHnAk59b6
         8Z73qS4ulRn0Pism+fEui70ShALr385jLYREYj4emGoAS2D5QepgsGOCYiqWD206ots4
         CzRJ5aDPKkapsDcrCYCtCj5ig3xY0NSylRH8/B/C6RJ8UXv1m4MbQbv2qdrQ7qsg9T/C
         Rz/r0OI/azB82Bb6/SPdl/f9d1+qjQ/ZaqZXr+x9hbyAjGTMwa+YII2nHNMrB+ySEUMF
         9mz06BFqbiWbHo8FSdimMLZbmAzjn/LkCN/XyDLYChGPd5hWu73MHoNBAmu/6RVBfQsj
         sBNA==
X-Gm-Message-State: AOAM533c9JWUakHyAXxjp1n9SPVmxyqxPRM9Eht2G/t0kdAyKYgaQkiZ
        wq17WbQtWYXNSOYN9gHHF/ITbWFsVqr9HETzBFRPDEK+
X-Google-Smtp-Source: ABdhPJyS5p4z+NGpUKwEL6G/F9/aPy1vEN9fhtpW2XWDIyxKStCMNQRWzSC+y7WpCQC9arNvuc+3NTXgHXUbh+cWdCU=
X-Received: by 2002:a9d:1a9:: with SMTP id e38mr13788953ote.240.1605894589074;
 Fri, 20 Nov 2020 09:49:49 -0800 (PST)
MIME-Version: 1.0
References: <a542b260-7eb1-8917-9379-e945003d7817@fourwalledcubicle.com>
In-Reply-To: <a542b260-7eb1-8917-9379-e945003d7817@fourwalledcubicle.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 20 Nov 2020 09:49:38 -0800
Message-ID: <CABBYNZJK0rnkkmkgg-qsd-50aN0ribGd5H5Ux2-hg6wZ3k8xdw@mail.gmail.com>
Subject: Re: [PATCH] Fix HOG profile incorrectly stripping off read report bytes.
To:     Dean Camera <dean@fourwalledcubicle.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dean,

On Thu, Nov 19, 2020 at 5:47 PM Dean Camera <dean@fourwalledcubicle.com> wrote:
>
> If the HID subsystem requests a HID report to be read from the
> device, we currently incorrectly strip off the first byte of the
> response, if the device has report IDs set in the HID report
> descriptor.
>
> This is incorrect; unlike USB HID, the report ID is *not* included
> in the HOG profile's HID reports, and instead exists out of band
> in a descriptor on the report's bluetooth characteristic in the
> device.
>
> In this patch, we remove the erroneous stripping of the first
> byte of the report, and (if report IDs are enabled) prepend the
> report ID to the front of the result. This makes the HID report
> returned indentical in format to that of a USB HID report, so
> that the upper HID drivers can consume HOG device reports in the
> same way as USB.
> ---
>   profiles/input/hog-lib.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 78018aad3..49d459e21 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -779,7 +779,8 @@ fail:
>   static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
>                                                         gpointer user_data)
>   {
> -       struct bt_hog *hog = user_data;
> +       struct report *report = user_data;
> +       struct bt_hog *hog = report->hog;
>         struct uhid_event rsp;
>         int err;
>
> @@ -808,13 +809,16 @@ static void get_report_cb(guint8 status, const
> guint8 *pdu, guint16 len,
>
>         --len;
>         ++pdu;
> +
>         if (hog->has_report_id && len > 0) {
> -               --len;
> -               ++pdu;
> +               rsp.u.get_report_reply.size = len + 1;
> +               rsp.u.get_report_reply.data[0] = report->id;
> +               memcpy(&rsp.u.get_report_reply.data[1], pdu, len);
> +       }
> +       else {
> +               rsp.u.get_report_reply.size = len;
> +               memcpy(rsp.u.get_report_reply.data, pdu, len);
>         }
> -
> -       rsp.u.get_report_reply.size = len;
> -       memcpy(rsp.u.get_report_reply.data, pdu, len);
>
>   exit:
>         rsp.u.get_report_reply.err = status;
> @@ -846,7 +850,7 @@ static void get_report(struct uhid_event *ev, void
> *user_data)
>
>         hog->getrep_att = gatt_read_char(hog->attrib,
>                                                 report->value_handle,
> -                                               get_report_cb, hog);
> +                                               get_report_cb, report);
>         if (!hog->getrep_att) {
>                 err = ENOMEM;
>                 goto fail;
> --
> 2.29.2.windows.2
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
