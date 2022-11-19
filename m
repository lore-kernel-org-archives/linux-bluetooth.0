Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0511CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 05:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiKSFDC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 00:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiKSFC4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 00:02:56 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358B8BB9E6
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:02:54 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id n18so4706303qvt.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RjxlRxKCIDfFaulFyl+vyXBUvxQJKFos8BzMvPQDRig=;
        b=csGiagb8UvUI9R6xSZsSoQRm7xaNMU/+pOqXXgsc1RQW6n3vQ+6bs4MacQmcnwRzWF
         3yxrtFCSf2FGafKRabKQbg/hI6/hLCijLxxxhm/IrCTPnSG8DExRPH4mz0HKZAJN+/H/
         uJU7UYq8Y7bx+1j0l3jtGHkAA3GORKySVKUlJ7EtSaURPV5NwYflb9kFmVw7ZNeIkwdk
         EidnfDr3P4uIeMx8x68lleOv+jycfx6xbPmjrvQWTkM0Cp8ZQWJXAjZA4szQtxzBmC5H
         UCSkV7/BChRre7DqrhqQRI7Jo99IWPeVgSVPNrozgKh+m74dmunBIvU219f7Bv/I7jtA
         tUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjxlRxKCIDfFaulFyl+vyXBUvxQJKFos8BzMvPQDRig=;
        b=E9LMWVXaHK1XYteUKC2Rm4qwowE87TNUOVSzrq2ODaiR0XGv485qkaabsKMbA0zZ5+
         4EjALc5j5vcJfNZ+T8rMOdm90qE1sf/22W+QZrNPobjEw8Q9F+uQjIq6784RCYkAIUJo
         WkCsEGFZhWceUYcYudOg8WcQvvVNnxe4BVxsin1+UWQTTbnnbbLQn+z0pjYm/C7/wkh5
         lHWRyi7WT827vY30W0a7SOLhhcJ1ThZuiKj5ZbSVeMpkwj2KU/ijRli7KCOTuRdpLiiE
         Vfdz4GmMRikwodp5XDS2Jr4avOHQwtW9b9t9MlIDlZzpGmY3Kc4UJZmQKb9hRn1weWaN
         L04A==
X-Gm-Message-State: ANoB5plxulQUhSb4jS3IStFSk9jhzWKi60+vbtaczhmDZhj29aeKht4z
        1UvaprfoVdzj4eiEVjfnQxmIN9aIhcuasQ==
X-Google-Smtp-Source: AA0mqf7URj51IU6QoqEz9fwcNlE1Ax2FthUb9M6plmAhBci75sLun08P0nlhaf4+cYRcuPzUMZM21Q==
X-Received: by 2002:ad4:5347:0:b0:4b9:e098:e334 with SMTP id v7-20020ad45347000000b004b9e098e334mr9449568qvs.38.1668834173099;
        Fri, 18 Nov 2022 21:02:53 -0800 (PST)
Received: from [172.17.0.2] ([4.227.247.130])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa617ac616sm3922594qkp.49.2022.11.18.21.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:02:52 -0800 (PST)
Message-ID: <6378637c.050a0220.6084f.2dbc@mx.google.com>
Date:   Fri, 18 Nov 2022 21:02:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0385778514090038039=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] bluetooth: Remove codec id field in vendor codec definition
In-Reply-To: <20221104071810.22720-1-kiran.k@intel.com>
References: <20221104071810.22720-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0385778514090038039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691972

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 FAIL      0.49 seconds
BuildKernel                   PASS      35.22 seconds
BuildKernel32                 PASS      31.71 seconds
TestRunnerSetup               PASS      434.13 seconds
TestRunner_l2cap-tester       PASS      16.16 seconds
TestRunner_iso-tester         PASS      16.27 seconds
TestRunner_bnep-tester        PASS      5.59 seconds
TestRunner_mgmt-tester        PASS      112.46 seconds
TestRunner_rfcomm-tester      PASS      9.57 seconds
TestRunner_sco-tester         PASS      8.85 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        PASS      6.95 seconds
TestRunner_smp-tester         PASS      8.71 seconds
TestRunner_userchan-tester    PASS      5.84 seconds
IncrementalBuild              PASS      39.47 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============0385778514090038039==--
