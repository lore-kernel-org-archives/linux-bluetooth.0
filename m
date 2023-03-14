Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A7C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 20:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCNUcS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 16:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCNUcR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 16:32:17 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CAB51F8F
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 13:32:16 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-176b90e14a9so18717733fac.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678825934;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mfw9cT7SIQhWP6RJdrtm/3jW1mMw+s2bOWun7o8BVPo=;
        b=A+emvUsRBUIG7wHEvURWykaPQY720usGsZ/RIcnilMrnzTS8e2MwBJocjiYw9LSyP/
         8SNN+9QtvedZN2Zwc2nC+ZYrWrf69andi6sdaoWTBH2AcFexpCGk36707uaKBltKMWNM
         eBfcrr1w+JVeL6phEdcGAXiTUc8DXeOcn+8S5Kp8WVRhVYwmkooauTn4h2yNivs2vWrJ
         mYfgRmndGn7rldjDNrNzKFafS67KIF1/HWzlDIbakQFxdo6GJzXFRx9okH9oxdYteEx+
         Rhon9+etvr8yHH3CV2nr+6yyOZtns3XqFDLtsm0G2T+AQogm2xO+c2STteMTBFO4imIW
         UVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678825934;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mfw9cT7SIQhWP6RJdrtm/3jW1mMw+s2bOWun7o8BVPo=;
        b=JaYkkRCvMEbFMLoCqiP19KYXMF3xvkpPv3HLL27ugh+qzpSU6BuMFwFENWZYvJ8P+P
         h9kv8e+mpLHkABUoE334FAstAEQ0wIPz7AXs+eUsE7SYI/IKxPliTusOiaId547iSrMP
         d2Dt5vJ+wvTBuKr/YqkT2qeoVyJVN8gVAGNQh8nDVJX1fpSocmwSZwBxSWa7v2hNcez7
         GNByWAMiZm0AK+ZcgRbOemEhjwjiAZI7tpThPsuOEDoXTwtkVxHjpCeVJfUDcyLLMiGq
         kwachsUb3gt3vqTUdywPNdN2vp7I6FxdSoooM63HvwG8k06iLDOHm/gYvNdKfxl9JGlg
         VuZg==
X-Gm-Message-State: AO0yUKUvY+RIVEorGKP3/cn1BLTtWLEp3gl3sjdixe6/9Lj7z3Ji/zyw
        oGpIQe36jTjV9WY2B76WA1KQFQVEV8Q=
X-Google-Smtp-Source: AK7set8sNQTN6OPHZeirZ+9+xVEcbd9Wv6mJVtvCmLxpNo8wmucNVZsU5TnlW3HhkV1IYUDHRP5Ccg==
X-Received: by 2002:a05:6870:50:b0:177:c8dc:501f with SMTP id 16-20020a056870005000b00177c8dc501fmr2996103oaz.29.1678825934638;
        Tue, 14 Mar 2023 13:32:14 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.132.87])
        by smtp.gmail.com with ESMTPSA id c5-20020a05687035c500b00172428894e0sm1507316oak.28.2023.03.14.13.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:32:14 -0700 (PDT)
Message-ID: <6410d9ce.050a0220.1e400.7fc5@mx.google.com>
Date:   Tue, 14 Mar 2023 13:32:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6865216162000439484=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/gatt-client: Fix crash on bt_gatt_client_idle_unregister
In-Reply-To: <20230314192325.464661-1-luiz.dentz@gmail.com>
References: <20230314192325.464661-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6865216162000439484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730060

---Test result---

Test Summary:
CheckPatch                    FAIL      0.83 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      26.48 seconds
BluezMake                     PASS      751.63 seconds
MakeCheck                     PASS      10.76 seconds
MakeDistcheck                 PASS      148.57 seconds
CheckValgrind                 PASS      240.05 seconds
CheckSmatch                   PASS      322.03 seconds
bluezmakeextell               PASS      97.02 seconds
IncrementalBuild              PASS      627.67 seconds
ScanBuild                     PASS      968.28 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] shared/gatt-client: Fix crash on bt_gatt_client_idle_unregister
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#90: 
   by 0x48BBC7E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.7400.6)

/github/workspace/src/src/13174960.patch total: 0 errors, 1 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13174960.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6865216162000439484==--
