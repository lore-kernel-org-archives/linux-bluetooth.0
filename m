Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138FAC77B70
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Apr 2023 10:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjDQKgC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Apr 2023 06:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjDQKgB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Apr 2023 06:36:01 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B002D7AB3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 03:35:04 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id ff18so2529417qtb.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 03:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681727654; x=1684319654;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HMb1Mg0w9DJSd1Ipu8WHIBkxAAI4Bk8jU6v7+aT0fys=;
        b=K0XdDE3jo2xUHXKI4cwsaP9ody43ehb9KQ5AdasBiM2rbh5r4tSLA8O4Pi+Ip6LK4S
         NFrl/4jMTzeKvcxfdTQDweAFmlEzMOoi/jwuvBo81pXsxwlaIt1ayYO6zBEcS9JTE767
         0mBNPlVB+XHWQFXvKU7R0GACJUrmetRviBL7SzAVdDj+BFsC4TW3JIsSGpSbdnhNRS0d
         v8ccdGfPx8TTl8tFi/80L1yQOX3dUP2fnfR3jefwOFFdNXxANNmngtJMpdTG7VhVJZni
         vn3ajqwlbFjqMXJw3pFCHsMSeD56fHy3zw4ICIWzPkTB7CLkUnpO6Sd8fx1hLr3FtFZ8
         kcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681727654; x=1684319654;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMb1Mg0w9DJSd1Ipu8WHIBkxAAI4Bk8jU6v7+aT0fys=;
        b=JnzGEwKm0tcGfoGJUcxjOyyaA4zHUqaOFcies/jRqaPpF03EHTzXsNkqMooKUmj1Ms
         KxhFU8JLZTb094yUV2rcYuBdjI0f+mHhq0/iShd+xnNJrLJ3XuK++Ot78cx7Fm/EKSvW
         jK9PkCOE6VYf+BxALUGZOC2jKPwYmMTOs3hbjS92PRChFRGjOC8BIOGMQrJyszDkD5dq
         jnKd/g/qmPHy2DYKSFz4wt3slpPQJmI5uQxeM9aETAP0GPElGu7ZUvU0O5kw/Lhog/Wi
         Okcd8Gc6O2MJGU2X0SsuCHr2384rENstTrA6eoj92I5x+Mi4SxiEYnbe38BNmvEnNEAU
         SXkw==
X-Gm-Message-State: AAQBX9f66rIGne8XMu7fiPiEeU55iUlTe7xj1mYZTOC+Pu8eenQVN16t
        dS6af5obviUA8DplrB6h2MUZc4ltBvo=
X-Google-Smtp-Source: AKy350ZB1qD7q4f35iHE94+m/3hetoXLIeEFj2V3+9M2es9KHmafBa3TMQVSolGhuWUKKvhCUGuV1Q==
X-Received: by 2002:ac8:5c49:0:b0:3ea:8993:2e89 with SMTP id j9-20020ac85c49000000b003ea89932e89mr18608224qtj.38.1681727653827;
        Mon, 17 Apr 2023 03:34:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.158.57])
        by smtp.gmail.com with ESMTPSA id l18-20020ac87252000000b003bf9f9f1844sm3184771qtp.71.2023.04.17.03.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 03:34:13 -0700 (PDT)
Message-ID: <643d20a5.c80a0220.db65b.e98a@mx.google.com>
Date:   Mon, 17 Apr 2023 03:34:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4267485842108502480=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2] Bluetooth: Devcoredump: Fix storing u32 without specifying byte order issue
In-Reply-To: <1681724399-28292-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1681724399-28292-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4267485842108502480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=740420

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.81 seconds
CheckAllWarning               PASS      34.90 seconds
CheckSparse                   PASS      40.02 seconds
CheckSmatch                   PASS      109.25 seconds
BuildKernel32                 PASS      31.11 seconds
TestRunnerSetup               PASS      440.77 seconds
TestRunner_l2cap-tester       PASS      16.90 seconds
TestRunner_iso-tester         PASS      20.85 seconds
TestRunner_bnep-tester        PASS      5.56 seconds
TestRunner_mgmt-tester        PASS      114.94 seconds
TestRunner_rfcomm-tester      PASS      8.84 seconds
TestRunner_sco-tester         PASS      8.21 seconds
TestRunner_ioctl-tester       PASS      9.58 seconds
TestRunner_mesh-tester        PASS      6.94 seconds
TestRunner_smp-tester         PASS      8.07 seconds
TestRunner_userchan-tester    PASS      5.81 seconds
IncrementalBuild              PASS      29.67 seconds



---
Regards,
Linux Bluetooth


--===============4267485842108502480==--
