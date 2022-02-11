Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBCEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 09:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348187AbiBKJEf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:04:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348274AbiBKJEe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 04:04:34 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26605B53
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 01:04:34 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id c189so7720149qkg.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 01:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=90CZo7azyvQyTmjjfWpSwKhMw9idfyDR48ymng0w6U4=;
        b=qjoSYk/428A+z7uwzYvmIgnaRDHSlju6pUwr6eyh0i4TDpcDqOQ83pT2ki89qk6Wnx
         Kto3Oz8MXwgBrJaUBAngLKCCUmRE4JEl/g16gv1C7EuFhQ+BxGc2yg3YoLNlZmKRrfIH
         E7CXVXwXEJsONDLxOqfoV97YMsn7/M493r8PcftrXnVwhZMBe6imBXbcC/xECqkiBWhi
         lBiAVZ8mFrVRB7BCoLcLf6WmXdxtRaDZ4OyOALHFfJaZVzldj3lGWWwWd3r7srudNrIJ
         mweySNpttn12ghq8oEkgZuO2k7DAa3VfhDPyr8arDzzBKHnVQZp3qNUdtEVVuZFjN4dA
         +ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=90CZo7azyvQyTmjjfWpSwKhMw9idfyDR48ymng0w6U4=;
        b=KUT7qYvOj5EoJfod9dbrsw+pM4Z4vbzNfzt5dGqfiinYRnL30u8bWGL63bBUcAcTj1
         W2UDXOw6oZV7FMJ/Gk5WfhnnAA734PAVaMkK/rO0zeAHqk2hLOA8eham4SY+JE/Gb2X+
         HHYCpqOTjsxPxmXCwpbsLe7vQdQGtIIS+iXIEqTM7wJE2oDuCqrEiFTf0aj8GDAOWEbW
         5wHMkoNOuS2ZlAZN7msDopudRJaGNhFPb8QkRpDrOrgkfXGc8WGhzkL/7QkiiDMDX8oe
         hvPIkWB3sCSG7hwvzdlSude4+V6T8WmTjdJpLo63rUIr/ni0zypnJ/nlj4cHo3TKytuc
         /S+g==
X-Gm-Message-State: AOAM532Qf247ub/RuoQRqopGFifwHv0ztbWAZhvvGxsT/lqdVVZ9V8gx
        8620hgqAAZmIBpaKf2OZFrcyLEiuOcj3zg==
X-Google-Smtp-Source: ABdhPJzRoLvKBFaw29NzMMNPDCBXnVf3bJi7dMMX0PeH5ZTCiQXbemHgyscDjn5Jc4fBy2V4D5jA5g==
X-Received: by 2002:a05:620a:414f:: with SMTP id k15mr240112qko.564.1644570273029;
        Fri, 11 Feb 2022 01:04:33 -0800 (PST)
Received: from [172.17.0.2] ([40.117.47.84])
        by smtp.gmail.com with ESMTPSA id j11sm12204334qtx.67.2022.02.11.01.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:04:32 -0800 (PST)
Message-ID: <620626a0.1c69fb81.83aea.325c@mx.google.com>
Date:   Fri, 11 Feb 2022 01:04:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1510696376546208312=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zijuhu@codeaurora.org
Subject: RE: [v2] Bluetooth: btusb: Improve stability for QCA devices
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1644566620-16748-1-git-send-email-zijuhu@codeaurora.org>
References: <1644566620-16748-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1510696376546208312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=613387

---Test result---

Test Summary:
CheckPatch                    PASS      1.65 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      30.51 seconds
BuildKernel32                 PASS      27.10 seconds
Incremental Build with patchesPASS      37.19 seconds
TestRunner: Setup             PASS      474.61 seconds
TestRunner: l2cap-tester      PASS      13.49 seconds
TestRunner: bnep-tester       PASS      6.11 seconds
TestRunner: mgmt-tester       PASS      104.89 seconds
TestRunner: rfcomm-tester     PASS      7.80 seconds
TestRunner: sco-tester        PASS      7.87 seconds
TestRunner: smp-tester        PASS      7.64 seconds
TestRunner: userchan-tester   PASS      6.38 seconds



---
Regards,
Linux Bluetooth


--===============1510696376546208312==--
