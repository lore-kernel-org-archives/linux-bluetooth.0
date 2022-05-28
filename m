Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DCBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 May 2022 15:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbiE1Psw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 May 2022 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiE1Psv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 May 2022 11:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBB52AD
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 May 2022 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653752929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5GAhpNoL6mVubSpwZ4APr5XIqQJTwS8OwKgO1Q7qWXM=;
        b=dZdtc9faiWDozjJPa+MUOQ8Ltp750xU6GcX/ayYXhB3tOExhpKRD7abRY3vbj02lsZD9jq
        JVCR6ELvSvY3/4xnLu8CA4O2d7FSEhu931dye2U0mu6GZ3y2aMYdmGlGqyE0eqZJ4xifPV
        yzBdmSOFa5JVld4xvWszgX8djRt44rE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-yTebxjixOZafsppPLYhu8g-1; Sat, 28 May 2022 11:48:48 -0400
X-MC-Unique: yTebxjixOZafsppPLYhu8g-1
Received: by mail-qk1-f200.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso5922578qkb.11
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 May 2022 08:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GAhpNoL6mVubSpwZ4APr5XIqQJTwS8OwKgO1Q7qWXM=;
        b=UruKZJoKnm3wOjd1a/AkjZL6bPJW+feCQNcX4sdueMaRMtPJVT5THmsrrMqmGqTtiW
         p7ELMLlFUkMKVnfdTkL57Xs/O/cb74tZBH3uGPD6fcOT7UW35nM6Bm8HCdx9e0w3yGeg
         1B3B4d774dHAvkHZDCcYlMGaqHDeHehYegd0PRV6m/RFN04q9tdc0amPNazzn1OCbqCL
         XYgbgX6vDAzALbvYIgp84FqFYG8lDNz6N6Q4avzJ/GJ2ESYu2nSm5HmYVhg9B3f9fSnJ
         mc7G5vX0Tj267Ytv9+JjxVB/0uMSzRHoQKSKpsb6re+XV8FEHGdipqJJQEzWsJZifuYV
         0QZA==
X-Gm-Message-State: AOAM533MTs+/U0Gt9UurV/fayEXOGnZy2v0f4VXLFrKgV/gsGxhmaM+O
        j7MCrh8QpKnhUY6Pm8e4aiDebwBa7fy1og4/HNotVatZMR1AiJbTiI76j+GhP1XuZxpf36OCMwG
        0Qzvcm3OBHZ2ZuJIahkCSMVeGVz7FEcwJZIWduEo0uvOO
X-Received: by 2002:ac8:5750:0:b0:2f9:410b:7101 with SMTP id 16-20020ac85750000000b002f9410b7101mr19892462qtx.291.1653752927535;
        Sat, 28 May 2022 08:48:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmAsucB7ng/+qB+vvkMRhBKq3xcdUohmtwPZcqjrboA1dOIsdMeoqf6NSF/fuav7Oq7do5fGX9GQQTQ5RsLU8=
X-Received: by 2002:ac8:5750:0:b0:2f9:410b:7101 with SMTP id
 16-20020ac85750000000b002f9410b7101mr19892448qtx.291.1653752927345; Sat, 28
 May 2022 08:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220526162806.16618-1-jukka.rissanen@linux.intel.com> <20220527075625.9693-1-jukka.rissanen@linux.intel.com>
In-Reply-To: <20220527075625.9693-1-jukka.rissanen@linux.intel.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sat, 28 May 2022 11:48:36 -0400
Message-ID: <CAK-6q+icAttyjPFx6LXLTUu4b6WBpj9kwKNxUS9WE=cPz6=DnA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Jukka Rissanen as 6lowpan maintainer
To:     Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, May 27, 2022 at 3:58 AM Jukka Rissanen
<jukka.rissanen@linux.intel.com> wrote:
>
> I no longer work on this so better update the file.
>

> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

:'-(

- Alex

