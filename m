Return-Path: <SRS0=A3U8=2Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3AFC2D0DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Dec 2019 13:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC93E206CB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Dec 2019 13:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC1yjNXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfLZN1l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Dec 2019 08:27:41 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44686 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZN1l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Dec 2019 08:27:41 -0500
Received: by mail-io1-f68.google.com with SMTP id b10so23237672iof.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Dec 2019 05:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AtyxqKL7AaLWX6CvYTKcO7ZFdyfyBQdpg1ZUyvdWoZY=;
        b=eC1yjNXEaYUAD4g9zqdX9OwRgnVJdkeFU9vlg31Pb6YC7d/1NMqPgMOyAZl6ONzmfY
         9pf/uZJUSZilclDvRztBd0vEY2vVa0ob9oqmX4JtcFw61PU52FS0dZNyIx8KuiofyBrC
         btV5A4zNsngC3flVTh0lch4V53sJ0P/PcsHaiTYoBikchTMOJKQv5skCNlxLXezIoXrz
         +2HbhadeDM7a7jq5Ibg+N/yadYl3MwEfELtSqDy34+YsksrE18omRcjb0n9Vs99A0kVg
         FCCCqv90JDkp6+5yFeAcT2BLjYIVbtQmqLqnWtmNzx0NvF3Lm40QVS0ZIlBzSVgF8atH
         ZvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtyxqKL7AaLWX6CvYTKcO7ZFdyfyBQdpg1ZUyvdWoZY=;
        b=L5rmC4VHzKanPgEneYS5EU46IKSZgtSgkKjD8mDelF8fYYXke9xfrB8IDlI274+Hdw
         gFbM6FOzaawTosiVntAsjL8qnSrlwH9AcHGNWAMgKFLmCQHAnaaE0YkERaxCvHg08JYM
         vkBtxdFQpRANODY0C5wSSjL081f1VwMYh5MHH6gjrKnBLpNQmeRjgwHOZa+mkoU7kVfC
         7tFLETE6aJKHs3MLLp82DUu+R7AlmSz26F3FDuE54tA7vrMq2Nm1gISnvCtCJ3Y3CRpr
         QziK6ki8D9xYyd9pqgD5zveKOnsBIWFE5T6kUWz/HNn8NNqDTvMoeelud8o5OLkrR6nl
         WNcw==
X-Gm-Message-State: APjAAAVeeopyH0L6BboI093KEAEgv9bQ7NBEDtymb+m7NtToZ4fyQicG
        o4Tu9xm0PLKHWcDwJJi2t3f7F0DE5/Yjvt7zSurO9Q==
X-Google-Smtp-Source: APXvYqyCE1hPQ2KwHmO5HHxAgiA7uMpc9QsqCJuIIOXIqDv08MmOP4CcthXMwSl0vwkgzvtUREyhB1RJNdK/Fg94jnQ=
X-Received: by 2002:a5d:8c8c:: with SMTP id g12mr31582974ion.23.1577366860161;
 Thu, 26 Dec 2019 05:27:40 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191206040900epcas5p2ccb274134dab1154452d6f8d75dfedac@epcas5p2.samsung.com>
 <1575605319-461-1-git-send-email-prathyusha.n@samsung.com>
In-Reply-To: <1575605319-461-1-git-send-email-prathyusha.n@samsung.com>
From:   Prathyusha N <tech.prathy@gmail.com>
Date:   Thu, 26 Dec 2019 18:57:28 +0530
Message-ID: <CAOm2iCNUrB7mnZhXjc3V6SNz3pZbKh5418PrJ=McUwJDGD5CcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mesh: Start link establishment timer of 60 sec
To:     linux-bluetooth@vger.kernel.org
Cc:     Prathyusha N <prathyusha.n@samsung.com>,
        Prathyusha N <tech.prathy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Dec 6, 2019 at 9:40 AM Prathyusha Nelluri
<prathyusha.n@samsung.com> wrote:
>
> From: Prathyusha N <prathyusha.n@samsung.com>
>
> 5.3.2 of Mesh Profile Bluetooth specification:
> To open a link, the provisioner shall start the link establishment
> timer, set to 60 seconds, and then shall start sending Link Open
> messages.
>
> On timeout, close indication will be sent. Provisioner cancels the
> Link Establishment timer, when the link is open i.e. in pb_adv_tx().
> ---
>  mesh/pb-adv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
> index 27cbc46..c9a2a65 100644
> --- a/mesh/pb-adv.c
> +++ b/mesh/pb-adv.c
> @@ -458,6 +458,8 @@ bool pb_adv_reg(bool initiator, mesh_prov_open_func_t open_cb,
>
>         if (initiator) {
>                 l_getrandom(&pb_session->link_id, sizeof(pb_session->link_id));
> +               pb_session->tx_timeout = l_timeout_create(60, tx_timeout,
> +                                                       pb_session, NULL);
>                 send_open_req(pb_session);
>         }
>
> --
> 2.7.4
>
Gentle Ping.

Thanks,
Prathyusha.
