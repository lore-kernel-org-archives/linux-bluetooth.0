Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA9CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 18:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C89206A4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 18:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbhADS6G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 13:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbhADS6G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 13:58:06 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49D6C061793
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jan 2021 10:57:25 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id y15so19212898qtv.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jan 2021 10:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3JN5ZCdGXS37uC6d6DI8PVKD8KsPpg1n7e7tkzUB2gY=;
        b=iNHUh2Ef0X/OJtTYIJ27IUD49t6Tq1C9smbjHuWfijq8VTH8D23+eFs7hiwLASQpUK
         TM9SRIDpUto2fP0Hn7ajU3JsfVJNhRkLW4GGX0uV+Qd9za5RBvkFJb/urQBk46Bsqp7H
         oAFbv/iJb7fZ8XTty0VZetX9lXYd3UI0rJoZlMBezj7xzI9G2mObQv66ulSRfhhN/Vfe
         bLvAhFSElfxgrVOu2XZwLSc5lzr8X7dmYKESdHYLWu91V4KXjL/HuIa7KJhILOGg+3dW
         0ZtJyl7ma1i3ma1KNb1VI2VH/fz52JSHEinPSUv7GdpzJgSYuhIDX/Vl12EnEB7l3eW6
         0WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3JN5ZCdGXS37uC6d6DI8PVKD8KsPpg1n7e7tkzUB2gY=;
        b=Rrw+/vn3OY/76XZRdugq4+YfclxUYfIEDk4R75VU+8d7KIGvKTZXFmVvo9hleFmcq9
         k7TlIyEJFQpNOWlAZgp1zC1d83vfQxCZQNtnCWNPiZnGZIkWDAvg5DVRdMDgHo49PGr+
         RxGJNm5QdxJ19o1la2uGLZEBvkAYpMUQjgTNpSMXP+uLj+opB5do910E0EfAIlA4uzLX
         LTYgRXxD+xGoTeqhazrMmIfPBUC1qrZcaq7RZdxPaf9106N7jyvQZaQvMo36pwQueUNG
         xFTxTlvBmFCH2YoamIGBGXr6MnVx5LgiPdkxLnIx4NhnLuJ2MeEWaZF7JE5zQhH2ZEd1
         McBw==
X-Gm-Message-State: AOAM5319M59GzlNKrrRFrJTRwoblsZW0QGkCTuUyBUh+jCqJ4SuTHyV0
        ZOb/GxsHoMURAh3BV8vFS8RJjCG9soJBww==
X-Google-Smtp-Source: ABdhPJyNJoI1zETdSlIyhXFfBZdkxcFE/GDK5wm/9e9QSuDsxMl/dJcF3U737uKwvt8zTMhor+24eA==
X-Received: by 2002:ac8:4991:: with SMTP id f17mr72710731qtq.210.1609786644943;
        Mon, 04 Jan 2021 10:57:24 -0800 (PST)
Received: from [172.17.0.2] ([40.75.28.48])
        by smtp.gmail.com with ESMTPSA id 17sm39989891qtu.23.2021.01.04.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:57:24 -0800 (PST)
Message-ID: <5ff36514.1c69fb81.72554.adc9@mx.google.com>
Date:   Mon, 04 Jan 2021 10:57:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5296151731496204118=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] cfg: Add check for newly used function in ELL
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210104183813.573731-1-brian.gix@intel.com>
References: <20210104183813.573731-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5296151731496204118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=408789

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
cfg: Add check for newly used function in ELL
WARNING:TYPO_SPELLING: 'dependancy' may be misspelled - perhaps 'dependency'?
#6: 
ELL has a new dependancy for rawmemchr() which needs to be accounted for

- total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] cfg: Add check for newly used function in ELL" has style problems, please review.

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


--===============5296151731496204118==--
