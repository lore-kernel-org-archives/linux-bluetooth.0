Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F65CC54EAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 19:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbjA3TA5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3TAz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 14:00:55 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A696B37F0D
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 11:00:54 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v17so1185722qto.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 11:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xx/XDzPg6X+7qZQ8ZV3mx64lYq7oj9bNaU9JtDxuoE=;
        b=ewS/tz+CGxCLL3dueowG4+1D8zEbvnEezJj5XhKRzeYAzgQL0ObWQRhpt7aQL6ta0Q
         zKm2jYDY2dza3IoHSZRJPlKcvmh+dHbr4QWHLTDVrDOJxLCwt0D03VJZi9zaudJruEgf
         dc3Oo5DFP12tNF1tcpuiDEdDFz03Y6h1tSAqlMR/f9Vt91pC+xrMsuz8q31cXBCV5hq0
         ptSWF7H3a3UURTge+loJo/VzesifRziNmyAZZA5Ufo3swAQH1BksoRcXj9TX48JIdTMj
         g/XaxlhxD73DJR6cs5CLlkLX5cQzY2NXJCtuQUrbePoHL0lYL42rECPR9tFjPfgPn0O9
         PJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Xx/XDzPg6X+7qZQ8ZV3mx64lYq7oj9bNaU9JtDxuoE=;
        b=Nem9ORvzDzVoi2+lMdc+DULRvR792dIaEkw9XcVAwpTf0egagiK8/mi9fdabv5P8kk
         lo+xM99TMt0EgRYSKLyl95UAx0mSPGRNgMidgt1QU34hSJet0MJzw26WNicHc/0rHB8J
         2aFbtRRo1HM9EwwmPAM3/dWKTj6iXnpnARhepHduZxhXJthSayDWrHt1cIxgF6JHkxJ7
         oSbqgcdecsSxgsKvuRkN1TcNA6zEgjN3fazEQs2axcZVMYOAu1z7InEW0CVAoDYWwErK
         5WmihZMffAeN1o1ki5UGAbcJkyT8VmK8sdnOENWQzHpsEMPy8oyD8rhwNizVIoDIJAJq
         ZReQ==
X-Gm-Message-State: AO0yUKViatC+29PuYjG2dMJJpF+Ud2KD2P7JWp4GRtOXbMbpy6lXqmWD
        vdS/XU7hWp8peJCifU7pkDOwbHJbHdY=
X-Google-Smtp-Source: AK7set9UHYlvlSE4ybemSh3pJOd75WQm6kR+PgOCXeWdsSI/gquIbQuHcpvyapfpPfw/X2f5bJPBkw==
X-Received: by 2002:ac8:5ac6:0:b0:3b7:fb35:915a with SMTP id d6-20020ac85ac6000000b003b7fb35915amr40899996qtd.45.1675105253535;
        Mon, 30 Jan 2023 11:00:53 -0800 (PST)
Received: from [172.17.0.2] ([172.177.106.84])
        by smtp.gmail.com with ESMTPSA id r13-20020ae9d60d000000b007246f005d8bsm670311qkk.116.2023.01.30.11.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:00:53 -0800 (PST)
Message-ID: <63d813e5.e90a0220.65d15.4547@mx.google.com>
Date:   Mon, 30 Jan 2023 11:00:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6126201546948359932=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: MGMT: add CIS feature bits to controller information
In-Reply-To: <229cb2a6ecc8f182471f87ed527883c1a8353af5.1675103818.git.pav@iki.fi>
References: <229cb2a6ecc8f182471f87ed527883c1a8353af5.1675103818.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6126201546948359932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=717082

---Test result---

Test Summary:
CheckPatch                    PASS      1.22 seconds
GitLint                       FAIL      0.62 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.56 seconds
CheckAllWarning               PASS      34.38 seconds
CheckSparse                   PASS      39.59 seconds
CheckSmatch                   PASS      108.21 seconds
BuildKernel32                 PASS      30.43 seconds
TestRunnerSetup               PASS      437.15 seconds
TestRunner_l2cap-tester       PASS      16.39 seconds
TestRunner_iso-tester         PASS      16.42 seconds
TestRunner_bnep-tester        PASS      5.45 seconds
TestRunner_mgmt-tester        PASS      108.87 seconds
TestRunner_rfcomm-tester      PASS      8.75 seconds
TestRunner_sco-tester         PASS      8.06 seconds
TestRunner_ioctl-tester       PASS      9.35 seconds
TestRunner_mesh-tester        PASS      6.90 seconds
TestRunner_smp-tester         PASS      7.96 seconds
TestRunner_userchan-tester    PASS      5.73 seconds
IncrementalBuild              PASS      28.60 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: MGMT: add CIS feature bits to controller information

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
16: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============6126201546948359932==--
