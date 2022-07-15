Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85FBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jul 2022 09:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiGOJI4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jul 2022 05:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiGOJIy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jul 2022 05:08:54 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B259013E85
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jul 2022 02:08:52 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b25so2342170qka.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jul 2022 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+pOnAYWXSzOAKoviEnPMWRQMjbpQDHL1cnw7nFcBnvw=;
        b=SUtr9utWSwuRlgbakBmBxCryB72TD5UBDP72RwTp4tr2B8uDJJRg7R3Hv3T0RMc+S2
         6Y1WyjdsqXg2EzESypGQt4EuQjVTJgfha0gcsnq/SRrDUO75LqxHJVe/9+G7kXdumXZT
         5lxqSNBWj+CO0TkwE5wESF/HKl1GFBwlDMa2h/EdJfpMWr5Zj/WdL8w17gIn5M+Z7hs5
         Nf0Da4fu7kW0x5Vn7oif8jyN8Wtry1zMT+Gsd3ZpbG/ydWT113n787htWV59+egkalmo
         MzfSa9OyCn3eiY4m/FVOfL8d8xONY1+6fZkd2I83F/+KQsFjMATxQtxyHqpyl16fYMcw
         qxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+pOnAYWXSzOAKoviEnPMWRQMjbpQDHL1cnw7nFcBnvw=;
        b=iOVQAjeyNjWaOmNzvoJ/N7sBIA0ezrQssZztz687hToqLWkHN1z/JoQThB6TGVSb5K
         yQzLsJnNdeO9uITnrfIEz46/Q895FXxURHzp0obFPdLLxbtjaMHooiXEQDKh1Slaa0Tw
         QdO5faWE+K0IrcXLPTmgEra2lvWOwHZ1v7A9hujo2NoHsn+yXRf2oANOEMoskeHn77yp
         VRSebstxBqpO9yFVQjb8TRLgDX8t9yUAakW/1LFB69Yste5OevVGl88GU2wBqCENGxhv
         1hjyhQEI/RBJ7Noz2GyDp5rbP56Ly8u3j5LOSc9Si5sVOzewsUDNowXgZw2JYyYr/Bz5
         cWJA==
X-Gm-Message-State: AJIora/a1EORFHpXRSd/M7jTXU6/0Mpd7jNUXNyMsHhRG9L2RP2CzNYk
        twQTZLFdvycJmX/9DkoZxkjkjjWT+bw=
X-Google-Smtp-Source: AGRyM1svpoNUHB2RFE86UGZzxkMHzCumDYEdYshGWXkwGgQdOHz5FXNAo7tqBbZ1WfUdLqh6yMDmNQ==
X-Received: by 2002:a05:620a:2901:b0:6af:ca8:3f9f with SMTP id m1-20020a05620a290100b006af0ca83f9fmr8985515qkp.578.1657876131444;
        Fri, 15 Jul 2022 02:08:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.124.126.128])
        by smtp.gmail.com with ESMTPSA id bi1-20020a05620a318100b006b258b73eeesm3565392qkb.120.2022.07.15.02.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 02:08:51 -0700 (PDT)
Message-ID: <62d12ea3.1c69fb81.d0f76.7664@mx.google.com>
Date:   Fri, 15 Jul 2022 02:08:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1616855783615748766=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v4] Bluetooth: hci_sync: Remove redundant func definition
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1657871102-26907-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1657871102-26907-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1616855783615748766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659977

---Test result---

Test Summary:
CheckPatch                    PASS      2.14 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      32.11 seconds
BuildKernel32                 PASS      28.11 seconds
Incremental Build with patchesPASS      38.59 seconds
TestRunner: Setup             PASS      480.85 seconds
TestRunner: l2cap-tester      PASS      17.33 seconds
TestRunner: bnep-tester       PASS      6.09 seconds
TestRunner: mgmt-tester       PASS      98.87 seconds
TestRunner: rfcomm-tester     PASS      9.63 seconds
TestRunner: sco-tester        PASS      9.40 seconds
TestRunner: smp-tester        PASS      9.34 seconds
TestRunner: userchan-tester   PASS      6.30 seconds



---
Regards,
Linux Bluetooth


--===============1616855783615748766==--
