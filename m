Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D41C43464
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 21:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB02A2075B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 21:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh5l6VV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgIQVtD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 17:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIQVtD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 17:49:03 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E79C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 14:49:02 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id p15so1811121qvk.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 14:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=I7JMbI6mhJEkXtALsnZMYNxrFH0u/Eq4oP/lweS505Y=;
        b=Uh5l6VV/UhIOvB5xZcw9B79q5066Qc9cbcNs9hIakymcKJVP0S+30s/BZRRc8mOLgf
         cBhZspT5diTbdR5wJioSGLpsdOB+ty6Z4DiXPP5lq0V3QgRser0fS5SztLZbFMqPE2sD
         TZ3+YVsCXQ7tJnjCymcS3+GmgusF6pFL4ss73WW/Cs10vAsoOQ26V6/QRHNJTYa0+wET
         yKBv7skZOHYEUregexDs2WkFwPQFVrBl6l0PCPQEq9t7gsUZroptB8WHvT2+zsbcDGVz
         SNoGAyV9ih7lId7FaiaJwyobTuQqwMQT2fWyUVzFlgu6D76XiAOPPcj9sBXIMaSCSmtQ
         yqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=I7JMbI6mhJEkXtALsnZMYNxrFH0u/Eq4oP/lweS505Y=;
        b=uAXQszvCK/+jYctD0elAB8kCVqK5UHQlFmH9ELvFkhlZixBhQBE+kHJsoQKULIp3zJ
         LQlJDyHGIfn9ktpqTq6xnTcfqk+cHRN1e3Bqos2/biL3ofcsV4xQWezIDxfqBbY3Xv5d
         1kt4var/lbPPyBCUZ9fK4qdYfDYGsVkokcsLoH1SfFmuFuZ+w77UKrdUZN9kEnWDW4VH
         Bw+RV69hXKAnzaQcQ8+kO4cQ7BENmTL9FaQJ4ihdr+p66kzYaiYEADY3eg16GnF3ZBE9
         GZA7Yjz1iwxqXaPJj8feW+4iHetdWI2xbZ+GLwKxbrIWdNJ4nHgebS6b8F/EN9I8Bdls
         rPKw==
X-Gm-Message-State: AOAM533EVCivDAfl3N1+YSBG+S33mNhD0saliUkLlwkvLKLudaKg6EC2
        h+TWxC0dOvin78vJUqJt6FOv1n2ORPWA/g==
X-Google-Smtp-Source: ABdhPJwBHiBsY0RHg8qUO1vw9DxpyeOYQlUQFR4wqiyBxZ6hD7DLqE+LrW6VbyV/Wjn39oI+SVmXRg==
X-Received: by 2002:a0c:c244:: with SMTP id w4mr30898973qvh.12.1600379340668;
        Thu, 17 Sep 2020 14:49:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.152.21])
        by smtp.gmail.com with ESMTPSA id d10sm775201qkk.1.2020.09.17.14.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 14:49:00 -0700 (PDT)
Message-ID: <5f63d9cc.1c69fb81.8ea44.56ca@mx.google.com>
Date:   Thu, 17 Sep 2020 14:49:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2336312357875185178=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v4,2/8] adv_monitor: Implement unit tests for RSSI Filter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200917142456.BlueZ.v4.2.I5ae05701b2b792a3ea2ca98f4a5d977645b1afc2@changeid>
References: <20200917142456.BlueZ.v4.2.I5ae05701b2b792a3ea2ca98f4a5d977645b1afc2@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2336312357875185178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#161: FILE: unit/test-adv-monitor.c:1:
+/*

- total: 0 errors, 1 warnings, 512 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============2336312357875185178==--
