Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA4FC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Nov 2020 18:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB112244C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Nov 2020 18:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGMgjlU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgKOSvT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Nov 2020 13:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgKOSvS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Nov 2020 13:51:18 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D291C0613D1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2020 10:51:18 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id y197so14576686qkb.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2020 10:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=LB2RRJDDicH5ptUf0JPMysCtjzHuXyp42jOQB2g/G0Y=;
        b=mGMgjlU2u3jBw3FPUDPkoTs/Hxi3j/LOtdDXuL8zVu97fQhOR3SyKzalfGZwnKLtpe
         FBAAScvdDGNDf55hCBipeM1CdTDP0C89uUisJY+PrBk4Rk+A4reuz0qbY/blM2fWPatE
         v5vuwWqp2vkcxNVCq08ttd8ne0npzwIVDirhnlTWvuDJtSqhUiFqJ3XfyqnDCRSZ8Rdz
         twGOTKpNP1K3YDGC5T6i1KEsgB2ClM+NTej0EN0XKGRR3l1irx+UtYgFFTSiI+M18bxn
         5y5RP3Ia8kXZXaWye0ybQ2h12yZhwSmRfIxo07pecP7HhQUcDb6rIpeTXfjuF4vWlhFN
         B6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=LB2RRJDDicH5ptUf0JPMysCtjzHuXyp42jOQB2g/G0Y=;
        b=o/VQQ5rvFeGHgMDxK1IlQi8UKeamzW9uONqoyXjhxkopTJkCP5To9ClwpE76Dro3jO
         UfiHkSSrsrEybPDV1xI1JEYauyvRY+Lx7R+eR3qmTeacW8GGsxqBagx1sk3YNWO8h8Bw
         tn4jYNM8XWWVZ50t1auzSrMpII6Tod1JOSpPi/uIraw9F6B6OXOgHZL9FJZhfMRYdsdD
         DWfccV73HnDio3PO3vm5/fK+lpqLbBBhbpQ5gZQRCaP+Fx7aUcMwHSiVF6P8tQMChKCQ
         HIGUbAU+twke31/7+J5Sd4vgDJTqNQf4AAunmvZNx6h0+qO8TZNPVdndjihXbo91shUs
         9P+g==
X-Gm-Message-State: AOAM533+xUD/6sd5dKamo3nLJUaXf7hwAUnROhfeT2WVTdIh9eZUXdsb
        HL6lUGyFcwowQrXv6BVrwhxTarXiIjX5zQ==
X-Google-Smtp-Source: ABdhPJyquHBMXq45CWAoL4i5Qxzpl6ZPp9mXEwyRA3oC36NFgwnh7A5V+o2a2fYzg/aAoEKWJ9BrwQ==
X-Received: by 2002:a37:a783:: with SMTP id q125mr11291699qke.10.1605466276875;
        Sun, 15 Nov 2020 10:51:16 -0800 (PST)
Received: from [172.17.0.2] ([13.77.84.86])
        by smtp.gmail.com with ESMTPSA id r18sm10717090qtp.89.2020.11.15.10.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 10:51:16 -0800 (PST)
Message-ID: <5fb178a4.1c69fb81.4f84a.b6ef@mx.google.com>
Date:   Sun, 15 Nov 2020 10:51:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3172889633092105139=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jimmywa@spotify.com
Subject: RE: [v2] Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201112140326.GA139401@jimmy-ryzen-home>
References: <20201112140326.GA139401@jimmy-ryzen-home>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3172889633092105139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=382789

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
Test: CheckGitLint - FAIL
Output:
Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C.
1: T3 Title has trailing punctuation (.): "Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C."


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============3172889633092105139==--
