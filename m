Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63167C25B08
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 00:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiHJARQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Aug 2022 20:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHJARP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Aug 2022 20:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B34247D787
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Aug 2022 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660090633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWwaUHjBysXWhHJ+eod4q2ogYoDzJ4P57FOFOXiREtk=;
        b=HyxAY64GXnH9CfsFkZQg0JItCxvaX5LlS98hi3IWooCRBK2b/uBWAo2RRAwrj69J9T4mCu
        /aTl+vXdGXnv35AOhdiWTjc6t1xgndaYeP7625qGXU9e28VeZDlLywgmXeRUiBO1226BDd
        +aSM5nTZskJNoAgJDtBLiAm6V5FLZUQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-s-pyHa_cMDi1IOwlnhxQvg-1; Tue, 09 Aug 2022 20:17:12 -0400
X-MC-Unique: s-pyHa_cMDi1IOwlnhxQvg-1
Received: by mail-qk1-f197.google.com with SMTP id i15-20020a05620a404f00b006b55998179bso11344003qko.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Aug 2022 17:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hWwaUHjBysXWhHJ+eod4q2ogYoDzJ4P57FOFOXiREtk=;
        b=UV1rTo/TCq4i3EYCylU+0DdOmQF1usNY6qN0XDbCpszz9UUc2labJ35nu0Jprb3xhq
         C39P+Tz6HaxPIz6W9qZqis9xdADyG2GXI38zzUUJhRHRZron6WXotAeHM2SBUm4dLUGK
         zJsQbqmOFJytHBejZqwvje9B+nAZphOwbGGE7wmfl+70Bg8L9yWoVxVNQuwWexOd+GqP
         Vg67hKYSl3Q+bn3ndG6wdLgKQsTl4lvYyYS/lFZkXI7Hshrj8qxehnf7o0bZNlv2iIwN
         t89+R8/WK/OGZD8FVkfnYhVZ3qRT2mGuBjBOMS5jWasiOIxn/mp1sJCEbUHEAyWcPgNk
         mDOA==
X-Gm-Message-State: ACgBeo3PjZtXowCqwvIdmbaTgveRjWaYCg30HPq86yG7tVU8r+V2oW90
        y9tXiVYlXkkuWL0zIdzFKDHHsGsAOSddJDgkYhQXinMnVk2hERfbeldUhYmn4EmyvxmPSZzm8bF
        TVq3TxUIfRBKBeAzHm9aX81ZxD2nlVemqYsscs+k5j2EC
X-Received: by 2002:a0c:e0cc:0:b0:474:94d4:53e with SMTP id x12-20020a0ce0cc000000b0047494d4053emr21898134qvk.2.1660090632157;
        Tue, 09 Aug 2022 17:17:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR65oSYaxdMQK1e3z5h5nEqt9Sgaho3HpLyfWhDFN2BziT6eJUv59emy46T6uE93XY9XUBsqOtkCCMMXbfgRTkI=
X-Received: by 2002:a0c:e0cc:0:b0:474:94d4:53e with SMTP id
 x12-20020a0ce0cc000000b0047494d4053emr21898122qvk.2.1660090631911; Tue, 09
 Aug 2022 17:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <3a3904c4-1bf9-ef1b-3d03-b5c3e1e2f8c5@desertmonitor.com>
In-Reply-To: <3a3904c4-1bf9-ef1b-3d03-b5c3e1e2f8c5@desertmonitor.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 9 Aug 2022 20:17:01 -0400
Message-ID: <CAK-6q+gBUHaR5njKHJJnONW41duVafMA-6R8jKMtN=7M1mg6rA@mail.gmail.com>
Subject: Re: 6LoWPAN (IPv6 over BLE) neighbor discovery
To:     Philipp Blum <info@desertmonitor.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Aug 9, 2022 at 4:24 PM Philipp Blum <info@desertmonitor.com> wrote:
>
> Hey,
>
> I am currently working on a demonstration for the W3C TPAC next month.
> Just wanted to get an update on this topic, since RIOT uses it in IPv6
> over BLE.
>

Which neighbor discovery are you talking about? Can you be more
specific here? I am not aware that any 6LoWPAN implementation uses any
optimized in-kernel IPv6 neighbor discovery for any low power/lossy
network, we are still using the default IPv6 one which should probably
still work if the other side supports it. In 802.15.4 we tweaked it a
little bit to support the short address into the address option as
RFC4944 describes it [0] that autoconfiguration can use it.

I added linux-bluetooth in cc.

- Alex

[0] https://www.rfc-editor.org/rfc/rfc4944#section-8

