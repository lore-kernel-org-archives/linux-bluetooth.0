Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8502FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 23:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444904AbiEFXIU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 19:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343967AbiEFXIT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 19:08:19 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245731360
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 16:04:34 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id kj8so6430044qvb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 16:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TSW7Ky2+39q78nKbzZa0TnFpYW+RNZTIWVZXfxwzAKQ=;
        b=FevivayEUaAF420/ByMMb5FRFgB0A5aUuwAfQIF96yGdSZMkefLv4yLD24KRQZ7Ka+
         C8VGxT9Nm+yEEo5GxirO4R3erqg1H89QdvxHmFMkqC1po04Ec+vdcI4kt55a/qdBJoJ9
         bbCnD2LlGqITw9Z9yAnCJZVVtnU1zX8uh7KZfSh/1zDw8gilFkrcsKcLoRJ/DT+5J1Ki
         vADA34NpJE7WLlCTn+cTMkkWUATsonJLX1MSq3lltcZjDU6JfoK37i3lWf08x2q0J0mY
         DMrkIz59EYSVybmbCWiTNzMLHK78bDC0/aJmdODdsF0IXSPQMgZ8MVL5nJqzTK2Fonkg
         icqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TSW7Ky2+39q78nKbzZa0TnFpYW+RNZTIWVZXfxwzAKQ=;
        b=GWFnPTgYNExWiPceExFWD8ioy8maMFGoV2XUsV3EO6Ko5rD4OV3mfJjcx580+4FU52
         gxo6+YOalSOV618z2GO/Ydu9MJSHGVH6DqR1z4oCNBGTltZIs3QdaXE6I96tqV08oGG2
         BDKWDzyQodV2K0ta/KfLp9sE4Wd4NgoRoCl0qgfOoMSXm5fEvWjfVFVX++FUeRdaev0V
         ULXZ2tbal2T4OUSwmNpPvf7z/YrwcSVacAU9+Dxv1bbUfE3t3wQsNZudqX+zK28EXXwW
         qit72mF/FVYJjFKSHUGXv8OZaCnOzE33C+sq1yVv6vwKYiT6hex3C4AED8uxIylPIKJD
         /i9w==
X-Gm-Message-State: AOAM531lbUmBdwBOtSvkmM8Z5xQkFbG3lKKA9I6ZrizWEhCwR9xIuH98
        NC/0BoGevf3p3DAln4GHswnQHSygU1tmZw==
X-Google-Smtp-Source: ABdhPJzxzUHwQHCtEzIOh8LlAVfE0lHJkSHZy4TlKULzuzlhHNyfhP4daRp1WMyE/S070zTnMx3DvQ==
X-Received: by 2002:a05:6214:260d:b0:45a:e401:66ed with SMTP id gu13-20020a056214260d00b0045ae40166edmr4176811qvb.37.1651878273705;
        Fri, 06 May 2022 16:04:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.232.127.249])
        by smtp.gmail.com with ESMTPSA id d16-20020ac86150000000b002f39b99f6a5sm3452966qtm.63.2022.05.06.16.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 16:04:33 -0700 (PDT)
Message-ID: <6275a981.1c69fb81.92327.34c5@mx.google.com>
Date:   Fri, 06 May 2022 16:04:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7392779977388121341=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/8] Bluetooth: eir: Add helpers for managing service data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220506215743.3870212-1-luiz.dentz@gmail.com>
References: <20220506215743.3870212-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7392779977388121341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639251

---Test result---

Test Summary:
CheckPatch                    FAIL      17.02 seconds
GitLint                       PASS      8.58 seconds
SubjectPrefix                 PASS      7.54 seconds
BuildKernel                   PASS      30.93 seconds
BuildKernel32                 PASS      29.11 seconds
Incremental Build with patchesPASS      186.72 seconds
TestRunner: Setup             PASS      468.99 seconds
TestRunner: l2cap-tester      PASS      16.91 seconds
TestRunner: bnep-tester       PASS      5.90 seconds
TestRunner: mgmt-tester       FAIL      99.29 seconds
TestRunner: rfcomm-tester     PASS      9.70 seconds
TestRunner: sco-tester        PASS      9.19 seconds
TestRunner: smp-tester        PASS      9.46 seconds
TestRunner: userchan-tester   PASS      6.02 seconds

Details
##############################
Test: CheckPatch - FAIL - 17.02 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2,4/8] Bluetooth: Add BTPROTO_ISO socket type\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#177: 
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 1682 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12841667.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v2,5/8] Bluetooth: Add initial implementation of BIS connections\WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#848: FILE: net/bluetooth/hci_conn.c:814:
+ * */

total: 0 errors, 1 warnings, 0 checks, 1885 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12841668.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: mgmt-tester - FAIL - 99.29 seconds
Run test-runner with mgmt-tester
Total: 493, Passed: 491 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.087 seconds
Read Exp Feature - Success (Index None)              Failed       0.087 seconds



---
Regards,
Linux Bluetooth


--===============7392779977388121341==--
