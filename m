Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCABFCDB46B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjJKRJM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 13:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJKRJL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 13:09:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0723F98
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 10:09:09 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5859b2eaa55so23371a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697044148; x=1697648948; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PrN0P2cOxxpS9ML8ydrldHv1/uOlGizvSO9iDpbVB2w=;
        b=dGpygNeXHbwC8iJfEFwEe9/9anS6CBk3yuKHHL+B3tWe5VUANFPstKihWE2oWE+uyH
         RghgemnYmnbs5fOKplHJUS+aiv8TQFUwVN2x6nRPfbJuHFcaPN3ixaQ5xA2sI0oQjE92
         14js4TFVXs+uWkgUrioejqKfMGmHgH+84QC9O5Pb8kztIEg2G3ICiPmCCFvVsncr4D6l
         q4dHLMsuopSsRtlaxF5NlU0RGwWMOJl83Z4EcHXO5rHb+1IUhw5/p0MVGcxnzlVhR/WY
         JAhbasDo8HWnjhm7+42mkxOf5S2VSWqg1MWKFanaDQk9LsF01AYecE3gA6nB/0QbNIZD
         AhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697044148; x=1697648948;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrN0P2cOxxpS9ML8ydrldHv1/uOlGizvSO9iDpbVB2w=;
        b=ntSsdV97jIBPYeiH+VH5UxMEtKRCJOMjjc4dDrgl2idtBJUUYrP/yL0hFt+YceJ75b
         YyGh2Tpru3IBQP4FQIHKbQiZ3iaBrlOdbAjKN/HtAHiOJbGqAndEbMrc0j+K1Vh7FdgZ
         /ZhzMFMu65AxY+UhuQagjOKYG0TubhJIUeSD09Y7ZS17nJwX/iJSmD7/Q1UskXtjfq3j
         74VKQjjjaBbTMlxdqXxckyXBZmrmof3uI1C/av55v1K0yU2eUpvtiaIxEfyA5V1U1TAk
         fTO4ZAxZk5DfTgrhPlDqGk32NuOCqQHIvNFVftOJwKqlvuthFO0a1O6aLqxySKNWo8L2
         +RDA==
X-Gm-Message-State: AOJu0YzRkCZnGK02Q7ndqBTuAMnlP2psmQ4s9cKYKA3EtIlQN9TGjeWJ
        udoKNUqEG4855DdLaz1U4ywFxlE4BQo=
X-Google-Smtp-Source: AGHT+IF8Fq0VBhE+Ghgq8bsjv6gAxQbqEZMGywGRFSL9HQAYPpCC/rS+dAjqXFdnukHjmFYyDxXfog==
X-Received: by 2002:a17:90a:d804:b0:273:efc0:33eb with SMTP id a4-20020a17090ad80400b00273efc033ebmr17094116pjv.14.1697044148216;
        Wed, 11 Oct 2023 10:09:08 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.165.252])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a199d00b00278ff752eacsm158961pji.50.2023.10.11.10.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:09:07 -0700 (PDT)
Message-ID: <6526d6b3.170a0220.dda8e.0b84@mx.google.com>
Date:   Wed, 11 Oct 2023 10:09:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3848034567968521252=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, keescook@chromium.org
Subject: RE: Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name
In-Reply-To: <20231011163140.work.317-kees@kernel.org>
References: <20231011163140.work.317-kees@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3848034567968521252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=792247

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
GitLint                       PASS      1.86 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      41.40 seconds
CheckAllWarning               PASS      45.62 seconds
CheckSparse                   PASS      51.89 seconds
CheckSmatch                   PASS      136.78 seconds
BuildKernel32                 PASS      39.60 seconds
TestRunnerSetup               PASS      611.26 seconds
TestRunner_l2cap-tester       PASS      36.60 seconds
TestRunner_iso-tester         PASS      64.47 seconds
TestRunner_bnep-tester        PASS      12.89 seconds
TestRunner_mgmt-tester        PASS      258.17 seconds
TestRunner_rfcomm-tester      PASS      19.17 seconds
TestRunner_sco-tester         PASS      22.53 seconds
TestRunner_ioctl-tester       PASS      22.02 seconds
TestRunner_mesh-tester        PASS      15.88 seconds
TestRunner_smp-tester         PASS      17.19 seconds
TestRunner_userchan-tester    PASS      14.01 seconds
IncrementalBuild              PASS      37.07 seconds



---
Regards,
Linux Bluetooth


--===============3848034567968521252==--
