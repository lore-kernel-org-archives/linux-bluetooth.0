Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC74C4321E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Nov 2022 07:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiK1HBs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Nov 2022 02:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiK1HBr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Nov 2022 02:01:47 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B21F1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Nov 2022 23:01:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p24so5531654plw.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Nov 2022 23:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dV5E55IN/BDA2/xIdwS6sJnc+T9Ta6jqgWjJrW8kPp4=;
        b=bcIjDcrx0umlk4DaczolhiMx1bdbeMVaWshohD9LuPlSnv+XYtQL8db6tSDgT8V+ft
         BWrEFc/uPW5Remoe0qsbj96UbkRovgomzVkJAGkk2/XzLEsomt0Egy7jqQhwhtSiuaxS
         lu2reUqrVp//nNO1vXeBOkBoVIYeSOINRJBrI8qGgkSFmru+eSrIpkiMvIw+SWCyMum4
         +ipF4BYFEvFSytR4EVnZzWK7FNSF6I0k+nysCNofwJZEfyUx64U/POKCLHFFvKPS1i1J
         kxHwHcH0e0Y9cHWWbfvq070QnZNG9O1dcNmeyJOORimClhTlJUSsa+fV0CTr8LZuBcWy
         126A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dV5E55IN/BDA2/xIdwS6sJnc+T9Ta6jqgWjJrW8kPp4=;
        b=hOruZHo16LZ36SQfxqKqvcCdt5a94UrvT3BvvPk7NbtbO/crmF4RX7EGeUKC32A8PH
         rPCbVU5MZiSOhaiBkU2Ua1kZ2mwhBd4VH4PSEEGfmoeLvEpMD9LIG+RYI/9SIR/Ef+NY
         s335vR0d673qqf/zDQ8xybRpc+SvLRR+/Bhv3NSH/wd1f+GiczKs8Zs8lqAIFXLlyvuV
         Qi+yVnP6mpfc0cG3SSx9sxcrYVU44r6ZjcW9P+1AnMLzUdzzoA6cxKEksSe2HHlZflrT
         fwhAOU5smzgJ8njKewh6YRBMAtqOx2uukvYkX0jJzunl1PcguUpFO0WOZg8NtqjEfi7s
         932w==
X-Gm-Message-State: ANoB5plmmrIRZjILlmd09c8lyqTLPwwr4g6uMmPRAEtKiIjP6tgrKqFC
        ylgnneQs0Ml7R4oLkIc7pjq2YaFIJYE=
X-Google-Smtp-Source: AA0mqf6Px+u8+7rBrLYUWjJmik1QMdpYy/ezsIJoagdYpbPrn+5gYfUhOLR5gIx1FI3lld8c8GcSzg==
X-Received: by 2002:a17:902:d893:b0:188:542a:68d8 with SMTP id b19-20020a170902d89300b00188542a68d8mr32424969plz.126.1669618904993;
        Sun, 27 Nov 2022 23:01:44 -0800 (PST)
Received: from [172.17.0.2] ([20.228.87.205])
        by smtp.gmail.com with ESMTPSA id j8-20020a170903024800b00186abb95bfdsm8010786plh.25.2022.11.27.23.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 23:01:44 -0800 (PST)
Message-ID: <63845cd8.170a0220.7ff72.ae0c@mx.google.com>
Date:   Sun, 27 Nov 2022 23:01:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7673605262349944546=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, andy.chi@canonical.com
Subject: RE: Bluteooth: btusb: Add a new VID/PID 0489/e0f2 for MT7922
In-Reply-To: <20221128063000.41036-1-andy.chi@canonical.com>
References: <20221128063000.41036-1-andy.chi@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7673605262349944546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=699572

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 FAIL      0.43 seconds
BuildKernel                   PASS      34.44 seconds
BuildKernel32                 PASS      31.53 seconds
TestRunnerSetup               PASS      425.10 seconds
TestRunner_l2cap-tester       PASS      16.03 seconds
TestRunner_iso-tester         PASS      15.75 seconds
TestRunner_bnep-tester        PASS      5.53 seconds
TestRunner_mgmt-tester        PASS      106.76 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         PASS      8.86 seconds
TestRunner_ioctl-tester       PASS      10.23 seconds
TestRunner_mesh-tester        PASS      7.09 seconds
TestRunner_smp-tester         PASS      8.69 seconds
TestRunner_userchan-tester    PASS      5.78 seconds
IncrementalBuild              PASS      32.16 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============7673605262349944546==--
