Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D75C4321E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 18:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiLAStG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 13:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiLAStE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 13:49:04 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB554458
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 10:49:03 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 130so2714411pfu.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 10:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DXOO7C09+oJhyAn7CtbXv0hrqHWtJrYdpk1h3VMEARk=;
        b=Z3iu/CCk0RfqO/QMPok3+zF+MqAYy1zTk5mYKi8kSi3qrpqOXKfPeEtNzCdT6N4+O4
         ITDRHxpmnxNrRXC/8Yr4JA7/Uy65/bF8oGIGZFT/Hf2nNkDGjwV+1nwK9CrpQf/4YMya
         218GLGxeQ6J46s9mVNCJ/v1z96N/eTTkGcCXFfMvEXqT2fL+8EhlmUYEv11ScWRQ9yUk
         2rcmRs1g0/jotzfQPYlPLdwIwwFGxqzw3XHKOZHvC3TlH9SREkavzqkigL3rMBmRhow1
         6jsBWzoyvlMUWaKqlt7ly1rvIccCuSSSCZhq/GWi0YE5aAAbGG+PwdtjH8fE1indRTwg
         Hczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXOO7C09+oJhyAn7CtbXv0hrqHWtJrYdpk1h3VMEARk=;
        b=dh7IzjqPS5FOTUExMr0M5aPw4NQWc/7F59HQQSu2uxwHwJgSnp7w7bK9wIYIkTdUYH
         3l7L3K9XN8ieOlIwJn+3UjQDPzAEymM8rV331+csqa0YyLVh4YZcaYPtE3NchOihzh/o
         tFpf+LZfHsgoehG8pEUMyT9beYYYwbGK+PWODi9c0VT48h0uiZ3qM9FuMPvHo4JnpwvY
         zp4hUB1H/9KotHMK8kkG65WshBLMpRDYwRO2Chyh7oRTEO5Qjiy0x6T1oTewYc7RK4Yf
         vCqAFa11Sndgw2hZypicQ23VlvCd96r+o92IMifj2LFQex/HHQCcoYUd4QlxYERxuLYI
         0bdQ==
X-Gm-Message-State: ANoB5pkwCmjPJLgxqT0wS03B3pTziycnAjJRYFY8u3iffnmp9vpbbWeb
        pbcs1RkH60/C+2GB11WrdWtgCULsTdM=
X-Google-Smtp-Source: AA0mqf5NbhXZzPxVfPI1c4yz/CXNT71wb+9zf8UCLxr36jaN8IdDGRWkaL2+smHm156rLhb5Bop8tg==
X-Received: by 2002:aa7:86c7:0:b0:562:45f0:df50 with SMTP id h7-20020aa786c7000000b0056245f0df50mr49611334pfo.16.1669920542874;
        Thu, 01 Dec 2022 10:49:02 -0800 (PST)
Received: from [172.17.0.2] ([20.66.126.119])
        by smtp.gmail.com with ESMTPSA id t123-20020a628181000000b00561dcfa700asm3569001pfd.107.2022.12.01.10.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 10:49:02 -0800 (PST)
Message-ID: <6388f71e.620a0220.7b7f.74ce@mx.google.com>
Date:   Thu, 01 Dec 2022 10:49:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4670230595142554821=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, allenwebb@google.com
Subject: RE: Fix git lint error
In-Reply-To: <20221201171613.1819631-2-allenwebb@google.com>
References: <20221201171613.1819631-2-allenwebb@google.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4670230595142554821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=700921

---Test result---

Test Summary:
CheckPatch                    PASS      0.35 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      34.37 seconds
BluezMake                     PASS      1186.40 seconds
MakeCheck                     PASS      13.08 seconds
MakeDistcheck                 PASS      189.04 seconds
CheckValgrind                 PASS      306.64 seconds
bluezmakeextell               PASS      124.33 seconds
IncrementalBuild              PASS      986.86 seconds
ScanBuild                     PASS      1316.16 seconds



---
Regards,
Linux Bluetooth


--===============4670230595142554821==--
