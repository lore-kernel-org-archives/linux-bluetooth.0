Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26099E810AC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 08:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjI0IpA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 04:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjI0Io7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 04:44:59 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2F1EB
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 01:44:57 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c0a3a2cc20so6171691a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695804296; x=1696409096; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jYV/b+hsoYrwr+TVPX0NlcuNwZXGt6NdGj883a3mEHU=;
        b=EhYC8lJ8aBhHkAh1sHfqyC/KCvVjVUE0Av0mJxDaQ3XcyErk4M1fTuklIMjzT5FRe+
         WF418eOXUxJRpKwOcG84Qfh6w28XeDnoWD4Ee1c4SvNG4voCCB3CcghKTytuUNJuaisi
         Rxq1lGVbRDDMDgs/9GiilCT7VKXP8iiHVuGvk7rYiR7ICRLuDGiJusUX9ZJknnloKdSN
         9TaK97EtUurh05NVJtmjt2Z3erDkOtPdKM6EgWWt9tgpwewq4XMy2kjuoXE+fDMLPCP0
         b46AlYEAGWIJGmtJtVLAE6fumY8cotAdgbdNjtVryIjYK38t/Uj9R97ZP4Dd0vX2XMOE
         7r5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695804296; x=1696409096;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYV/b+hsoYrwr+TVPX0NlcuNwZXGt6NdGj883a3mEHU=;
        b=cn8sa7Zqru1EK/z+gQ9cPx6BA0yl+c853wIttDfQ+xfn5hPWKA8+vVS2E+duj7FLrD
         yWYjmsLlXyU3MXu8VmliQxhjnDgOahAFlCwMHIlL8Naag24sQu6DSIWLZKmNhZKF6uou
         Fif3L3LicbtBRG3UmqWKqcUrhpFf03xULXM2W1v3PrQFPydOUpK/rqRwqpgSGz+2AF6T
         /Ej2qRqgGDAdrhpOpNSUmyDDfeqxGWgadl4dRM0ZJtOXfARgxeMUoCBEo5e1/6XpFQZY
         Uuezd01/pDGCkefHFW8NqH1Q6FnTsubNxHzFvBWrZ6sj4MqvEr1MMd5UUgkZZfNxxwfK
         bDXA==
X-Gm-Message-State: AOJu0YyskYNQCk4pUwbGe9OTIYld5pxrCC3Wr1ikKP23AMUidLDAm8Im
        xDww7M6xLLsIpQoi5Bb7MXkErRJ/Efk=
X-Google-Smtp-Source: AGHT+IE0iINZF6Qd9RpOFIysyAz/PZt1ODZ9UCXpKQ/9hMAA/Pak+S+H/1wOouIC/k15D1QKyQ6u6w==
X-Received: by 2002:a05:6830:11c5:b0:6b9:b1b0:fcd1 with SMTP id v5-20020a05683011c500b006b9b1b0fcd1mr1403432otq.31.1695804296494;
        Wed, 27 Sep 2023 01:44:56 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.132.80])
        by smtp.gmail.com with ESMTPSA id z2-20020a4a9842000000b00573a0631d98sm2658396ooi.34.2023.09.27.01.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:44:56 -0700 (PDT)
Message-ID: <6513eb88.4a0a0220.25210.303e@mx.google.com>
Date:   Wed, 27 Sep 2023 01:44:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0455396699049948732=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Allow binding a bcast listener to 0 bises
In-Reply-To: <20230927075835.20125-2-iulia.tanasescu@nxp.com>
References: <20230927075835.20125-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0455396699049948732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=787934

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      40.16 seconds
CheckAllWarning               PASS      44.43 seconds
CheckSparse                   PASS      50.99 seconds
CheckSmatch                   PASS      136.07 seconds
BuildKernel32                 PASS      38.81 seconds
TestRunnerSetup               PASS      600.28 seconds
TestRunner_l2cap-tester       PASS      36.44 seconds
TestRunner_iso-tester         PASS      60.29 seconds
TestRunner_bnep-tester        PASS      12.51 seconds
TestRunner_mgmt-tester        PASS      255.74 seconds
TestRunner_rfcomm-tester      PASS      19.34 seconds
TestRunner_sco-tester         PASS      22.27 seconds
TestRunner_ioctl-tester       PASS      21.76 seconds
TestRunner_mesh-tester        PASS      16.73 seconds
TestRunner_smp-tester         PASS      17.08 seconds
TestRunner_userchan-tester    PASS      15.17 seconds
IncrementalBuild              PASS      38.15 seconds



---
Regards,
Linux Bluetooth


--===============0455396699049948732==--
