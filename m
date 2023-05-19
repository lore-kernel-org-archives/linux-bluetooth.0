Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9DDC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 May 2023 22:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjESWeG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 May 2023 18:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjESWeF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 May 2023 18:34:05 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59246E4D
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 15:34:02 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6ad13a1fbceso2859856a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 15:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684535641; x=1687127641;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r0Me+Z3GGYH9cLjG3MrRMdj7yLTCif6v1/GquQmwMpw=;
        b=bsjLTeaZyDlGnfuUkvDC6SaxFhCS0kivWoOqeA13EG0AAuR6ab9lvEManQBCtS1fs/
         yqobQClqRReWftwnWREcFVPK2Xyn71MMCEfjExSOozizkwkPDbKoQulH7mFOZpNuTT+x
         ahAwTt4qo8o23wfotTVQNia0DWKRTX4nhnFo5TSAc0fOyH49WCXcfV0CCMMMVKC+bzUj
         nUE2pl+YtIsKmNeWtN+D9ix3LxuO6gvwHAvaIcTmD3VMbWoLAmyGavpA7rFNjGHBn+zW
         kWhYAKw1TlgZsOpl61Z9cE96Qs3UB6X0qDMuqJfQ3bM7t8kzeMTwejnhnjLq/SuDu7J1
         6CoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684535641; x=1687127641;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0Me+Z3GGYH9cLjG3MrRMdj7yLTCif6v1/GquQmwMpw=;
        b=YHyrhH9GB090Mts8sCsg64IpwQ57F+Z7pdxuaSK5us5JsxPVwpV6G18cHZfVon7AZJ
         Bja3GrGtMWBGjR0AGiVZiLhbsnsprGwBZNJiNrnjWfKah2W76yWEEkezEFVliX95Ldsk
         cCwLjbbiaoggoxf5h1rGMjPGIU8EQzibr8NdvAbSccCUJPQ90/O3bkHsqBVe/B7Mr6+S
         E26u/Cd1nUYFH6WTGjIYvjWGX+4Fsiby60LNjmBPjtK6bjhGQX5jN3r9ouS8PEr3lD5D
         m3JkbU93f8j4IAJt7WNp3zqnmkfT/MjX4X0ov9ZHb3efxWbjQG0VV7PV2G9w+o6gyj/c
         /a0w==
X-Gm-Message-State: AC+VfDw79sZjXmgqogihOttW4NYFPcJrfvnLVM0eofra4eprs1lf0rlb
        8WRYNM8+yDRDljpt2BZ4GxOWPtFgCQI=
X-Google-Smtp-Source: ACHHUZ44irkl34acAuBP9x69s/kEBxw3l+wpyIQBhWHLRMHlqQyLL/uIPWyK9aLT0DjgXmO6RfJgOA==
X-Received: by 2002:a05:6830:208d:b0:6a1:42ee:1f5e with SMTP id y13-20020a056830208d00b006a142ee1f5emr2003662otq.0.1684535641076;
        Fri, 19 May 2023 15:34:01 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.64])
        by smtp.gmail.com with ESMTPSA id b13-20020a9d6b8d000000b006a647f65d03sm89290otq.41.2023.05.19.15.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:34:00 -0700 (PDT)
Message-ID: <6467f958.9d0a0220.06d8.09b3@mx.google.com>
Date:   Fri, 19 May 2023 15:34:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2046332396611023766=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, minhuadotchen@gmail.com
Subject: RE: Bluetooth: hci_mrvl: use correct __le16 type
In-Reply-To: <20230519214408.20984-1-minhuadotchen@gmail.com>
References: <20230519214408.20984-1-minhuadotchen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2046332396611023766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=749396

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      37.47 seconds
CheckAllWarning               PASS      39.39 seconds
CheckSparse                   PASS      45.76 seconds
CheckSmatch                   PASS      121.96 seconds
BuildKernel32                 PASS      35.34 seconds
TestRunnerSetup               PASS      499.62 seconds
TestRunner_l2cap-tester       PASS      18.73 seconds
TestRunner_iso-tester         PASS      24.52 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        PASS      126.94 seconds
TestRunner_rfcomm-tester      PASS      10.07 seconds
TestRunner_sco-tester         PASS      9.03 seconds
TestRunner_ioctl-tester       PASS      11.07 seconds
TestRunner_mesh-tester        PASS      7.96 seconds
TestRunner_smp-tester         PASS      9.00 seconds
TestRunner_userchan-tester    PASS      6.41 seconds
IncrementalBuild              PASS      32.82 seconds



---
Regards,
Linux Bluetooth


--===============2046332396611023766==--
