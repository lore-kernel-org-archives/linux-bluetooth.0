Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D77BEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 09:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjF2JZ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 05:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjF2JZ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 05:25:26 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26502134
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 02:25:25 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7672303c831so46737085a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 02:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688030724; x=1690622724;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D4I/TY7c6xHiXdGKI+IdGXt5RVxEglZ81NsxjXgx5LQ=;
        b=YkEaNrk2VlDviK9kelo3lIP2zHA+fgrZ7AHEkh1xRoSHO7b7Gjb1woxpI5tbl+J1D6
         WFJck2By8xtO6OEBvWI1dBPr+GI8Yf8QpYOxEwLZk9d6pZM8Dwgot5/zHt0mWCYCns2y
         wObSAGtB3a06gz5oJ2c4Ci3x6qnreYBMiRJY56l8Ov9YEfxWCsMZL/OPCw3WWw0oKRBh
         TqZaL/zx+67f704qbZmaPUttOZKy7vPYMQStGolI3AI85q79m5aCXB6T8L8VPEHYk923
         r87wBvcvQrq2xa0EmZYJ7hgZk/TOgY73O0PI1qHGxu98epnRTl1s9jL6UcL37DMfK3M2
         bp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688030724; x=1690622724;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4I/TY7c6xHiXdGKI+IdGXt5RVxEglZ81NsxjXgx5LQ=;
        b=j8EZEzwF2LiIJ6SMlI+4wNzk8pST0t47bW2Y4uoxTpaSghK7JSsK0Nrdia8XbknwaR
         Oi8CG2O38+buinlmMEnKR3J5j3dSGdAtljj85GfV2Un6iPqBri2C96iwj3pzlNwe4c8W
         t2BNmKJBbauJ6n+mexdkGEQmmG7hm2WuljzS3lA6PmFieGDxshF9fvn2Luv3rN+9mb3y
         CDkifTfY8EM/LjJZYsSVlpKwXYepgC8RWm+BL7NSw/oQtv+vT80VSvBUkAeak7xg/yOC
         4ABZNYXmJuFlyPg6S1QpGQSkUElmHCMbXyPJL2nk0Mozd2FwkHTNfwOM1Zty7Ao/q6uQ
         y0mg==
X-Gm-Message-State: AC+VfDwM/3zCkF8gbC1lJy8JJBZeTc6pdHRdi6pMKD79zYlbJtDMbmMD
        OTcybISFhZBmXFrDSqohEyVZqqEHgbI=
X-Google-Smtp-Source: ACHHUZ4aTlbLpbqAqehknLn0S34ezvTrTMTtww9bSTQZKhTxbYRbxS51+4nsArzVcUMnD0JU5OFuAA==
X-Received: by 2002:a05:620a:2589:b0:75b:23a0:d9e1 with SMTP id x9-20020a05620a258900b0075b23a0d9e1mr42017792qko.55.1688030724631;
        Thu, 29 Jun 2023 02:25:24 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.6.21])
        by smtp.gmail.com with ESMTPSA id pc26-20020a05620a841a00b0076219ec1fbesm2055620qkn.42.2023.06.29.02.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:25:24 -0700 (PDT)
Message-ID: <649d4e04.050a0220.f3b88.637a@mx.google.com>
Date:   Thu, 29 Jun 2023 02:25:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0208996532272622545=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: shared/bass: Introduce Add Source opcode handler
In-Reply-To: <20230629080735.525650-2-iulia.tanasescu@nxp.com>
References: <20230629080735.525650-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0208996532272622545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761141

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
GitLint                       PASS      0.68 seconds
BuildEll                      PASS      26.38 seconds
BluezMake                     PASS      770.64 seconds
MakeCheck                     PASS      12.18 seconds
MakeDistcheck                 PASS      153.70 seconds
CheckValgrind                 PASS      248.67 seconds
CheckSmatch                   PASS      334.87 seconds
bluezmakeextell               PASS      101.04 seconds
IncrementalBuild              PASS      1289.17 seconds
ScanBuild                     PASS      1002.57 seconds



---
Regards,
Linux Bluetooth


--===============0208996532272622545==--
