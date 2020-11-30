Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E7CC63777
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 20:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8835420706
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 20:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHut5Xnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgK3UdZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 15:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgK3UdY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 15:33:24 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CEDC0613D2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 12:32:44 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id h20so12209608qkk.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 12:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zLkmyE11bDmYElV1d8G7qmsEg5FC3WNWnM48izMxonY=;
        b=iHut5XnhOojGyqA+8A8qv/xvdKfeyJy0qR9HZuDee+lp77lXs+E7TJ5BFMsmLElbNM
         BvDKPaLQQRIYxob/ky3c92F7X5ngcX7FpGl/QOMT1P2lkbZFBWr1D/iVsLcxXd9Ataf0
         cgNA21eB1daXxfO56P12VL5Ex1R0wxo83hMWLyLuORI26z0DlC9pOnyKGYioWawv5eoU
         qOpd+rittkGKYtlAZ1fSOQyRNQknpuDXEE+gq18xkjEUDr0Jzy/4WEpt+1ecLyKBYM3D
         pIPTO9D7SDfWH3hTeLR19706EwCb2lztxvm3B1WDITUjSOhNd/MpdrR1fbp8F3JJ2kyj
         AyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zLkmyE11bDmYElV1d8G7qmsEg5FC3WNWnM48izMxonY=;
        b=GDIkKsSYoNPfvVoW6YXfMpbwsHEusN1GUUzZbPUr9VOfjWuTJ2RVrzRzINR+0snBYS
         fx/7cuCHlDbfV67+XvYwjR+nm1gldDc1vq2lz/1uKuwj31HXn7BZgYn5BfMoG1gVn6oY
         J3BtDtxv6kl8Bzl8I+cHXhTQEygoZNuoTeWzRolYlwYOHpmoBLuFzfPr6+sDmQ5h9Aj2
         R7g1xFEgx3FAkMN9yxTSdsL/B+LHDEVU7FrdXYrXC8S6MXAJ3qCey35xssFYQopZMKqZ
         E1tQ8vIfy/6eg8eF1lB8xioVuTZ5WXVNqfNz3rXF7ZrDmask8l8kQtzUOqXaw1K0JMcl
         N8ww==
X-Gm-Message-State: AOAM530b0fOA4XMvy40JCNkNgU5nmy20chWkyQRhzz0vMb0FKptA4v29
        KbAJpgpQKqQff5HnBjv1NelqzjXn6eI=
X-Google-Smtp-Source: ABdhPJzV2Ci+2drbj4GNMQD29W8QsOSxSTSNtHsu/19hxA374w8eeqFE6yufZ1/mbaHiPUJiqG9StQ==
X-Received: by 2002:a37:6384:: with SMTP id x126mr24640205qkb.458.1606768363237;
        Mon, 30 Nov 2020 12:32:43 -0800 (PST)
Received: from [172.17.0.2] ([52.177.68.202])
        by smtp.gmail.com with ESMTPSA id j13sm6995973qki.5.2020.11.30.12.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 12:32:42 -0800 (PST)
Message-ID: <5fc556ea.1c69fb81.8f41a.a91b@mx.google.com>
Date:   Mon, 30 Nov 2020 12:32:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4922433744424389599=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v4,1/7] battery: Add the internal Battery API
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201130200307.386410-1-sonnysasaka@chromium.org>
References: <20201130200307.386410-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4922433744424389599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=393515

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
battery: Add the internal Battery API
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#71: FILE: src/battery.c:38:
+static struct queue *batteries = NULL;

- total: 1 errors, 0 warnings, 215 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] battery: Add the internal Battery API" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

test: Add test app for Battery Provider API
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#12: FILE: test/example-battery-provider

- total: 1 errors, 0 warnings, 232 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] test: Add test app for Battery Provider API" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============4922433744424389599==--
