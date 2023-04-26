Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB97C7618E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Apr 2023 18:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjDZSin (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Apr 2023 14:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjDZSim (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Apr 2023 14:38:42 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C4F7AB9
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 11:38:41 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3ef3ce7085bso32379871cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682534320; x=1685126320;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A+rsVt5UUED49vdReRn/5heChy1aNTLFCFVS6yW1H5s=;
        b=OAV9uXGn/C/kueCsVCwRgpFjYA5aThHY7V4HCDyF/ciYKVIzb8O2oNx97F/U95pMzK
         eAe/zX1B3VuRcdvCH5sF9U45ETL+KSbmmuaXLidOQFQCaBmAImjfYyeNBRfW1/cyoSMr
         ZKHWTj7aUTrGLd2JOYr1lCxXIRFNWp2G2LFZKsqtpPjJm5gi2t7LwK3UzZ+KzjkchGWp
         IXlQB/WdQKOodoJlVV2tfu3LEiqZY8kMKahGBUrRK/X+zOOp+SE/l+jDxK6H8nejcc4Q
         1pXFvbPW+r0hh9ZrC4KHLUKrzz6vB3+Zqes90UgmXUT/OH/hvd4SbW7VTUVDQRs9Vova
         TafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682534320; x=1685126320;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+rsVt5UUED49vdReRn/5heChy1aNTLFCFVS6yW1H5s=;
        b=b697enifL5FS5cmlwEPcajDpTeMO0ETAl4lfdn8Cq8QXWodk44N4vxb1BxqcfdzJsE
         OD+7BZ8fIKO3gm0E1zcrzOSJvEhFTT1ykftIf3+tZXirIqZ/ACmwwkwvnaUSFFydioVQ
         87xZWlVR+xv3kuM9mdY+w2cTR71KOtGN363OwyC6m91xZjV1u0fW4TIhabulJ+Z+ZmM2
         jEoCZOJDK6qvLFyLi39RyxPEzSTDr+Uh4TPespqb1ku0sNNHXIWiLbkd64gV+xM2HUpM
         NOpn7+1eiOeck1FQPhDW1HbF9i0jjO0IlnZ2sUoXwnicxHpIJiisO7CUns1a62mB8l7V
         tgDw==
X-Gm-Message-State: AAQBX9dM0bKrt6p2A4QXItqJcNyVMWg6wAxDqQeYf3V5HSP8CtT4rurn
        2SNmBkbnQIAWr2GR3CH2uOZeGzOYjOQ=
X-Google-Smtp-Source: AKy350Z8uMeQmtFVdae9lYw2+ck/W7e53CTANHlH54vpz/kWJ6oCvtdGOnMjQhG1PjUkT5DY821DJg==
X-Received: by 2002:ac8:594d:0:b0:3ec:46e9:bc4b with SMTP id 13-20020ac8594d000000b003ec46e9bc4bmr40206963qtz.29.1682534320085;
        Wed, 26 Apr 2023 11:38:40 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.6.29])
        by smtp.gmail.com with ESMTPSA id l9-20020ac81489000000b003e302c1f498sm5516148qtj.37.2023.04.26.11.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:38:39 -0700 (PDT)
Message-ID: <64496faf.c80a0220.55121.6c09@mx.google.com>
Date:   Wed, 26 Apr 2023 11:38:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0822323000644081691=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, raul.cheleguini@gmail.com
Subject: RE: Bluetooth: Fix unexpected SMP command errors for ATS2851
In-Reply-To: <20230426183306.2048251-1-raul.cheleguini@gmail.com>
References: <20230426183306.2048251-1-raul.cheleguini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0822323000644081691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:4374
error: drivers/bluetooth/btusb.c: patch does not apply
error: patch failed: include/net/bluetooth/hci.h:316
error: include/net/bluetooth/hci.h: patch does not apply
error: patch failed: net/bluetooth/hci_sync.c:4581
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0822323000644081691==--
