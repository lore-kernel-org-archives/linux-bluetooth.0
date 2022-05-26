Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F11CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 12:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiEZMDX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 08:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiEZMDV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 08:03:21 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300E1D02A2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 05:03:21 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2cbceefb8so1878828fac.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=yMw5Z6A2gPkKSiVkD/jui2/6d9UG/C8m60pM/Nwk5NI=;
        b=pUkChCcbBWRyLzDJxAhosrAExVAY6MwZs85BSQwNHcAojYR1nKmZ3krLKhEV7xcf5r
         ockbc6/pbuDGhBeflV2kAzmQs4vZv+pD/kMyRzJS8s5G/BA7+D5Dz0bxsJqTTdDbx0RM
         l8FgtOEKDPsv2FxXRrt0VIN2Yf2lDfWS8ONZ+2td/wB83+AlaiIAkTVYqOHehtX2YuPt
         O3WsaFOuXp1F9t4ToBuRtxLFy4rA2u31lpclQUw6vfZswoOEhJ+l3XjyOL79nih9EDo+
         0mWmhdR+PI+W+NBeV6hyIQwoE2daIbC76PiLrdNTM7Wjmnxs+nWWGHCs04egNoi4jVm0
         SeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=yMw5Z6A2gPkKSiVkD/jui2/6d9UG/C8m60pM/Nwk5NI=;
        b=lBn3/sSYQL8UannfjdrtNhdmekhHOcjO3yKj+5bZd5K4WFsX2BvtdKaNN4vGfKD//Q
         pOjQU8gLsQipCZuzsW1Qt9AcK5n28Xw8hNzHjhrLxD6uB6UxMs8EQMncrnY5ZsZnrEnq
         CFD2S5b2OuceMcKEFrOG9jL+hNBzcMMGF6uoM1SyOTth6uc4NH3w44XpcBEnDPWYWNtl
         korelG9b7kXVPH6j1GyO3CIyxLLxImCrACZq2vj18c53giavhS12byxucAXjAjov10he
         j6Ou+RIT3SAQyZQvCZMWTM9HNL6R3iegYZeR4RPZuNsZ7l7HKhFV4z3ShLM603fP9cV0
         L5mw==
X-Gm-Message-State: AOAM533G8mW2bi2rsqGNKfKSQ585ivSSSHESAilR0oX5yQD/oOKE+4MN
        9bMriF0owhiBSKsZEbXshf2GJqZXbSk=
X-Google-Smtp-Source: ABdhPJxUPfRSpsPSBfEgGDy+woKA/pbIYXEKDCZtbwS0EbHv9t2mCwB+y02vwtHDHEWFfZzBjQelOQ==
X-Received: by 2002:a05:6871:782:b0:e9:6563:e477 with SMTP id o2-20020a056871078200b000e96563e477mr980780oap.62.1653566599874;
        Thu, 26 May 2022 05:03:19 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.164.140])
        by smtp.gmail.com with ESMTPSA id lu16-20020a056871431000b000f2776dd2acsm525381oab.27.2022.05.26.05.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 05:03:19 -0700 (PDT)
Message-ID: <628f6c87.1c69fb81.afd91.37a4@mx.google.com>
Date:   Thu, 26 May 2022 05:03:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5733589955623290384=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [v6,1/5] Bluetooth: mgmt: add MGMT_OP_SET_QUALITY_REPORT for quality report
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220526112135.2486883-1-josephsih@chromium.org>
References: <20220526112135.2486883-1-josephsih@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5733589955623290384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=645247

---Test result---

Test Summary:
CheckPatch                    PASS      8.97 seconds
GitLint                       PASS      3.75 seconds
SubjectPrefix                 PASS      3.14 seconds
BuildKernel                   PASS      35.18 seconds
BuildKernel32                 PASS      31.16 seconds
Incremental Build with patchesPASS      139.43 seconds
TestRunner: Setup             PASS      531.60 seconds
TestRunner: l2cap-tester      PASS      18.61 seconds
TestRunner: bnep-tester       PASS      6.66 seconds
TestRunner: mgmt-tester       PASS      108.86 seconds
TestRunner: rfcomm-tester     PASS      10.21 seconds
TestRunner: sco-tester        PASS      10.05 seconds
TestRunner: smp-tester        PASS      10.13 seconds
TestRunner: userchan-tester   PASS      6.89 seconds



---
Regards,
Linux Bluetooth


--===============5733589955623290384==--
