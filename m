Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1BCC83F17
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Aug 2023 21:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjH2VgG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Aug 2023 17:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjH2Vfk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Aug 2023 17:35:40 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C3124
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Aug 2023 14:35:36 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7928dc54896so139721439f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Aug 2023 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693344936; x=1693949736; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x30sB8UDoNw1Arr1/1MKyEwZODC2cjmWRp5FBp5FMvE=;
        b=luNgCDMIVM84B5G5QOuSGN7Vu0UzZ09DXWdrLrhFX//Qi6ybtmq4lFYgIYSWuAqC/g
         Hcuxc4kamno184SUOwOHcsuQrDRKdj0dPJPFLPw/ccT/J6CskGqL3KeswAvHHkqcblQT
         YHpQWGuJQjluiMDbT21h0si9YEeWhLmHzaQqvl4NneLLY6oXLhViVdOr4Ayr0EhYcsV+
         Khj2h4h8U4jrC8sJzChvHgFwWtwI60L1wduiZWIbOFjVKHDTu7rheS+fxJWBzK6b9meg
         qH5Q+DERBbd0J7b5E0INywNlpLU2/2QJuKRarqJ2WweMzoluQ2mkEAi6NX4D/eahLenY
         g20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693344936; x=1693949736;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x30sB8UDoNw1Arr1/1MKyEwZODC2cjmWRp5FBp5FMvE=;
        b=BF0+QWl5rVwGRXdDl+6eVEIdRwX76zh70XMIa08pifAbEteLYSN5gukw30V64B/xIR
         uehMwLeZk1uwv85Nn/Ih+nMsrnxhaoSHfUqhGHu3IvEQFyrQmsgWuatqGTzOY6cUgjk9
         rha+3H4ADMbtau7BJOuLvqJW7A8Z5Jbppmanpi72OldFtqgXdhbZuouICBAnuLqVW9Rx
         KjjYshim4b6QloWXfrMJnBvl8cYD3x01lV6ba/yH1xB5s+2Q17qIiTxwZIBjjyhG2N+4
         xcVFqgaAEuyW1nSEaIl4Gul6U7nLzxNXB8NStZtQj9ETYmFo3GrX1JM5UdxwjbmSf03d
         WH1A==
X-Gm-Message-State: AOJu0YzoLG9NgvQlziD454EEZkqGtGmnwltfVtMVMJqlUJxZA1uTA8pw
        3suw+glSEsR4htGVu5UGx0WU8PxEbks=
X-Google-Smtp-Source: AGHT+IGDzISvQkcc2ZgnxB3oecr81hsVkUnblhrxZ4R7UMTvKpPlXC9tsXIQmoRltS5nQf7Ud8GcBw==
X-Received: by 2002:a05:6602:2018:b0:787:16db:82c4 with SMTP id y24-20020a056602201800b0078716db82c4mr649104iod.18.1693344935876;
        Tue, 29 Aug 2023 14:35:35 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.60.114])
        by smtp.gmail.com with ESMTPSA id x17-20020a029711000000b0041d73d0a412sm3406365jai.19.2023.08.29.14.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 14:35:35 -0700 (PDT)
Message-ID: <64ee64a7.020a0220.8ba64.4023@mx.google.com>
Date:   Tue, 29 Aug 2023 14:35:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0131360134663627227=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
In-Reply-To: <20230829205936.766544-1-luiz.dentz@gmail.com>
References: <20230829205936.766544-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0131360134663627227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780332

---Test result---

Test Summary:
CheckPatch                    FAIL      0.96 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      35.95 seconds
CheckAllWarning               PASS      35.32 seconds
CheckSparse                   PASS      39.77 seconds
CheckSmatch                   PASS      111.71 seconds
BuildKernel32                 PASS      30.60 seconds
TestRunnerSetup               PASS      472.66 seconds
TestRunner_l2cap-tester       PASS      26.59 seconds
TestRunner_iso-tester         PASS      47.41 seconds
TestRunner_bnep-tester        PASS      12.15 seconds
TestRunner_mgmt-tester        PASS      218.19 seconds
TestRunner_rfcomm-tester      PASS      15.49 seconds
TestRunner_sco-tester         PASS      18.88 seconds
TestRunner_ioctl-tester       PASS      17.38 seconds
TestRunner_mesh-tester        PASS      15.88 seconds
TestRunner_smp-tester         PASS      13.73 seconds
TestRunner_userchan-tester    PASS      10.71 seconds
IncrementalBuild              PASS      28.98 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
WARNING: Unknown link reference 'link:', use 'Link:' or 'Closes:' instead
#90: 
link: https://lore.kernel.org/linux-bluetooth/578e6d7afd676129decafba846a933f5@agner.ch/#t

total: 0 errors, 1 warnings, 0 checks, 30 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13369574.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B1 Line exceeds max length (90>80): "link: https://lore.kernel.org/linux-bluetooth/578e6d7afd676129decafba846a933f5@agner.ch/#t"


---
Regards,
Linux Bluetooth


--===============0131360134663627227==--
