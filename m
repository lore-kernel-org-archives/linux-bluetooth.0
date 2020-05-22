Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E728C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 23:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E4720738
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 23:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryWC/Av1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbgEVXhI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 19:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387436AbgEVXhI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 19:37:08 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0930BC061A0E
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 16:37:08 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v79so2356101qkb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 16:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8pM7R8kQz8z7A0dtBzhCmlmvbV72xtfGD3L0s9gOJHo=;
        b=ryWC/Av1etqqJGYrN7swr2ynkJHgJAXwKg/XQShBA9Ay4NiepLDrptILF2QexN+urE
         QFzGdDy5fb6VlKJkKkdZC3hlaZnC3PpVSq1TNfAJBzlCkSJyKXmJm0xVhN0YfSXwPCmq
         lupDcpjGLBw2RzjjinHtygCItohJj94yRZl3/HZqLVMuUl5K38LqDTiPohyqFvf04CC6
         VKDr3oOlIjiuDET+pRI2Eep0QP215/1F9jBKT5xMfiglepqChLYV/WLQQlmuKtLHnlEW
         RhXWjWdHP/Hyzxyk4xrUt6+aJZLMbIJJ4wlYMxmTY0uUniYn4k3EjR/rH67yY47Bwt74
         MNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8pM7R8kQz8z7A0dtBzhCmlmvbV72xtfGD3L0s9gOJHo=;
        b=TZattxF/kRmmaT4DcCnZy+y2ieqDZTw2wLBYp7tufnbRshr9fPAHFgJj1pNaLEohz4
         UGXv42EiqaM/uSAASxqyR08heE1pd2JgCi6H8PmEUuVoh7/x0e9NMyWbyfZ2pZUpNGLj
         lS6IlZMJszIob7eQ4wWligXJ0BDQ68HYgP4xWYMWTUDFtm8d3SKDDrjsgnC4Y1Mja+DC
         ntqGcAPPVq+x8Xi2YqWi2T3+k7xgtpCjj9oxanQ0XxHigpMi2mbLhwhPx5IMtZjmj67l
         w61PL2zRoWlzD/pkSS18BaS/r5G5OE2Tu+RBPT7OKqrCbSJZosuKYNj4Kte9wxJwLIkm
         8KEg==
X-Gm-Message-State: AOAM533mlQ0HHvQItEOeTyF4TVJfQNYdWy67R4v/MvqnjKtprnBgu5/U
        sPwBDpctHordT7lTZKf+boCtkWve5jk=
X-Google-Smtp-Source: ABdhPJy+dgU1CyIdN+f4cKCm39rrcdcTDUgGuIeRiRuZXOfpiLfh+0gKQp0qPpKvKLeXlSiaA7nM2Q==
X-Received: by 2002:a37:6389:: with SMTP id x131mr12627541qkb.160.1590190627165;
        Fri, 22 May 2020 16:37:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.17.127])
        by smtp.gmail.com with ESMTPSA id t12sm8429304qkt.77.2020.05.22.16.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:37:06 -0700 (PDT)
Message-ID: <5ec86222.1c69fb81.532bb.0f39@mx.google.com>
Date:   Fri, 22 May 2020 16:37:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1262121329160489496=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v2,4/4] mesh: Destroy PB-ADV queue when provisioning done
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200522211309.233824-5-brian.gix@intel.com>
References: <20200522211309.233824-5-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1262121329160489496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============1262121329160489496==--
