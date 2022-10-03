Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AE8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Oct 2022 23:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiJCXuX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 19:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJCXuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 19:50:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195FA1C40A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 16:50:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g1so18780028lfu.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Oct 2022 16:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qRl2ZJ32/eyNGgIghWiSk5Ggy+aKqHiJOuIc2FoOIkU=;
        b=PbkHaPUyvcE2MPg7hp15UHngdeT/82IwuXrhMGNgVlRikvq9Smyr2Q5gZZoTxvpi8O
         pQcy2Jia+kAqnokl4nE8O0EpE+aFqXmqYxPkmcnO++RXMZUqtYUppYnq6UemjsZDSwMB
         hSUYMh9tbXNpGlM1YMao+O0+gppQXIRVIY2Kj/jXm/DbYAQ35lwgS+vkI6564mJqBYs2
         9gfDkFiv3xlRO5isqEr0jMI2sjw/wpaH7mvAoSHpvBbIJc9zpOqZUlbVSjnmpsMzyYO3
         zpos42QiOGOwZXl/Q3Uw6AiWIKHig9uYLpaoz+sib2VFrR9D67rjhMi76q/whCI29c5N
         z10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qRl2ZJ32/eyNGgIghWiSk5Ggy+aKqHiJOuIc2FoOIkU=;
        b=Jx4IPYLHtGmEkL8bgYSPq6SwLyiQni6PmkFwoKZGe9hRoDlF5dP/U7Yp/vkhfoYhpS
         IuJqFhq/BKBZCE/N03kdUk71QHr7IpKbjvccx1bCQTiokphsiqwgaO6VfDNFuRLvQDoF
         AboqHSt3sPoZVOGGcRFjJAWEohDlYEt+KGPtIwHGWOLtqEqQPNrMM0+vtco4WjsViEAI
         bkLJNHNqlPja1TNSBbVsXgsj3dOBzBclUcmujRbh65EjgoajCuoFh+c0LvUl7BsXYqUe
         vsXTiHsVoEpZhdyVrDzwUzsHrIWMP87DZQdOoUdXKSBGNIGZZydunLvtKP/MpDdWCzVM
         6Jkw==
X-Gm-Message-State: ACrzQf1AwxeF2G829C4qPy5Y3Y/oKjRdZMstUEx+MnSNs4UfGJU2EUwI
        9Kp0RpZsD6JCQQ2hg+63BASM7qOdmWijQPfmiLLntM7F
X-Google-Smtp-Source: AMsMyM6GZrM/5btSxdWuZ4PYyujXyKCnkXh5qUo1g4ORVjSW+YRxbixRBRBrLnkKNlBUTAfduFbDtsP8ItH0cHc5eDc=
X-Received: by 2002:a05:6512:34c9:b0:4a2:2b33:5358 with SMTP id
 w9-20020a05651234c900b004a22b335358mr3466252lfr.106.1664841017255; Mon, 03
 Oct 2022 16:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220819204649.244035-1-inga.stotland@intel.com> <9b1114d762c15f6d70f99be37ca5e8708f3b9998.camel@intel.com>
In-Reply-To: <9b1114d762c15f6d70f99be37ca5e8708f3b9998.camel@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 3 Oct 2022 16:50:05 -0700
Message-ID: <CABBYNZ+2sh-CBk95o7Expdv=rs-SqcwqWZkbwG6qcuA8wDQ00g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] README: Update Mesh required Kernel Config section
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "Gix, Brian" <brian.gix@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Mon, Oct 3, 2022 at 4:28 PM Stotland, Inga <inga.stotland@intel.com> wrote:
>
> Ping
>
> On Fri, 2022-08-19 at 13:46 -0700, Inga Stotland wrote:
> > Add CONFIG_CRYPTO_USER_API_SKCIPHER to the list of the required
> > .config options
> > ---
> >  README | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/README b/README
> > index 3dc226ff1..7de7045a8 100644
> > --- a/README
> > +++ b/README
> > @@ -79,6 +79,7 @@ may need to be enabled, and the kernel rebuilt.
> >         CONFIG_CRYPTO_USER_API
> >         CONFIG_CRYPTO_USER_API_AEAD
> >         CONFIG_CRYPTO_USER_API_HASH
> > +       CONFIG_CRYPTO_USER_API_SKCIPHER
> >
> >         CONFIG_CRYPTO_AES
> >         CONFIG_CRYPTO_CCM
>

Does our CI infra already use the above config option?

-- 
Luiz Augusto von Dentz
