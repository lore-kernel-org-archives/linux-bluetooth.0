Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B4DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 07:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiCEH6t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Mar 2022 02:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiCEH6t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Mar 2022 02:58:49 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91197522CB
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 23:57:59 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id c4so9351288qtx.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 23:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aKQNz2VtncJV5BUmlWhQ0aWN51SBjejd2LIvV1stw8U=;
        b=BbTuKUNGloj2u8GMba1isDA4ttuG0Ev1IuV27avGyrmAvSieJhA/dyGX5V+lZSNLZS
         MIbJ+ZnWdkf+5Sd/BN/UqUSM2aOQpppnAy5VBxJMyBDeW3BI4IT+/tcaQn6Ha0z49mrW
         s2NyH0YpnKDlkyO/g3zoVpFAupU7WOudPIitgpO2dB99cNmdmVVLRd/t+TcTCG0VpboN
         poDl8ioQvlENyLk5EEjZt6BPjWt7rYQfVrC4iyDYLwxPFscYJBJ/Uw40v92UMnhTfXAm
         5WyiEze4tqXUa0vQ0I0651UycdRU4o6r08jM2XXfakS92/ZKoh+p0vrOsI9CCvd+5DD5
         JGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aKQNz2VtncJV5BUmlWhQ0aWN51SBjejd2LIvV1stw8U=;
        b=UPoOduh4E2oJsqzqYBL4IoV+/adMe2UTKbvNPFUfm0vgp5YtLhCifiaWOGR2ljLZkJ
         VqEDf3FnEs17uWHgJ8YFxLHM3aZbP5ZGbQAyQrgB2fIoqLr70qjnjDoFgNJe5Jq9hI4g
         SYCD+8cPS5fBzTDBbbkHOWLdeAIyzwXEoSJcie1uPo/YAL0swxivVWzPHtg8xy3JkKue
         QwqAdmivH+mK6VFFpoTgQfEZGUE2LIuc3IKYhjWZpa5p4FPwjf0F9aPCMJhnBIDINeRa
         PGY3JzxNmgzM84ksgRoQk1zay17kr5cH4mIlkhf4rShDFs+EKCi50Y6ktfd8dtiwb0Pj
         aSyA==
X-Gm-Message-State: AOAM531G23CuEFAeenDQ2uyYNfEslbvwHAqUOGax03YTBOdzRHdXx1aS
        5NlQqpVkVGbLCS8W8Db1De04ZvhgGTw=
X-Google-Smtp-Source: ABdhPJxPKpCpk01kDBer2r1mjCf3hsToUHx0Q/8/POsKkdtjF+pFEd3ookfi90MnUOg26bucFSln3Q==
X-Received: by 2002:a05:622a:148d:b0:2da:5cc0:7647 with SMTP id t13-20020a05622a148d00b002da5cc07647mr2032215qtx.337.1646467078521;
        Fri, 04 Mar 2022 23:57:58 -0800 (PST)
Received: from [172.17.0.2] ([52.184.167.65])
        by smtp.gmail.com with ESMTPSA id s19-20020ac85cd3000000b002de4e165ae0sm4722349qta.75.2022.03.04.23.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 23:57:58 -0800 (PST)
Message-ID: <62231806.1c69fb81.590de.acdc@mx.google.com>
Date:   Fri, 04 Mar 2022 23:57:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1267288052385319118=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, swyterzone@gmail.com
Subject: RE: [v3] Bluetooth: btusb: Add quirk to skip HCI_FLT_CLEAR_ALL on fake CSR controllers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <3b6c7c18-dc48-b924-bd09-3638a5c741a4@gmail.com>
References: <3b6c7c18-dc48-b924-bd09-3638a5c741a4@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1267288052385319118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=620584

---Test result---

Test Summary:
CheckPatch                    PASS      2.12 seconds
GitLint                       FAIL      1.06 seconds
SubjectPrefix                 PASS      0.95 seconds
BuildKernel                   PASS      31.67 seconds
BuildKernel32                 PASS      28.77 seconds
Incremental Build with patchesPASS      38.30 seconds
TestRunner: Setup             PASS      491.73 seconds
TestRunner: l2cap-tester      PASS      15.72 seconds
TestRunner: bnep-tester       PASS      6.20 seconds
TestRunner: mgmt-tester       PASS      102.91 seconds
TestRunner: rfcomm-tester     PASS      7.99 seconds
TestRunner: sco-tester        PASS      7.79 seconds
TestRunner: smp-tester        PASS      7.73 seconds
TestRunner: userchan-tester   PASS      6.47 seconds

Details
##############################
Test: GitLint - FAIL - 1.06 seconds
Run gitlint with rule in .gitlint
[v3] Bluetooth: btusb: Add quirk to skip HCI_FLT_CLEAR_ALL on fake CSR controllers
1: T1 Title exceeds max length (82>80): "[v3] Bluetooth: btusb: Add quirk to skip HCI_FLT_CLEAR_ALL on fake CSR controllers"
24: B3 Line contains hard tab characters (\t): "hci0:	Type: Primary  Bus: USB"
25: B3 Line contains hard tab characters (\t): "	BD Address: 00:1A:7D:DA:7X:XX  ACL MTU: 679:8  SCO MTU: 48:16"
26: B3 Line contains hard tab characters (\t): "	UP RUNNING PSCAN ISCAN"
27: B3 Line contains hard tab characters (\t): "	Features: 0xbf 0x3e 0x4d 0xfa 0xdb 0x3d 0x7b 0xc7"
28: B3 Line contains hard tab characters (\t): "	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3"
29: B3 Line contains hard tab characters (\t): "	Link policy: RSWITCH SNIFF"
30: B3 Line contains hard tab characters (\t): "	Link mode: PERIPHERAL ACCEPT"
31: B3 Line contains hard tab characters (\t): "	Name: 'CSR8510 A10.'"
32: B3 Line contains hard tab characters (\t): "	Class: 0x7c0104"
33: B3 Line contains hard tab characters (\t): "	Service Classes: Rendering, Capturing, Object Transfer, Audio, Telephony"
34: B3 Line contains hard tab characters (\t): "	Device Class: Computer, Desktop workstation"
35: B3 Line contains hard tab characters (\t): "	HCI Version: 4.0 (0x6)  Revision: 0x3120"
36: B3 Line contains hard tab characters (\t): "	LMP Version: 4.0 (0x6)  Subversion: 0x22bb"
37: B3 Line contains hard tab characters (\t): "	Manufacturer: Cambridge Silicon Radio (10)"




---
Regards,
Linux Bluetooth


--===============1267288052385319118==--
