Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0414C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jul 2022 03:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiGLDRo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 23:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiGLDRi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 23:17:38 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A992865
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 20:17:37 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y3so6724716iof.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 20:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=GcNSoVbbl0VRwsd+8igHJNNbk1/Gn9WhOvf10fjGNIM=;
        b=Op1xRa5aZgSbPSTWgU1WJVhjiKBlu9UwsuXTMXUW06TuZqEDiRNSYqwrYujZUdLAU2
         Kmy47RblfOz+6jqwtvhApwhdX3RVz//WnzGvlrXSa/fUqjjzlgqRdzCX0K0c1c0C+/u6
         5tATITv8Z7v7BM61GUc29LrRtYOO1n+U6J4wgRsB/1EHW7CRqHWgghdD3XYt1AaqTD3x
         MVUaoergeVYgIZ2MgRxaLIiUbr9ijdBjfTz+nsdUl+lSBTZx3+FtUmM4qBqE2mSANMZD
         yuyvmq1XuRdSsOZlnt/QMgAo+LhTJxUaAKigxuYu5WO314wfAJfYi4BcLOtJcU0bD43M
         zQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=GcNSoVbbl0VRwsd+8igHJNNbk1/Gn9WhOvf10fjGNIM=;
        b=nthAhsK7N/buPb6GMPHPMIJxHEea/gFqwpezoyQJRKDasNny4+Rq2kn5WnfiMPXGFw
         L1Xl1TCaniCGAybQmWDRUMX+SbOxk+ZSABXFyJy3doCaNciXKEzYc3qY6aOn2qvSW20Y
         +I3Bbc/j/Yl8JmjDOWLsRfkkmkXwa6Yc3BMwJnHZ+oZunJD6fKr1c/JhW5SX9lXVSjcI
         SeO9wa+a7XIFy6VHvxYnk2jSq2yM+UP6VcFGEAT06MrYvhGA82YgTIlhwGmOSa6wAuSu
         YPNf27IixJCiUmF2gjlzxID9/wx8K2uSQ1NEYa8QtJseQDYFR8fEyfAt/FY4Rv1ihHBZ
         DSnQ==
X-Gm-Message-State: AJIora8PWGYFTH7JD1xuefhcF/RVKaPnf3EYQq7hPmFSqELwvrrZW9CG
        RVJ7Sgy1mKTi0Z3ckZIhv6FXaB2RmJA=
X-Google-Smtp-Source: AGRyM1vIkwgcNu+oqrTHXHQAvtL9GXX9/P8vONiyd+PE0a13wDDw3wkIe+9cSWp2qMBiTgJRVUacuA==
X-Received: by 2002:a05:6638:251:b0:33f:6d6e:d8e0 with SMTP id w17-20020a056638025100b0033f6d6ed8e0mr1391996jaq.200.1657595856807;
        Mon, 11 Jul 2022 20:17:36 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.157.127])
        by smtp.gmail.com with ESMTPSA id k186-20020a6bbac3000000b0067b85cfb30csm3352081iof.1.2022.07.11.20.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 20:17:36 -0700 (PDT)
Message-ID: <62cce7d0.1c69fb81.7ac83.27a2@mx.google.com>
Date:   Mon, 11 Jul 2022 20:17:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4648599919325641772=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: Bluetooth: hci_sync: Fix resuming scan after suspend resume
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220711170515.kernel.v2.1.Ia489394ab4176efa5a39ce8d08bb4c4b7bee23b9@changeid>
References: <20220711170515.kernel.v2.1.Ia489394ab4176efa5a39ce8d08bb4c4b7bee23b9@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4648599919325641772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=658728

---Test result---

Test Summary:
CheckPatch                    PASS      1.60 seconds
GitLint                       PASS      0.77 seconds
SubjectPrefix                 PASS      0.71 seconds
BuildKernel                   PASS      31.65 seconds
BuildKernel32                 PASS      26.96 seconds
Incremental Build with patchesPASS      37.72 seconds
TestRunner: Setup             PASS      463.20 seconds
TestRunner: l2cap-tester      PASS      16.32 seconds
TestRunner: bnep-tester       PASS      5.49 seconds
TestRunner: mgmt-tester       PASS      94.37 seconds
TestRunner: rfcomm-tester     PASS      8.93 seconds
TestRunner: sco-tester        PASS      8.69 seconds
TestRunner: smp-tester        PASS      8.72 seconds
TestRunner: userchan-tester   PASS      5.69 seconds



---
Regards,
Linux Bluetooth


--===============4648599919325641772==--
