Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D85BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 09:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbiDFJBu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 05:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449498AbiDFI5h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 04:57:37 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63259287A06
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Apr 2022 19:32:59 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z19so2335223qtw.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Apr 2022 19:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=uh7H/KA8eT1jaMukwiwChChVfneSlp6vWMEutXKZdXQ=;
        b=A+sEGJ6fE6f3nyPNUA3rB/cC2hX6mDT/c7ZvkXr8aBCrjzh90xx6R8Wnn5Z2EbvdmQ
         FHPlAXzUOSfOmG8y2O+MqdeR/OK3uqSnNTBkpOTHU+l3OAffGI8hp/HW1txJGXghijQ0
         +Yg61+NOLIfBD4p7KEaYJr21p5GUUcVaoA3SOvjCO85wL3mEwYb/8MH3mAlfeCsgEVX8
         Nl/J5K2+2yOMqfp7FA3WvKdfA8paEqxcrKPBI8Vc229+hjtQwlNnbicgwNVXG6pDj++B
         kb85Nhzi0LgERkC9q2xMHto1GB0H/XKVzmqLmwM4cKUGjQADVXZa/3U2CXGSJpro/p46
         d1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=uh7H/KA8eT1jaMukwiwChChVfneSlp6vWMEutXKZdXQ=;
        b=eCdFIgcmIzR5XTDLiaOQZzbgUNOqm3YpJbOC25CdkHZXjxH5rP+M2PtwtlHT/TYtU0
         OicVICldm4v2y6k5RLkWDe3U1wpUdVtsAgTC0DOeW+NGRmR/vjVrLhTCWL047OB3R8CW
         6bwwtxMpyYqbdVekRlKRP6vBWA4rbcNe74LbQoUzbFT1MCgG3To9l/nxdTsNMTQpCWGV
         02sB8VXYv6IsRGxmcr0tPeLWKk42XFf6Bf6cVQgw1KhkjuofljhYyJQlvlJ6HVHZeGW1
         iyAuI9PvxosGAegQKpPe+zQoP34yLZVVHlz7Wf8LkCAmrdMnyGPgiZuAITob4YiRXcYQ
         htTw==
X-Gm-Message-State: AOAM533w5SaR6ZDSE0KPt+mqHxesRLhnQh5I3iiNIJVwTZAcKSdtYTQm
        Q5JkLAq6c2TSiRICHWEo2qJcQvI+WyNOAg==
X-Google-Smtp-Source: ABdhPJwXW2pw3FlvMsmYBjlXMds+PEpwKgA388lw0bfbpC4fM5rbAjOlEh7d34fKz5WP68QF3wYwXg==
X-Received: by 2002:ac8:5784:0:b0:2e1:ed90:fc65 with SMTP id v4-20020ac85784000000b002e1ed90fc65mr5795011qta.232.1649212377972;
        Tue, 05 Apr 2022 19:32:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.67.142])
        by smtp.gmail.com with ESMTPSA id n10-20020a05622a040a00b002e315b9f08asm12948137qtx.35.2022.04.05.19.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 19:32:57 -0700 (PDT)
Message-ID: <624cfbd9.1c69fb81.5bc09.06b0@mx.google.com>
Date:   Tue, 05 Apr 2022 19:32:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7475406081154361035=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Split hci_dev_open_sync
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220405215207.1415731-1-luiz.dentz@gmail.com>
References: <20220405215207.1415731-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7475406081154361035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=629301

---Test result---

Test Summary:
CheckPatch                    PASS      1.78 seconds
GitLint                       PASS      1.12 seconds
SubjectPrefix                 PASS      0.94 seconds
BuildKernel                   PASS      31.71 seconds
BuildKernel32                 PASS      27.35 seconds
Incremental Build with patchesPASS      36.12 seconds
TestRunner: Setup             PASS      441.79 seconds
TestRunner: l2cap-tester      PASS      15.41 seconds
TestRunner: bnep-tester       PASS      5.96 seconds
TestRunner: mgmt-tester       PASS      102.57 seconds
TestRunner: rfcomm-tester     PASS      7.97 seconds
TestRunner: sco-tester        PASS      7.87 seconds
TestRunner: smp-tester        PASS      8.00 seconds
TestRunner: userchan-tester   PASS      6.63 seconds



---
Regards,
Linux Bluetooth


--===============7475406081154361035==--
