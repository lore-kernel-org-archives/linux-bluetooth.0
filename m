Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F020CC2D0F3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 18:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF09212CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 18:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEsNtaOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgCaSAa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:00:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34189 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgCaSA3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 14:00:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id d3so15163403oic.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vs1VUnkoIEvtnC7AWwumBTwvSPgxRS3Rd5OhGDVlF24=;
        b=mEsNtaOJwzJ3fcbAapELMBhshmMvkGv4FUAZ3QF1aqyYH56eSwq4TPOSIdZcYdqHcD
         8AghGwaSvjmc/4hnxLnOp15a0jT8CB3E5rjpHVZwi38gxIY7ff7WtA/nYTkjN58Ng570
         NN6/PrnnAW/i5AzosbvDoWSzZ0onZNoLsZK14e8RRDzi46cCCunfRLvbWSiO0D9tYmR6
         98+j/ndsjF610rrn5ti/rthuuLuMMv/VQLHQ+nMFpV0ZWE7l7dAPxdG/Upz3CP9mUWIh
         cJj+Puq2dPCAAM9qZp6Z6avOUzB3utAHEfoe95jDo9NHwpYWgb97/sFkKPpVOtzSNE/2
         nZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vs1VUnkoIEvtnC7AWwumBTwvSPgxRS3Rd5OhGDVlF24=;
        b=gqNkqzuFhhcPZEIDO3hY+OjID5CAh/qgWuKPGfmA7cgan8gok9hkfXVk4IP2kl/KE4
         n05z9yKctIj7JVaBjyr+zQqhnVlx9CdRTZaHOBDMLRSxwooNgIvR1nC9tJ2icgbUkRN4
         Yi42CQG0q+13+Ob0d/hvMnTC2tfxbBRJRMTXsDunuThYJTkNgscIgZjQiGdJ1qNSLxqE
         /Z05C6lTioT2hWyFLaruaXbFOqVywW5bXtiUaDwgj9NRK6WM8dcPy+VjGQ8x4QFSE6m7
         28AmuKM8KxfOqziqTj17jU+BnCQieUetAM+y3wEtQPJf9myUx2G2VFuXxcuXyR1WuyB2
         S91g==
X-Gm-Message-State: AGi0PubWqsltbIugicA4V5gy+5VxP+A1DLIvWyJ8lqAKHIjJ5nanEcKW
        tXaA2j0uJwyU7QUr9Y0P2+pUsr0nX9s6bLVgW+g=
X-Google-Smtp-Source: APiQypJfFpC3kq2xMP07r980pYYtDuE3XoyeSfCwMWcCpRlGAmFRNRcOiUwPdrS7AtntAKrryEqCt7I2mq/pEX/Miyc=
X-Received: by 2002:a54:4e13:: with SMTP id a19mr56455oiy.108.1585677627551;
 Tue, 31 Mar 2020 11:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200331120725.376209-1-szymon.janc@codecoup.pl>
In-Reply-To: <20200331120725.376209-1-szymon.janc@codecoup.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 31 Mar 2020 11:00:16 -0700
Message-ID: <CABBYNZ+9X4EUNthpV0jAbPQi2NRwMhGzswFQie6rDOAmkTV3cA@mail.gmail.com>
Subject: Re: [PATCH] main: Fix GATT option parsing
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Tue, Mar 31, 2020 at 5:10 AM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> Key name is Channels.
> ---
>  src/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/main.c b/src/main.c
> index 7b927ac79..98621fddf 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -109,7 +109,7 @@ static const char *gatt_options[] = {
>         "Cache",
>         "KeySize",
>         "ExchangeMTU",
> -       "EATTChannels",
> +       "Channels",
>         NULL
>  };
>
> --
> 2.25.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
