Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB624C4321E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 10:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiLAKdZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 05:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiLAKdA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 05:33:00 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BF1A2821
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 02:32:09 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13bd19c3b68so1625379fac.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 02:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5wZRJpk+Ka/SDa5vmGL95dkvEyEH3SXNXIQ+fhXpfqM=;
        b=WJg6B59MQYnNDaJcIxtRv1ixoBagI5igggh/M/Keum8ZPrNGWo3VCLZoUGYykGfakN
         DaaOTHBNB5UWav39WdVI09qwWP5slgwB2QgzjjSZvZWQlRqQgYZH1RUqpERPDnuyhdLK
         9AT0KymK6/C/F8zroaNnKQPG7msLHW0JkFkVTLeLO1xyf4vpji+YEV01sQANQZkOoUtF
         97kpt20kT7xF56j4Pz+mcsho19TEAqeluBWG5djtXEslAUkx1E4WXsj8HnUtM8O+TdPJ
         IRZt51wDkv7CV8i/mzG9EK44h67B+rkEATMgzirUM8ehhrMclJRwOa/zCAKtstUIAk2P
         mh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wZRJpk+Ka/SDa5vmGL95dkvEyEH3SXNXIQ+fhXpfqM=;
        b=e23Y5TqqAJtLk/rv6ZjkcccS9nbw2qFiUvhLKLN6ETyAjUgxEtoSRGBqxgUgRI9E9j
         EW6fD1vb+TmMzXuXrmf3nj0AHXwXwbeGr9BPoNhBpUvnyb0+PAcAWcGQcH6rO3TtzWqI
         i6g3ykhVacoiZV0XqprSYrxLQvGednzCi/SihQiKTEytsZRS1PUCru3GeNQRpm6YTo5u
         yEXPBBtYlxxyVWk/69G8Uo3LDl3iSSGnkJSs8YrA+yrhqXU9kG/ccbfTJgXSx4SAqc4W
         QP+MYL/SgaTb+3WX13g46NtyCYjNemn3aMFsHtKIhtdLyaKn/EGiBlk9mtRzoWkQMKnB
         LhaQ==
X-Gm-Message-State: ANoB5pktevbhjmTsJQCDT90pp3+sVdhsKLsDFp4+68Oz3Z7D3mK/G6Ot
        vqzVV8grrPO4OYuU14Otp/qrjV7+OpM=
X-Google-Smtp-Source: AA0mqf7bNWW7KsWapGsCc/A3GfcUPPruIzCdeg12rG2NjJZQg2CRs4m9ojfwk1t/V7zSNVi/K170ng==
X-Received: by 2002:a05:6870:81a:b0:143:813a:5ea4 with SMTP id fw26-20020a056870081a00b00143813a5ea4mr15658031oab.198.1669890727823;
        Thu, 01 Dec 2022 02:32:07 -0800 (PST)
Received: from [172.17.0.2] ([104.210.215.171])
        by smtp.gmail.com with ESMTPSA id y201-20020a4a45d2000000b004a08307dc14sm729678ooa.8.2022.12.01.02.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:32:07 -0800 (PST)
Message-ID: <638882a7.4a0a0220.f3244.38f1@mx.google.com>
Date:   Thu, 01 Dec 2022 02:32:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2257505726687672992=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lifangpi@hotmail.com
Subject: RE: [v4] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
In-Reply-To: <SI2PR02MB4603E18266419AF72EB5864BDD149@SI2PR02MB4603.apcprd02.prod.outlook.com>
References: <SI2PR02MB4603E18266419AF72EB5864BDD149@SI2PR02MB4603.apcprd02.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2257505726687672992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=700773

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      34.83 seconds
BuildKernel32                 PASS      31.07 seconds
TestRunnerSetup               PASS      428.94 seconds
TestRunner_l2cap-tester       PASS      16.10 seconds
TestRunner_iso-tester         PASS      16.47 seconds
TestRunner_bnep-tester        PASS      5.53 seconds
TestRunner_mgmt-tester        PASS      107.12 seconds
TestRunner_rfcomm-tester      PASS      9.49 seconds
TestRunner_sco-tester         PASS      8.91 seconds
TestRunner_ioctl-tester       PASS      10.26 seconds
TestRunner_mesh-tester        PASS      7.01 seconds
TestRunner_smp-tester         PASS      8.73 seconds
TestRunner_userchan-tester    PASS      5.84 seconds
IncrementalBuild              PASS      32.32 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU

46: B2 Line has trailing whitespace: "	"
46: B3 Line contains hard tab characters (\t): "	"


---
Regards,
Linux Bluetooth


--===============2257505726687672992==--
