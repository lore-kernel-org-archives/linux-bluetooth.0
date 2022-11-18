Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A202C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 03:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbiKRDuY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 22:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRDuW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 22:50:22 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291C78F3ED
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:50:21 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z26so3746582pff.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba0RHRepAV1Czixc1V3T5Ul2Mmz3b8836zER3Lz7Vbg=;
        b=nmVmNjzPtNAStULHpLrUvWyH0s6qWwIXT1XoM7aZ2CwtyYJNvnJj2C4T66RaXKKkBl
         a4lsdh/Tg4dDWRakLG0bmOu4J9Wa9127ud0s7xKx5T+tWwq+wjQILwxTw0RJQJaJ6ox0
         WgYOkLL7zrfZxPHKhNURa5L4Q4lg4/Javig1X7fuDDOooJTMmox+W7wwrenpcro0tLIA
         3g5krlX9GvxPDDdBTqXMyasYTB0NupvQDzhFRxfTBoVR2vL5JW1FP0eHcal5kanu3nK1
         lnvHUstQVPfFhXw1mCKo95KWFZIi97g7Ar3ujaA4IlcnBoScHz+ItGro4BkG5wVasLhI
         PVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ba0RHRepAV1Czixc1V3T5Ul2Mmz3b8836zER3Lz7Vbg=;
        b=KQHXHavDz1HoyhCXagHbnVZZClxfeUu/SZLE6e7OBA9rx9c3Dm/DkEY+m6mnH/44gu
         MxMgPaI8hObzSLSTTpVx0mx9VX/t8Tq+koZid60QeCbLF0CBvN13lzFIZzIxNTrS9FF2
         8X1WfKhdvyrqyyds/RlCFeHSRFOku/V4UUOzbBvLr0Uh57UMWAOBW2eMvFGnOqCcXP3G
         e6LE8gNwIc8eJsQVcOyrw0GWb8cv4nGuiOY6Kw/QgDGhYUEYw9eN85SE5xgDPPvaimY6
         FTqvcPDImK3hd8sBlvhwAkGxeBDuP2vchauwN0vBPXEa36L/wQqgZaHiqMTd+qYgBj8K
         XLrQ==
X-Gm-Message-State: ANoB5pk8cEv9DSOi68HyFlaPer9a7GMp6g7zrw/2KwQJ2KpgRPHXGARq
        J+s0QEGTgCdJGMPvxbNNryp2F9sjLss=
X-Google-Smtp-Source: AA0mqf6r1kvLuj+anybo6yfeikTePavRfcN3A9mVFKnLYB4RtWK51KFBz4bIIHereiFsSm70iNwxYQ==
X-Received: by 2002:a05:6a00:5:b0:565:af12:c329 with SMTP id h5-20020a056a00000500b00565af12c329mr5971502pfk.48.1668743420343;
        Thu, 17 Nov 2022 19:50:20 -0800 (PST)
Received: from [172.17.0.2] ([138.91.166.160])
        by smtp.gmail.com with ESMTPSA id p188-20020a625bc5000000b0056e32a2b88esm1907835pfb.219.2022.11.17.19.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:50:20 -0800 (PST)
Message-ID: <637700fc.620a0220.92bea.38e2@mx.google.com>
Date:   Thu, 17 Nov 2022 19:50:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4307589975275984932=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org,
        dominique.martinet@atmark-techno.com
Subject: RE: Add serdev support for hci h4
In-Reply-To: <20221108055531.2176793-2-dominique.martinet@atmark-techno.com>
References: <20221108055531.2176793-2-dominique.martinet@atmark-techno.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4307589975275984932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693092

---Test result---

Test Summary:
CheckPatch                    FAIL      1.76 seconds
GitLint                       PASS      0.52 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      39.53 seconds
BuildKernel32                 PASS      36.25 seconds
TestRunnerSetup               PASS      490.82 seconds
TestRunner_l2cap-tester       PASS      17.35 seconds
TestRunner_iso-tester         PASS      17.53 seconds
TestRunner_bnep-tester        PASS      6.16 seconds
TestRunner_mgmt-tester        PASS      117.62 seconds
TestRunner_rfcomm-tester      PASS      10.32 seconds
TestRunner_sco-tester         PASS      9.66 seconds
TestRunner_ioctl-tester       PASS      11.21 seconds
TestRunner_mesh-tester        PASS      7.72 seconds
TestRunner_smp-tester         PASS      9.39 seconds
TestRunner_userchan-tester    PASS      6.36 seconds
IncrementalBuild              PASS      41.59 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,1/2] dt-bindings: net: h4-bluetooth: add new bindings for hci_h4
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#114: 
new file mode 100644

total: 0 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13035921.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============4307589975275984932==--
