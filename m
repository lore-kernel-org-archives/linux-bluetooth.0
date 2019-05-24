Return-Path: <SRS0=vizm=TY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A115BC072B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 May 2019 08:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640FA217D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 May 2019 08:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/QhEpcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbfEXIuR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 May 2019 04:50:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44869 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389488AbfEXIuQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 May 2019 04:50:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id g18so7978477otj.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2019 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTvIhWgfosdc65HgmaQhEWS8RJB+R+ySpDXKa0g/H98=;
        b=m/QhEpcguK4EDDPXehbAPHDoHjzYCr8dOEdxnRENnZwnAR5faZgzluzPb2fGJp0067
         q0W2Tl3IMHzHUsWq6eYpVDjH9sxpaJHYSbYnx9i+6kdVNvyJI9RVX/AMmtwH3Qz/z2xe
         QGSwpff4HnkcepepX3286OEla9Vp7kjeZK3LwTg/y/TzU7qOmOfz0ODfP9tVc3aMzSgv
         k7D0JjjVz1OS9Uw7iYQ8LZbsHPOX4rT1YiG33fjfqmCkvR8LMQb3nHOTWavyrqC4rr0R
         1LgAJgRRtRn4jqnOs8HktJtZX4WoXLSjWVY3RrNcwg+nyffh3G+YhguFE5ous5NsMoVa
         ebpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTvIhWgfosdc65HgmaQhEWS8RJB+R+ySpDXKa0g/H98=;
        b=Ssbm7fQ5S8KptqqWOKju2GrgCCCuWacTTB5BQjKIEElQ29dYSC3kM0u5C1FZC1/8Er
         daiJ5kWIggil2pD27Z4MV5vStnHg4d04Z7D8fRWNKFx2CmcP9zzg07YVVndAZo+o2dLy
         BvpCII8DicbsoolhuGtAMYu6v4h3fkzKH6+L8/zyOom38cyyDy2bbu+wowhoFK/r9L78
         U8Uo/5BpaXHZBSpfcqSYMiTRA2GwidfZ9A48cwLLR/qDv/OXHN6FDX2c6ZaUn52U2RgZ
         /i4jPAu0Rqz07faAwlcjyphAIBQ6D+jfSEg/aek5+yqHfDQP6yxQkcOo64XG7xw7Ib2V
         +BMA==
X-Gm-Message-State: APjAAAUWtlDuJwrtMu6MyIxzC6I9Cumw6NM5Kf5kfHDZJgej12DLU2wV
        /5wyg6EceH9rzqsRc1dV05/Th24/SmJu9MeHK4Jzst/Rw58=
X-Google-Smtp-Source: APXvYqzT+XYN6ObAyC0ae8i8zTXHYXztBQuMFvMS1USNms64r0Ja72Il7j+sPht9jaWGiD+b5ylkFDgRUfsBasCqfwA=
X-Received: by 2002:a9d:6288:: with SMTP id x8mr34045682otk.79.1558687816004;
 Fri, 24 May 2019 01:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190521200313.11487-1-sbrown@ewol.com>
In-Reply-To: <20190521200313.11487-1-sbrown@ewol.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 24 May 2019 11:50:03 +0300
Message-ID: <CABBYNZLC=_XGWqpP94cN5ifg-jSbDyMekGWxOAg2Nis=yn81jA@mail.gmail.com>
Subject: Re: [PATCH v2] meshctl: Retry recvmsg if data is not ready
To:     Steve Brown <sbrown@ewol.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Steve,

On Tue, May 21, 2019 at 11:29 PM Steve Brown <sbrown@ewol.com> wrote:
>
> Commit d6eec1b67d6d ("meshctl: Switch from write to sendmsg for Acquire*")
> causes a regression by returning an error if recvmsg has no data available.
> Fix it by retrying until data is received.
> ---
> Changes in v2:
>   * Reword commit message
>  tools/mesh/gatt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/mesh/gatt.c b/tools/mesh/gatt.c
> index 2269a20cf..0a942d4eb 100644
> --- a/tools/mesh/gatt.c
> +++ b/tools/mesh/gatt.c
> @@ -415,8 +415,11 @@ static bool sock_read(struct io *io, bool prov, void *user_data)
>         msg.msg_iovlen = 1;
>
>         while ((len = recvmsg(fd, &msg, MSG_DONTWAIT))) {
> -               if (len <= 0)
> +               if (len <= 0) {
> +                       if (errno == EAGAIN)
> +                               break;
>                         return false;
> +               }
>
>                 res = buf;
>                 len_sar = mesh_gatt_sar(&res, len);
> --
> 2.20.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
