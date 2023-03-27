Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7A9C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Mar 2023 21:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjC0ViH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 17:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjC0ViG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 17:38:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5142198B
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 14:38:04 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z11so6663817pfh.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 14:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679953084;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+vN67vVASCqDNmp7HQzNCAq1AzqdCqXibPsYCkZnUpo=;
        b=Q7STdJ9hVT/an7Axg42NdJRmMneKD2IjDJ3OitrF8frdoxYlhqVk+BATbd6Ijzc91/
         DrM7KFeAl3dq+ftUJz3JdQUg/18+ianUIOYK4sYwY+Xg3NetoZu28TVCuNMuZJr5j7Av
         T+oZnYeqi6juT09wAH6UaflHJ2WkS8l25vaD6DiEKMQQqo1UR4JnRspHxCvA6ZMypx74
         sCUP5eoeN4NT8gnD+9rCUdircJytgJ6DWHcPdY/medjNeZZdtOFBHNvHOzE6mrHm5m9r
         50e0WqSzIRfoZx8EOqcISSm2Z3vGkKbeQ0SOHhs8dxGG+B02hpXfv5eum2z4IO93kmxc
         3c7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679953084;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vN67vVASCqDNmp7HQzNCAq1AzqdCqXibPsYCkZnUpo=;
        b=Nx0+bkFxzdNke4P4BhbP7Il9AMIryAMBcyJ8xvABJbEbZzkVzK+/TEb4kNubaWUFQB
         dZNuE7DV9nP+7pquGfjMLMXpWkKfPciztFSjfaIrDJl+t66wyNxllr2RlUzSVTYULqVL
         visnhT23i4pHCNOqvmjWKKGyiXPVA6RR1HsCdYSh6Rue842xxKhoTqSrMbB6edU+JuzS
         CXuNiMcrGJ7roNadgPTD3Qc/LpasO4+GFi/TFJyEWOeFyvaWq75Mh+MO5OXvxAimbUHI
         x9Ag1BazrcrQXvanOb/68bwMltWizoawKL+Z3Zc/BInOCyHCsrwCk9yD3CidzYCsx24E
         aQ1A==
X-Gm-Message-State: AAQBX9eRRK0nbKMQ+Gt2bC/fIGEFpF+Rd/fVl10IzDBs8hrBkEABrUxu
        wYXUI1sYOZG5fPJ/bWmt2313MeOyBKM=
X-Google-Smtp-Source: AKy350b1f/OG+5PrF/zBQ/zfNAIAYjmIFf2oA6jc8/lY5dl2649/5r1MZw1eor6REj9EAd7/yYRdZg==
X-Received: by 2002:a62:8443:0:b0:625:c631:8cea with SMTP id k64-20020a628443000000b00625c6318ceamr13097949pfd.15.1679953084067;
        Mon, 27 Mar 2023 14:38:04 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.87.16])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b0058b927b9653sm20067990pfn.92.2023.03.27.14.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:38:03 -0700 (PDT)
Message-ID: <64220cbb.a70a0220.7321c.4051@mx.google.com>
Date:   Mon, 27 Mar 2023 14:38:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0929363805030823590=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: hci_conn: Fix not cleaning up on LE Connection failure
In-Reply-To: <20230327205347.51568-1-luiz.dentz@gmail.com>
References: <20230327205347.51568-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0929363805030823590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=734342

---Test result---

Test Summary:
CheckPatch                    PASS      1.92 seconds
GitLint                       PASS      0.50 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      44.56 seconds
CheckAllWarning               PASS      47.79 seconds
CheckSparse                   WARNING   52.51 seconds
CheckSmatch                   WARNING   139.93 seconds
BuildKernel32                 PASS      41.19 seconds
TestRunnerSetup               PASS      588.02 seconds
TestRunner_l2cap-tester       PASS      19.97 seconds
TestRunner_iso-tester         PASS      21.20 seconds
TestRunner_bnep-tester        PASS      6.99 seconds
TestRunner_mgmt-tester        PASS      131.45 seconds
TestRunner_rfcomm-tester      PASS      11.30 seconds
TestRunner_sco-tester         PASS      10.26 seconds
TestRunner_ioctl-tester       PASS      12.11 seconds
TestRunner_mesh-tester        PASS      8.99 seconds
TestRunner_smp-tester         PASS      9.94 seconds
TestRunner_userchan-tester    PASS      7.70 seconds
IncrementalBuild              PASS      74.35 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============0929363805030823590==--
