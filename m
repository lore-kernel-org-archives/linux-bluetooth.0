Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC0C63777
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 23:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6586A2222B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 23:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBoobW9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgKQXSC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKQXSC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 18:18:02 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDD3C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 15:18:01 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id g19so118692qvy.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 15:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kyHiQkY8WVHY0W4qoQdI2UH2fO2U5l9m7ZQkGArKfaQ=;
        b=QBoobW9JkjWuZ2Zt1Vn5e5COXCDzaoC5vfMKT73x16GvLmL/cSnbmwv5dJ26Qu7NyQ
         bhIsSQFWi/CgThQmlVKGOJpxa+psPqUFyjva0LdVeHdZNUcPCeTGiFqpVgFEjfarykUa
         9M+PxWG2uvEK/WsxHCdZxjBoLg9utS5qGfA9MfIyqzHyVjYL9gacwCI4YcY7lBUgpFH9
         fXh1lkEA7v+2jSq2MYod9sOR1OylcRfsnbeJTfIvTAFi5JnIFrO3wkpblU0EpK6VfhnS
         Z2XZEJQ+YOBpmxW5JaNLRMybsjBUhUUi42Mttn4KVHKcuLBT35i/GfnQ5JLYBHAd2YEh
         AJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kyHiQkY8WVHY0W4qoQdI2UH2fO2U5l9m7ZQkGArKfaQ=;
        b=lUtMQdTjY9N18ByFsgQDYa7ZwOz3zlxD54NS+IqmAsCYVRLJp5mn59Hsfpz8HDZifj
         x3grn2mjOxyjsgx8nVDzk7CW2h3USu6cK44xJWn7Z4G5AkHbHZ2Ph78oFoYKKo4dTmEv
         BA1r/rh2UvzR/z8fyeSZvKteciLC+qOFuJeDA5te0mpobvx6Ycq4yI5w5rMUKerlLRl6
         fQ+vDtoUig41z3RXtJCpN6wyq68v+t3xO86UPb8/vXwjpys+4QHrTgtfCG1/OBF2sL1D
         /19G/c5G8qrgqcDC69wlaE9PvIEhafmWt4BA7++DuasV+XhUGGVBZihA4nhMGDZgAFvD
         TRpA==
X-Gm-Message-State: AOAM530vAW+DiQOfft/4fEHA1rnL3KbsGjiWbcuYUyJctZr4C+HZfs1s
        JuisUgzw6tSd8AzMTxjxXVRe/Am91n220A==
X-Google-Smtp-Source: ABdhPJyCdmZAyJqHsXsrnGx5gl1XDnSUEGJPhvD2aVLuFCTt9PCidp3U/vwD5ABn+55CNxn+d6avUw==
X-Received: by 2002:a0c:f254:: with SMTP id z20mr1821894qvl.36.1605655080967;
        Tue, 17 Nov 2020 15:18:00 -0800 (PST)
Received: from [172.17.0.2] ([13.68.110.168])
        by smtp.gmail.com with ESMTPSA id z186sm1343428qke.100.2020.11.17.15.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:18:00 -0800 (PST)
Message-ID: <5fb45a28.1c69fb81.5964a.a8e3@mx.google.com>
Date:   Tue, 17 Nov 2020 15:18:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4590015376847848602=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gubbaven@codeaurora.org
Subject: RE: [v1] Bluetooth: btqca: Add support to read FW build version for WCN3991 BTSoC
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1605634182-7926-1-git-send-email-gubbaven@codeaurora.org>
References: <1605634182-7926-1-git-send-email-gubbaven@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4590015376847848602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=386201

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
Bluetooth: btqca: Add support to read FW build version for WCN3991 BTSoC
WARNING: Duplicate signature
#11: 
Reported-by: kernel test robot <lkp@intel.com>

total: 0 errors, 1 warnings, 84 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Bluetooth: btqca: Add support to read FW build version for" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============4590015376847848602==--
