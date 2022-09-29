Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10066C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 12:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiI2MLn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 08:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbiI2MLh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 08:11:37 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96301D62E1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 05:11:36 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-131de9fddbaso502038fac.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=MTfzPOFte1oCXYyULrpbLb0TnEN5tYOd3Kx4AcckpqM=;
        b=Xcw+6dHao+pn4KMlGaqx7f/NLDx4zN9e/H9CG+pADO+6A4SDulSjdBWRIqKWo5bKEe
         0NPptcHAuJCnXXWKlw43rT54+rgqrhe4yUyDMd2UzvEpniFLHZMo0xbRIKFJ1jPlA0w7
         K4UAr7e/rf2KyXKx30afeKbRTDlNurbnp1uNCqz4exMYVH7J0yeN/GyVjEwAaSYMM/k7
         W282hwhudXPHjaV4Nn7YNvc6nfkGxCN1HcHRyAiSbhEa94LzCxermh5LA6gjyfa3957j
         QjjksGW34hTD2EIKDbFNQD4G1YKxQsB+s79jx1NYqAghXi6nro7QdV5PE+kjLM3Z31jA
         kaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=MTfzPOFte1oCXYyULrpbLb0TnEN5tYOd3Kx4AcckpqM=;
        b=nqS5IdamRrKyehTSrXiZCyJdit7Op2UzGa2HoVyyH4i5oUVgpnTPpkIoEf72i7F1NU
         htnkC4ZMyG8zwBJDTSog1IHHZ+kZXz40jnXNwAbbR0do8qlvg7XbbGJF4bhgH8I135as
         w5bQFchybycI6eBwYavZEIF98+aLNBnpjXrb7P1ferm1TWgBSA8PhoYZxEFYigdG9RjB
         7j+gOhvrpizY1kzdUvCKr0bjy4Zl97sLWS9gbFx31yhgQn0W7ZqCMACoWmxJHQs1bRDz
         wLdKwLao5jJsPF1njrumK+toAYppAXL2fXT76jCCfxR4UAR8Kx7znc0eju1sl4iIbWog
         C6iw==
X-Gm-Message-State: ACrzQf0t8rxTnqPeGlNUGqoza98AvP0nrdlsJ8C4cWlyCCbcyA8MnuRo
        DlgqL6UtnC3Kd77l7EaaV4sMkPVXw7RKrg==
X-Google-Smtp-Source: AMsMyM5wGQU13XCfm3bj42qNHrBtV91FnNiepA4565wjimuu+6YIvyLHHjrx/GESk4AOhNYBxxg8Iw==
X-Received: by 2002:a05:6870:a2d1:b0:131:a8bc:54db with SMTP id w17-20020a056870a2d100b00131a8bc54dbmr4413783oak.187.1664453495580;
        Thu, 29 Sep 2022 05:11:35 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.91.196])
        by smtp.gmail.com with ESMTPSA id h8-20020a056870d24800b00131c3d4d38fsm916145oac.39.2022.09.29.05.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 05:11:35 -0700 (PDT)
Message-ID: <63358b77.050a0220.c4f70.33b2@mx.google.com>
Date:   Thu, 29 Sep 2022 05:11:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4543893599660616185=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: Add btrealtek data struct and improve SCO sound quality of RTK chips
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220929114426.4413-2-hildawu@realtek.com>
References: <20220929114426.4413-2-hildawu@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4543893599660616185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=681879

---Test result---

Test Summary:
CheckPatch                    PASS      4.94 seconds
GitLint                       FAIL      2.88 seconds
SubjectPrefix                 FAIL      1.93 seconds
BuildKernel                   PASS      44.62 seconds
BuildKernel32                 PASS      40.86 seconds
Incremental Build with patchesPASS      75.88 seconds
TestRunner: Setup             PASS      694.33 seconds
TestRunner: l2cap-tester      PASS      21.50 seconds
TestRunner: iso-tester        PASS      22.09 seconds
TestRunner: bnep-tester       PASS      8.42 seconds
TestRunner: mgmt-tester       PASS      137.38 seconds
TestRunner: rfcomm-tester     PASS      13.29 seconds
TestRunner: sco-tester        PASS      12.30 seconds
TestRunner: ioctl-tester      PASS      14.72 seconds
TestRunner: smp-tester        PASS      12.54 seconds
TestRunner: userchan-tester   PASS      9.03 seconds

Details
##############################
Test: GitLint - FAIL - 2.88 seconds
Run gitlint with rule in .gitlint
[v3,2/3] Bluetooth: btusb: Workaround for spotty SCO quality
18: B1 Line exceeds max length (85>80): " - Additional info: The comparison of btrtl_usb_recv_isoc here is for invalid handle,"
19: B1 Line exceeds max length (91>80): "   the invalid handle shouldn't appear. So we try to find out the rule and filter out this."

[v3,3/3] Bluetooth:btsub:Ignore zero length of USB packets on ALT 6 for specific chip
1: T1 Title exceeds max length (85>80): "[v3,3/3] Bluetooth:btsub:Ignore zero length of USB packets on ALT 6 for specific chip"
15: B1 Line exceeds max length (86>80): " - For ignore_usb_alt6_packet_flow, manage the common flag by the vendor private flag."


##############################
Test: SubjectPrefix - FAIL - 1.93 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============4543893599660616185==--
