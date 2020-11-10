Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091E7C388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 08:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A5A20870
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 08:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF+LsgKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgKJIQG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 03:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgKJIQG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 03:16:06 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4625C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 00:16:05 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id y17so11039689ilg.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 00:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=47gLNcQKX1hJtTjmQk+SWDbWvLpq5B7IZ1FS3HkCwGw=;
        b=PF+LsgKjWssS3Sndvli+xmTcpaF/U/CkDzjFR82HFSc1EUYiZGLm3uZT6wHbepcCfR
         ZvnI0IWticPeu3qgDdCykrl502DNGwvKVyqZyF6NJh3Aur4C1AgvDmfwVH6K+S+6Aa88
         /4PbAnpA4T2BP4RwfYFBDcZ3tGSPotm++rjVLLFXYfqavXpqXj3kSjaXkAileEWCafLV
         67ET6qOND9eZBTbsge6F5u06I0CZMm8EHmPwJhm/Xw9THXsUBZJgbs3XOwYYny5a4CKX
         XQ8qCrOmR5a5/wEj8Z+GxEWxtpK/GJGiSVGxUt3TinTMKgRxqEOzdu2e4qlOw8rj7W7p
         XZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=47gLNcQKX1hJtTjmQk+SWDbWvLpq5B7IZ1FS3HkCwGw=;
        b=AuYVqHo+LdjKmGss15H5MLMnucvDSOf8B/IGH0KzggjGU4yZGpVHWNtff8b0VzLWoO
         W+hqShFqZs7kbcHVeaKHXnCHK05MVNlXP/1lsYyTImaKIDSdfQKKrGnLWjT6nJxMS1y7
         LaGhJCgxJdeiEMknRvOsYPADc7Us9rSKBtHZL/0ap7b1Pq2SgTpRjQUxhj4L4MEYkpnf
         ZZc46xpkOndwv76ZSiyojNRjvUeORDEyPAVtTO6qCUWTLhWuyLGkk4T1vwM/tuys7W/2
         tYHosAJaFDbjDcukouNSi3Hu5j3h7xC+1NKSi6QwIQJabV9vYPFbvrrHr3hSb4LKptYe
         lQKg==
X-Gm-Message-State: AOAM533DKDn44LX49/4epmn3fVL5bEk08Ln/36UBuPyfG0+GYdxqhtuh
        wQq25e64g8CHDJ4FhCM+RPKq9EZnBlM=
X-Google-Smtp-Source: ABdhPJyBylgQ7A20OR5sXV/AsiJAHW64TYiGxgbQtr5QRjbWvgta3iaVBRA+V5E/y1y5PI0p11OOlA==
X-Received: by 2002:a92:3403:: with SMTP id b3mr13120097ila.140.1604996165102;
        Tue, 10 Nov 2020 00:16:05 -0800 (PST)
Received: from [172.17.0.2] ([104.208.236.131])
        by smtp.gmail.com with ESMTPSA id t26sm6862146ioi.11.2020.11.10.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 00:16:04 -0800 (PST)
Message-ID: <5faa4c44.1c69fb81.54477.9dda@mx.google.com>
Date:   Tue, 10 Nov 2020 00:16:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8940696783896248074=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btusb: btrtl: Add support for RTL8852A
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201110033837.19373-1-max.chou@realtek.com>
References: <20201110033837.19373-1-max.chou@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8940696783896248074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=380837

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
workflow: Add workflow files for ci
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#18: 
new file mode 100644

ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] workflow: Add workflow files for ci" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============8940696783896248074==--
