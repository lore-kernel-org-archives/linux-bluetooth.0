Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF72C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 15:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjEBPfv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjEBPft (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 11:35:49 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1FAB3
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 08:35:47 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-32b47d6792dso33192685ab.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683041746; x=1685633746;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UdAAGeoL43vRswKQeZ7xfldDs2uiBZNF+WfY7tkTgvU=;
        b=Z7Etn/gHNDzjzRO7f2UdDVGCnf8BTbrSvSjCndXlZ3DaWiK7icw7z6YwgUclB1mLwN
         wi5IGLk6xz4d8XwzF6KI0GRyFcT8lAZlNN+v+QaqJZ/IpCJapFdy1huBU3Tgj7rkfOrF
         dUGcGYg3cmeYB5x9JCbbWr0UN+aubbY3A/jZDonJN3NkeCAyBWyEVu3wt5x72XF5kHnl
         gSgUkpu9++bvU9CgV9ngdndBDjcXOVG/mOpUtMi8sdTznvMPRwvgp+cPiOlS5zL/5TNb
         XltaIWKdtzNpaBvMFSTcGfwUftZGF585q6QMfr0NH9Ne8CiFFDcWEZlra4AMonQr8fh+
         aLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683041746; x=1685633746;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdAAGeoL43vRswKQeZ7xfldDs2uiBZNF+WfY7tkTgvU=;
        b=l/3pIXIfI9SloHtLrpU5vniZN9zYyLnYv7XeEJDbQEIR+4ZGqCyFXwLLoS1wy7Qfsn
         CA4NkewoDkhnQinYLFPwF6aMmKr+84+epp1fih7av3w1p6DkYV2XIdVDRSfdRv35+XyI
         2a+jcxxYOe3jnyqQ2EsoNv18vJ1+U3I9//keBZpYx4pxoYQrqqOVA1A+AUfjsLlQeiJV
         VRSkna+B4N603M4ebVLPtM3Y/vprm7RHPxGxum78XvxrWAhIXtA80FBfXkl/eMgXh6P/
         cGRpuE7W1KXmTOo6vWK8jQKhsQOzSyAoFjCdZC5T1R4Wd/BaIGbcG9ISh/RXwB8XY+Of
         2pRg==
X-Gm-Message-State: AC+VfDwYW7rQnX06DQbeNqZGzaxvLVP7WWtww4FG3DXG+HbD6snkxbXn
        cpFh5thC0uKZNtv19oKpSHXjRbNUgtI=
X-Google-Smtp-Source: ACHHUZ71tu46ojM9d3K/WMtagWJUud7KlB4ah/Ldb70CDV+s8Q/LDl8wictW2+8ZPwXMNM6LyH9hDw==
X-Received: by 2002:a92:d449:0:b0:32a:e727:57ff with SMTP id r9-20020a92d449000000b0032ae72757ffmr11965582ilm.21.1683041746568;
        Tue, 02 May 2023 08:35:46 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.18.87])
        by smtp.gmail.com with ESMTPSA id y22-20020a056638229600b0040611a31d5fsm9134907jas.80.2023.05.02.08.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:35:46 -0700 (PDT)
Message-ID: <64512dd2.050a0220.848c8.ab29@mx.google.com>
Date:   Tue, 02 May 2023 08:35:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8309017907203166884=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lrh2000@pku.edu.cn
Subject: RE: Bluetooth: Fix potential double free caused by hci_conn_unlink
In-Reply-To: <20230502145737.140856-2-lrh2000@pku.edu.cn>
References: <20230502145737.140856-2-lrh2000@pku.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8309017907203166884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=744426

---Test result---

Test Summary:
CheckPatch                    FAIL      4.18 seconds
GitLint                       FAIL      2.05 seconds
SubjectPrefix                 PASS      0.60 seconds
BuildKernel                   PASS      32.22 seconds
CheckAllWarning               PASS      35.05 seconds
CheckSparse                   PASS      39.69 seconds
CheckSmatch                   PASS      110.75 seconds
BuildKernel32                 PASS      31.05 seconds
TestRunnerSetup               PASS      440.47 seconds
TestRunner_l2cap-tester       PASS      16.56 seconds
TestRunner_iso-tester         PASS      20.35 seconds
TestRunner_bnep-tester        PASS      5.36 seconds
TestRunner_mgmt-tester        PASS      113.08 seconds
TestRunner_rfcomm-tester      PASS      8.52 seconds
TestRunner_sco-tester         PASS      7.90 seconds
TestRunner_ioctl-tester       PASS      9.26 seconds
TestRunner_mesh-tester        PASS      6.76 seconds
TestRunner_smp-tester         PASS      7.93 seconds
TestRunner_userchan-tester    PASS      5.61 seconds
IncrementalBuild              PASS      75.99 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/6] Bluetooth: Fix potential double free caused by hci_conn_unlink
WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#83: 
Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#84: 
Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/

WARNING: Unknown link reference 'Closes:', use 'Link:' instead
#84: 
Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/

total: 0 errors, 3 warnings, 0 checks, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13229025.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,2/6] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#82: 
Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#83: 
Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/

WARNING: Unknown link reference 'Closes:', use 'Link:' instead
#83: 
Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/

total: 0 errors, 3 warnings, 0 checks, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13229023.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,3/6] Bluetooth: Fix UAF in hci_conn_hash_flush again
WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#93: 
Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#94: 
Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/

WARNING: Unknown link reference 'Closes:', use 'Link:' instead
#94: 
Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/

total: 0 errors, 3 warnings, 0 checks, 58 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13229024.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/6] Bluetooth: Fix potential double free caused by hci_conn_unlink

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (88>80): "Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/"
[v3,2/6] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (115>80): "Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/"
[v3,3/6] Bluetooth: Fix UAF in hci_conn_hash_flush again

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
24: B1 Line exceeds max length (88>80): "Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/"
[v3,4/6] Bluetooth: Perform hci_conn_drop in hci_conn_unlink

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B3 Line contains hard tab characters (\t): "	hci_conn_unlink(conn)  [conn->parent == NULL]"
14: B3 Line contains hard tab characters (\t): "		-> hci_conn_unlink(child)  [child->parent == conn]"
15: B3 Line contains hard tab characters (\t): "			-> hci_conn_drop(child->parent)"
16: B3 Line contains hard tab characters (\t): "				-> queue_delayed_work(&conn->disc_work)"
[v3,5/6] Bluetooth: Unlink CISes when LE disconnects in hci_conn_del

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B3 Line contains hard tab characters (\t): "	All SCO, eSCO, and CIS connections on a physical link should be"
14: B3 Line contains hard tab characters (\t): "	disconnected before the ACL connection on the same physical"
15: B3 Line contains hard tab characters (\t): "	connection is disconnected. If it does not, they will be"
16: B3 Line contains hard tab characters (\t): "	implicitly disconnected as part of the ACL disconnection."
17: B3 Line contains hard tab characters (\t): "	..."
18: B3 Line contains hard tab characters (\t): "	Note: As specified in Section 7.7.5, on the Central, the handle"
19: B3 Line contains hard tab characters (\t): "	for a CIS remains valid even after disconnection and, therefore,"
20: B3 Line contains hard tab characters (\t): "	the Host can recreate a disconnected CIS at a later point in"
21: B3 Line contains hard tab characters (\t): "	time using the same connection handle."


---
Regards,
Linux Bluetooth


--===============8309017907203166884==--
