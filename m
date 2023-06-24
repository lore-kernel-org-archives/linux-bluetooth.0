Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50705EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jun 2023 17:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjFXRdO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jun 2023 13:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFXRdN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jun 2023 13:33:13 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D0A1BC2
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jun 2023 10:33:12 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-400813cff23so17999041cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jun 2023 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687627991; x=1690219991;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+hkra1oDx5GGBJB9GGMZi4dTCO3dBtYNofuqj2AULK4=;
        b=dWBM2x/lkfAYLwirIwiRXp9jZIjA9UXTONnzQeTyymfBsnddokg/eFYRDizoeFDRo3
         0RYZySYq1ViwEoiViFgcx4H6kmnbo63c+8gS++tn7z2GgmpICJen2/XxRdktAgIpVzPI
         XjCYxLnNNXLeHilVFLs9HlQSTsg+2aKeCi0IDTKlWvXXXY6IegOT/d2DeA1ScQ++gmBQ
         WbrtDH/mjKqXYuKuezPcrWeg97HvQcVXI7fImPDYTKB2ZwL4x2x3URlulv8ThTjGnrsY
         QnT7jdzLi0oDRFrKdlG2FESL9hVSZl62Zy2Tmk/HMLqutT8hrZFCJSv/uv6LwTQwvA1Z
         if6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687627991; x=1690219991;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hkra1oDx5GGBJB9GGMZi4dTCO3dBtYNofuqj2AULK4=;
        b=B5h968EAAEtwCLS45p9fxwYIBD0geoxFXgBILbAQbDXadh/L4vi/Pl1j+zqIK+5wd3
         vy4EgRxMjUv7We2NZutmbn5UvT3m3yWFHhpBl+THSxFTPsAwXMegDvORWtYmjK39kGQ1
         DDaK6awapX5TNeCorlA1MzFj4DEU76O2wADVDTK55lQeAYpagAKLz2Pi18PhkI8z0JDb
         ixvdv3s04WfrIJEoR5zD7z2V6g0+tf95DjKUCCTpkswyzYM2lqKhCt7GPIXxHA2pG0Hr
         T9K3hJO5trFu+W5nWaRIkmsOYBow+jnEkPgmBNui2nOgWwedT/Q6scNBMFeWBxiF3nhs
         hBAA==
X-Gm-Message-State: AC+VfDz522bpTrFK2EB5KzZN54HY4eilKL9m4aYlBja5ElbzRwDn+qvf
        blybfCzkn3O34p1deyNo09+ywSU64PY=
X-Google-Smtp-Source: ACHHUZ74RrSjoY20qyDf/h6hEkGpZ/RcoZeDE2NAxiT9XCdqK5Mwh5wDkqbB+nsOVArTp3uAOr2ybw==
X-Received: by 2002:a05:622a:1b8c:b0:3fd:e091:3fe4 with SMTP id bp12-20020a05622a1b8c00b003fde0913fe4mr27219185qtb.58.1687627991524;
        Sat, 24 Jun 2023 10:33:11 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.71])
        by smtp.gmail.com with ESMTPSA id o23-20020ac85557000000b003f6bbd7863csm934751qtr.86.2023.06.24.10.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 10:33:11 -0700 (PDT)
Message-ID: <649728d7.c80a0220.423aa.159c@mx.google.com>
Date:   Sat, 24 Jun 2023 10:33:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4835389528226690349=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ruinairas1992@gmail.com
Subject: RE: Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally
In-Reply-To: <20230624170810.298776-1-ruinairas1992@gmail.com>
References: <20230624170810.298776-1-ruinairas1992@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4835389528226690349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=759995

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      33.88 seconds
CheckAllWarning               PASS      37.06 seconds
CheckSparse                   PASS      42.21 seconds
CheckSmatch                   PASS      113.68 seconds
BuildKernel32                 PASS      32.91 seconds
TestRunnerSetup               PASS      468.69 seconds
TestRunner_l2cap-tester       PASS      17.78 seconds
TestRunner_iso-tester         FAIL      25.51 seconds
TestRunner_bnep-tester        PASS      5.99 seconds
TestRunner_mgmt-tester        PASS      137.48 seconds
TestRunner_rfcomm-tester      PASS      9.45 seconds
TestRunner_sco-tester         PASS      8.57 seconds
TestRunner_ioctl-tester       PASS      9.98 seconds
TestRunner_mesh-tester        PASS      7.39 seconds
TestRunner_smp-tester         PASS      8.50 seconds
TestRunner_userchan-tester    PASS      6.08 seconds
IncrementalBuild              PASS      29.80 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 76 (95.0%), Failed: 4, Not Run: 0

Failed Test Cases
ISO Receive - Success                                Failed       0.212 seconds
ISO Receive Timestamped - Success                    Failed       0.203 seconds
ISO Defer Receive - Success                          Failed       0.203 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.202 seconds


---
Regards,
Linux Bluetooth


--===============4835389528226690349==--
