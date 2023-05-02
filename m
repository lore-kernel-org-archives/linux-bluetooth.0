Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B399C19F20
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 21:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjEBV5n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 17:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEBV5m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 17:57:42 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813151704
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 14:57:40 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f0b299d739so20782771cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683064659; x=1685656659;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pMGVUKrj3uT/NUePyWsHuEnttSo1QVfGGZ0dNz90jZI=;
        b=dTZwlI705WziNoeQh4oHsVRnV0fG4oTNfCxv0JXkCmv/Cbyebo8mslDG/EMfZXvK1K
         PxbMEGH7XMGuZg41ODmmrCdkAsdaEeBYlo7A19jd0iChMQn4sevyp3w1SLDvtRCS8TpA
         nSFvgTwXPw9zWCz81rAt5zzxXoQWT7+vNKwp1dHRI0vvYeamFjcdLnafPLPomUJWl1iN
         IaEqPwd1Kygudaxmy83jSkUWKAEM+StPaVbHU+/ltUI04EIABizcrmrPMYvrW0naULqF
         VPt5/AjR8e1tZ/ZfC3N2rAnj5WNGBVc+aOvpeI4hKPDois2JrGl8b+SRpGZwicLBgpHm
         d1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683064659; x=1685656659;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMGVUKrj3uT/NUePyWsHuEnttSo1QVfGGZ0dNz90jZI=;
        b=KLr4Bkieh/Z4hgl+RubUarXYPkc9LxKau+xZricn0OJVQ0yOShAxqziVoJrjPzGR66
         DwgaaUwO0TXgxYHiAomI/oMCHYggVEtITswZrCpStH36RAMzoVpRIYs7iEgNInFaFChB
         LPiBkyFxow7iEonI3ZsZIcMltlqE/3Z4Ibfss8hqQsoY2OiBLXD0dCKFFlxMXRO0fKPs
         fynwyxwPQrDgzSjPmqLT1i6V2GSWhybiaaCX6xr6WPAnltSIoyH/6V3j8Mp6DnulEBC0
         f4P3gI2t6ScSZAnXI1Lf2yCiCfsoPvFBkaX3NfYAYBVtrrYF2mYU8AECFuJUwYRhuSiC
         QHsQ==
X-Gm-Message-State: AC+VfDwIMROykoaYQwH6Uq7thDlKFocmsTRTgZ141YHGqPAyiTZbWNaP
        OJG4J7/ppfscmMa7Po5eFyHIg7gMHhSH3A==
X-Google-Smtp-Source: ACHHUZ4qBgrlaog3OtPkgaB4Fp/L35UFds3Tl9j8jqkF9f9qjEbNp5p9GOcRxPonQPF28IOcD4mzvg==
X-Received: by 2002:a05:622a:1a11:b0:3e9:bca:8c2b with SMTP id f17-20020a05622a1a1100b003e90bca8c2bmr30571136qtb.9.1683064659382;
        Tue, 02 May 2023 14:57:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.37.21])
        by smtp.gmail.com with ESMTPSA id bp41-20020a05620a45a900b00748613be2adsm10009444qkb.70.2023.05.02.14.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 14:57:38 -0700 (PDT)
Message-ID: <64518752.050a0220.9ec55.82e7@mx.google.com>
Date:   Tue, 02 May 2023 14:57:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6785229507280676602=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink
In-Reply-To: <20230502212527.1662896-1-luiz.dentz@gmail.com>
References: <20230502212527.1662896-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6785229507280676602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=744510

---Test result---

Test Summary:
CheckPatch                    FAIL      3.26 seconds
GitLint                       FAIL      1.65 seconds
SubjectPrefix                 PASS      0.54 seconds
BuildKernel                   PASS      32.65 seconds
CheckAllWarning               PASS      35.59 seconds
CheckSparse                   PASS      40.56 seconds
CheckSmatch                   PASS      112.78 seconds
BuildKernel32                 PASS      31.49 seconds
TestRunnerSetup               PASS      449.26 seconds
TestRunner_l2cap-tester       PASS      16.56 seconds
TestRunner_iso-tester         PASS      20.36 seconds
TestRunner_bnep-tester        PASS      5.37 seconds
TestRunner_mgmt-tester        PASS      111.98 seconds
TestRunner_rfcomm-tester      PASS      8.60 seconds
TestRunner_sco-tester         PASS      7.92 seconds
TestRunner_ioctl-tester       PASS      9.26 seconds
TestRunner_mesh-tester        PASS      6.79 seconds
TestRunner_smp-tester         PASS      7.88 seconds
TestRunner_userchan-tester    PASS      5.66 seconds
IncrementalBuild              PASS      66.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink
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

/github/workspace/src/src/13229309.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,2/4] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
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

/github/workspace/src/src/13229310.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,3/4] Bluetooth: Fix UAF in hci_conn_hash_flush again
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

/github/workspace/src/src/13229311.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B1 Line exceeds max length (88>80): "Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/"
[v3,2/4] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B1 Line exceeds max length (115>80): "Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/"
[v3,3/4] Bluetooth: Fix UAF in hci_conn_hash_flush again

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
26: B1 Line exceeds max length (88>80): "Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/"


---
Regards,
Linux Bluetooth


--===============6785229507280676602==--
