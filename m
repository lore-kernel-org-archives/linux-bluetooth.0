Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36A4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 02:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiEECtK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 22:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbiEECsy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 22:48:54 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17944E6F
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 19:45:16 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id o18so2293211qtk.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 19:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Y+mbQoQIFF8qAAh3qR/O5FA6PUemecmQpeavLg+zVvU=;
        b=H+qx87Nu+EYJQkGt0zgI0HzFCzTh/vN7gqQDs72NkP+8JBe1YCo8gX0rUdMrGX8zfF
         42p6rxW4G/5HX1gKnmBOA1chRW0iQ0fCr93+nPv9lPxoDB7bmhG6L6pbJnQIDbmoD+4R
         j7jBAYqwBcDuwbiIGKy+oJLvYaRXg3c+TSEZyi3V1yCU2F5u9U38vSeKvQ+39nZe0rD7
         wXiHNzM7gb212Wc/a5Phw0gMEgt+9eotH5QAzH/Dgr4RpM/zSRC8J/zm3WJmLhufPaZu
         oemiSAjzEljY+rHm9BSHmneHTuZ9fSyJ+nJfP0H7fwlCD2+ggfRalooQHLsca3wCh8WS
         GY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Y+mbQoQIFF8qAAh3qR/O5FA6PUemecmQpeavLg+zVvU=;
        b=gR/IAuCPmcQqDCieoXpdM8nM4Jjqkaj1mZM+nzq5S+2W60KxR/DrSsXzL7tYdZE8kg
         TxB4Krz1ytWKphK5YKMOXDJ3pl2N5HlJYDZSX92uybs9u7F+VT96FMTAaSapbcSJ/Ae/
         Dg2F05fDhRaJCA6m5YxPP0lSACfNtMDcphpGClQ4jvtOe4G6gx0+Z8qqIlkVSDzHM1Vw
         FWEDTtdD6v8LjB5pnbNMU16ejR8Q8sJ3secSRb6to5PDJm9KyappNBC7tC5a0CuUMNij
         N+5tohA2pwTWq69RHvpUyLyTjKhdFE20Y3vPoEJb47VZMLx29Fj0yB7iSuuN0BmIpPJp
         m0bA==
X-Gm-Message-State: AOAM530Fc453v9uSN4F51139Mf3EuwAx39M9z5U9ck89IWD4S4eolzmv
        MeYxJle6S6iON+gIWYn04mSUO6oV8Rg=
X-Google-Smtp-Source: ABdhPJxsdsXrjCddrQsj6BGNpqmv4K0w1bwcyssj6CvhlikN0ZU+iiwROnZPVtFM0OUmtromat9WnQ==
X-Received: by 2002:ac8:5c4d:0:b0:2e0:71b7:2829 with SMTP id j13-20020ac85c4d000000b002e071b72829mr21775328qtj.323.1651718715087;
        Wed, 04 May 2022 19:45:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.232.195.241])
        by smtp.gmail.com with ESMTPSA id f5-20020a37d205000000b0069fc13ce21esm169905qkj.79.2022.05.04.19.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:45:14 -0700 (PDT)
Message-ID: <62733a3a.1c69fb81.d59fc.0e1a@mx.google.com>
Date:   Wed, 04 May 2022 19:45:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7119214395130189612=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: eir: Add helpers for managing service data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220505000629.2903297-2-luiz.dentz@gmail.com>
References: <20220505000629.2903297-2-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7119214395130189612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=638503

---Test result---

Test Summary:
CheckPatch                    PASS      1.85 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      32.21 seconds
BuildKernel32                 PASS      29.10 seconds
Incremental Build with patchesPASS      38.34 seconds
TestRunner: Setup             PASS      475.83 seconds
TestRunner: l2cap-tester      PASS      17.45 seconds
TestRunner: bnep-tester       PASS      6.18 seconds
TestRunner: mgmt-tester       PASS      102.95 seconds
TestRunner: rfcomm-tester     PASS      9.73 seconds
TestRunner: sco-tester        PASS      9.52 seconds
TestRunner: smp-tester        PASS      9.53 seconds
TestRunner: userchan-tester   PASS      6.60 seconds



---
Regards,
Linux Bluetooth


--===============7119214395130189612==--
