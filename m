Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5ECC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Feb 2022 00:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345660AbiBEACn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Feb 2022 19:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244086AbiBEACm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Feb 2022 19:02:42 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593D8DF8C1BC
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Feb 2022 16:02:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w20so12284502edc.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Feb 2022 16:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=X42Yl9QMyPV2NXhWHC7Poum8xe9aayY2SBprh9fIsh8=;
        b=ocVWw+YP06Rde8ntV8a5MGEVZCKaTq76fEJvT0BPOTnlAttc+ozRwuuXHzSUkedroF
         eeoo/TCu09TjtdvDto/65yFBq9raXZVTVlJrgXfdqsy6Oyb5nl+5PGhFPbN3VPohsmuo
         pnciwuCVqSvi75XpZbhpJO7cjObyADhvIZC14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=X42Yl9QMyPV2NXhWHC7Poum8xe9aayY2SBprh9fIsh8=;
        b=THdR5OnTzmU5SHRR98pqMlCy8HxpUoo9aBqzJZ9ptCTTxxzJwIgLWbX+9Fs6bioEVn
         kDE8AAJl+xSsR+PIGjqE62Bw6KI0Rz5CjGA/OldFUuWdeBH6967rfGJubQSkhBU/+U/H
         X3+EQDya8lHHN4eRM63/1Rlfdxd5kjvXOEgFxlnzJDgfFGrDSRfLIY/TKiHa3oli0+w1
         spi5MCHrRrbxtN2u9ycO3/qdB3KCoQcCNS8U2Zbj/UzmAJqNEfFEwNhhMuoejhL/rGVj
         hXeRDCcQqWO764AGlsDUEX+C4Zz/LRslb9Ywh/loeIBcha1dzqd2P5+r/OvdRbPp4aFC
         6irQ==
X-Gm-Message-State: AOAM532uneQEdEMnI3gebIL5KDdYgB7DnQikUD2rGG9kLgDwPdYzvSEI
        ujPkOlJGikk9VGOUtj+lHt7wt5A+fwB2qg==
X-Google-Smtp-Source: ABdhPJyCE+DWIxoXEM0BOSJiUtsi2468cEckq+JwXsiRUQvldBJRe9PUKUw4yVexFRJHmdFE8UUvYg==
X-Received: by 2002:a05:6402:254a:: with SMTP id l10mr1777537edb.230.1644019358636;
        Fri, 04 Feb 2022 16:02:38 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id fh23sm1103344ejc.176.2022.02.04.16.02.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 16:02:38 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so1681662wml.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Feb 2022 16:02:37 -0800 (PST)
X-Received: by 2002:a1c:f702:: with SMTP id v2mr4179825wmh.155.1644019357479;
 Fri, 04 Feb 2022 16:02:37 -0800 (PST)
MIME-Version: 1.0
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 4 Feb 2022 16:02:26 -0800
X-Gmail-Original-Message-ID: <CAO271mmuMDoqNdXUUuPpyz3VyuLWrZUr1K=Jry+H9mGEtz-Z4Q@mail.gmail.com>
Message-ID: <CAO271mmuMDoqNdXUUuPpyz3VyuLWrZUr1K=Jry+H9mGEtz-Z4Q@mail.gmail.com>
Subject: Question about Trusted property
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz/BlueZ maintainers,

What is the purpose of the Trusted property on org.bluez.Device1
interface? Does it mean whether the device is bonded? My experiment
with BlueZ shows that sometimes a device with "Trusted" property set
is not bonded (does not have pairing key stored) and also vice versa,
so I am assuming that the Trusted property means something else. What
is an example use case of the Trusted property?

Eventually, what I am trying to achieve is for BlueZ clients to find
out whether a device is Bonded or not. Using the Paired property is
not very accurate because it is set to true during connection although
the device is not bonded (pairing key does not persist after
disconnection). For this purpose, I am about to propose adding
"Bonded" property to org.bluez.Device1. Some use cases include when
there is a temporary pairing with a peer device we don't want UI to
show that the device is in the Bonded device list. What do you think
about exposing the Bonded state via D-Bus? I will do the
implementation if this idea makes sense.

Thanks!
