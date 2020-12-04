Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD66C4361A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Dec 2020 04:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EAB222B6
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Dec 2020 04:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgLDEIp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 23:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgLDEIp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 23:08:45 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2FAC061A4F
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Dec 2020 20:08:04 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l7so3113570qtp.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Dec 2020 20:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=eMC1+3fyUvKz+Ob+19aVkfNL4Kh3AE/SH6EzhhSrKdM=;
        b=InOBrXUn9D5FYLXoAa8m8X92S7txcJ55oOf2xrb0WqgVPWyZ+WY5AswzOn6CEAKJQi
         vOLuQIQzFVydmJfdUwkV3PUTup1zL4mdLCK29K+5Dzm9+di85JnxOpbpDjMKEAPKzoHW
         UAgJPZzTrji62/xCSL1RuwNHzhkf94NzDF3QImRy741e2p8gTIor0EOA/QycKsksZQtP
         yHdjySnhFRGJYtOwOo6RzGRihaG51Y7RIGlf9y/JspjMQOi8xKg2cpkWGYXrmfbVLUAR
         THGE+sWBXZtxEJ+AAF861cT0dBiGpkZvdX1HfSWO30QawJx73g57kYiI7OepNtoPnePP
         w2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=eMC1+3fyUvKz+Ob+19aVkfNL4Kh3AE/SH6EzhhSrKdM=;
        b=cA9c7Si5UcAjBUBhsQswWQuH+xikEO6Nj5icZ3wfXH9was0e15VA0xd66sFRFX8RGJ
         Pe/JDuZd4aA4O3KzFB62LI1AWPWYEt2Bvk1ybcNJXr++Y/Lpep4UBwgdVIMr/TAtn1Ex
         eCutclNPQnUJ8oIN7UxOajdhO6pMvw/aU2rLCPOpz6aF2HeUBZOn0fyCa9Rcx/01WKq0
         2jHVfvigklco6alzGHbEJtZRNyfK5kExNRS38u3J8AZcxr6I59Fq3wANPCG3NkwynaQQ
         HK4s9H+VdF5aj7Kq6++RcAePf/SnHzUXW1dkFwEQ68NgF+eFlHOjZpXsjyvS44aW+4Ob
         REnQ==
X-Gm-Message-State: AOAM533aBxJcCfGf1iFbxyaxmrL8MD679uDCT6MoRs1n0XVx1e135pO8
        mc7QremteViolAiWf6iKz6NNpiRFidY=
X-Google-Smtp-Source: ABdhPJzMXKr71b1gXBsXn9QRz8QZl29q/Cgh/QZSfhbE/V1qVEI3WzXxPC7bD1dZUz3F7xCx0tdN7w==
X-Received: by 2002:aed:214b:: with SMTP id 69mr7085114qtc.302.1607054883697;
        Thu, 03 Dec 2020 20:08:03 -0800 (PST)
Received: from [172.17.0.2] ([40.123.37.221])
        by smtp.gmail.com with ESMTPSA id u15sm3497101qkj.122.2020.12.03.20.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 20:08:03 -0800 (PST)
Message-ID: <5fc9b623.1c69fb81.54716.db13@mx.google.com>
Date:   Thu, 03 Dec 2020 20:08:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4121237263546986360=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [v1] Bluetooth: Set missing suspend task bits
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201204111038.v1.1.I4557a89427f61427e65d85bc51cca9e65607488e@changeid>
References: <20201204111038.v1.1.I4557a89427f61427e65d85bc51cca9e65607488e@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4121237263546986360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=396009

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============4121237263546986360==--
