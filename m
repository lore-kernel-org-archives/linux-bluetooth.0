Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66045C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jun 2022 21:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbiFOVuu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiFOVut (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jun 2022 17:50:49 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2CA35ABE
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 14:50:47 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-30c2f288f13so74541537b3.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ni2+Z4+FaOrYaNl57ZOrcI8cGb5LUVcfY4BS8e4nlo=;
        b=mp0HpJP8UE2fb0XRQO3zKlah6eEzCXVh044OB/QP6MB05Fpq09DUqH6TUogHVp9cKy
         IbM7+vCQemOiCaPMWWc+wUB2foSdxCLhimA33Lamy537FVIvAVfRS8SDyb/5wtaHu+Jo
         RJLY2j/dsY+oU4Okqv0FyiECbKeWNDopstSLEUNGZ6q6s4CzmpB5v9yyIWsO++IV2spb
         CuPnF2wamKmHT4qBiuh5bUSQWDJzJvwwxwR3tvZ+VKXlqRmZGZLbax27a1j6nNoq6wNN
         VyL4UHSP8kV2vqyo/QcaBGj22IxNK6ZbTC7a/QxCA8JT6sxuytktLjrX55166xTMsVc4
         FW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ni2+Z4+FaOrYaNl57ZOrcI8cGb5LUVcfY4BS8e4nlo=;
        b=UwJzBC7xNtGLqdlRfUv4JZ0bsn01O9aMn1/40Oyuk+VjPc0E9zVQDb3/Pw+TRxENd0
         SYQV+BGxMAvDjF/9eU3Vw13I1HNiymlXo3xL9cjwz2uSnK0HrnZQNole6S8UwBjJXKj1
         mVzZfZZrMX2kAavfwIlxSb9nQHRZoZFpGidYYtdufCudfBbMMxSxUko9pwe70bgejJXS
         7rX3M4RfN8Fd2PaRsSfyBLe3VafgPnDH+2NZOgOZ71zhFFCmv8tqZLeVX+zRTBDC04BE
         tgoiUdyPFg9HkP8fBm5lwmo/5n47oQJu6H6Ut0TYz5bjQBj49etm5dCvkwSK98MXekQg
         j02w==
X-Gm-Message-State: AJIora+VK6Xt6fzNtFd9vLESumiaMQXIAqCvKRBNmWrKWAMYgKY7WgBu
        kI/bkuHUGzXH5yEvdBk9A5o7wSxkUKsdl7YA0OQIig==
X-Google-Smtp-Source: AGRyM1tPI14LkQ/YvBg6NCQBgZzoaWvTWprhy0E9Xqj/xLnij0vQRJL/A1uMejKt8IaEDtT6RUxPtyH5EIOpWXxJ+uE=
X-Received: by 2002:a81:830f:0:b0:313:3918:5cf with SMTP id
 t15-20020a81830f000000b00313391805cfmr2079347ywf.126.1655329847132; Wed, 15
 Jun 2022 14:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <YqmXmsTX7dD+5HjN@kili>
In-Reply-To: <YqmXmsTX7dD+5HjN@kili>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jun 2022 23:50:35 +0200
Message-ID: <CACRpkdbStsAF2Jngohh7Lsg6xs0Vsc-v_SR3WC3ndbZEhx9tEg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btbcm: Use strreplace() in btbcm_get_board_name()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Jun 15, 2022 at 10:26 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The original code works but it's a bit iffy.  The end of loop test
> should be something like "board_type[i] != '\0'" but instead it is
> is "i < board_type[i]".  Fortunately, those two tests are equivalent so
> long as the "board_type" is not an empty string.
>
> It's much simpler to just call strreplace() instead.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think I just copied this code from the BRCM wifi driver for the combo
chip, did you patch that too?

Yours,
Linus Walleij
