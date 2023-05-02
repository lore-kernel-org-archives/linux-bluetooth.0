Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3755AC77B78
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 21:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjEBVCP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 17:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBVCO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 17:02:14 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BF71734
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 14:02:12 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-38e04d1b2b4so2357105b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 14:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683061332; x=1685653332;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2z8qnu4i+0DMajS25UYRAiuGJkDlcEDFutAOsWFBmaE=;
        b=d5+xxl685rRktuV7+xgWQMRPDyAmDCZvPowApA4BYfqOHpVXPJgzuOdV7QDhqDywRO
         Hd5o6wjCt4sVmV6d6ZV0jNsXK/qpHekaehty8ejC0RxDU4TDmj0VluWVUxn2472P9088
         eggQKqy8VtkvD9mUo4/3KsBpbGsCNeqoDPJOf4+6C/8mEum9do+kLMoyEG/WUJPkSREm
         daym+AkR3sYv0wJI0GoC/sRteFvPEI6gyEizCmuemfH6wvBX7BUa7lNPMsSE3N/2lJmQ
         V3OHhdXxsuXMgSgECEbmj0WejpvwOskrkGfQl4i1OGWh/KTB/Pqy2Zj2xNaq+AGnWWPj
         8FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683061332; x=1685653332;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2z8qnu4i+0DMajS25UYRAiuGJkDlcEDFutAOsWFBmaE=;
        b=Wny5+F7SH+ykT3kyy7fcIULakV07E3QaTHAG+0tpQPeEXm6V6SsrDvnFp+uy31SECT
         Hcq8T8VDhGTXCMliiJS+XZOGFTgaM0epvheAlXte4Guk1fD9bcakihzEnkamun6MymP2
         W6NMLQO6ybijI4MJ3bs/VGEToPpVb51S/gJDoZMGewwsXElrW/NvfFauzSDXy8doX0UQ
         SMn1QuCAc/HXq0gRFRY+g+ZN4G4CW775f3drII9V8h7Xg/yLbgWgNTTqTnX4djrTGmCe
         DHfTj4OcFZvsD+BglCgzRdP/ZNbBid2zDFf9EykXvsRB9gDACOOZyy0u2XGSsA/uEnyY
         nJhA==
X-Gm-Message-State: AC+VfDxWxmw7IhDxLLN9r9vasr5wuWyIlgl0MPu6nKe5wSRZRBA8yKlk
        B5AaIHvwKwx4997/Pyx6OWMmsQQDGsE=
X-Google-Smtp-Source: ACHHUZ6e5R3s+y8qbbysfCnABQMUL4WXzD9GeUeOyRSlVZa+IshcDogkoPwJ1Me6ssQypp2HSnfXWg==
X-Received: by 2002:aca:1c03:0:b0:38e:a7e4:48fe with SMTP id c3-20020aca1c03000000b0038ea7e448femr7918693oic.50.1683061331623;
        Tue, 02 May 2023 14:02:11 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.10.112])
        by smtp.gmail.com with ESMTPSA id o188-20020a4a44c5000000b0053b56462336sm1551986ooa.21.2023.05.02.14.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 14:02:11 -0700 (PDT)
Message-ID: <64517a53.4a0a0220.96abb.a29b@mx.google.com>
Date:   Tue, 02 May 2023 14:02:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0779456044020734854=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink
In-Reply-To: <20230502201534.1500462-1-luiz.dentz@gmail.com>
References: <20230502201534.1500462-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0779456044020734854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=744493

---Test result---

Test Summary:
CheckPatch                    FAIL      3.39 seconds
GitLint                       FAIL      1.58 seconds
SubjectPrefix                 PASS      0.42 seconds
BuildKernel                   PASS      39.43 seconds
CheckAllWarning               PASS      43.86 seconds
CheckSparse                   PASS      49.57 seconds
CheckSmatch                   PASS      132.49 seconds
BuildKernel32                 PASS      38.58 seconds
TestRunnerSetup               PASS      539.76 seconds
TestRunner_l2cap-tester       PASS      19.52 seconds
TestRunner_iso-tester         PASS      25.90 seconds
TestRunner_bnep-tester        PASS      6.81 seconds
TestRunner_mgmt-tester        PASS      131.49 seconds
TestRunner_rfcomm-tester      PASS      10.59 seconds
TestRunner_sco-tester         PASS      9.65 seconds
TestRunner_ioctl-tester       PASS      11.70 seconds
TestRunner_mesh-tester        PASS      8.48 seconds
TestRunner_smp-tester         PASS      9.61 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      81.52 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink
WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#91: 
Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#92: 
Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/

WARNING: Unknown link reference 'Closes:', use 'Link:' instead
#92: 
Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/

WARNING: Duplicate signature
#95: 
Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com

WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#95: 
Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>

WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#96: 
Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com

WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#97: 
Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

total: 0 errors, 7 warnings, 0 checks, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13229266.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,2/4] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#95: 
Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#96: 
Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/

WARNING: Unknown link reference 'Closes:', use 'Link:' instead
#96: 
Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/

total: 0 errors, 3 warnings, 0 checks, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13229267.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,3/4] Bluetooth: Fix UAF in hci_conn_hash_flush again
WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#105: 
Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#106: 
Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/

WARNING: Unknown link reference 'Closes:', use 'Link:' instead
#106: 
Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/

total: 0 errors, 3 warnings, 0 checks, 73 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13229269.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B1 Line exceeds max length (88>80): "Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/"
[v2,2/4] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B1 Line exceeds max length (115>80): "Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/"
[v2,3/4] Bluetooth: Fix UAF in hci_conn_hash_flush again

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
26: B1 Line exceeds max length (88>80): "Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/"


---
Regards,
Linux Bluetooth


--===============0779456044020734854==--
