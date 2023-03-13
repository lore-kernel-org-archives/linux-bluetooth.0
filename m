Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC6BC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 20:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCMUlR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 16:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMUlQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 16:41:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45BE8C523
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 13:40:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so5516421pjb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678740033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QEhBHMYf7fOZcGaphzmQmyiYW1dEDLtiZvp0J3GaagY=;
        b=MdY/Ei3oiaziXimJmH8GVFPm4ZZfhNSCK0DNHj5pQMIhjzt95zqzAylyVGnGivkjT2
         SPV/HGI9UvYgz2NWXE/TobG/GW8K56C93snyoVk8mgETedQBFbDGbKSGYxGdlrCBLKW9
         LyLKmTDGT/dOE61xRoad1GVytCmLc8Z2O9U0buog1aoPZ5voU1dS5Lmhkhju+HSTFLez
         Y1byhREUsFenZDnEMcIpTitCnB9ZUox5zkSzxXBOQbsEbl80iliS6RCfPLj9wCbqYMp/
         HBGFMxc6EC6+KgPqXJLrI9pN/2rHr8reaSrbRj0ZpSMaypOKvLh9INIeF6fmIpCXOgtq
         FpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678740033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEhBHMYf7fOZcGaphzmQmyiYW1dEDLtiZvp0J3GaagY=;
        b=RmolnJjUeSyCIA9irfvezF2d2lrDpNDwMoUDrRiFyX0AVv3ozjwU71/cafuhAOf4s/
         0TdAsDRQrxGbTgW/euSpwm/aT2626pbsU3hDtbchqDKChu2O44fZrj+jO3esE/ZYVT9D
         VCQfgyg7nTdTskgX3XGK1eFhMijaCtqBTxNtFLJC1+HLAL5MML3HFLK89Wkc+djLGrf6
         g2xt+OMWsAS4BZd8PK3SQutvIu1LEEewjarCZnd2aPlm+zWlGCzIpHTY/28OcEQoWwEI
         n3kYfLnmXG1JPEqh+kpncZuy6V/+7ARuGwMNOSEup78oTEHu3F2PJSdvxEwQwypbCEZ3
         JlpQ==
X-Gm-Message-State: AO0yUKViGuW+FiVgDuYQEoZa4LMF6RCx5uzMfPsmUbbbwi2MBEcQnuCU
        Bct/SkIrKh3mUnevWlsczl4q2aBgZ3Y=
X-Google-Smtp-Source: AK7set8XtVISjQ4mSkcYhhYFrI9Lpmj+jXipWuQPl+ADuT/SsbDdwg/aVHCkYA77jbI5Yg9RLcKKoA==
X-Received: by 2002:a17:90b:3b90:b0:233:fb7d:846c with SMTP id pc16-20020a17090b3b9000b00233fb7d846cmr36022024pjb.9.1678740033219;
        Mon, 13 Mar 2023 13:40:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.70.65])
        by smtp.gmail.com with ESMTPSA id lj5-20020a17090b344500b0023a71345b26sm300132pjb.13.2023.03.13.13.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:40:32 -0700 (PDT)
Message-ID: <640f8a40.170a0220.b1a0b.1444@mx.google.com>
Date:   Mon, 13 Mar 2023 13:40:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4591214244685445983=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Subject: RE: [BlueZ,1/2] mesh: Fix uninitialized memory usage
In-Reply-To: <20230313190808.48102-1-brian.gix@gmail.com>
References: <20230313190808.48102-1-brian.gix@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4591214244685445983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=729587

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.51 seconds
BuildEll                      PASS      26.19 seconds
BluezMake                     PASS      755.85 seconds
MakeCheck                     PASS      10.79 seconds
MakeDistcheck                 PASS      147.44 seconds
CheckValgrind                 PASS      239.95 seconds
CheckSmatch                   PASS      320.15 seconds
bluezmakeextell               PASS      97.47 seconds
IncrementalBuild              PASS      1211.06 seconds
ScanBuild                     PASS      958.65 seconds



---
Regards,
Linux Bluetooth


--===============4591214244685445983==--
