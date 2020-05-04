Return-Path: <SRS0=pLxO=6S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0380C3A5A9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 23:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7352206D7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 23:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4QJ00yL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgEDXiy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 May 2020 19:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgEDXiy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 May 2020 19:38:54 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1355EC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2020 16:38:54 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r25so364604oij.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2020 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ELPnoqUh0urDUwpAiK8SXLr8aaUyMULi1shsvUvAuMk=;
        b=h4QJ00yLVkaHjtw7ZKCwBNDZ3GiSMz/Ob61Rhiz28GoAG6PrjD2aR1MicokEYEWKyw
         +4jRQ9rWkoiGL8I1QP2v9oBUxHUpGdPnjVT90txA6pNywcmxY66Tx2y2L3iBu7F/GQE/
         fL+ZG6n9DhI88Xwzr429SM/k+5bDzAocd570YQcsoaPV0KUtxd9zoTRP5i8ENX1qS65T
         8LBPpfd+7UkkeQy/03f9DscFre++X0X9RGaI+vsXTWWtHuDt9ZcUnWy9LEoB8E0UjM38
         EYriiGnPRRp1HKTQGZlhNF+wCv9jo7Z6QfmUd3oqE75kkcfX6i28VmxekYxKqqYzDNCj
         +Hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ELPnoqUh0urDUwpAiK8SXLr8aaUyMULi1shsvUvAuMk=;
        b=OqFu2eSlonaQQgxxf9VqLWiQEaPsP6jS2Jkq0xXtMrXCQXPOzTcapKJppEo6I8QXmR
         hfzEp5PkRS9HYLtIEpqlZS3VbjwBeLFFtHLz/QFsn3fKIkxKz0G8WOYgQQJLvvOAXFDf
         LznMjPcS4C76JPiWJDi9qjoHDvx7UtyHyyAxHezsTfmtdQs/RJOt2uRemS/mDEfr44l5
         /r/w0iglgKW5KNAgT0YapMKve3aI/p2OnOMwgCyjIN5NHKCzpfwj1Ir6KDw7wSFakecX
         TPrgEaxV0U3sHSgCHXf287bj7m1eklwFa5oiAlk85MTuOXobWzt3nz5RgEEBYHIW/vYc
         qgNQ==
X-Gm-Message-State: AGi0PuY+t1TCe+ZEDOwY90IYrhQMs4qs5cs5b6KWZ5uutjpKAqvRYmXs
        6XrKBSlgSq3DFxXyVH/DDiV5OFuqhWbaqpsjI6N5dauI
X-Google-Smtp-Source: APiQypLxRYNvtL6wqdG20RX7bUMJ11kpL4vrffVay6wNImVV1Ou35ijDQfJV/YiHh8dwLRvA9FInZejPRLTHaizPUko=
X-Received: by 2002:aca:acd0:: with SMTP id v199mr637687oie.82.1588635533463;
 Mon, 04 May 2020 16:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200503111148.11412-1-pali@kernel.org>
In-Reply-To: <20200503111148.11412-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 4 May 2020 16:38:41 -0700
Message-ID: <CABBYNZJ_KQ39u5FvaVd678OTS3-Q7CSLzsbqB0NSLnEwGQD3Og@mail.gmail.com>
Subject: Re: [PATCH] doc: Update assigned-numbers.txt
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, May 3, 2020 at 4:11 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Define missing rfcomm channels specified in src/profile.c
> ---
>  doc/assigned-numbers.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/doc/assigned-numbers.txt b/doc/assigned-numbers.txt
> index ca171c4ff..cf481c15e 100644
> --- a/doc/assigned-numbers.txt
> +++ b/doc/assigned-numbers.txt
> @@ -8,6 +8,8 @@ avoid conflicts.
>  Profile                Channel
>  -----------------------
>  DUN            1
> +SPP            3
> +HSP HS         6
>  HFP HF         7
>  OPP            9
>  FTP            10
> --
> 2.20.1

Applied, thanks.

--=20
Luiz Augusto von Dentz
