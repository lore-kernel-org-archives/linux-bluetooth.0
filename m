Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDDAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 19:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2510F61056
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 19:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhJ2TE6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Oct 2021 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhJ2TE5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Oct 2021 15:04:57 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DC1C061714
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 12:02:28 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bk22so3619353qkb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MoOQUlO03ITdLRAGamiKWx8+BjQiaUahq5Kdo5pJs2c=;
        b=Wl/lsndWQLOfViH0vztL2XQCoemq19ewiq7HLjAD8OETYnUos3DkTA7NNnQ/EKJcFs
         pEa95H+F9btBASuJcMbQWVrm+p7I5tzfVXqZXSJOJA+3gPR8EhGKgRULAUSWK6ICEiTM
         dTlDKCxsz6wbF9hFzel7HZftY8RczJkgt3wTkg47mIm5VyUziAR3U7GOQNjVHEnGGbES
         gFJL0Mewi1o0eZbc+JNjP1Tdw0/kz3zfq/wLdnD3Pa5A94WH60rmAMMWZjZkmVIMyN9H
         tCcGuX+OA8sKLARXyDBNHGvx2/h2Y9zlOVvrEu5VVdEw4yG9MgEh4sDoT/mqWjAQtVcx
         BAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MoOQUlO03ITdLRAGamiKWx8+BjQiaUahq5Kdo5pJs2c=;
        b=2tFRxaADYGxJnK5JhXDX7071wmikhe5xYNEd4BoA0lGRQ/H47wMXHszor+6TUrxy/x
         WcG4xcR3CSub5sF87w8zog0gHmh0fxfNbJJuZDMFIKvUEn1d4NaxfV3HuxrFPICMLIVD
         NL5/r8NY7URmb65WFsuDBIse0Szn4d5dyQdFD+I8Byf2MhgZRpds+7m/HBBlE041KaQR
         CaQ9zIi60R/geLsjq8J9H1mI9uKEkX7LWVgHwNq+7NQhwkDK73tb5iyF0UyPAh8QKtq0
         vnBHC1EhjQjTc6k1ZMjSSVZ0o+yD4ZE/ftQLAOOT3OakmH/3I/p27qeHjMmVnV+WKhQd
         crpg==
X-Gm-Message-State: AOAM531FfCh6PzDeYdqZk7oDyVlpbVBxpOxj52MyJXbYN2vRYKHxodmN
        xsQLmRA+WHbXLUICSpgf67/P5PA5d7FNdw==
X-Google-Smtp-Source: ABdhPJw3IEYBAE6da+lY3N86QEzXMVh6YA9/Opfym+zNejr9uiXNBjQWRsbwYXilAkBNSs8lYBgbQg==
X-Received: by 2002:a05:620a:24d1:: with SMTP id m17mr10633104qkn.316.1635534147317;
        Fri, 29 Oct 2021 12:02:27 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.38.89])
        by smtp.gmail.com with ESMTPSA id o1sm2997900qkk.22.2021.10.29.12.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:02:27 -0700 (PDT)
Message-ID: <617c4543.1c69fb81.e7a42.59e8@mx.google.com>
Date:   Fri, 29 Oct 2021 12:02:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7953849676553608148=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v16,1/2] tools/mgmt-tester: Update the expected manufacturer of emulator
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211029182929.705682-1-hj.tedd.an@gmail.com>
References: <20211029182929.705682-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7953849676553608148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=572711

---Test result---

Test Summary:
CheckPatch                    PASS      5.01 seconds
GitLint                       PASS      1.96 seconds
Prep - Setup ELL              PASS      50.14 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      9.33 seconds
Build - Make                  PASS      217.69 seconds
Make Check                    PASS      9.42 seconds
Make Distcheck                PASS      257.14 seconds
Build w/ext ELL - Configure   PASS      9.45 seconds
Build w/ext ELL - Make        PASS      209.14 seconds



---
Regards,
Linux Bluetooth


--===============7953849676553608148==--
