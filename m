Return-Path: <SRS0=/Nrl=6I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D58C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Apr 2020 17:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F178120736
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Apr 2020 17:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmpLot0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgDXRZL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgDXRZK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Apr 2020 13:25:10 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413DBC09B049
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 10:25:10 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m13so13685740otf.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4egXVX/iDmYJpX6vrUTZw9sr2LFA5GnvLZBpGidNPTg=;
        b=OmpLot0Jn6is1sQlUePOXsjtDux6ul9R43uVEJcpHzHaJM/PPEopcpNTRp1yUxzxS4
         IWdv9HoSuOnLFs3l3YdLVNdVBViKfWpbXS8PmhraFK33E3gLq0euPktJodol12YX5jzY
         CE+ix/Nm9QNSUWO1qy9LEFI5me88LnTDhEjTm1V9unNhHF6B04wNntabEytbJDbBcvhg
         zuyB82624UyBTeblq+eRPHJsOJiTIhejIKM4iT8QdYFilqcnyD/6KTvH4IG1ehfF/phm
         1lhqqraEWO5J84yd24hCPR10ODZFQH96ciNGGGpuSJ5zF1Ticb9vGZaYs9aBjzKmM8+t
         k8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4egXVX/iDmYJpX6vrUTZw9sr2LFA5GnvLZBpGidNPTg=;
        b=Fa2VNJ8eNAmcLf7mOLf51PjmWNN631wyFkom/hVF+xTSEUf96lG74olj6WDOhueae4
         j01KbwpKgL6QV1ygxJo45lcWNjaH8SoUXpxblZJEnoz0/gxLLlHOSMVaOq1GUNgnRY6t
         2dBUdeQQB0/tZ4r4awYubzi03uSSK24rv6cKuJSFU5MFKgZl+Cc1SrfDywIDswM3qnAc
         tytlokzYMnKZWD4ebqilUvo0CGH9dInn2UJkm5Ac6hNbVeeevs3AebjdHREAkhjqvpqo
         PebDjykSFvYDErHWKi3/7bl9mUiwmLWeHp/wlQLdfQR+f1+fg5p2932V3uanufVaGWtn
         fGBA==
X-Gm-Message-State: AGi0PuYMtxadKOIR1HhHGv87gks8/a48g7p68vz8cD33PL87NYgO+7u8
        /fNVsDInacpiHsCInLCM6tDJESyKuz7Al2Gm76OsYpLu
X-Google-Smtp-Source: APiQypKs2rZf9PgdOOdQ+eKbiSo/SMbXlEeqbZlCuegXjemKIH59AvbiggyQfDowwHZ89CpmqFjd1gfdktQCuFThiKQ=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr9040301otn.79.1587749109583;
 Fri, 24 Apr 2020 10:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200423233414.15141-1-pali@kernel.org>
In-Reply-To: <20200423233414.15141-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 24 Apr 2020 10:24:58 -0700
Message-ID: <CABBYNZJGz0wrGohqXmjgNF_8gx7a2E61kQB8QzGDyCWOvm4dgQ@mail.gmail.com>
Subject: Re: [PATCH] btio: Fix error number
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Thu, Apr 23, 2020 at 4:36 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> In commit d20ee8273e61e16c78582344f274254973cdf00f was unintentionally
> negated error number. Fix this mistake.
> ---
>  btio/btio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index 460aaf5be..13c731062 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -230,7 +230,7 @@ static gboolean connect_cb(GIOChannel *io, GIOConditi=
on cond,
>
>         if (err < 0) {
>                 ba2str(&conn->dst, addr);
> -               g_set_error(&gerr, BT_IO_ERROR, err,
> +               g_set_error(&gerr, BT_IO_ERROR, -err,
>                         "connect to %s: %s (%d)", addr, strerror(-err), -=
err);
>         }
>
> @@ -1718,7 +1718,7 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gpoi=
nter user_data,
>
>         if (err < 0) {
>                 ba2str(&opts.dst, addr);
> -               g_set_error(gerr, BT_IO_ERROR, err,
> +               g_set_error(gerr, BT_IO_ERROR, -err,
>                                 "connect to %s: %s (%d)", addr, strerror(=
-err),
>                                 -err);
>                 g_io_channel_unref(io);
> --
> 2.20.1

Applied, thanks.

--=20
Luiz Augusto von Dentz
