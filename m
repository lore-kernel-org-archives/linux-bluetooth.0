Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5382C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF09820826
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoQHXgUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgEUSHw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 14:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgEUSHv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 14:07:51 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE6DC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:07:51 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f13so8185409qkh.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=syKuTd0ZmbrOPKvQ7e7uMbRqckT2CqRXycSOOTugPBs=;
        b=KoQHXgUFpToFwsax3nq3+ZGgcBlDf2tM9KU7+z13VcsLNC+ONB/Ndwns/HZ0r3ZtRO
         59+G6qXB7Edy9FyDp7v6aCnZM232oBf9tBAEZMZh8kWLS89m8F/dJZiJ8SVW4cW6wOF+
         FRvWzbRZQFUCbCm57iCaMNkw/uxeThej//0xuAGm4AfwHmfHvEVBWfA+AcU5MgPTqeML
         SMy5GCprpXSvFztfrcJiQF7W8jt8am8SUEL68xGjgkqv389PU83k8CoARS4q60BZWFd/
         b54XdSbUP6LEfE9MtqKmgVzkU/7rmBn/arE2+sNjOdSZqOl1rSipikzPNJIcNPOCyQEP
         UH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=syKuTd0ZmbrOPKvQ7e7uMbRqckT2CqRXycSOOTugPBs=;
        b=mLqMpTZJAce52bePbyedmomhaOdPqqtCODsiuIDzGQDqbyiLiK7kY1sxIK1u1bb/o4
         OfSaX5Gkjsk57Bt2kRypsASmkQjQIZ3V92ZKyOQqlOurd0t0ujQR/iPynTCKScOl+RI+
         7xqIZbwfXae5GnhRc8lyiqIlbctvQf4Q6CpCL0leMdGShyIDfnKQhsT0VQYG2c/OnNFB
         /SI5dq8fA+kiydDPYCHw54RsbnPNe97wbKDSHjOxwMt+mRfw85Zjruwy96TL3jFnssDa
         xNaqfrN6tSRKHorWwukx6930+Tm5K1vQY4oW7eI20HfbiDcyVTcJO41CFn75J9SWK2vA
         7dtQ==
X-Gm-Message-State: AOAM5329PuLWRHMlaORcrji9wjANpWvAsACBjshYYqxJeYAjXf52L/Td
        JE+n7RhSb8JWRh3iJ8fK1jD+d4iY
X-Google-Smtp-Source: ABdhPJxf3iXRQ38ozKNmTh/5Qzk2GnTsvNXUdcq1QkFQLdtiZnICzxcJY0U08/Wu6CkxqcJFtYM6Gw==
X-Received: by 2002:a05:620a:112c:: with SMTP id p12mr11035333qkk.313.1590084470736;
        Thu, 21 May 2020 11:07:50 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.124.4])
        by smtp.gmail.com with ESMTPSA id v46sm5728564qth.77.2020.05.21.11.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:07:50 -0700 (PDT)
Message-ID: <5ec6c376.1c69fb81.39450.231f@mx.google.com>
Date:   Thu, 21 May 2020 11:07:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5564949236230936050=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [v3,2/3] doc/device-api: Add Types property to org.bluez.Device1
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200521180101.8223-2-sonnysasaka@chromium.org>
References: <20200521180101.8223-2-sonnysasaka@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5564949236230936050==
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

--===============5564949236230936050==--
