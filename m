Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B2EEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 23:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjGTXEc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 19:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTXEb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 19:04:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFEC1731
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 16:04:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-262dc1ced40so798062a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689894270; x=1690499070;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zxvSzHyMRK+W1AfWFdz9M1MXBMV1zfcjfJDwVes5T9o=;
        b=m3Qcv7MCf3i29fYNAMdlOupcCnVhRKDO9mAhddC117jc5FcZWjxHhRCe2sTbqoOn9+
         wbmK2rradEm2oPo0MMhyWQHP8eB06Z10jHdxt2AAZBV/1W2p/u/OPKQuX/BmI/hYlPFy
         vRdYxbMCE6Ylm5BpJKqsg7a/PFKz4c5D8RvCpBru0wLqBA4OanCJOFMR0FJI440ideNA
         Y6DqGf25lXWd6XwDNZqvYWBJN7BSp/AfGSx6VsfA8UlboPvbigWG1fCv1qUtgqtUZw92
         0HJRaObpMvyPKQ52kQhRw1sfAGub0TBBKT5gKr57GFFRUeqNbOvdztt9CUmRa9F8TK5m
         N/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689894270; x=1690499070;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxvSzHyMRK+W1AfWFdz9M1MXBMV1zfcjfJDwVes5T9o=;
        b=ldWYAX8pYq4UEx8hR+patFWJiUmFS6NBskur5/scMv3aaO7E2tDQInqXCb0Mu34a2+
         kA0uzNmVyLWOKk8h1w9fJ+XXufUQkRMMLNR8tdtbmGXkiE5GlKOw1Nw0jGFy/0GPnPsE
         TJfWaoAdIiyUOvER8pZ1f/GfQH8WLDB9HVHp/N1ZlCc4BoSjeyMbWhrntStRjbX6i2tN
         8Pp3fuCnnzH8Q/UVuy0is3mEnBXIDuMlbdlK3vtgH0OrhyPNHAAH6UPJhi+C55SUKyxz
         O+o0io/Yc37oGlpW6YudutrbpySWJr3zdOHJh/EjV1HNppAaXqg45+fs1th3UhryakG+
         tFtg==
X-Gm-Message-State: ABy/qLY3SLfz+LqsFBtqabG1W4SDoc/jrlmZTQ+SRzTN9hORAfV1Kld9
        KBmjJ7ZStL9pD9z5hrKPDY6BkJtkoYg=
X-Google-Smtp-Source: APBJJlEBr5BmgAvFCVBzID4zWhiT7MI7XEgKOgTQzY7Zdq4N40KDow9ZBLNEG/wfEfS10nex00UClg==
X-Received: by 2002:a17:90a:3841:b0:256:d4a:ea4c with SMTP id l1-20020a17090a384100b002560d4aea4cmr77079pjf.30.1689894269844;
        Thu, 20 Jul 2023 16:04:29 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.245.150])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a190500b0025bfda134ccsm1552195pjg.16.2023.07.20.16.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 16:04:29 -0700 (PDT)
Message-ID: <64b9bd7d.170a0220.dd99c.30ee@mx.google.com>
Date:   Thu, 20 Jul 2023 16:04:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4270893622927196642=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: btusb: Move btusb_recv_event_intel to btintel
In-Reply-To: <20230720221954.517948-1-luiz.dentz@gmail.com>
References: <20230720221954.517948-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4270893622927196642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=767998

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      39.56 seconds
CheckAllWarning               PASS      43.31 seconds
CheckSparse                   PASS      49.59 seconds
CheckSmatch                   PASS      133.43 seconds
BuildKernel32                 PASS      38.20 seconds
TestRunnerSetup               PASS      580.86 seconds
TestRunner_l2cap-tester       PASS      27.15 seconds
TestRunner_iso-tester         PASS      64.40 seconds
TestRunner_bnep-tester        PASS      12.78 seconds
TestRunner_mgmt-tester        FAIL      242.32 seconds
TestRunner_rfcomm-tester      PASS      19.39 seconds
TestRunner_sco-tester         PASS      19.88 seconds
TestRunner_ioctl-tester       PASS      22.11 seconds
TestRunner_mesh-tester        PASS      16.00 seconds
TestRunner_smp-tester         PASS      17.17 seconds
TestRunner_userchan-tester    PASS      13.16 seconds
IncrementalBuild              PASS      35.68 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    1.891 seconds


---
Regards,
Linux Bluetooth


--===============4270893622927196642==--
