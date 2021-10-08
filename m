Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62605C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32ECE61019
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbhJHTzX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbhJHTzW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 15:55:22 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6DEC061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Oct 2021 12:53:27 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id k19so1426113qvm.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Oct 2021 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3JFeg6OX5GjHj04py1up0JNDtdas/VB4RlWVOupm/Wc=;
        b=EkZSt/IR8v8P8Zwqdiqp5WXFLApgBLjDxXuoPW6AR1UKs6wqc3H8KUrh3dT6kTXEkn
         HhKGz5sySI6D5C/HHrbLgvzaO9pjxAOTwUkI/R3izsosfA1UPfVkwfjUOxLO1wXCA7a9
         yI4CNwdaAO2pohoIQttLO/45b/uWtu1ftRCH+GSS2PSarglI/U25uydqFtl6sKRFU9b9
         zcXpBtNtVgJ6e+euVulq/yvXKcnUbsOjdgiWi+PvxG7zXnUwLG4l2HQTfgHXVu08qwiU
         GCs2eaK3AJ8wW+D8DRkFUC5DUkX6Ma2UgTjgkfZVDh+rRSZgNiFYCXEJhLBGCOOXYmAs
         aUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3JFeg6OX5GjHj04py1up0JNDtdas/VB4RlWVOupm/Wc=;
        b=AyVB8gMBP4KUMlWtwUmnUINx26e1FRbKth0oZ+XtBN1DB8JeTRrEAmSPQp3T5BhrX7
         4d8qWFSOr71YGQrHbQ6OGOa1aitRavRTedtgjBrFc797P7Hjgb8JRZGjBcAipmNAIDvO
         im6FU/W2aioi1VLgrbOXESQklk8SNBvhjcW+AZFHxIt0KKXL3Hf6bHE8Ci0E/DcoqTiB
         BJtnrkqFGuBe+CPHrVGueGXSe2Sg6mwEn0PhgNmLVTknT6qRVTjvEB9UEKsN9f5vlC/0
         Wd3jmsDtjsw0aFslZLb7N++W3Uzk8qL9c2uf8aa6PIY/fdHldj0e8GdYxqjOXe9SUfei
         97Rw==
X-Gm-Message-State: AOAM531t5SY+E1TUVEoVgjS6kBIW2ewLgsg6RW55MWGYn1aqUbQ3VNkc
        P3MTN1n9grcGFmGlAi0dvbDs5qFpf1DG+w==
X-Google-Smtp-Source: ABdhPJxGhxj8uzMLuuYiZr4LOhg1GOFrCfIYtQBslvw53w96EWepuzBfxCwVms+0+OAk9nN4hKxhNQ==
X-Received: by 2002:a0c:b2c5:: with SMTP id d5mr11847899qvf.65.1633722806210;
        Fri, 08 Oct 2021 12:53:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.58.140])
        by smtp.gmail.com with ESMTPSA id w1sm181133qtv.71.2021.10.08.12.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:53:25 -0700 (PDT)
Message-ID: <6160a1b5.1c69fb81.114d8.18b4@mx.google.com>
Date:   Fri, 08 Oct 2021 12:53:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7895794929121886205=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3,1/3] doc/tester-config: Enable Runtime Debugging Feature
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211008193628.39347-1-hj.tedd.an@gmail.com>
References: <20211008193628.39347-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7895794929121886205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=560147

---Test result---

Test Summary:
CheckPatch                    PASS      4.39 seconds
GitLint                       PASS      2.75 seconds
Prep - Setup ELL              PASS      40.26 seconds
Build - Prep                  PASS      0.45 seconds
Build - Configure             PASS      7.46 seconds
Build - Make                  PASS      174.06 seconds
Make Check                    PASS      9.00 seconds
Make Distcheck                PASS      211.98 seconds
Build w/ext ELL - Configure   PASS      7.81 seconds
Build w/ext ELL - Make        PASS      162.27 seconds



---
Regards,
Linux Bluetooth


--===============7895794929121886205==--
