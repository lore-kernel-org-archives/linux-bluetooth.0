Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD93C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Nov 2020 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D1620719
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Nov 2020 18:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYEYGL94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgKOSvc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Nov 2020 13:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgKOSvb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Nov 2020 13:51:31 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2B1C0613D1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2020 10:51:31 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id o66so1221253qkd.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2020 10:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bqpUMhL/zt7JWK/1e/GRQQmm8loSuUS0o6mhtSr3QFw=;
        b=mYEYGL94+6eYSN87vs0N06dLQmBNs2P0SiAlkUCBlD5oWgAa7o4F/dvPOvNFHcdg8+
         NXmVVZgV3rFD3c5ASzRR9xLCMLxXRggfpBnyIG7uPGsfioAYAd1yp677ze+cZWozI75G
         263HMShc2o12yHwJdV4qIoFLBiBnHxjUJi8YOmjIg1/NgX+nFjMHSSzbe0nZaUYr7y4w
         7/WPoDvzfrINC/aF3ItMjY8kvBDzmzLZyEZRVXypRIUTClaFeiOb5bIB7JipKGOO/ryg
         Shq1NAZ26c0ftaMKSqgdBlxh0sZb/JzSSyvkNpR26qGjpjRIVCMSdJpUY6zLMuX9kCCq
         B74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bqpUMhL/zt7JWK/1e/GRQQmm8loSuUS0o6mhtSr3QFw=;
        b=Xt3qqiGg7T9hcyeE5yI5jlVHz9SKjMl5hHhDP7xquzd2Ia05aeZF2KXT/bw5lttX8B
         Q7FYUAcqeEn8uGSZay4Ibj3XkhJFP9OROLZordLiV2dcG0yZu7O5oKMn/c9pn9k6UwMw
         xeYrMD4wS9mODD/lH0U5MPxVkc9PyEOQ9atn5woCyanxckTfqqZq7RNFQlEQ7prqTamh
         27vSf9kzqXgJZfWsWUPuAQ/LElkDY9DUAC1LE5bSRIRvE5dPX67v1qtz3aZHwdvoMfxP
         LQrrnjL7wHDvxIMpvvLiHmLX1dztM8J4WBS8pehTc4jFi7VjQ66eWqI4oxQ+yTh21eIH
         p3bA==
X-Gm-Message-State: AOAM533TGnlJdBhxBhKNMDL4fN/iDF7uDqjejt24n5zv0Hghf2m5WKI6
        wOl2vIK36ZB5gqho3NY1f6WKtdDrD5oNgw==
X-Google-Smtp-Source: ABdhPJxnQsk4UjrD90cBWh6557YmvWKTw8qoG3W3cxd/PaYP225hdrLK68xwdo4OVLrdDqQ37FGFLw==
X-Received: by 2002:a05:620a:1647:: with SMTP id c7mr11345378qko.455.1605466290597;
        Sun, 15 Nov 2020 10:51:30 -0800 (PST)
Received: from [172.17.0.2] ([52.167.57.177])
        by smtp.gmail.com with ESMTPSA id 7sm10480826qko.106.2020.11.15.10.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 10:51:30 -0800 (PST)
Message-ID: <5fb178b2.1c69fb81.70c9c.b92c@mx.google.com>
Date:   Sun, 15 Nov 2020 10:51:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8709528402981763248=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gubbaven@codeaurora.org
Subject: RE: [v1] Bluetooth: hci_qca: Handle spurious wakeup from SoC
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1605463143-4635-1-git-send-email-gubbaven@codeaurora.org>
References: <1605463143-4635-1-git-send-email-gubbaven@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8709528402981763248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=384477

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


--===============8709528402981763248==--
