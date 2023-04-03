Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7FDC76196
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 17:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjDCRhX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 13:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCRgq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 13:36:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AAE3592
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 10:36:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ml21so5997874pjb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543401;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=suKU/oJTktSAP24VEb1J3ArkvZUtcCyA9xF+gUACU/I=;
        b=LcY+90ZV0mQKOwmRKvRNWoXMAEdjI2qnztoYch89NwsnUPA+4kwqWd1AyWjkiCnuIM
         gFSnPanHR0b4Daz2+FLQ4UYkS8U1STVUmoCdZ+KzeZnr/MrMWeAlFwCsjQCh5U/f9n0c
         6G4ErCTyxqvmYmQZ93sYigwFsyaaKD2I4N8+Uy8XzxSLZM39Pbo+2EGldfS1zBQkRMeM
         CIXcV0vPrciU9EVALIEsq5IPxb1ANKcmUnOdTfVeFzSujnhIyf33prg6ZjPF/3XOwpmf
         Bq1EYcgd18nUu2WKodXb2+VXMCDkhzgm9BG5lMCppnUGJQdPi50MLtjPQ/m9AqCAqFL7
         HT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543401;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suKU/oJTktSAP24VEb1J3ArkvZUtcCyA9xF+gUACU/I=;
        b=55m3ydom14vRI0pkAVZEOXGZwwGWShojmxNpUeipH9ZD71eERBHuhzhAYScjKmxq6C
         czKFcWTJMiN0ZDMXGnDND+Tn3kK3ELhNZ+/frzRdSs59oN5qtwsh4ky8QpyieWhGweg2
         fO8V7h/N01vEQ7qh3smkFdDEYsUZdfZV4JLlo2JNLUQJHLF2htjjVPPEXcIqcqplCeg/
         XKno3C/d8cBaF4IwZ8p43l4mwyVDz8dTyxO/NXkb9liFIKvoMiFTsnu0H1ymOrDs5qT3
         5XdogupTrud0l9iWKTq5lE2TUuaA/OTMEqFNRcsm4+U+eyKg/ErkDxwY35scExvBLbm5
         KLzg==
X-Gm-Message-State: AAQBX9eESS3DK5qgL521THStDBMpCJIWHMsI/qxO4xYoguOQP1E829jM
        mq4MEZBiYw8hL7uACiKKrD5h+FtvZ7Q=
X-Google-Smtp-Source: AKy350aeiMycWn9VvTzsgzV1mIzqyiS2SPjlB2TYZin4EkkYEU4xLphmp2XHNYs0I0cdlqvPsN4Lgg==
X-Received: by 2002:a17:90b:17c9:b0:237:9cc7:28a6 with SMTP id me9-20020a17090b17c900b002379cc728a6mr41301224pjb.26.1680543401006;
        Mon, 03 Apr 2023 10:36:41 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.166.4])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a31c600b00233b196fe30sm9854320pjf.20.2023.04.03.10.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:36:40 -0700 (PDT)
Message-ID: <642b0ea8.170a0220.cab70.31eb@mx.google.com>
Date:   Mon, 03 Apr 2023 10:36:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1989863308424955603=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, eddy.zhang@rock-chips.com
Subject: RE: Bluetooth: hci_h5: Complements reliable packet processing logic.
In-Reply-To: <20230403162928.118172-1-eddy.zhang@rock-chips.com>
References: <20230403162928.118172-1-eddy.zhang@rock-chips.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1989863308424955603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736467

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       FAIL      0.69 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      40.98 seconds
CheckAllWarning               PASS      44.42 seconds
CheckSparse                   PASS      50.07 seconds
CheckSmatch                   PASS      137.54 seconds
BuildKernel32                 PASS      39.45 seconds
TestRunnerSetup               PASS      569.34 seconds
TestRunner_l2cap-tester       PASS      19.17 seconds
TestRunner_iso-tester         PASS      20.88 seconds
TestRunner_bnep-tester        PASS      6.83 seconds
TestRunner_mgmt-tester        PASS      132.76 seconds
TestRunner_rfcomm-tester      PASS      10.48 seconds
TestRunner_sco-tester         PASS      9.60 seconds
TestRunner_ioctl-tester       PASS      11.50 seconds
TestRunner_mesh-tester        PASS      8.51 seconds
TestRunner_smp-tester         PASS      9.61 seconds
TestRunner_userchan-tester    PASS      7.11 seconds
IncrementalBuild              PASS      37.38 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_h5: Complements reliable packet processing logic.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "Bluetooth: hci_h5: Complements reliable packet processing logic."
14: B3 Line contains hard tab characters (\t): "		........"


---
Regards,
Linux Bluetooth


--===============1989863308424955603==--
