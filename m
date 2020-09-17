Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D434C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 04:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3EB206F7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 04:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsJM4Z5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgIQEuh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 00:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQEuh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 00:50:37 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D81C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 21:50:37 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id w12so1012201qki.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 21:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=i9Sl0F9P8LkdySdG8WzA0EgTK0D2DDOLL0jbDf3Ahc4=;
        b=VsJM4Z5uv3efGt8AlKBgZ4XohZOPDD7vzGBkUR0vDVSGeLNbkeQ0Z++/qylAlynege
         RwR/vknVR/UHoeMDc6ymv5Tf0Ktag+DA+d4pAsqzAxREfM60YvukIvlxkU7J0Dpj201q
         FyZX+bkaj184vj6jZKOPsBxWKy9v8zz6ha2XhDVWm4GhaAywhjmfBd+6avqADJajDYco
         +IO64iH4cGfY0uOGBXSp2t1lWndNb7SsdvbVfqD2eH9Pl8Nnf8TOFGpA0UT2/bStVITl
         TvWxQPUXxXn84tcyCauw1XybbqWkNVDfa/2snrx/BUPX/pY/j9eWcezXkdJgU6W0cOSG
         AZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=i9Sl0F9P8LkdySdG8WzA0EgTK0D2DDOLL0jbDf3Ahc4=;
        b=EFKGddQG3CBkygq+bimmec7QP/gVDwPSyo0GXUI3/jUqUfV5Rd2ZTMfawDVUWBz7FM
         UqTywVmW+Q2+zKSKGncRPLf3aNh0lna/XDH1RyLEwuVGLOfkLSvAmPDSq56rgBAXUDfE
         PxPZr+fBhbYgM17Sn9aOTgj9rovjfqqfQcNfrVE18tKX+YV6+eA/3nTT9x0e77fsCeKK
         Hrto4NgEvoziv4QEc7z42d7iLEc4bGPC3xYrxOGixl0hiMu0eWy0AcyikG0uOQ3vcniD
         46arCexCBcFS4NL3CUn2qCm7QMtYbg5a+wRG1uNJRSbQ+qBEapiBeR6iauEjVplfWYJ5
         KQmw==
X-Gm-Message-State: AOAM531OLr+bF2VnSYF3PXXWG5vNuTbgM13p/kLD8AhmrQ7SPE7zitwK
        ZPpkqoX+v5c3EZXya6GGPZDHU5RMUuTyog==
X-Google-Smtp-Source: ABdhPJxD2+aU/a3I2Of7YIUAYsIX+eVRMeWVNxIUaK/68dpL1V/VZ+B922NWlZegoFjJLX3HTZppgA==
X-Received: by 2002:a37:4a94:: with SMTP id x142mr25294285qka.27.1600318236465;
        Wed, 16 Sep 2020 21:50:36 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.17.141])
        by smtp.gmail.com with ESMTPSA id k26sm3666560qtf.35.2020.09.16.21.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 21:50:35 -0700 (PDT)
Message-ID: <5f62eb1b.1c69fb81.fd05e.6157@mx.google.com>
Date:   Wed, 16 Sep 2020 21:50:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5288157599522859432=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v1,2/8] adv_monitor: Implement unit tests for RSSI Filter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200916212926.BlueZ.v1.2.I5ae05701b2b792a3ea2ca98f4a5d977645b1afc2@changeid>
References: <20200916212926.BlueZ.v1.2.I5ae05701b2b792a3ea2ca98f4a5d977645b1afc2@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5288157599522859432==
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
#163: FILE: unit/test-adv-monitor.c:1:
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

--===============5288157599522859432==--
