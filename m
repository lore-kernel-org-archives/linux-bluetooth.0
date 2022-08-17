Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7A2C25B08
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Aug 2022 12:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiHQMBp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 08:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiHQMBn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 08:01:43 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262C5844DA
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 05:01:43 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id cb8so10178099qtb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 05:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=TOjEjlTV+Mn9/OEKS2xHjtCvumKP3BTdm9cVIoFio/Y=;
        b=CZ0scJv+ZuzBcG80OtzCxU9VFJCG0YyMYwULSZhkg9uQ8TVMBKDHYBO2pB4Y35jIor
         1O4tfRXHqU5Zb11/pC/9BNDQIO0l0Ada2CjM5sSxGZvPZ9hANx0MrlL61lRWJqdjhGhh
         /PooKqEaC+j/XqrEGG9a1RSIhDxQn2VMaBaJyvdHaEOgyEnS3TOnCRvhyjXC4+TzjY0L
         2WKnEJw4OPfzdwypFdDBaBzKlB/s7SPva/MzSllUI7lNIojwgYBPFbsCvFUCqvMgfxA0
         7ksNTYvQs3h+5dmIGSVcv8PMExKBg0JFRYrktMYvDt40LvpC1LeJ2dFehfyCne4rGx9j
         xnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=TOjEjlTV+Mn9/OEKS2xHjtCvumKP3BTdm9cVIoFio/Y=;
        b=nLoI36QnzNmsem03e+E9S+hy20vYCHZcAFqDrSQK2QNkrX69hGz+MMEa9MXyjKYMv1
         2SfvWVJAbd7x8HD8Dv1bmXpVSAoLt8D7YJhxE73AkyfqlKSjAnvVyDoty4O8vxjS8afu
         9jR2YZFEE6qdyTL8Qb+Wn9LTkKERFfOFS59ib2HPEPMIo2Wv66QB8u6owk39Ya+SY4NZ
         98TGDdLHIlQDsK/csaOfFsi3rq+PQ9Vlh2OH5oitXwF7IrXku1UZDNjzO5O62NahV+WU
         BMk3TI/oHcWaip3p2HqSkjCR+vER5Bwo1leWG9m1QSUlKSQ8qvp/HagSzUAgb50g17u4
         0qrA==
X-Gm-Message-State: ACgBeo0t8xLiPngIU5OLv0VWKOc8MCarSyHs5zrJ5rZ/zPZ9rKxxYsEW
        F6vF6AECDP6IeaUNak96raxkHrPA7P8=
X-Google-Smtp-Source: AA6agR4icaH0KsGRV0nwlpNiU5LH9K3sV9Vvz26oQ/fn2KKIwWmEzrkZDP7YZqq9Kmz+0ugQaVn/+g==
X-Received: by 2002:ac8:5f4b:0:b0:342:f2d0:5940 with SMTP id y11-20020ac85f4b000000b00342f2d05940mr21945929qta.26.1660737701814;
        Wed, 17 Aug 2022 05:01:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.149.181.206])
        by smtp.gmail.com with ESMTPSA id m6-20020a05620a24c600b006b60d5a7205sm14915473qkn.51.2022.08.17.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:01:41 -0700 (PDT)
Message-ID: <62fcd8a5.050a0220.19ee9.1790@mx.google.com>
Date:   Wed, 17 Aug 2022 05:01:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6701162525115040943=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: RE: Bluetooth: hci_sync: fix double mgmt_pending_free() in remove_adv_monitor()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <ea64b27e-6cbf-fdd5-1f23-aecc3a308e47@I-love.SAKURA.ne.jp>
References: <ea64b27e-6cbf-fdd5-1f23-aecc3a308e47@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6701162525115040943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=668362

---Test result---

Test Summary:
CheckPatch                    FAIL      1.67 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.83 seconds
BuildKernel                   PASS      39.01 seconds
BuildKernel32                 PASS      34.80 seconds
Incremental Build with patchesPASS      49.40 seconds
TestRunner: Setup             PASS      559.58 seconds
TestRunner: l2cap-tester      PASS      19.08 seconds
TestRunner: bnep-tester       PASS      7.71 seconds
TestRunner: mgmt-tester       PASS      115.23 seconds
TestRunner: rfcomm-tester     PASS      11.41 seconds
TestRunner: sco-tester        PASS      11.14 seconds
TestRunner: smp-tester        PASS      11.07 seconds
TestRunner: userchan-tester   PASS      7.90 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.67 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: hci_sync: fix double mgmt_pending_free() in remove_adv_monitor()\ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: unsaf ("ace/src' is owned by someone else)")'
#63: 
commit 7cf5c2978f23fdbb ("Bluetooth: hci_sync: Refactor remove Adv
Monitor") forgot to remove duplicated mgmt_pending_remove() when

total: 1 errors, 0 warnings, 0 checks, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12945738.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6701162525115040943==--
