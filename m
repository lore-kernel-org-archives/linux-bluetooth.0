Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836DFC05027
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Feb 2023 23:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjBNXdG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Feb 2023 18:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBNXdF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Feb 2023 18:33:05 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CF6234C9
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 15:33:04 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id j4so6482211iog.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 15:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5G8DXaV6tlKE1G7KmKT4KdnnRLBPlbmVXjTxyZU3+bs=;
        b=Uw0HdqOIDn/rOkvl34r0xhOdE3F7j93OpfjofQjA1K3ea+Ow0zvdyJBtC9UGM3plcf
         jYm2GJ+MUWTKbUYfN6SXjwrzd4UIBfKHbhExJ9lh8GrBMNl3iPmGyU6uxRHjP/L4EB73
         fsthxsMQelZqoUk9Nx71QMG2PvgbPzg5pUfy1WviHBRoFJV0l4X1OI5frdbpawU4WunN
         R/hhWbJRwBH8IXxbfJ39hFaJ/9RNMhOi02QjcfhlT5A6KSQLCz/Dwb9M6dTNx7uHfg6O
         iXXGbDLQKjM0E0I1Yd1mPtiZ0CIwM/2vBM7bGgT9SFwpj7xA7Olfc/0a53Gp84Ny+cas
         MbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5G8DXaV6tlKE1G7KmKT4KdnnRLBPlbmVXjTxyZU3+bs=;
        b=jh+Uw8vXHR8FeoWIvRIYCJTbg3bgAAnR7vJpkwIwvHxhReMLnsF7wrBXqOuJ73Ej/U
         9kZSAJdHLkL8hY8XnPhwcgBiutVNC+eb9GbeFyyzzFa/e8VL7n3vhiqb9B+qEdSDXY6N
         NUbpISEjjGr7HKnbRKXiA91WFG8Xq1rB3YExmcP6zLl1F8aeia7BLnmnIHvfjR39+Y0F
         zEIpwDoygB/UlzDuL2Zzp43s/OcWuR3QSniuk18K0vivq9DIAoycJPSB6rWnsRXwHrlR
         JFkfAfAP5kVmGYTYkw5CfX0mOxJ01XxVM7HWQANJS3jsepAEwqKAPcXzmmXUCUDVK2Yh
         5WxQ==
X-Gm-Message-State: AO0yUKXZeBvfBENxdnv3ase/5O0S/Y1ZZgm+6vPGSDc0gx1/CeiAaSZc
        9SENhsfRmQb2NC3Metpd5oPsbmCbk3Y=
X-Google-Smtp-Source: AK7set92B+77IylH1qFh9SzxL2o7XowgbgGgbJzxpE/9xxFiRZIvJEZST2c5XvdfWoo8+hxS2WUFnQ==
X-Received: by 2002:a6b:6f10:0:b0:729:d10b:d1f6 with SMTP id k16-20020a6b6f10000000b00729d10bd1f6mr562267ioc.0.1676417583864;
        Tue, 14 Feb 2023 15:33:03 -0800 (PST)
Received: from [172.17.0.2] ([13.86.22.99])
        by smtp.gmail.com with ESMTPSA id y7-20020a02ce87000000b003a9cab5c5e3sm5092319jaq.116.2023.02.14.15.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:33:03 -0800 (PST)
Message-ID: <63ec1a2f.020a0220.1206e.dc79@mx.google.com>
Date:   Tue, 14 Feb 2023 15:33:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0283756324410044223=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: [kernel,v1] Bluetooth: hci_sync: Resume adv with no RPA when active scan
In-Reply-To: <20230214145609.kernel.v1.1.Ibe4d3a42683381c1e78b8c3aa67b53fc74437ae9@changeid>
References: <20230214145609.kernel.v1.1.Ibe4d3a42683381c1e78b8c3aa67b53fc74437ae9@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0283756324410044223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721882

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      31.28 seconds
CheckAllWarning               PASS      33.77 seconds
CheckSparse                   PASS      38.16 seconds
CheckSmatch                   PASS      106.49 seconds
BuildKernel32                 PASS      30.27 seconds
TestRunnerSetup               PASS      430.27 seconds
TestRunner_l2cap-tester       PASS      15.86 seconds
TestRunner_iso-tester         PASS      16.35 seconds
TestRunner_bnep-tester        PASS      5.39 seconds
TestRunner_mgmt-tester        PASS      106.72 seconds
TestRunner_rfcomm-tester      PASS      8.65 seconds
TestRunner_sco-tester         PASS      7.81 seconds
TestRunner_ioctl-tester       PASS      9.10 seconds
TestRunner_mesh-tester        PASS      6.75 seconds
TestRunner_smp-tester         PASS      7.82 seconds
TestRunner_userchan-tester    PASS      5.61 seconds
IncrementalBuild              PASS      27.87 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[kernel,v1] Bluetooth: hci_sync: Resume adv with no RPA when active scan

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
21: B1 Line exceeds max length (100>80): "- Always pause advertising when active scan, but resume the advertising if the host is not using RPA"


---
Regards,
Linux Bluetooth


--===============0283756324410044223==--
