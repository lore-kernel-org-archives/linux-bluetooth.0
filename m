Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7E2C61D97
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 16:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjA0Qr1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 11:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjA0Qr0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 11:47:26 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3502F199F0;
        Fri, 27 Jan 2023 08:46:48 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id o66so4653853oia.6;
        Fri, 27 Jan 2023 08:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2P3exPS46FCuDEJsZhMkyQI8tWctasaM0g3W82t3mtc=;
        b=W0lAIvI+f9yqF2W4ylDvJ1fbmpYqKoW/rGgM3EgKypWyfVTFvLSvuK997i4+0QZ8OD
         LoM1fBxmpdbQ5P7uruEEPSsVPccHSUm0oXU3XYcM/+1vvtCoJWbouXtAf31jpceKeZup
         Gx/4Zgp5dWNhaaWJFJbbNeIMSKj8++NPZlolBkY0/nacNerRSFQyGBNLBfdQm3uGb/i9
         HP/dR6XXBjMphjscdS+63Uu0GY2dDNsMsYzEyXs/jK64TNzbTcR1p7tGQYP+AmBc9iLU
         51x2gvCLXfM7sJBItCslAC0Cmfbbzc56nBhgcOSlTFVgfu9NzQX7tT8hq86OkPcbyJp5
         TNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2P3exPS46FCuDEJsZhMkyQI8tWctasaM0g3W82t3mtc=;
        b=sUsam1oq5LJhBmVpbEsgf8isHYMUbWPQ6Hp5LQniX55sI/kPQ/JqucUmfz7P5YXkim
         SOMfGlb10DeboLCwnKxA0l3d/05hTnc5EEpI3/a/fy3/dBEk5hReS3dO6CnACDLtX/h8
         Q3lffSXXB5AlCNx14cEoNSOCjqYaLHeyqf0CkIN5nrhTCXjfRp6RjfDfBoMDOS+lC5yS
         uzWEnwHb+dDPcme+azDPfpruZwI3QvGZa93HY5xULu4aVzrc9yl8EmjwfG0S2RGy1Goe
         ZYhOL6RVyxGWfX4xgo4ONVKB5okuKiwE95dYxJUMGpRFtG3dBso55pubz/wt1/Nu81e0
         20iA==
X-Gm-Message-State: AO0yUKVbFfBqttsX1uoruc4OnW6wKX6FWtalKLxikWZGj9jea0uCYaty
        JYXZP9k91onlMji2moVNC6w=
X-Google-Smtp-Source: AK7set9VKpC6Qzj7rQikZ5B5cKyszGYD0wzi0IyNmjajW1eyIvZX8kRpk1aRA88Wr8wngGMccqIGiQ==
X-Received: by 2002:a05:6808:911:b0:35e:a9d4:30d6 with SMTP id w17-20020a056808091100b0035ea9d430d6mr2792250oih.44.1674838007430;
        Fri, 27 Jan 2023 08:46:47 -0800 (PST)
Received: from neuromancer. (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id u22-20020a056808115600b0036718f58b7esm1743540oiu.15.2023.01.27.08.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 08:46:47 -0800 (PST)
Message-ID: <63d3fff7.050a0220.db92.7af4@mx.google.com>
X-Google-Original-Message-ID: <Y9P/9H/NkmCF8dHE@neuromancer.>
Date:   Fri, 27 Jan 2023 10:46:44 -0600
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02bddab6-4c63-bb39-9a11-8dab81322c28@linaro.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jan 27, 2023 at 11:24:03AM +0100, Krzysztof Kozlowski wrote:
> On 26/01/2023 17:55, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add compatible string for RTL8821CS for existing Realtek Bluetooth
> > driver.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  Documentation/devicetree/bindings/net/realtek-bluetooth.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Based on your driver it is compatible with rtl8822cs, so you can
> indicate it in the binding and use just one of_device_id entry.

It's very similar, and uses some of the same constants, but has a
different firmware. I assumed the firmware difference is enough to
require it to be differentiated, but I wasn't sure. You are saying
it does not? I just want to be clear.

As always, thank you.

> 
> Best regards,
> Krzysztof
> 
