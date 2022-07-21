Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175CAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 07:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiGUHOp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiGUHOo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 03:14:44 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7E7B1DA
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 00:14:43 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id v185so690100ioe.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=M7JXNK2g7pKfxATgEekX4yHfU+/3D8yMcEHyHIElWlY=;
        b=BH5mMhoUKhyWxjbThozgL6E1lKUg/Xbccd9Dudt85F3ugpqhJokig5HaBRimpmG0bB
         t67UdUVFsUN66/bco9WLFoWdgnwfkLX9VEn0noA3QBt6PSTzfOKwxwtGCZ5rnByW9oKf
         8+D3lKzKmMCRnWagTHyiiUeqam3lEdDziA6CXQsCrncK79q97p7N5AwzUudLk8APU60K
         oa0PYCjNbiIsqt7JwSqtxiSgwpjDH/hXxt0Tt5rGxaktnD07oyGygfh7q8eONzvPgHXL
         aztZ2F/9ZhbdQaQPbGubBq3bfj8/WVdTBWkm9VOI5FI/vTi1E4Rlup1ECf8tDfeX3fQr
         bbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=M7JXNK2g7pKfxATgEekX4yHfU+/3D8yMcEHyHIElWlY=;
        b=qORhBBV5jdpVFsItRSNIsF9Jj6VK6W99KdrC2zP4emZe+oFjRFhn+MzCRExkTielyy
         wqBf/qmtNh3z4QFZdD6tkZp2DDpMqSXhBkrm9Wl2BA94nkNWSgPK+q/hw+6euThSAiH6
         o/4dQdQLKUi2m+OicpFnNN8lSA2JMRDD7I3zxEvwx8eGdVdqtZSzCNIwaKVrE6VBMjgK
         orHC6cXBTyLyMIU72ADgOYZbXYBx/k1M7AmusnoTpis376Jd2o+6Ce5EniJ8OCMAx3CB
         SOraq9lsB2emIGKoXvETuJ/ZiolmjOQ+QTvKC9WC2ouWtAd0kVAA6cYOTQOR2isIYEUr
         0Q3g==
X-Gm-Message-State: AJIora/7yvsUWb9ow9+rUJ19Tf8C5cCne+DwaPZiR85L2+/70wi897cQ
        iDD07uAheQdgX9dP/JFh1PU586QVxyA=
X-Google-Smtp-Source: AGRyM1uT7ms19BuQD5pLz4E4Xhxcku2B1etW5C68iCLRLo7ca0Fts8haflUqegfwvXsXliGYf/shEg==
X-Received: by 2002:a05:6602:1355:b0:63d:a9ab:7e30 with SMTP id i21-20020a056602135500b0063da9ab7e30mr19319326iov.119.1658387682496;
        Thu, 21 Jul 2022 00:14:42 -0700 (PDT)
Received: from [172.17.0.2] ([40.69.150.96])
        by smtp.gmail.com with ESMTPSA id d39-20020a0285aa000000b0033f07b375b8sm472751jai.52.2022.07.21.00.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 00:14:42 -0700 (PDT)
Message-ID: <62d8fce2.1c69fb81.6caeb.05b6@mx.google.com>
Date:   Thu, 21 Jul 2022 00:14:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6928278153450079382=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Bluetooth: Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1658383473-32188-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1658383473-32188-2-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6928278153450079382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661704

---Test result---

Test Summary:
CheckPatch                    FAIL      1.73 seconds
GitLint                       FAIL      2.68 seconds
SubjectPrefix                 PASS      2.42 seconds
BuildKernel                   PASS      35.75 seconds
BuildKernel32                 PASS      31.50 seconds
Incremental Build with patchesPASS      94.85 seconds
TestRunner: Setup             PASS      537.66 seconds
TestRunner: l2cap-tester      PASS      17.25 seconds
TestRunner: bnep-tester       PASS      5.91 seconds
TestRunner: mgmt-tester       PASS      99.66 seconds
TestRunner: rfcomm-tester     PASS      9.39 seconds
TestRunner: sco-tester        PASS      9.13 seconds
TestRunner: smp-tester        PASS      9.18 seconds
TestRunner: userchan-tester   PASS      6.10 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.73 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2,1/4] Bluetooth: hci_sync: Check LMP feature bit instead of quirk\ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: unsaf ("ace/src' is owned by someone else)")'
#81: 
the quirk was introduced by 'commit cde1a8a99287 ("Bluetooth: btusb: Fix
and detect most of the Chinese Bluetooth controllers")' to mark HCI

total: 1 errors, 0 warnings, 0 checks, 23 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12924756.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 2.68 seconds
Run gitlint with rule in .gitlint
[v2,3/4] Bluetooth: btusb: Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for fake CSR
1: T1 Title exceeds max length (82>80): "[v2,3/4] Bluetooth: btusb: Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for fake CSR"




---
Regards,
Linux Bluetooth


--===============6928278153450079382==--
