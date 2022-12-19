Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A462C4167B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Dec 2022 22:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiLSWds (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 17:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiLSWdl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 17:33:41 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DBD14014
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 14:33:40 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id s9so9602648qtx.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 14:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cEKCxErCUNEmpWURajGzkzOu1j8HGWOR8dZ380aw5FE=;
        b=amq77iJtNjpU6Q7QFJSl+BKqlAeLXPJ6oGjpMmBbKKMRXE3r5x9F+itCKjlc922qCB
         3a+ZbHQ+FCbKqeUmCADy13uyiWe0AlhgUptkAutfzs4CVvQ+pMf3xChf/v4ezpAbO9V5
         3szGWqPSczccUQ1yNRseBCuv9yFp4SRqjGvU9P/qXQZVqtuzUq8iOExPYCMWsJW9iEFK
         JJqBx69DOcLuGYGngzKtnqxrN23ZY58w2/T2xC5vpBVSka3NtcbkQMTDbORBw/r5mh3E
         V0jr4Dbt3LQF9eYgPBVibggUCtw7RNHR/QNrJ9fhaxTn20uTGscanQP0kiJSqN9bjB9O
         GVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEKCxErCUNEmpWURajGzkzOu1j8HGWOR8dZ380aw5FE=;
        b=ytR6DmH3avWCsbnIAKx4H1c+nU98prCiUjKawGWIHupJagk6b+qwtqW4O5GZdMo2qU
         LRyPdT6F2krhIOYoVqDwGiDSXTffQh0/81J0I0mDlns18WyHtm7g9/mrKxzZ7eb8ti3g
         FRP30QS1wtvvWxxH7t+FSGPLBOWUTwatWg6ln6pps10PmQ+ZCXYT58Tw4oAAUcaLV9i7
         wcZM3Xcb6jq8vHNHOVsliACNQFboq6BDJ4wOyzEZNJHA8YrvEJJBEViPtxBIfKGTSYZO
         2V31QnpH+rEMJpSzcieNivChh1fPkYqvJ93DNdqqVXfMAfcy6tTECZcHyoQ+cqNvlvqS
         L7ow==
X-Gm-Message-State: AFqh2kr2z6F3TzZgVhvm8qdv67zw/GvKmPs5dj7Mvt3ro2q03gkyutst
        PRrkhF5tXoQTL27iXukEolDPlvAo+dS/xA==
X-Google-Smtp-Source: AMrXdXs5Ax8pCo3ldEp1/JaDLanL1FhnegBJvRRoljENLyLIKSuwMABVPBVe4RbNlaQ7HEc/WQTGFg==
X-Received: by 2002:ac8:5645:0:b0:3a9:6cf8:9b4e with SMTP id 5-20020ac85645000000b003a96cf89b4emr18242102qtt.35.1671489219421;
        Mon, 19 Dec 2022 14:33:39 -0800 (PST)
Received: from [172.17.0.2] ([104.45.203.178])
        by smtp.gmail.com with ESMTPSA id cj23-20020a05622a259700b003a7f597dc60sm6686892qtb.72.2022.12.19.14.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 14:33:39 -0800 (PST)
Message-ID: <63a0e6c3.050a0220.15e9f.4b94@mx.google.com>
Date:   Mon, 19 Dec 2022 14:33:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8675017971559098313=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix use HCI_OP_LE_READ_BUFFER_SIZE_V2
In-Reply-To: <20221219213747.3659867-1-luiz.dentz@gmail.com>
References: <20221219213747.3659867-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8675017971559098313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=705742

---Test result---

Test Summary:
CheckPatch                    PASS      3.22 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      40.47 seconds
CheckAllWarning               PASS      41.57 seconds
CheckSparse                   PASS      46.16 seconds
BuildKernel32                 PASS      36.23 seconds
TestRunnerSetup               PASS      519.98 seconds
TestRunner_l2cap-tester       PASS      19.26 seconds
TestRunner_iso-tester         FAIL      20.55 seconds
TestRunner_bnep-tester        PASS      6.68 seconds
TestRunner_mgmt-tester        PASS      123.47 seconds
TestRunner_rfcomm-tester      PASS      10.35 seconds
TestRunner_sco-tester         PASS      9.39 seconds
TestRunner_ioctl-tester       PASS      11.23 seconds
TestRunner_mesh-tester        PASS      8.27 seconds
TestRunner_smp-tester         PASS      9.32 seconds
TestRunner_userchan-tester    PASS      7.04 seconds
IncrementalBuild              PASS      34.46 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 56, Passed: 49 (87.5%), Failed: 7, Not Run: 0

Failed Test Cases
ISO Send - Success                                   Failed       0.293 seconds
ISO Defer Send - Success                             Failed       0.288 seconds
ISO 48_2_1 Defer Send - Success                      Failed       0.293 seconds
ISO Send and Receive - Success                       Failed       0.290 seconds
ISO Broadcaster - Success                            Failed       0.270 seconds
ISO Broadcaster BIG 0x01 - Success                   Failed       0.261 seconds
ISO Broadcaster BIG 0x01 BIS 0x01 - Success          Failed       0.261 seconds


---
Regards,
Linux Bluetooth


--===============8675017971559098313==--
