Return-Path: <SRS0=NBlN=DW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF56C433E7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 23:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3150420759
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 23:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpFcBgv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbgJOXAV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Oct 2020 19:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732386AbgJOXAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Oct 2020 19:00:21 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A083C061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2020 16:00:21 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id q136so307814oic.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2020 16:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JnAXPeDYy1S/qvcUYpj96TTQBn9DWRHtlOI/cVKexUQ=;
        b=EpFcBgv5nO4h6Z1p5FwCeaUwCpKqUlngGVchI2XvKWjfmmqOLX8CtcJT+L6V2IddYB
         p3B85maN1xxMrkg8B7fE37JpKdssMaD/pvJs2V83ldLRs0QcdXu9mtiKqYU5D6cqx0wi
         4x235tFYqO9YdT0s9vbdX+K5Q8g7UwRbBEilNwdR+R0kjp7Peyg/g982aUufzQC5CbCx
         SUGklHqqjgNaz6ALyIuCvBGvZLl98C7hsRHE49jGbw5LqvEWf4zpvhqFyRQQLyNxCJnM
         jFCQ0u0uInoD026upmS5hZ5ls/5A9XT7f1XTxHVek99xcyJ8OBQQb+v9cKNqY7TROvQ3
         6shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JnAXPeDYy1S/qvcUYpj96TTQBn9DWRHtlOI/cVKexUQ=;
        b=tfQ/EL8tKhktHjY0A5myhuvmalgC9Jrck7QdmoaZPYDfXXxn4Pu17Nex5F/7hytmBN
         qJW4vs9VSTdph46bSeSnUDfG5w8niUv774V6cQnabncpAfKdlZbE1PPWBUPwIHXVkHQs
         Rl2YCgLGS0srdsM6YWzhY7hGuUJhkjmr32lPqAM9EYyNOFNd9MZOIwArPq02p2V1r6TY
         ckA9XWW+7u4p0BX0diyCb56UoHc3hTHBDKhFkfiUAWu7gSLmTGf8J8/3T5hd+/7fyf9X
         J4zCs1TEb3B8ppnvRVyDD0+vjsrx92kfRQRG1OZGT1EvIeypXIcX16m+MMjfC8067ytx
         AFTQ==
X-Gm-Message-State: AOAM532xBctAm64c1ShLqIwe8Ig1M4QzQBKgMET/b+BoxY4F96wLsas6
        FLZmyrI10+IWL27aYh9dbbhCFgEXPUfABhllBuAv7sdOCpdufg==
X-Google-Smtp-Source: ABdhPJyTlkhUI1+DkyoleXl5WkUa0HClHHdGi8aXIVaMQAt1dHE2NUDNz5AegCV7rhaktv9aqs9gc214KpJV9ZPeuJ8=
X-Received: by 2002:aca:4c7:: with SMTP id 190mr578266oie.58.1602802820526;
 Thu, 15 Oct 2020 16:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <CABLzjm8S1J5MRhrwFu1pbX9fub7X5nXmYRWmtRsmVRObeJOCbw@mail.gmail.com>
In-Reply-To: <CABLzjm8S1J5MRhrwFu1pbX9fub7X5nXmYRWmtRsmVRObeJOCbw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 15 Oct 2020 16:00:09 -0700
Message-ID: <CABBYNZKP45JDj7dBAADVN7+1vpLCEcFy2y62yfGE0c1gGG5fjA@mail.gmail.com>
Subject: Re: Entropy source based on the RSSI
To:     Alexandre Augusto <alexandre.a.giron@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Ola Alexandre,

Que coincid=C3=AAncia ver alguem da UTFPR por aqui, fiz meu mestrado ai em
2003, muito legal o seu trabalho. So por curiosidade, voce chegou a
usar o BT_HCI_CMD_LE_RAND como fonte de entropia? No Zephyr
(https://www.zephyrproject.org/) agente usa bastante porque o
controlador pode usar o sinal de interfer=C3=AAncia direto da camada do
radio, abaixo da interface HCI, e segundo o pessoal da Nordic tem uma
qualidade bem maior do que por exemplo RSSI porque nao depende da
quantidade de dispositivos em volta.

On Thu, Oct 15, 2020 at 2:59 PM Alexandre Augusto
<alexandre.a.giron@gmail.com> wrote:
>
> Hello,
>
> based on the motivation that IoT devices do not have many entropy
> sources available, and also on the fact that trusting in a single
> source may be risky, I have researched some additional ways to collect
> randomness for the device, using bluetooth technology for that
> purpose.
>
> For those who are interested in:
>
> Github: https://github.com/AAGiron/Bluerandom
> Presentation: https://www.youtube.com/watch?v=3DiAKaKAmqCFo
>
> I also want to say thanks in advance to Emil Lenngren for his valuable
> comments, here in this mailing list (back in 2019), and also to the
> Bluez community.
>
> --
> Alexandre Augusto Giron



--=20
Luiz Augusto von Dentz
