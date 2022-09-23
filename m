Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31898ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 06:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiIWGqu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 02:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiIWGqp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 02:46:45 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22A612872E
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 23:46:43 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id ay9so7908839qtb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=S7TgDxeJ4PFaSYX7HSn4tFOgB52lJgCxGYUS1dJKkKI=;
        b=geChas31PCMknpjsJ5Wslck2yOwuPUT6sNDSKlNFYfjBms287rrLOjbWhx94NqGPEQ
         /hW+Pf14aWefMoKYJhPKw4r+AAw010q096TDwTu5FvohNhEYe7DWdAb1hOPgYnNud0Mi
         jpF/gBSYiEN4rsVR8wKHLWkv3YrDcgOZlBJ4vn3x0xXjdMfWpOH2e8oyFf7waPuHx6K+
         IrSYP2qNzBB+xyg/YdPqrhaIoUZMcjAo/HK79ehivggIid1zDobAwkjYQ+xOzCoOE/p+
         9IZZnDYXoeGJq7Dnr/UmUggqoCGHb4Ki4BsuMvo0FJucCj4gw3L4yU6mm/8cWAA42MTD
         1Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=S7TgDxeJ4PFaSYX7HSn4tFOgB52lJgCxGYUS1dJKkKI=;
        b=cmNqgVwEpFKs1Hu1pVK6dbFJrdcPHY43iyJ3TtUAq0dnXQFIoQZBb7KAndW9BVIWx0
         g2hLfhrbkM7MxqvwVwxkUJLhgdtRXhf09Gu2Gyqw3fbhloef4Qc64eZzqRIOSrYlGTeK
         p7GVV2WIipFbUqXWlnWEVae6XI2QjhTSRL2rLRBm+SdwaAVwA22zHd1ONQ8BQQYJ+xZv
         hs5/8luAZzT/bUwouLQ698VbrA1YuEctTjeVrkmHgeTHHQJ11tiOMqsYeFlrsg69x+2v
         HPUcxlc2/KAfYdTJmtGhB5F4T1kPOJtowsZaKpuuzinr61GW+nZaloO9yxk1O/QkXQUt
         FcuQ==
X-Gm-Message-State: ACrzQf1dG5vbubRI/yJxgfDgpfnv+TLNDQlLiJayl3yvTtCdChtfUDkO
        6kBZXsbGorrYaj1YWGiuIi3N5wyQZkk=
X-Google-Smtp-Source: AMsMyM5Hsch8PJz+oAhEx79AhPQ2/9iAVDgF4z6W0J8h7AvB18DdXYUc2dNz9mw8T28mvppM4I2wsA==
X-Received: by 2002:a05:622a:149:b0:35d:287:8a3e with SMTP id v9-20020a05622a014900b0035d02878a3emr5899570qtw.641.1663915602759;
        Thu, 22 Sep 2022 23:46:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.120.18.148])
        by smtp.gmail.com with ESMTPSA id i10-20020ac8764a000000b0035badb499c7sm5225575qtr.21.2022.09.22.23.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 23:46:42 -0700 (PDT)
Message-ID: <632d5652.c80a0220.3482c.3bac@mx.google.com>
Date:   Thu, 22 Sep 2022 23:46:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9169417009614600795=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v6,1/3] Bluetooth: Add support for hci devcoredump
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220922221037.v6.1.I44a65858f594107d3688087dfbdf669fac450b52@changeid>
References: <20220922221037.v6.1.I44a65858f594107d3688087dfbdf669fac450b52@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9169417009614600795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679707

---Test result---

Test Summary:
CheckPatch                    FAIL      3.05 seconds
GitLint                       PASS      3.12 seconds
SubjectPrefix                 PASS      2.73 seconds
BuildKernel                   PASS      35.48 seconds
BuildKernel32                 PASS      31.81 seconds
Incremental Build with patchesPASS      63.14 seconds
TestRunner: Setup             PASS      527.04 seconds
TestRunner: l2cap-tester      PASS      17.42 seconds
TestRunner: iso-tester        PASS      16.74 seconds
TestRunner: bnep-tester       PASS      6.62 seconds
TestRunner: mgmt-tester       PASS      105.17 seconds
TestRunner: rfcomm-tester     PASS      10.40 seconds
TestRunner: sco-tester        PASS      9.85 seconds
TestRunner: smp-tester        PASS      9.89 seconds
TestRunner: userchan-tester   PASS      6.81 seconds

Details
##############################
Test: CheckPatch - FAIL - 3.05 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v6,1/3] Bluetooth: Add support for hci devcoredump\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#146: 
new file mode 100644

WARNING:SPLIT_STRING: quoted string split across lines
#622: FILE: net/bluetooth/coredump.c:300:
+				    "Devcoredump complete with size %u "
+				    "(expect %zu)",

WARNING:SPLIT_STRING: quoted string split across lines
#641: FILE: net/bluetooth/coredump.c:319:
+				    "Devcoredump aborted with size %u "
+				    "(expect %zu)",

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#735: FILE: net/bluetooth/coredump.c:413:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump init");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#778: FILE: net/bluetooth/coredump.c:456:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump pattern");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#804: FILE: net/bluetooth/coredump.c:482:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump complete");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#826: FILE: net/bluetooth/coredump.c:504:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump abort");

total: 0 errors, 7 warnings, 0 checks, 685 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12986135.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============9169417009614600795==--
