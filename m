Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DEEC77B7C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 May 2023 04:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjEaEku (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 May 2023 00:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjEaEkt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 May 2023 00:40:49 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332239D
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 21:40:48 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6af86627460so4143827a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 21:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685508047; x=1688100047;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jtdZqJjI77pW6U6LUsvdmec8432ZJhmP98Iu95aVpKQ=;
        b=WWeE9NK2tqZb8DaNuAW/BOqKMfyceRjsK0ICGTbkrX+vMXKEfZ2YoPPJYQduAuw0pN
         Sox/Fa2Z6bCco6jgq353OjPH748huf8FDa1ww6ZIko3onf7l42sNI5UzmxScIJj+WaWE
         nDMREjOCT3G+Y2VShd/x3b6lOmf/ft/T8D+74WBGiOYJOkdUipoOk8cqmk6kKmcd6oV+
         j8rS02gaX9sz0Hu50n8AiFHbd58T8oSemS9Dagxzpo06aOGx+hRNaT3FSUkMBMFL78lV
         gPPB99g4sfDyiKIi0c/rnIZHmfMauMiHN6R4WYQiNatBrZnGuOPiDG0yAUegKMcfCZN4
         GDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685508047; x=1688100047;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtdZqJjI77pW6U6LUsvdmec8432ZJhmP98Iu95aVpKQ=;
        b=BJ65mipeLPXx9zVaXG4a0XJWzHcfHJuuuIhtaICQWSaY+0XXG0EOjoWES+hrWFTuUv
         969rvSwLXOBOS+sRpv0HwWCsqN1sEFtlhvO9aVNBmdjZkE+5P46Sa3+wILL8H6ZlbMUI
         A03j00y0graOJArHDfv1PwLMy+OfNCWZV9vdRnKmwDuCvxFTFhgMrHCWEU+HNxw6JZ8R
         2cyj2oqEHfqWZRbYlPv/Iq2iGeSYaDM2eYdRw2Skj8OwIQnilatYLJTLIqUHUTOYkka2
         oUeWXsnlJe8PrG80PVuIFy6rFAVMm+bW83SYg0ZyNbo2B/QmLZA3geIx0eF584Ru65o1
         JaSA==
X-Gm-Message-State: AC+VfDwj21MUu11E0ATUBmWAJqcfjfTA4BmYXESU7aS7BpQN6yP+xdRi
        HnwYgu//elyFMuM8aIVBfG2eAT9ku1w=
X-Google-Smtp-Source: ACHHUZ5uK1oadOK3w1bkw0MiXPH9/9VqKEcNwgdEMiqjcXswtO24RMTwhrTBdSRqPTEl9wvWtj67Uw==
X-Received: by 2002:a9d:74c3:0:b0:6af:8210:8177 with SMTP id a3-20020a9d74c3000000b006af82108177mr1082678otl.31.1685508047376;
        Tue, 30 May 2023 21:40:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.248.87.128])
        by smtp.gmail.com with ESMTPSA id l5-20020a05683016c500b006af814436f4sm139026otr.25.2023.05.30.21.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 21:40:47 -0700 (PDT)
Message-ID: <6476cfcf.050a0220.2075.08b7@mx.google.com>
Date:   Tue, 30 May 2023 21:40:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1164989541407376799=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v5] Bluetooth: Fix l2cap_disconnect_req deadlock
In-Reply-To: <20230531034522.375889-1-yinghsu@chromium.org>
References: <20230531034522.375889-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1164989541407376799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=752538

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      44.90 seconds
CheckAllWarning               PASS      48.44 seconds
CheckSparse                   PASS      54.85 seconds
CheckSmatch                   PASS      148.43 seconds
BuildKernel32                 PASS      54.23 seconds
TestRunnerSetup               PASS      614.44 seconds
TestRunner_l2cap-tester       PASS      21.99 seconds
TestRunner_iso-tester         FAIL      32.58 seconds
TestRunner_bnep-tester        PASS      7.79 seconds
TestRunner_mgmt-tester        PASS      149.31 seconds
TestRunner_rfcomm-tester      PASS      12.29 seconds
TestRunner_sco-tester         PASS      11.32 seconds
TestRunner_ioctl-tester       PASS      13.46 seconds
TestRunner_mesh-tester        PASS      10.00 seconds
TestRunner_smp-tester         PASS      11.07 seconds
TestRunner_userchan-tester    PASS      7.96 seconds
IncrementalBuild              PASS      40.67 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 75 (93.8%), Failed: 5, Not Run: 0

Failed Test Cases
ISO AC 6(i) - Success                                Failed       0.304 seconds
ISO AC 7(i) - Success                                Failed       0.296 seconds
ISO AC 8(i) - Success                                Failed       0.308 seconds
ISO AC 9(i) - Success                                Failed       0.304 seconds
ISO AC 11(i) - Success                               Failed       0.328 seconds


---
Regards,
Linux Bluetooth


--===============1164989541407376799==--
