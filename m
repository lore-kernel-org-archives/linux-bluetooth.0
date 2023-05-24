Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE746C7EE2D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 May 2023 11:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjEXLdz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 07:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjEXLdy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 07:33:54 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEBD12E
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 04:33:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38ea3f8e413so76439b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684928032; x=1687520032;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C7V/2rblxPTdCyxJUH0Ms+oTVyti2bfAzf6+2HvNzOo=;
        b=mZdRvMzzhayARP6t5mw2kM9dudlEOnXwQPK6bKwJdOqmmDdunGg2cpe4OpWQDu1oGv
         zz2ZnEFftH+VPNmZYzxrTVZ2twINz1oBf9Elp3EXCODMtGB54om/olaTPd/FUeVceTB6
         kMoVHo5lyUCQZOtH06CqqEr/zB7olTFcDX6WC/mdRU+31fNbKkYM7U3EnFcjfIelc1F2
         aBa9FT/h91m7Eq64/UCjgasOSU7hsv4kUWCuf92NgrFnXBMN3R91LhtIMUWYBZuXJrwl
         TuzUiwz3V3AWMPUqGlDn9nl3KV/6rXwxjYQfb5WX56cPcGEy/GN0rf8Owk2tbwQAUp92
         fWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684928032; x=1687520032;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7V/2rblxPTdCyxJUH0Ms+oTVyti2bfAzf6+2HvNzOo=;
        b=NcjeE367nbF507qo2FUCnB9wCpA+1LILjmEggnuXEMIunvMqTkXRupjxV5h3TWLTh+
         RffJ00ZMv/+NgGPkLuc2XMy+2xoDyvGtlCLv/jgVHkDpqZjrmKLf2IW5t/cBSRidSLxx
         laEf0MpXCuQwd7R1JCvTjDVkfZBuuzHA1kPmSwkOkb7qOPqrimOQj3DCfQXtlONvVe79
         K7G/TZ6CQkg1jjk2cOmJepU4qJoWuIULyMGKlvCxxbD8XTHybp0WQFuzKOXkEsf6FJ0f
         dD8OH9eGp8ECNerTFKThNnDLEy6Ll179jIKJoP8GYC85HfTVCdkNKTvpzUPB7YBIGues
         LQwQ==
X-Gm-Message-State: AC+VfDzjELZ4vW4vYOYDyWhngp1ugrIG19rxnJOhrQb2miOYIKowff8H
        7zYTyxi56q5SN/SC+4nldeZlbDkBHvBXkg==
X-Google-Smtp-Source: ACHHUZ4qrHS9ix9mCT1dOE39GKEpLTFwJSF+Z2+p/8E83Ut2ncm+Pz1vfj073++idhV/iW5VDThTCQ==
X-Received: by 2002:a05:6808:56:b0:38c:11b3:a397 with SMTP id v22-20020a056808005600b0038c11b3a397mr8710761oic.14.1684928031785;
        Wed, 24 May 2023 04:33:51 -0700 (PDT)
Received: from [172.17.0.2] ([52.185.204.70])
        by smtp.gmail.com with ESMTPSA id 3-20020aca0b03000000b00396050dca14sm4721158oil.28.2023.05.24.04.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 04:33:51 -0700 (PDT)
Message-ID: <646df61f.ca0a0220.27822.57c6@mx.google.com>
Date:   Wed, 24 May 2023 04:33:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3011662076003802701=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v3] Bluetooth: Fix l2cap_disconnect_req deadlock
In-Reply-To: <20230524110119.602679-1-yinghsu@chromium.org>
References: <20230524110119.602679-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3011662076003802701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=750612

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      37.20 seconds
CheckAllWarning               PASS      40.25 seconds
CheckSparse                   PASS      45.22 seconds
CheckSmatch                   PASS      125.07 seconds
BuildKernel32                 PASS      35.91 seconds
TestRunnerSetup               PASS      510.24 seconds
TestRunner_l2cap-tester       PASS      19.01 seconds
TestRunner_iso-tester         PASS      25.36 seconds
TestRunner_bnep-tester        PASS      6.56 seconds
TestRunner_mgmt-tester        PASS      127.03 seconds
TestRunner_rfcomm-tester      PASS      9.87 seconds
TestRunner_sco-tester         PASS      9.08 seconds
TestRunner_ioctl-tester       PASS      10.41 seconds
TestRunner_mesh-tester        PASS      7.70 seconds
TestRunner_smp-tester         PASS      8.93 seconds
TestRunner_userchan-tester    PASS      6.59 seconds
IncrementalBuild              PASS      32.29 seconds



---
Regards,
Linux Bluetooth


--===============3011662076003802701==--
