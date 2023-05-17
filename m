Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78053C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 01:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjEQBd3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 21:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjEQBd2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 21:33:28 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E148E3C01
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 18:33:21 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f389c519e5so2212031cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 18:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684287201; x=1686879201;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=znBpPa0Jx3TD2WpHsQW5WcqEKnWs6Dx+UPoEDe+pkso=;
        b=nqCXpmIR1z7+BqxYIg400YF8jOuWp1oKPgDonQ4b4ec6tFa89Vr1hQ2Ow7ImiG9nhW
         m8WWEZUzHV70mfHDmFDKS8qOuNxxOxeLxso/hxEVJjI8sb2rb/OrZbMJ9puTspoBE2V0
         yfJes6XieL5+L+henp2L1PdpB9gIqNOOb9nNmnbpJbggLQc1v9P5ZO/6Mbt2iLdgBupN
         3o8qYBkLMU63VGapk5bCHkv95yGLFWfEX1m9HNn10N2Oxc+D28jKO0WwyXCymYL221a/
         McGbdM+9nP7WURM6G9CCaVobgg5CAAIhNNLukwwjOYQZQIkhssaPvqz2luQxU1dMHoJX
         xsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684287201; x=1686879201;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znBpPa0Jx3TD2WpHsQW5WcqEKnWs6Dx+UPoEDe+pkso=;
        b=WxIT3zAYl1X2YZ/DD4QZuaUBzaJfNpubRSmpZfjc/9n6NKpqIrLjjoRRSEmzI7eCeT
         dmAt8mX6OBwxSsjbs2Ll2tqJqZYjqF8EXmRszBu1vhsWKPA3C7pSXmtCTALVhUKoy2SO
         krfPJF1ey+JSYE2coeX4OhgwHR2/00wRp4z4q4eXwDuS8qW/hgJ/jWvh5JkoWphnV+Mx
         1Jt6+EsicPGezepLDg9G8SGHmr8PxsQXP8cQLztK4ZwDk14lo3pzqNmC+qwj17uxfFc5
         ejY84pKy5pTPmINBk+toJmnwGdeJzAWeQHjctc69FyaTqCYC7gOciVlCjrzD6gLuV2x3
         4R+w==
X-Gm-Message-State: AC+VfDw8WsDe6PDTRcWYeD0o2LzPfeQN3Fcp6+XCs0YmcKf/z7JOZsrh
        aZSjmiPi/Vr/BZlQ5tF/D596XCYtT0I=
X-Google-Smtp-Source: ACHHUZ7VC/0AHZO7Y+XJlQlWPZzGqtXe3WpU4hjB4DLYnTYFWx8cFlcMPwxCUDVwBsmcXJ3V5phtKA==
X-Received: by 2002:a05:622a:1a1d:b0:3f5:39a7:1b9e with SMTP id f29-20020a05622a1a1d00b003f539a71b9emr12234714qtb.56.1684287200801;
        Tue, 16 May 2023 18:33:20 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.50])
        by smtp.gmail.com with ESMTPSA id cj25-20020a05622a259900b003bf9f9f1844sm6672747qtb.71.2023.05.16.18.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 18:33:20 -0700 (PDT)
Message-ID: <64642ee0.050a0220.71e9.2a62@mx.google.com>
Date:   Tue, 16 May 2023 18:33:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1901841180680565683=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,01/10] profile: Add support for experimental flag
In-Reply-To: <20230516205924.1040506-1-luiz.dentz@gmail.com>
References: <20230516205924.1040506-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1901841180680565683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=748169

---Test result---

Test Summary:
CheckPatch                    FAIL      6.73 seconds
GitLint                       PASS      3.96 seconds
BuildEll                      PASS      35.64 seconds
BluezMake                     PASS      1248.12 seconds
MakeCheck                     PASS      12.92 seconds
MakeDistcheck                 PASS      205.33 seconds
CheckValgrind                 PASS      331.37 seconds
CheckSmatch                   PASS      451.09 seconds
bluezmakeextell               PASS      135.40 seconds
IncrementalBuild              PASS      10357.78 seconds
ScanBuild                     PASS      1362.35 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,07/10] plugin: Treat -ENOTSUP as -ENOSYS
WARNING:ENOSYS: ENOSYS means 'invalid syscall nr' and nothing else
#101: FILE: src/plugin.c:189:
+			if (err == -ENOSYS || err == -ENOTSUP)

/github/workspace/src/src/13243878.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13243878.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1901841180680565683==--
