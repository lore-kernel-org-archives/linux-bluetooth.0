Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3B1C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 12:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjCOMoP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjCOMn4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 08:43:56 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8493AA4B3A
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 05:42:40 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id bf15so7740885iob.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678884159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nZOUTD9Zuse0d8AK/dVtdm56PC4Xr5c+DibW7hr5KC0=;
        b=F3AD8vSpxTJBBjFMKNo91J9qFzsQu/xRQKH0UTJ0sVQJ52uX0OD8KrAwoT91/hAGbM
         WZfl/49RRg9kqcXFzWQuvS884ZWkr5Pg7DSdC+c00j1uFo2e/N23lkGjHOfuTu+Q0kO5
         ZeGQYY4bjtOlXAYy7fXF8nbhfYCu5Mosm0UuYn16ygCTL1DUB6OPpgcBe5LZz2+9douL
         vifzHlOUA+BQGOs4PIZq/Bjep99WXGqLhXd76jkUerrv1wUJZPXdhbqYYkX1SFaS2lhD
         U7YnLjpnXMi8xS50BqEsIAC3l56hT7MljAwTsbYnbP+rY6KdF3/AdrX21mYxEeXXmMQM
         LT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678884159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZOUTD9Zuse0d8AK/dVtdm56PC4Xr5c+DibW7hr5KC0=;
        b=WNAQ5LEBqn4O8FLC5i4To0HFUXMX3GnGIRr3goZ1w60bQHfxU1uXvQugG1RRUuKOjX
         LrEo4dhdi+99HtVtctGHQe5lqgNfWw8aAtPTFsmrrbuqDgTEs3+PdnKwige3oPeXAXrM
         4CdD3kZOKPqbCd6ZBgWjTtEDECjQ7eKUNzNQmqzKcfEqXnpBSY7GqrcbBtrv2SgyZ31w
         kFDgXKkDv3WzCsdreO0GyTnM+iHHtxCZ2XY2xas9PrNHAmRpjG9jY5XDLd4JwbVkrRtl
         ZnhfDrPaTzp/+w9klFqlKpbR1qmYRiMLVs8y04vY0Q2s+1o4ZrQdy98+FrwCVVv4pqAJ
         vDzA==
X-Gm-Message-State: AO0yUKWvqk56zAqB5lgSiMhead87E6cE4K3EZG3907TT5u/e3GUw20wK
        vL8Im8eSpS629ud6yI/fXpeRHPu4ziI=
X-Google-Smtp-Source: AK7set/KGGtWX9kzBTersc5wx7nuVnoorqBL434ABTLSVFH6VQS6/VPdxN8OiXdm1u0qEB6sO9JdCw==
X-Received: by 2002:a6b:6e06:0:b0:752:f671:c0cf with SMTP id d6-20020a6b6e06000000b00752f671c0cfmr1211526ioh.10.1678884159556;
        Wed, 15 Mar 2023 05:42:39 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.125.163])
        by smtp.gmail.com with ESMTPSA id c23-20020a5d9757000000b00746041ecbf9sm1669735ioo.39.2023.03.15.05.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:42:39 -0700 (PDT)
Message-ID: <6411bd3f.5d0a0220.feb73.3d4a@mx.google.com>
Date:   Wed, 15 Mar 2023 05:42:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3310978799317873308=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230315120327.958413-2-neeraj.sanjaykale@nxp.com>
References: <20230315120327.958413-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3310978799317873308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730293

---Test result---

Test Summary:
CheckPatch                    PASS      4.91 seconds
GitLint                       FAIL      1.44 seconds
SubjectPrefix                 FAIL      0.65 seconds
BuildKernel                   PASS      31.18 seconds
CheckAllWarning               PASS      34.17 seconds
CheckSparse                   PASS      38.80 seconds
CheckSmatch                   PASS      108.13 seconds
BuildKernel32                 PASS      30.18 seconds
TestRunnerSetup               PASS      436.06 seconds
TestRunner_l2cap-tester       PASS      16.78 seconds
TestRunner_iso-tester         PASS      16.88 seconds
TestRunner_bnep-tester        PASS      5.33 seconds
TestRunner_mgmt-tester        PASS      108.04 seconds
TestRunner_rfcomm-tester      PASS      8.62 seconds
TestRunner_sco-tester         PASS      7.86 seconds
TestRunner_ioctl-tester       PASS      9.18 seconds
TestRunner_mesh-tester        PASS      6.72 seconds
TestRunner_smp-tester         PASS      7.78 seconds
TestRunner_userchan-tester    PASS      5.59 seconds
IncrementalBuild              PASS      43.18 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v12,3/4] dt-bindings: net: bluetooth: Add NXP bluetooth support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
20: B1 Line exceeds max length (87>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============3310978799317873308==--
