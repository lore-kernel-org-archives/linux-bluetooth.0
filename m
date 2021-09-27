Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF24C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 22:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A416103B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 22:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbhI0Wis (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbhI0Wir (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 18:38:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549A3C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 15:37:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j15so11370994plh.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 15:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=mE+yqeoY2pRULjziMh0z59fzsE9M5KglPRQHjVO9UsI=;
        b=fIC/ruXT0tNGzA9vHNRbEUTBFi4apZJJF3bUheXZtOVCXmnTmeOIHt+lkuu3R7zhig
         TJVf1hU+9PmY8BnyC+gH62XBe+kG+Qy/hQ7scd7KU/BXhPvcoJLoSdl7BQ5Tfmqj2ARY
         WDg6jcZVbcaDH7VyRVm+HsDHacc1qmi9vMqgcrQtMHwM2q6Xmb32BQHaHIj/qm1Xptis
         AkJucqxIY1Dmu8mq7eGoYMFGMsLO3aSQY/yJfsygP3ZcwJF61D6iCp6spZwuAAQ3ON5T
         3Ux+cIY2aEg3RyyXtwG/hH6OzseWqcuYiEiWcbqHDRfq/fucd+OAyCAUWQwrDLGyxkJ7
         eitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=mE+yqeoY2pRULjziMh0z59fzsE9M5KglPRQHjVO9UsI=;
        b=dsNve7X0V+ppIRsGBdEIWKXdSYifx6/E9Upne9ePbmK7xKAQnnYMs4diwurnHmmCXc
         yXeMKZWRS6f8GNtrDHSjBFKzNarxT3DffSGwYOfZxPZcYqqjYJS2sXT+Wdi8K0HcbXG1
         CN0H5nZ5zemE1jMGpbT7gkBXO9MX3ATO2exF7ANPS3uP7y3wD2/fOvKDpJAI/dMGAjNk
         65jN/hPAk3sFz4+9VF2HaZGc1pJNlFrE0Ms/3PIdARX2Pdic2WB4igEQbgyrsLIBaFQB
         zsPLPh7Brzs0TUlJltixlD/otqcKzxLvzv4MfD+wGMXxNWFNyxg5OaNGiEmfo2eZkjkL
         TObw==
X-Gm-Message-State: AOAM533lWT1plWC6uDWkIb8maTOAZUQgLblZPIlMMmUEPEIKtNyoQEe7
        fWv7Pu2b0odfRYdmuNYZg1EJwmU0D+g=
X-Google-Smtp-Source: ABdhPJzoLtKX2cjKgkkraNlUy735DOd0FJ4YJqEjK+83Dnbh1pD+gJ0j3DvpLUaZLhd3w70KrKyfJw==
X-Received: by 2002:a17:902:8543:b029:12d:461f:a6a8 with SMTP id d3-20020a1709028543b029012d461fa6a8mr2072563plo.1.1632782228569;
        Mon, 27 Sep 2021 15:37:08 -0700 (PDT)
Received: from [172.17.0.2] ([52.158.234.176])
        by smtp.gmail.com with ESMTPSA id y13sm19890876pgc.46.2021.09.27.15.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:37:08 -0700 (PDT)
Message-ID: <61524794.1c69fb81.6b7f6.1198@mx.google.com>
Date:   Mon, 27 Sep 2021 15:37:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2532284952402644482=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] doc/tester-config: Enable Microsoft Extension
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210927221307.211767-1-hj.tedd.an@gmail.com>
References: <20210927221307.211767-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2532284952402644482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=553807

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.30 seconds
Prep - Setup ELL              PASS      49.42 seconds
Build - Prep                  PASS      0.22 seconds
Build - Configure             PASS      9.01 seconds
Build - Make                  PASS      212.11 seconds
Make Check                    PASS      9.18 seconds
Make Distcheck                PASS      249.61 seconds
Build w/ext ELL - Configure   PASS      9.02 seconds
Build w/ext ELL - Make        PASS      200.96 seconds



---
Regards,
Linux Bluetooth


--===============2532284952402644482==--
