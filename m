Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BE8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 11:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352600AbiDOLIf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 07:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352603AbiDOLId (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 07:08:33 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1021E986EE
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 04:06:06 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id e128so4294797qkd.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 04:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=eGpXBPM/xyNmiFYiwHlkRN/mrOisGocBCuANsHUgqzg=;
        b=dcsgKxKijM5fJw9g+Xvx2R9zw9y6TqrfEgiieV8tCOWY3AluEO1ciPABfgYayGD/07
         mrAAjENhfT9IlQVpxgVcYygIb+yk9c7HErWwcPQUbN+cdEkd9WfbKxSgYa6N+LfT+7AI
         zjyEJFZOzggP0XSQoduvUzBjc2F63hPUcqn6tPkPU9vqVJZPkj++dp84U7UoGxJLa46j
         n/tbUpfrmTcCS+mZCjqUsOMTwBLdVl9D3a446h68qzpjjsmEwmXoyj4LtSXfGhZ5DDZy
         z2l7x41c15sVXXLoOJt6K0sj6pqUIZQQAeWG7JZDqJQFG2b90xDYsfb3AD7jFoyVkj1/
         Y18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=eGpXBPM/xyNmiFYiwHlkRN/mrOisGocBCuANsHUgqzg=;
        b=y7K6Vyn5tSzomnDLZU/+LE4IsyM2PX2P++GK7/oPvCT96lwNAshCuMF08hnDF5lCQa
         jHxXhgVTVkz4xWBW1ksmgPQnM3vmSg4/yam1pQPpZwQTiFkYkKMfgv4Y3sPKgYppNcoo
         stR5XFY583MjvoM6XkbvrAkycAq4iRmahbZ7yK5iai7alV1fsZA+32B4bv7pf24cAwJ5
         7+z44C/Xj9frH/NgyJa/YAO5NuFJjwpbfuPVgn34Yk730C/5FH4ij8D/caQfCYhA9ofP
         RvdVdIepcPDrmQDezvBsEk4XZCZgTmKZK3FG9SnxXcUcO7udE/CXIweMe9EeRLd4E0GZ
         0how==
X-Gm-Message-State: AOAM531P1Q7wxbnD8F1lRfcYGlyngquF3l8Ocfxm4h2HX3SZsQSFnr9V
        AlVfGa++/e2MkdmDh/wRVkGkXlRhfJqhQQ==
X-Google-Smtp-Source: ABdhPJw+UoFfIQmeu8wMIfXdEvnVlp2KipBq+gsVnux0QE2oz0ovyuq1XISvSv68ILncWVWCXQ0sZw==
X-Received: by 2002:a05:620a:25d2:b0:699:bd31:aafb with SMTP id y18-20020a05620a25d200b00699bd31aafbmr4992712qko.531.1650020765038;
        Fri, 15 Apr 2022 04:06:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.115.114.158])
        by smtp.gmail.com with ESMTPSA id j22-20020ac85c56000000b002f1d7c22ad3sm2571761qtj.10.2022.04.15.04.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 04:06:04 -0700 (PDT)
Message-ID: <6259519c.1c69fb81.d2e04.f357@mx.google.com>
Date:   Fri, 15 Apr 2022 04:06:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0271952638749797138=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2] Bluetooth: btusb: add support for Qualcomm WCN785x
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1650017516-28912-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1650017516-28912-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0271952638749797138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=632541

---Test result---

Test Summary:
CheckPatch                    PASS      1.67 seconds
GitLint                       PASS      1.13 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      36.98 seconds
BuildKernel32                 PASS      33.34 seconds
Incremental Build with patchesPASS      46.49 seconds
TestRunner: Setup             PASS      555.06 seconds
TestRunner: l2cap-tester      PASS      18.27 seconds
TestRunner: bnep-tester       PASS      7.35 seconds
TestRunner: mgmt-tester       PASS      118.46 seconds
TestRunner: rfcomm-tester     PASS      9.49 seconds
TestRunner: sco-tester        PASS      9.36 seconds
TestRunner: smp-tester        PASS      9.14 seconds
TestRunner: userchan-tester   PASS      7.66 seconds



---
Regards,
Linux Bluetooth


--===============0271952638749797138==--
