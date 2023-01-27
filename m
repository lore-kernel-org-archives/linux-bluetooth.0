Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC0BC38142
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 17:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjA0RAP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 12:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjA0RAL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 12:00:11 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC28CCC09;
        Fri, 27 Jan 2023 09:00:09 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-15f64f2791dso7229100fac.7;
        Fri, 27 Jan 2023 09:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2mF5+9dK/5MqlimC1EHxM91nvNH3pLg1R5a0aDT+pUQ=;
        b=GyiGplKkx2OilaDym9eDrrxMfEKFKOhfdjXv/pYNPaUuHQaiDT7E9hszn+IZLSguiL
         pzsIAVaiz4Ctys38brR+1HuWcCQyPrInlinixGx3c2wDzz6C0hwNATqY6DnkD4aR7utJ
         a9hf1kpeb5DgvyqYNdFT7iSQYqMbHqo4FLZkQJmfYbEN9cUi1BWpqHWUQD62PkY2TsRU
         tUEjnxXAtWjE321xR7rF9FQ9Hz1l4WNSphVydTZ1uiDJ82SyHob9EEmXMjff2JP1c5Dr
         fz440Q34F/9QNlmHfjXopp6uuMpCZYKYnQmAzoKAxy/eqXbBYXJUERCI+nKKT3Q3QHaE
         LQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mF5+9dK/5MqlimC1EHxM91nvNH3pLg1R5a0aDT+pUQ=;
        b=21YvCt4g97enogyJogJJMjEqITK+TtcPaTaZGwW4G1cz2jdXcPNeNkW6MMl+mDXLXi
         xa21f9FDJb5UUJ4T9n5RdBmR1qqd1725W2dMTUFRKBv83COGEaIZ30QZsH48P69Ijefa
         jlKoOAad7rdqNPnnZOKtEWp1bZjLVt8VS2UhhTfH8/LGfQVXrq8dxRPIVQ2QXU7XGGu3
         7fHyOCI6EI8qgoEGkLTp9W3jcTdFFrrwgM3WAzaNG8fAwVhkEANLHIBwW6Lq5Ta/F21q
         XnKhQCjref1cMmefI5gSZlMt7j4ZpE0CCvzCnIsjIqr5GYgWkv3SCWx8bmFKeSmx0cGv
         0vnQ==
X-Gm-Message-State: AO0yUKVjsYutsNVwHKqgz9ixWtjYuMwd1g4MgDb2SC7mi9fb1HMstNdE
        Cdjfzt0flC3KHh+XQBVmD4Y=
X-Google-Smtp-Source: AK7set+Hw+QDmwwvxZSd9pSCull/Yb6y527ZrTPKRmS5+jMyOmKCSLoX2EoZb4h4D0ljgeTkJe9e9Q==
X-Received: by 2002:a05:6870:4799:b0:163:4ddf:8eca with SMTP id c25-20020a056870479900b001634ddf8ecamr3436981oaq.46.1674838808974;
        Fri, 27 Jan 2023 09:00:08 -0800 (PST)
Received: from neuromancer. (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id mv7-20020a0568706a8700b0015f4d1b195bsm2055259oab.36.2023.01.27.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:00:08 -0800 (PST)
Message-ID: <63d40318.050a0220.b303.8deb@mx.google.com>
X-Google-Original-Message-ID: <Y9QDFqyXadEeghf4@neuromancer.>
Date:   Fri, 27 Jan 2023 11:00:06 -0600
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        max.chou@realtek.com, hildawu@realtek.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH RFC 1/2] dt-bindings: net: realtek-bluetooth: Add
 RTL8821CS
References: <20230126165529.1452252-1-macroalpha82@gmail.com>
 <20230126165529.1452252-2-macroalpha82@gmail.com>
 <02bddab6-4c63-bb39-9a11-8dab81322c28@linaro.org>
 <63d3fff7.050a0220.db92.7af4@mx.google.com>
 <ed5fec12-1c86-d235-718f-f812e7461d94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5fec12-1c86-d235-718f-f812e7461d94@linaro.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jan 27, 2023 at 05:53:49PM +0100, Krzysztof Kozlowski wrote:
> On 27/01/2023 17:46, Chris Morgan wrote:
> > On Fri, Jan 27, 2023 at 11:24:03AM +0100, Krzysztof Kozlowski wrote:
> >> On 26/01/2023 17:55, Chris Morgan wrote:
> >>> From: Chris Morgan <macromorgan@hotmail.com>
> >>>
> >>> Add compatible string for RTL8821CS for existing Realtek Bluetooth
> >>> driver.
> >>>
> >>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/net/realtek-bluetooth.yaml | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>
> >> Based on your driver it is compatible with rtl8822cs, so you can
> >> indicate it in the binding and use just one of_device_id entry.
> > 
> > It's very similar, and uses some of the same constants, but has a
> > different firmware. I assumed the firmware difference is enough to
> > require it to be differentiated, but I wasn't sure. You are saying
> > it does not? I just want to be clear.
> 
> If by "differentiated" you mean "incompatible", then depends:
> 1. You have firmware-name property to indicate the firmware to load and
> then you can use one compatible to bind and just load different firmware,
> 2. If device variant is autodectable, it's compatible.
> 
> realtek,rtl8723ds-bt also was added to the driver uselessly...

Gotcha.

They are incompatible, but the driver should be able to autodetect each
device as best I can tell. In fact all of the devices listed in the
bindings should be autodetectable by the driver (again, as best I can
tell). Honestly though that's assuming I'm using the correct firmware,
which is why I have this tagged as an RFC. I'm really hoping to get
Realtek's attention for them to chime in to confirm I'm using the
most recent firmware and under what license/terms the firmware can
be redistributed so that the firmware may be added to linux-firmware.

Assuming everything is good though, I can resubmit V2 and instead of
adding a new compatible just noting that the 8822CS and 8821CS use
the same bindings.

Thank you.

> 
> Best regards,
> Krzysztof
> 
