Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2F3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 16:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5091561211
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 16:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhIWQyT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhIWQyS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Sep 2021 12:54:18 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5C1C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 09:52:46 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t13so901569qtc.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 09:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ZWuXLt9njjO8N3oG0x5ko4j0aH+VumJJVD/Y8vaguF8=;
        b=pxsA6Frh9jEtefK81b+KXvKnY74dBWY6+NF1gpsJjfcqU0EZ/WbaTB2h5QBoS48eai
         V+w+AISVhuV/iqIhJAnsoX2E8xFq7UcLpT+14xrN08aExrUs3xZd+HSuC2w04WMtBWiv
         I0/33PwpauXqbQC7AxrTCfZQgGwZfsXRw8mxp4NHwPhDEEi5CVaO4Js3lUk3ofAa4Dd3
         Ykl6BTNBTvW+uQBFfoFtG3jEUw9xpV7jbnj95TQOqGJdXg6XMM2PC4UjD1zJPlDP7vGn
         fsj8KyRuF6CILymNjE89Q1Atu2/Oxsbpx2oMgys9lgDfjR2h6BdBhPBmm8aRU7vQtw5G
         z48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ZWuXLt9njjO8N3oG0x5ko4j0aH+VumJJVD/Y8vaguF8=;
        b=fp8T7fxfvwtQvbFq06/xk9PZ1sRPuM9jTJ0y0dh1sR+7CyfVs1brMV8PhBz5Kc9Qno
         7VeX98OkhcaYkamMVbkE4dkcVjKe8STwdbYzAbIZd9rEZzbbJBVSfEVaRtyPkLaZaYbt
         wyCcFcCF1LUatuPKDAJFLHFGpUOWiH16YDrOQlAVSXBxRc1f1pHDgIc5cTp3H6uqYBGJ
         DyMX1SqlqGxQPekc9+qdlcB9GulvcJ3++0VpGot0KHtLNgUPzyQOmpL7KI0nQ2MQejbs
         10nVjohY/6YU2wXhXuS9evvItq/L/R7e0+lyzAqwWFixWIu8Pxtw1/dD5OJjQXILyWr4
         6Bfg==
X-Gm-Message-State: AOAM530Z/PBhflizTxczwlGTAEgWLZfccJ/bRbMDoBozp0CX64bArVjG
        7Wg1Pqsvim2mJ3pTrCa8dDj4ePJhWmP3NQ==
X-Google-Smtp-Source: ABdhPJw/Y1kLy3rAJlAkwwG3HlZ1Dvrxct8Sv7bAQ/L5e2Vdn8sU6LMvF9hWF1vjGcEb0CBwfololw==
X-Received: by 2002:a05:622a:130c:: with SMTP id v12mr2218375qtk.315.1632415965874;
        Thu, 23 Sep 2021 09:52:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.126.148])
        by smtp.gmail.com with ESMTPSA id u9sm4460220qke.91.2021.09.23.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 09:52:45 -0700 (PDT)
Message-ID: <614cb0dd.1c69fb81.a826d.2a81@mx.google.com>
Date:   Thu, 23 Sep 2021 09:52:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6472471686899915652=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Mesh Configuration Database
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210923032603.50536-2-inga.stotland@intel.com>
References: <20210923032603.50536-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6472471686899915652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=551419

---Test result---

Test Summary:
CheckPatch                    PASS      31.26 seconds
GitLint                       PASS      18.98 seconds
Prep - Setup ELL              PASS      51.32 seconds
Build - Prep                  PASS      0.56 seconds
Build - Configure             PASS      9.78 seconds
Build - Make                  PASS      232.28 seconds
Make Check                    PASS      9.78 seconds
Make Distcheck                PASS      276.41 seconds
Build w/ext ELL - Configure   PASS      9.97 seconds
Build w/ext ELL - Make        PASS      223.01 seconds



---
Regards,
Linux Bluetooth


--===============6472471686899915652==--
