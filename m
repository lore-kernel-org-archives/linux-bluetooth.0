Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771F1C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 14:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiKUOSj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 09:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKUOSH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 09:18:07 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3AD1DF
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 06:17:59 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-13c2cfd1126so13806994fac.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 06:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ALT5YVVYG6lkx1Ks8P5NY21jQ+FyQABHDdWBiMXcWAU=;
        b=DGxazmgCY2bswSXem9UTC0DG8SJ4Nw9dPXBngHi0Cw6p6q8lTAc2cG1sOC3xd37/I3
         WxEV67mN2tDpNd6GwuNzk09svEQNg667bi1GA8G1tPSrFwhZC1cYuajTi/jN5XDZZ6BL
         EtnS4UOyIXn1FMpGy0hx2LnxeCJz7ojuYANok7U5Hu07UAjjOP4gt4wzqk5DsHkKQXDF
         DsbbQzXyXbmC9+0v5o4NdwS8u6eRDl2Gp7SxydZVh45kCSYjuCotHbyxqAv4E3v7SuJd
         v31YUI1kj5x8nUi7tIJqNbhxy+kKvhIDqsqwrtUE2VtIRoex4b+AlMqn2qvl6zh2b+ss
         E/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALT5YVVYG6lkx1Ks8P5NY21jQ+FyQABHDdWBiMXcWAU=;
        b=wQ2/u5F1xE9Ll0sYxFVl/02ir2r+Y/wnhaIwOrmipg2y6XGaUWJTmz7X4Xmcrcq8b8
         PW1rT5T693leRGu2WgMRHRwlEOegQS85Mcv+UeKdWUHOxPh8x9MBnpagraUtN4gbkyNZ
         4WGYV9q4ymhi947drgG5AOEeOHI0w2DsWUy2WCQ52mdOLXhrAaAoS6yltoSiF5EBlvwW
         07+E5c2EJT75LwCR2FA5snggE/s1J5dNizNtyqt1UfpNvC7ftNrHNkxLA1L+SxNp0++D
         ac64DvWz8CmWEWb0eSOLrKkLgUa1448quCC1+9F3axpwQrt8QLk3omjengDpfon7uA0w
         jKvw==
X-Gm-Message-State: ANoB5pnbiZOSWIexN+ZHUBG3ME66VIwLTDSeAtBHRseNNKmuN4GW5Tky
        qJEHisVsHYdNTwN83FBTMUMtMmCKH+E=
X-Google-Smtp-Source: AA0mqf4rQneplqEdJlAAWId1IQq162lBMnlXMemAEyXOwOb/XIZfuxs0NCX3Rg8QDQEOe4XioRf2Iw==
X-Received: by 2002:a05:6870:6707:b0:141:aba2:f9c4 with SMTP id gb7-20020a056870670700b00141aba2f9c4mr335436oab.273.1669040278911;
        Mon, 21 Nov 2022 06:17:58 -0800 (PST)
Received: from [172.17.0.2] ([20.165.47.196])
        by smtp.gmail.com with ESMTPSA id i18-20020a9d68d2000000b0066ac42bc8a4sm4883449oto.33.2022.11.21.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:17:58 -0800 (PST)
Message-ID: <637b8896.9d0a0220.d7a50.19a9@mx.google.com>
Date:   Mon, 21 Nov 2022 06:17:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7143523017370998338=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dimitri.ledkov@canonical.com
Subject: RE: [v3] Bluetooth: btintel: Correctly declare all module firmware files
In-Reply-To: <20221121132604.1298992-1-dimitri.ledkov@canonical.com>
References: <20221121132604.1298992-1-dimitri.ledkov@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7143523017370998338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=697625

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      43.48 seconds
BuildKernel32                 PASS      39.61 seconds
TestRunnerSetup               PASS      550.33 seconds
TestRunner_l2cap-tester       PASS      19.53 seconds
TestRunner_iso-tester         PASS      20.84 seconds
TestRunner_bnep-tester        PASS      7.13 seconds
TestRunner_mgmt-tester        PASS      134.76 seconds
TestRunner_rfcomm-tester      PASS      12.01 seconds
TestRunner_sco-tester         PASS      11.38 seconds
TestRunner_ioctl-tester       PASS      13.14 seconds
TestRunner_mesh-tester        PASS      8.89 seconds
TestRunner_smp-tester         PASS      10.72 seconds
TestRunner_userchan-tester    PASS      7.29 seconds
IncrementalBuild              PASS      42.55 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: btintel: Correctly declare all module firmware files

20: B2 Line has trailing whitespace: " "


---
Regards,
Linux Bluetooth


--===============7143523017370998338==--
