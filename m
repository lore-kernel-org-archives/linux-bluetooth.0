Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A06EC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 19:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F8D2072A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 19:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDTH30fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgCETRv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:17:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34993 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgCETRv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 14:17:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id v10so6874010otp.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2020 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sBkOD1ktynya5oOu7pXkdyqP/qG94Cqwvx9AYETXInw=;
        b=GDTH30fnSwDUkdQp8RhBnbYLUvU3+XqZyteLW9jxlNEBvCj09yB2MedZuRGD819U7Z
         BKl/Nu25FdlBg+JLNUqFOMDteyDqjMYxryDiYqUGOwFRqjmJHDZ7Qm61ibqX+auA4bVF
         kbUQE4RVQt7Zb3oBlhsatxD8ICqCnwSdHBkFupYxs6FkVtL0guMf9ysu29+WKajZtj4+
         QCsl4cDuyu9djXlhewElB4y+HTdavKzaHDW+aKZ3W9sB2RPvZNMTfcIA4yowPAY0kJ9S
         +3BIGLo3jcahSAEoIqYY/yqJjZbXAlkab2CqrwsrFgTLOB40QxfW/GxbFDTR1mjo9Kij
         4Y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBkOD1ktynya5oOu7pXkdyqP/qG94Cqwvx9AYETXInw=;
        b=TapTDnoKT6aaxzQsVPuyCkRsEd3xGr3HYWOUtUFDuN0IrXu3b52i93MvcuNJb1a+AU
         bk/J/P+eOOeugVc2H6IJSdqwTVL/y8ev6PMuu45A09g5ik1akl3RTvAQDG3uBir/16zx
         LxdQJoms3hzj6lQhc8vUDrjF83hqvO0tjBy0i3l17reXwzEEExfIisPj/FnzVecHZqtv
         DLpm/sq4TLIcfM/le6LftcbpP9NuCCiRp1TsM24G2QbBLQR4n6lhs7UbePD721Eids+z
         VKAOVBxDoa/3XGDJYM0bgzxoyoamDjQ3Synl0vZZIfhyYbU3QmR2OXKejbeiecOss6WP
         BsRw==
X-Gm-Message-State: ANhLgQ0ufSNMQ5uu/aDy/92QWrj8KeCsm+VLu2rYHI+EWjoFfTcG/Gkz
        emkT3oSsdidpcmJEDcy4q7SfBLhPw1stezBASiRwscUf
X-Google-Smtp-Source: ADFU+vu23dLna+DdPkrOu0fYRgD+QxXyNEius6cHOK/I2AU60TBUFyIsvojJ1XEG9FlEvxYuXaPOSoN4glpiFR3asQY=
X-Received: by 2002:a05:6830:1e34:: with SMTP id t20mr8356322otr.79.1583435870253;
 Thu, 05 Mar 2020 11:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20200305185904.Bluez.v1.1.I6c78c0eb9826eb17c944c4903132ee75c1324136@changeid>
In-Reply-To: <20200305185904.Bluez.v1.1.I6c78c0eb9826eb17c944c4903132ee75c1324136@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 5 Mar 2020 11:17:38 -0800
Message-ID: <CABBYNZLPDqsoPSPKz=X9LEDJvq9Lb0r7jXDS_BCi5d57dNXi5A@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] avdtp: Fix crashes in avdtp_abort
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Thu, Mar 5, 2020 at 3:06 AM Howard Chung <howardchung@google.com> wrote:
>
> Initialized avdtp_local_sep later since stream could be NULL.
> ---
>
>  profiles/audio/avdtp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 0e075f9ff..12d984866 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -3566,7 +3566,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
>  {
>         struct seid_req req;
>         int ret;
> -       struct avdtp_local_sep *sep = stream->lsep;
> +       struct avdtp_local_sep *sep;
>
>         if (!stream && session->discover) {
>                 /* Don't call cb since it being aborted */
> @@ -3581,6 +3581,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
>         if (stream->lsep->state == AVDTP_STATE_ABORTING)
>                 return -EINVAL;

I suspect there i something else going on then just the lsep being
NULL since we do check it on the line above it would have crashed
anyway, is this perhaps the result of lsep being unregistered before
the avdtp_abort is called?

> +       sep = stream->lsep;
>         avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
>
>         if (session->req && stream == session->req->stream)
> --
> 2.25.0.265.gbab2e86ba0-goog
>


-- 
Luiz Augusto von Dentz
