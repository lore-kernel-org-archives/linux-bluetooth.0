Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669FEC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Nov 2020 18:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6B72225B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Nov 2020 18:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilTk5Yph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgKOSxO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Nov 2020 13:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgKOSxO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Nov 2020 13:53:14 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53603C0613D1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2020 10:53:14 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id e21so10712973pgr.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2020 10:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=G8MDUXC9eyP3LGXcK2fKjpwOPFwzl7rZYA67YhbO85U=;
        b=ilTk5YphKoyyII5ytyVDyQUKlVwuVuOjfugAz2AbVu/sgR5wXiXYwxXWqDFmKMblSH
         twr1j2uXECczMOJH1wN8QbrxCxfcCvBmp36V5ntcachrj4+nGnj0xr5+4UL9MGSreS03
         Eo5rkxdlLzc/5LE3z+xQ+PAQ1nDBtbRvpkuDJycjvRSeE9iV67X3mfNQ3ZVF5TDZS9JI
         Gz7GBBznDEfKX4HFLLzinxbIa4nLkbs3ih7RquFysxc8cxihQmenyKWupLoKPqEw1jg2
         SyV+pzvsDF5I7g04VsUWPWNCKCOrUgR0YTIGOgqk6InEDs9ye5XnAJf8PkCFnVFI8ix8
         dL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=G8MDUXC9eyP3LGXcK2fKjpwOPFwzl7rZYA67YhbO85U=;
        b=joYWhnPI2pfFwawQDsXsf9ZrHToUaJJU/IHS1wyW+O3qREhDVfMkSbOpongO2LeIq/
         3I1JbKLBUeIeElShWoglKjWxnNhkcd24Tqzud6t3/V8xCEPgBi9jt7MA8sVgwD/xdL1A
         ADPWkgvhp6tYbU03/MXZ6/ZcIJOBWPrBbzEmJpdfAX2sdYOcWkacZQC+b7fcFfkIcy4m
         Ops5cAXSBJPKcBb4z7ZlmUCkThvZVyPHta+6Pp2sFl1zGqMoCp0vjtq16mUTcUIeiUZS
         /feo3UoYIImZMFBRInPbjkgoutjAjE7V9802iiXv/tH6mF488nq90xgijSFAd/EJwjcN
         KD8Q==
X-Gm-Message-State: AOAM531NYFeohIkfyKJT2roLiIwh6KIN2pzySs7RHweDy+Qg7iPMlVAw
        Td77N8RHpwB6tttlBSVlPgjL5uTUDhs=
X-Google-Smtp-Source: ABdhPJy3Z8jKZDtKF8tJNGemXWW1oqLDsUmlcs7gEh1CpDy6vS7RcnNT9eLAMyV58z3IDp/HLFYGfg==
X-Received: by 2002:a62:6304:0:b029:164:38fe:771e with SMTP id x4-20020a6263040000b029016438fe771emr11116560pfb.1.1605466393682;
        Sun, 15 Nov 2020 10:53:13 -0800 (PST)
Received: from [172.17.0.2] ([13.66.227.210])
        by smtp.gmail.com with ESMTPSA id 144sm16118488pfb.71.2020.11.15.10.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 10:53:13 -0800 (PST)
Message-ID: <5fb17919.1c69fb81.9867a.3179@mx.google.com>
Date:   Sun, 15 Nov 2020 10:53:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4494306410699215487=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ap420073@gmail.com
Subject: RE: [v3,net] 6lowpan: set .owner to THIS_MODULE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201115102714.30412-1-ap420073@gmail.com>
References: <20201115102714.30412-1-ap420073@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4494306410699215487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=384377

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


--===============4494306410699215487==--
