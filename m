Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B8AC04A68
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jul 2022 22:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiG1WDO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 18:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiG1WDN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 18:03:13 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA4D6249C
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 15:03:12 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id 1so1598170ill.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=G0l4KnLs+guplZ+iuaBgo5yWPQF4ZKMC7KWH31L0/1Q=;
        b=Ufmb3zYF4F0I7d9o2iOLAoycf5qLhpNrCpaocX63l00asRq2I0HYvRwFfmKJjYWcN7
         VEs/KZACxEsGyky0QJ7766eW6XX3ZQnjHZYWgp5cUf/nYStF1hlMLG/ZR1z+LIkppp0P
         FBkLh3Q+DN7jyVOzyO2L9ajId2YaV+a710JjkoKK+aRXLmBkoUWSTXITmLvmGcPkX91A
         jr4X4K5f3x5fK+o3Xw9IPyCLUsGQTGq23uLBlx1ODx9cp1+YH4zlcWc7Gmyr+S06nESl
         YCKo2dcHQRD1XCqS07dY1UcaGR6EzxgUit3YftrtcOE/LraQ2l96ZHczHfJ4BFrj+Wqn
         +8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=G0l4KnLs+guplZ+iuaBgo5yWPQF4ZKMC7KWH31L0/1Q=;
        b=A2iTae0h0uoBf23A9zD0dwC6ReOswaAUVkTrIcSsh/w1ifdTLr5Euu9MbPjbhhKqVc
         UBXkRPhf9v3y/5gXuHBD8X/j1Zx2oYCDQOlCmUu71bCTOtoRZKNn+KfVoeULd+ji2RMb
         rdME6rAvpkleCnF/KoYcYxgWeZ9sboo90U7Vx3kFxeC2jWNrJKYUgpmGTpJWKlwO8qN4
         yVpAYj8uSpqz+De7a1N6q+9NG90TeqNLI3yv0plmtN069ArfUIffdlZZUj+sAwSYnQhl
         zr3d+U66nhxOmNiwUYySiUk7A6CfWDBQhz9fJy/5xnDQPbvI0W76pFP+gBZYOktG5UB9
         9CTQ==
X-Gm-Message-State: AJIora/yr9XQ7wxD1vqbr+vj6jikXFTCnOWskUkwIeru8HnGU0xXU8Ss
        CXiyOKquMCQTAEzHc1ObswDF39qxTMo=
X-Google-Smtp-Source: AGRyM1tcwLBv2oHNwEJTBu8giYSGO2uNUOcs3GcrHC1FEs2y7M2OVwr16+ObTQ06uc1rE77Esy7FVA==
X-Received: by 2002:a05:6e02:1ca8:b0:2dd:6674:f1cb with SMTP id x8-20020a056e021ca800b002dd6674f1cbmr271411ill.131.1659045791376;
        Thu, 28 Jul 2022 15:03:11 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.195.174])
        by smtp.gmail.com with ESMTPSA id m10-20020a924b0a000000b002dd12857a13sm733468ilg.80.2022.07.28.15.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 15:03:10 -0700 (PDT)
Message-ID: <62e3079e.920a0220.ceff4.1616@mx.google.com>
Date:   Thu, 28 Jul 2022 15:03:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5849552911395913190=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_conn: Fix updating ISO QoS PHY
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220728210556.1236145-1-luiz.dentz@gmail.com>
References: <20220728210556.1236145-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5849552911395913190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=663884

---Test result---

Test Summary:
CheckPatch                    PASS      2.55 seconds
GitLint                       PASS      0.88 seconds
SubjectPrefix                 PASS      0.59 seconds
BuildKernel                   PASS      33.41 seconds
BuildKernel32                 PASS      28.76 seconds
Incremental Build with patchesPASS      40.18 seconds
TestRunner: Setup             PASS      478.62 seconds
TestRunner: l2cap-tester      PASS      16.65 seconds
TestRunner: bnep-tester       PASS      6.22 seconds
TestRunner: mgmt-tester       PASS      98.96 seconds
TestRunner: rfcomm-tester     PASS      9.47 seconds
TestRunner: sco-tester        PASS      9.24 seconds
TestRunner: smp-tester        PASS      9.25 seconds
TestRunner: userchan-tester   PASS      6.39 seconds



---
Regards,
Linux Bluetooth


--===============5849552911395913190==--
