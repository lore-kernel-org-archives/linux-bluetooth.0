Return-Path: <SRS0=6kNt=MO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D071CC43143
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 11:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C5220652
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 11:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD894d7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C5220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeJBSM0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:12:26 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:45387 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeJBSMZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 14:12:25 -0400
Received: by mail-oi1-f180.google.com with SMTP id e17-v6so1165908oig.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Oct 2018 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9I9s+U5UlqYnB5Bko5RfJUR1zqxO9n1QLzUPkwXVuUg=;
        b=iD894d7+GwCyQLGKYfDEqsVDEjocrkNcyqbkACPaegq8D9F3/GZDXnkVfLOR2N71JP
         mJshowhyYoVo++ZNcPxKJ0rVQEUQNTu4yAdntW/WB1kYbnR0aD07CiY7C6Rgy/8hJZwC
         yMSAj0+XuCq7GrrOS3bqXklrj5sc01rx8IG94W2NCn9nT3pYRDQuma41uo/yXvaOZQYD
         EkDBNzwK1PfB3vOfUiuMZiqK3yWkmDfVhSpefWwVnGDYZ1SbuRSJaHEh3f9fQb02fKDw
         q+mAJpnVymL5m/hku1+WTA11sT8+2hzdkzu9pqXVdy4x3Dt0qC+VpQBYoHDlfGL/FcA9
         RfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9I9s+U5UlqYnB5Bko5RfJUR1zqxO9n1QLzUPkwXVuUg=;
        b=Bexf5R0RA8zdFxdi4LT32m7TDnpy5llDVxNh8JcJuEg5Tm7V9qz+9ArYeuY1QMiLHB
         Uj9qSeONIwdP+1BznGeJ6cEqKMwMEgd4Xhbf4/2DhGHcsBZycpnABTynyahA+xDC1ayo
         PNdS/+wOJsTkYxzRSTgZObQpZapRPAbBRkHW5IE7399RfRJu24qNt40eVNY/JyKoUJ+D
         9so1EhmdmhS9JiXVYwSN5Lz+onDY8gA4i6r5ZRU9XiPFZtIPP+7nj0GAYxPdogVeTlFm
         50sVZMgT95aUqruelys3KKhJ3Yjy2SX9W04wa8xLQ6k6GSbvjeXWeWRiObL0xOWddXOB
         yogQ==
X-Gm-Message-State: ABuFfogSemb8bNVFtF4bAPMo9/SZYTbQZRzhdNc8fPTAiJfW+A8nnPK4
        A/6IAwFwNgerMFr+L7mOwnQZVJxpm2vr0XQ/y01kAA==
X-Google-Smtp-Source: ACcGV61A3gE7jf/80n7weDx7JetPFo4YemNRrBOhCwgkxxp4rpmZDH3awQmfajaHHsgl0dvEVPdW3EE+jr23knejcZw=
X-Received: by 2002:aca:c42:: with SMTP id i2-v6mr7657237oiy.219.1538479775727;
 Tue, 02 Oct 2018 04:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181002082442.20802-1-luiz.dentz@gmail.com>
In-Reply-To: <20181002082442.20802-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 2 Oct 2018 14:29:24 +0300
Message-ID: <CABBYNZJPcxQ+1FBU4Gc1qj_Gf7yDcEx84ft6BRksJrgbEE85+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] shared/att: Reset fd when disconnected
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yunhan Wang <yunhanw@google.com>,
        Sukesh Srikakula <sukeshs@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Oct 2, 2018 at 11:24 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Set att->fd to -1 when considered disconnected.
> ---
> v3: Pass btd_device instead of bt_att since the later may have been
> disconnected already.
>
>  src/shared/att.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 8bf3f4611..04577eddd 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -570,6 +570,7 @@ static bool disconnect_cb(struct io *io, void *user_data)
>
>         io_destroy(att->io);
>         att->io = NULL;
> +       att->fd = -1;
>
>         /* Notify request callbacks */
>         queue_remove_all(att->req_queue, NULL, NULL, disc_att_send_op);
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
