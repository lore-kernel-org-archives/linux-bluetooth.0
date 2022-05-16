Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F88C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 May 2022 17:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiEPR1x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 May 2022 13:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344276AbiEPR1t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 May 2022 13:27:49 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A136B43
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 10:27:48 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id u3so2343684qta.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OepNvauf18XuzHjZUEg2aAp4q0gbGgUD8E4hqQTZBGA=;
        b=hjQ/2EiXfrADShBZRyRiPDUiuBFGd2PbpJKgL2oo0N63dN4UlBAjR25dUdFvTFUfzJ
         1b1GkWCvzEWo38hi7oPCOf6S8bB0fTtzFbMoKNxsBr7+N2Ag1l+FKZp/6dPIniyruodu
         mgi5uU4DK9w1rwgv31RoO6d2je/1ujc+vNCWh+KBbcuGImrYNr4I0a3Msh4pBRuom0V1
         y5/hA51HUAM/VHezwbsOrzHBX4jLrJxvigSfIlP+blXjZJXAKgAa6FdAoMM5ykR/WxTc
         zmVI77emxgnJKrj1ETfkBEXxXYrRiGj8RdP1/jHumcB8XzZr2hYKs1vJkA/FqChZIyfd
         r5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OepNvauf18XuzHjZUEg2aAp4q0gbGgUD8E4hqQTZBGA=;
        b=5Qnw8Ik2eDRARy2RnQ9+4QaBPvC5phkxJoLsmum5xDmYcbdIlTNLD2FyX95rM2QSNs
         J8TF3OWPVNdx+RyFghs1M6iJuNATOlHrszxuQ9HITqm+Ki2Kuk1tcDq/iDrOMpi1xyVL
         R/6GXxImGHht7QD4dv+o87XcCCt3fV3A9Wj5XF8LyjP10TZGsdKpJztwE59iAxVsbELV
         hQJi13xHi55Eija+SWPv9XOF0bPnU9nE04FaxB33nem94ZIJLAv9NXpNRqiXAN1DuXSH
         f4kiQfdlqawwHLGFESf+lFSxvx2Eg4+wNIVNS6DmuRcjxJ8x05IbHRWIjj6gIP8mNEfO
         b2PQ==
X-Gm-Message-State: AOAM530Vs1dseAFV/YfGCmSsZoTRm170UMeEr4cCcOJro/W0hufo/e+i
        FezYh0BzrZ5gDc6xXbVPrp3cQLZuc4ReZg==
X-Google-Smtp-Source: ABdhPJyPYIpFGRHMnFJIkUBtDVLZZgEzWARhJza2rtI1GmJ8i4ZsLYIxu8hShth95HNc0DoxNxLGdQ==
X-Received: by 2002:ac8:5948:0:b0:2f3:cd85:f244 with SMTP id 8-20020ac85948000000b002f3cd85f244mr16298953qtz.149.1652722067049;
        Mon, 16 May 2022 10:27:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.87.3])
        by smtp.gmail.com with ESMTPSA id d195-20020a379bcc000000b0069fc13ce235sm6124273qke.102.2022.05.16.10.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:27:46 -0700 (PDT)
Message-ID: <62828992.1c69fb81.54873.08e5@mx.google.com>
Date:   Mon, 16 May 2022 10:27:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8624693831984572850=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: MGMT: Replace uses of bitmap_from_u64 with bitmap_from_arr32
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220516170452.1642546-1-luiz.dentz@gmail.com>
References: <20220516170452.1642546-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8624693831984572850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=642045

---Test result---

Test Summary:
CheckPatch                    FAIL      1.73 seconds
GitLint                       PASS      1.04 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      41.16 seconds
BuildKernel32                 PASS      35.46 seconds
Incremental Build with patchesPASS      47.01 seconds
TestRunner: Setup             PASS      580.07 seconds
TestRunner: l2cap-tester      PASS      19.69 seconds
TestRunner: bnep-tester       PASS      7.22 seconds
TestRunner: mgmt-tester       PASS      121.58 seconds
TestRunner: rfcomm-tester     PASS      11.36 seconds
TestRunner: sco-tester        PASS      10.91 seconds
TestRunner: smp-tester        PASS      10.89 seconds
TestRunner: userchan-tester   PASS      7.73 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.73 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: MGMT: Replace uses of bitmap_from_u64 with bitmap_from_arr32\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#111: 
 4532 |                         DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);

WARNING:BAD_SIGN_OFF: 'Reported-by:' is the preferred signature form
#121: 
Reported-By: Stephen Rothwell <sfr@canb.auug.org.au>

total: 0 errors, 2 warnings, 0 checks, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12851256.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8624693831984572850==--
