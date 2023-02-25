Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F4C64EC7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Feb 2023 23:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBYXb7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Feb 2023 18:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBYXb6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Feb 2023 18:31:58 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE5516893
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Feb 2023 15:31:57 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n6so1841453plf.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Feb 2023 15:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677367916;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sy92vwD4lBjK1sF//341s6b/f+QPbs3O1iYrf21UBtM=;
        b=lED12jXhD49ATx3PjAGxtoVnrT8nqbkn7QVEQ7oV7iu2bXxfUdfkVDp+EuzwXEK0FO
         azG7kaHmEdzEakJR0UT7IBfSUaxkVC530+oYfZa1VdPXKqdxFYbNauK4OWsGz1gZZhZW
         msSvhNcopw2CqoT6SrmeCSn9563ONk6IGr0XOkF32FJ4DzkbMbb6X2aqKFTWePEK5V81
         Nokhc8lqUCPLoBeWIDDkgBpW2N6KzZ2XIvtUgEZz/eSuXQTLbA1pUvGcK6qsjQxISKSQ
         tBbUod3WyGICQ2vqc2p9LxHj0GSIYRV7tFXbGZ0yq4AHI7+MtYVPTulrnYBWq4OTOjfW
         LV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677367916;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sy92vwD4lBjK1sF//341s6b/f+QPbs3O1iYrf21UBtM=;
        b=VxxlJsrLukAsgoAtXkA2vj7UcDx4MQOLQ3wKR2WkO8owZkNhC76wv+q7xcAMvYUNls
         2ARJgJhzg0p94yDbzSOQREdpPUuq0onzpANdywHqTWY9U+IrB7fvGObAM5jkPL+5PYK3
         08k1joF6S+H4YikdKX1f4vf9venuVAZdUt+6ulL13rtiOKaYpEgKJLpKfFM+pGOx+xG7
         4vgB+M4RfRFJij6/PMCE0eMH+PSoywha8uueoY7NV2XCQb/1sYQT/t5bkE+KTP1u5M/+
         BaoYtYpM/QfhjyjFj+Zr66HUj32UBysMFztLYsVUVFcQ8X4gOLKhKM04LQeF2aEgFUmb
         RcVw==
X-Gm-Message-State: AO0yUKVRcxBDuWDQSwDR+dVDvoxNzRWBrMwW/QSHvk8LL+L/se7LAali
        oJQpYABgtGQqFbOZIJaZCm02/C/o++E=
X-Google-Smtp-Source: AK7set8vRHO/flG/uO36mQyBMoFJBAf+BQjPyo5fACxGBIOPwNbd3d13E0y2sKN/VZGFHTiZCw/ZRA==
X-Received: by 2002:a17:90a:ea05:b0:237:91df:9fcd with SMTP id w5-20020a17090aea0500b0023791df9fcdmr7421961pjy.48.1677367916276;
        Sat, 25 Feb 2023 15:31:56 -0800 (PST)
Received: from [172.17.0.2] ([13.73.50.81])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a348200b00233567a978csm3575713pjb.42.2023.02.25.15.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 15:31:55 -0800 (PST)
Message-ID: <63fa9a6b.170a0220.18ec4.747d@mx.google.com>
Date:   Sat, 25 Feb 2023 15:31:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3545130371954229979=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] bthost: Allow sending ISO packets with sequence number and timestamp
In-Reply-To: <b071b484b1b199ad69412ca0b2610c9c75fe7181.1677361002.git.pav@iki.fi>
References: <b071b484b1b199ad69412ca0b2610c9c75fe7181.1677361002.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3545130371954229979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=724874

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       FAIL      0.81 seconds
BuildEll                      PASS      30.91 seconds
BluezMake                     PASS      956.76 seconds
MakeCheck                     PASS      12.69 seconds
MakeDistcheck                 PASS      169.88 seconds
CheckValgrind                 PASS      281.35 seconds
CheckSmatch                   WARNING   371.67 seconds
bluezmakeextell               PASS      112.03 seconds
IncrementalBuild              PASS      1553.96 seconds
ScanBuild                     PASS      1146.92 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/2] bthost: Allow sending ISO packets with sequence number and timestamp

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B2 Line has trailing whitespace: "    "
13: B1 Line exceeds max length (111>80): "    https://lore.kernel.org/linux-bluetooth/1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi/"
14: B2 Line has trailing whitespace: "    "
19: B2 Line has trailing whitespace: "    "
[BlueZ,2/2] iso-tester: Add test for central receiving timestamped ISO packet

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (113>80): "Link: https://lore.kernel.org/linux-bluetooth/1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi/"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:583:28: warning: Variable length array is used.emulator/bthost.c:740:28: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============3545130371954229979==--
