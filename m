Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B044EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiKREPb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiKREPZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:15:25 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D3B87A5C
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:15:16 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id jr19so2472297qtb.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K4iD9GnJoKtNil6+j72YOlQyKiVwvAsmDfqwIflBhVY=;
        b=PKuWnN3sIHss6HJiF1CFBljovNTDeiSu9IklIl39OrWwaZPCCDOcK9jVkAL0j7zXpV
         /FdegOkIB3qIJHSD/u8H9SDzitpwptcu7LmRq557wUDer8iXy/pQ1ET4O6leyQAUyIJV
         VIzoZvMCOmlULvBsr8B/agKkfjhCiIpSAnbGRJm9h9X06xTmeedb3kdcqUQ4AvOgpMqg
         TBdy29Rfr7yEvRdv7Wm5LtsSooLx+SqZ/zZVYtQgSUt3NCAJcsjV+qY7Z4306IgKaIVn
         B/p5Nh2biUog+KwBNm4o9V7d8YKYD+vMatHuK6seJeV8uWIFEWvZaJ5sXAX1DTSt4+4A
         orzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4iD9GnJoKtNil6+j72YOlQyKiVwvAsmDfqwIflBhVY=;
        b=7ZUEuKjBEonSazdOX3h9jZKhMXjOYPQurdeg7EllVrHCTlqT455LqJO/EGJlIXF8Km
         dJ20hEO8jkTsPueFF53ml0IEkAGE/3VV+BWaXaTY6xh2gTBP5vPDkUNNH6lD0XS75c4v
         FKTOUgrBm//c8He4H6V1pfugGs/l+YgYYSFEz7kTn1PX8kGkxp8VEArX6OzCPpEirrCF
         wRNhacVFujJ9spPB2OrQPkkXgbOlfnfWP+bB+iEDOUCjWrQr+inng4sbIBoL08AH3EfS
         95oleGMNEWMB0jIDONpw+Q7pc3wq9DXwkWW+djwB2O1nu4cuzxCQCuYKLRbOghRQYKPS
         ZhMw==
X-Gm-Message-State: ANoB5pn8WAgdv1ye65YMo4jgxEF5VODAcfTcyWysDgS5e8W0ulImBiNw
        SBwEkBIklGZhbg4QBAkKhwRtuHBzUwpzFw==
X-Google-Smtp-Source: AA0mqf6Wc4fWYGP+TPp1UAt2I82FmcUurqTfm5YOrLO/JNs/B6K2jzQ8PJrmeSHnLPLjAEjo5mEFEQ==
X-Received: by 2002:ac8:5042:0:b0:3a5:2751:ce81 with SMTP id h2-20020ac85042000000b003a52751ce81mr5133401qtm.322.1668744915218;
        Thu, 17 Nov 2022 20:15:15 -0800 (PST)
Received: from [172.17.0.2] ([172.176.64.89])
        by smtp.gmail.com with ESMTPSA id f7-20020ac84987000000b003a582090530sm1415943qtq.83.2022.11.17.20.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:15:15 -0800 (PST)
Message-ID: <637706d3.c80a0220.a3b7d.724e@mx.google.com>
Date:   Thu, 17 Nov 2022 20:15:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3982103647461986442=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/2] Bluetooth: Remove codec id field in vendor codec definition
In-Reply-To: <20221116062918.11879-1-kiran.k@intel.com>
References: <20221116062918.11879-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3982103647461986442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695805

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      0.67 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      33.65 seconds
BuildKernel32                 PASS      30.15 seconds
TestRunnerSetup               PASS      420.58 seconds
TestRunner_l2cap-tester       PASS      15.75 seconds
TestRunner_iso-tester         PASS      15.25 seconds
TestRunner_bnep-tester        PASS      5.23 seconds
TestRunner_mgmt-tester        PASS      103.28 seconds
TestRunner_rfcomm-tester      PASS      9.13 seconds
TestRunner_sco-tester         PASS      8.60 seconds
TestRunner_ioctl-tester       PASS      9.81 seconds
TestRunner_mesh-tester        PASS      6.62 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      5.52 seconds
IncrementalBuild              PASS      37.42 seconds



---
Regards,
Linux Bluetooth


--===============3982103647461986442==--
