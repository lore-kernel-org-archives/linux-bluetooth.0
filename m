Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836AAC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Feb 2023 11:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjBWLBU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 06:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjBWLBR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 06:01:17 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E965B52DEE
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 03:01:05 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-17264e9b575so5773219fac.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 03:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rHvMEyjrnA6A6pKTNC3riMYfvJV6hfwaRFlMs5txz9A=;
        b=b85hcjFijuJAy5Oh6bS+HRvK2hzgTWqdK4QkLGX4j5g7eSIdzPJyxzfb7T717i7PCc
         IwXhwSshgTVsmYWOJ800d2Bzkygqyuc7tZxA0LJ0xaOlrJpYcE9YaENBFdP1LM+FuMyM
         Pazj/GEByvNQRyxlS9Ek9gm/GfqQft+ZcYZer8Y7HFGi76Rj2nqEIIPWfLrEkcml59MU
         eGEODK+GHgKpC5DZlGI7lMyvXA2QfCMcotHwwyngROEy8aBMLhgbg8Cr5BAV8vL7ps+J
         55vil4z3Z8Vq6I+hpQfwXIbWKEUlH2WriajXMrgHaD1CmDYTrHcA4RPksDG2vYBns0At
         gSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHvMEyjrnA6A6pKTNC3riMYfvJV6hfwaRFlMs5txz9A=;
        b=zPod/Te9V0ze8HmrbdO0iysTast7LB7aMJ5VKaRLfFmLHJprl1OZTPtEo9vza0iwtK
         E+YgTCVKjOI7hIzEF2aLZJ51nzrI49mc0wkyfLfh5qA+cmwr1KrinAbtFlj7HsrI55Dz
         3zK7WrVIosWOoQUZD0/X0ZYlm+K77bLWyq80qmv1uR8DW6i0QSGuYrYJZCyb6rAE2E5d
         VqdjTyG8JUCNdJvhMFsnft4ZNDZOWgsCspCZ9ARJxHrMLEy7KcLcZFCspsoS0TSTSrHd
         PHJK0iVbO9hf79p8zNBYIGOvYh9Jb3q3z8cV2V9OVNHZgapgBxqnwQUuoT1j/NYj2SH9
         F+qg==
X-Gm-Message-State: AO0yUKUMqtMx+ZhQr5qu+bE0SEnq5k3IOaPBt0his49OFL+7gQ5JcnqW
        Wtd9zx9Pq/VuAnAv+ZrQV/i1r8W8ENo=
X-Google-Smtp-Source: AK7set9Z6VzkloOQK67arGWE4BiqQgMyyw3aNxRtUZAijqa0j3JCb8uYSB1BCDSQDr9RUCDImYeDfA==
X-Received: by 2002:a05:6870:170e:b0:16e:116e:1c36 with SMTP id h14-20020a056870170e00b0016e116e1c36mr10544476oae.3.1677150064832;
        Thu, 23 Feb 2023 03:01:04 -0800 (PST)
Received: from [172.17.0.2] ([40.84.170.68])
        by smtp.gmail.com with ESMTPSA id x8-20020a4a6208000000b00524f381f681sm2890874ooc.27.2023.02.23.03.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 03:01:04 -0800 (PST)
Message-ID: <63f74770.4a0a0220.16b18.d666@mx.google.com>
Date:   Thu, 23 Feb 2023 03:01:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3468526835409048084=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230223103614.4137309-2-neeraj.sanjaykale@nxp.com>
References: <20230223103614.4137309-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3468526835409048084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=724310

---Test result---

Test Summary:
CheckPatch                    PASS      1.75 seconds
GitLint                       FAIL      0.90 seconds
SubjectPrefix                 FAIL      0.60 seconds
BuildKernel                   PASS      31.48 seconds
CheckAllWarning               PASS      35.04 seconds
CheckSparse                   PASS      39.71 seconds
CheckSmatch                   PASS      107.50 seconds
BuildKernel32                 PASS      30.82 seconds
TestRunnerSetup               PASS      441.27 seconds
TestRunner_l2cap-tester       PASS      16.52 seconds
TestRunner_iso-tester         PASS      17.22 seconds
TestRunner_bnep-tester        PASS      5.70 seconds
TestRunner_mgmt-tester        PASS      112.84 seconds
TestRunner_rfcomm-tester      PASS      9.16 seconds
TestRunner_sco-tester         PASS      8.41 seconds
TestRunner_ioctl-tester       PASS      9.76 seconds
TestRunner_mesh-tester        PASS      7.23 seconds
TestRunner_smp-tester         PASS      8.24 seconds
TestRunner_userchan-tester    PASS      6.02 seconds
IncrementalBuild              PASS      32.75 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,2/3] dt-bindings: net: Bluetooth: Add NXP bluetooth support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
18: B1 Line exceeds max length (87>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============3468526835409048084==--
