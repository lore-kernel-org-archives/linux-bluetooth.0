Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA772C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Nov 2021 16:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhKTQDw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Nov 2021 11:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhKTQDw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Nov 2021 11:03:52 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9668C061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 08:00:47 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id u16so9257255qvk.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 08:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ZmTxAIyypCyPWs8ssftlE/9LCFaJ6YCNLXeyXI3MU4k=;
        b=nE4OxDoyvH8UFseJmsQLohz6PayTyriyNdWzYAAJVI3WL7aLG5e6BkvuCEPAWszwLs
         4CP1lxOShD4PNAZF0bFrqdDh9AdpihObgHbCXFSGaLhtvZFuIu1xLxp5kRWuo6IIS5//
         vZBnDjwSQrm3HkYYiH5pl+zQt//3oXeyckWT2YkW/RyDPmNs+12dYxU5IF1yO9+4Bsqj
         z0Jt8/s18q7lPSDzyjP5Lqaq0MJus1fOQZHCfF8tEa9o/wZocE9amZHgAN4zFopuHjNs
         eqecGI1z7C+n8BQYeC+i7taPSJsJFafwU2AQfK3bOxqb7dIXcx0DBvzUDq0lhP5HChAX
         LKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ZmTxAIyypCyPWs8ssftlE/9LCFaJ6YCNLXeyXI3MU4k=;
        b=gKfcP+CNi+/BuYyIjPStgWswZ5Tyv1Z59fcXccmaRpMPDTmGDyyPXUcUv1OKzPW5tf
         5tU1E7RvV3ijrpW4vl3vs2SVlntIVd7j99TsnVsIQa/TC+NcjvWmNt1w+9Aji8xIolQv
         bvRJTnAzQQJYjOHbcOp0VXcc9BifP7NECHhaHiAI+P3xEexp1ejHUIA+RG4vivC5nF3L
         K+jpSOe1W66zgX9mGTwavFKC+Cm1o2ortgK+Oao4oQR/c3DZnr45XjxLbcAAwWiiaeto
         LVMndpM7m4iDq6Wi+4dwouZa6Bfe9wvdKfUl0o/Ev4FT57/FGwZ9nMOJUuX87mAYJOAx
         +Hwg==
X-Gm-Message-State: AOAM532uFPYT8gxMd0uMR456znmZP7ZrO9nEjB0PBpYnAWEjA3/Z36PI
        pclOmYS3idNtLPjdhH187aRZwl3KjAHMNfpfTlU=
X-Google-Smtp-Source: ABdhPJz3tvuOLGQt6ARbB6n52Ey8gcISY5LFwAE4rAmC8N6E4v3dSI5RHwLrFzFr9CRY4yXfVWeDgQ==
X-Received: by 2002:a05:6214:240c:: with SMTP id fv12mr82611684qvb.58.1637424047057;
        Sat, 20 Nov 2021 08:00:47 -0800 (PST)
Received: from [172.17.0.2] ([20.119.187.141])
        by smtp.gmail.com with ESMTPSA id v9sm1582241qkf.90.2021.11.20.08.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 08:00:46 -0800 (PST)
Message-ID: <61991bae.1c69fb81.58706.8e87@mx.google.com>
Date:   Sat, 20 Nov 2021 08:00:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2803708776994463327=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [BlueZ,v6,1/6] doc: Introduce the Adv Monitor Device Found/Lost events
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
References: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2803708776994463327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=583423

---Test result---

Test Summary:
CheckPatch                    PASS      8.80 seconds
GitLint                       PASS      5.68 seconds
Prep - Setup ELL              PASS      49.12 seconds
Build - Prep                  PASS      0.54 seconds
Build - Configure             PASS      9.13 seconds
Build - Make                  PASS      205.71 seconds
Make Check                    PASS      9.38 seconds
Make Distcheck                PASS      240.14 seconds
Build w/ext ELL - Configure   PASS      8.69 seconds
Build w/ext ELL - Make        PASS      202.00 seconds



---
Regards,
Linux Bluetooth


--===============2803708776994463327==--
