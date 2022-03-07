Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10B7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Mar 2022 21:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiCGVCG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbiCGVCD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Mar 2022 16:02:03 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDC56662E
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Mar 2022 13:01:08 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id x3so13054484qvd.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Mar 2022 13:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=d7LPallSeRsQZZfmidBjCatylnSvD8MAgplozc4EjVo=;
        b=BkcPJ6/Jaaf/tcc71/2YTTbn/p4KXN+j4naIvKUHMYl1nVGJZBvP0oPUPQs/oAkkd1
         IsoNjOP1fX0w3SGdvPCwxZuMujII75n7Te+YYazTtjsheippwKwRhM4cbQjaiU77a6Gz
         f13wFcj+2mb7EwCNne6BZARW99Rhsvt7k13d1v6AL2Ix/UjcIBU4gRqXYTA01qMhSThj
         jThfDafELtScBCdXC2LjjpSYOVsvex0D6CCDVmUfE/0s5yCYra+CtjV1DOwzsnr0ZgBj
         TQ1uUgcxOm4KQTOps+VEUwEyEYkeHfXEr4qoftCaqzUaAvnf2fpUMpI5BhR/dsdrDnTK
         9ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=d7LPallSeRsQZZfmidBjCatylnSvD8MAgplozc4EjVo=;
        b=ktym1wrOL/iX2ZvLt1RYitT6CupviRnqmj5X6Od0F7nAGzp2AQMer5vMwpkupcODOT
         6fWcWIAforrgXW1X2DMrIsefDmdlowyFRxdaNYv5oZ8zEhbH06h5RvOUqiPbMpNvUPLN
         sgOs+V8tKUW53PZ6ilIW48g33cAQ7TEPsGw0lMQzroLzNkqbnbjQH+rAsTnQgKLJekJG
         34yfdGArW9WJzeZ8dBLR1toZFFAxCFuR0sXQXp3o2NfRP2CpK/NmN/R8rj/fKP0zPtaZ
         KVTu6xzDzEHuYrBYYA2Yemg/l+oeyyhNC9Nux5yQn9BFwrtSZ1ayBQW80W0im+FLBbWc
         2ktg==
X-Gm-Message-State: AOAM532H59FJ+0mYyxtZWnBxljzsfG/yAgN+3SwN3mWBmNIYxLhry+Oo
        iU4SBxIEwV9H8PO6n+wAKWh1nmaiWPuurQ==
X-Google-Smtp-Source: ABdhPJyesCS51yn7TE9l28JLNZ4n7C8CsTZ/+6CiMluZquMZFek6Kxrz5PTCWwhvSezhgYy7fp20oQ==
X-Received: by 2002:a05:6214:1cc4:b0:431:4cbc:1d91 with SMTP id g4-20020a0562141cc400b004314cbc1d91mr9934259qvd.64.1646686866593;
        Mon, 07 Mar 2022 13:01:06 -0800 (PST)
Received: from [172.17.0.2] ([104.209.146.232])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85e11000000b002ddd5fab777sm9410613qtx.41.2022.03.07.13.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:01:06 -0800 (PST)
Message-ID: <62267292.1c69fb81.bdfe0.344b@mx.google.com>
Date:   Mon, 07 Mar 2022 13:01:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7335133473495240533=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, swyterzone@gmail.com
Subject: RE: [v4,1/2] Bluetooth: hci_sync: Add a new quirk to skip HCI_FLT_CLEAR_ALL
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220307200445.5554-1-swyterzone@gmail.com>
References: <20220307200445.5554-1-swyterzone@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7335133473495240533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=621166

---Test result---

Test Summary:
CheckPatch                    PASS      3.37 seconds
GitLint                       FAIL      2.00 seconds
SubjectPrefix                 PASS      1.71 seconds
BuildKernel                   PASS      30.88 seconds
BuildKernel32                 PASS      27.99 seconds
Incremental Build with patchesPASS      43.99 seconds
TestRunner: Setup             PASS      474.58 seconds
TestRunner: l2cap-tester      PASS      15.58 seconds
TestRunner: bnep-tester       PASS      6.06 seconds
TestRunner: mgmt-tester       PASS      101.13 seconds
TestRunner: rfcomm-tester     PASS      7.73 seconds
TestRunner: sco-tester        PASS      7.61 seconds
TestRunner: smp-tester        PASS      7.62 seconds
TestRunner: userchan-tester   PASS      6.41 seconds

Details
##############################
Test: GitLint - FAIL - 2.00 seconds
Run gitlint with rule in .gitlint
[v4,2/2] Bluetooth: btusb: Use quirk to skip HCI_FLT_CLEAR_ALL on fake CSR controllers
1: T1 Title exceeds max length (86>80): "[v4,2/2] Bluetooth: btusb: Use quirk to skip HCI_FLT_CLEAR_ALL on fake CSR controllers"
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


--===============7335133473495240533==--
