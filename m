Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92342C46467
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Jan 2023 15:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjADPgP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Jan 2023 10:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjADPgO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Jan 2023 10:36:14 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F2167EF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Jan 2023 07:36:13 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id u8so19605605ilq.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Jan 2023 07:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=72TfXogHlGK2K/TPjBoWF38ebDvLpa6Ktc7muhh+1tY=;
        b=Z2+Q3nvmx0yHNFc5/6Thxk7invOmbM/XsbYF1A3N5Z2KZx/itcxvX2GgF3DrEl2jQh
         XNmODENzKWDOGODZIzJj8ydTxlsA5u4OwJ/k4M5XzQitQm/vjqY+MygDH4S6rJp3djhx
         QBhCiXKDdcFMjd22e4/htvQM7bNK/3x3B0hK3d0vjxStQtPuMmY2CHOZLf2NfRdV0X8O
         kPXia/keDxPP+v5i9iacscwqPP9kSdq2fQSDSJGxpWCn6O8LVTBjTeHLs8FvxYJyj846
         51GpHdLccWpFk7ezBiJc7OdDI2XNuFcj6cYNfPhuThgCTogKQTnr30LczX8b/JetVk4B
         KifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72TfXogHlGK2K/TPjBoWF38ebDvLpa6Ktc7muhh+1tY=;
        b=hEiBZg2je4Xi3rAI/5iakK84ST5JLCsytsOMTbMDsWWtzQ92D2HytaiiyMMN/9jTxe
         vhrkp47yNsjiGNI8Ez+xuZFgwVK3ta9fuzAk2xEScDRwsD5CGiqJu0O2XvWPEfxyMBrx
         ywjqJTsHi+Qb25lkRtGiw5B6WvfjLmG4b4vydKnP3eedCPQWNRwocw0gde4drfeMESHk
         9x5bI4QhB3ImCSA0zmcyTons8/kzLTNy+GQHdZMT7zubfcm8bWjQP2WlgnC68cacYfKp
         rMTcmr3JTf+OT888OCzfsv2ToQS5mTVN1yGflNkRZeO/qNfHDHyrNmemjldUOD7eEO8o
         B1iw==
X-Gm-Message-State: AFqh2krnRnI7uoutWmutxol6zWs2piWxwmByHGKgS3/VE+PQfw9JIMCy
        PND4cgqTgsfSMX4Yl+11LzbdKJZNAuA=
X-Google-Smtp-Source: AMrXdXvL4XakHJV4f+MxFMGdXp3Ou9ZuIxOF4PLUETp6N7+pJSDGEy7XKk+jJGv+cpAjClyOmhhJ5g==
X-Received: by 2002:a92:c84c:0:b0:30d:6ea8:559e with SMTP id b12-20020a92c84c000000b0030d6ea8559emr1968032ilq.20.1672846572935;
        Wed, 04 Jan 2023 07:36:12 -0800 (PST)
Received: from [172.17.0.2] ([13.86.66.37])
        by smtp.gmail.com with ESMTPSA id m5-20020a026a45000000b003753b6452f9sm10472286jaf.35.2023.01.04.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 07:36:12 -0800 (PST)
Message-ID: <63b59cec.020a0220.20d26.dae8@mx.google.com>
Date:   Wed, 04 Jan 2023 07:36:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5046152262235559819=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v2] Bluetooth: Fix possible deadlock in rfcomm_sk_state_change
In-Reply-To: <20230104150642.v2.1.I1f29bb547a03e9adfe2e6754212f9d14a2e39c4b@changeid>
References: <20230104150642.v2.1.I1f29bb547a03e9adfe2e6754212f9d14a2e39c4b@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5046152262235559819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=708835

---Test result---

Test Summary:
CheckPatch                    PASS      1.16 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      32.55 seconds
CheckAllWarning               PASS      35.19 seconds
CheckSparse                   PASS      40.03 seconds
CheckSmatch                   PASS      107.60 seconds
BuildKernel32                 PASS      31.41 seconds
TestRunnerSetup               PASS      447.97 seconds
TestRunner_l2cap-tester       PASS      16.79 seconds
TestRunner_iso-tester         PASS      17.57 seconds
TestRunner_bnep-tester        PASS      5.89 seconds
TestRunner_mgmt-tester        PASS      112.75 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      8.45 seconds
TestRunner_ioctl-tester       PASS      9.99 seconds
TestRunner_mesh-tester        PASS      7.57 seconds
TestRunner_smp-tester         PASS      8.36 seconds
TestRunner_userchan-tester    PASS      6.05 seconds
IncrementalBuild              PASS      29.68 seconds



---
Regards,
Linux Bluetooth


--===============5046152262235559819==--
