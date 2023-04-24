Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0944C7618E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Apr 2023 14:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjDXOdX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDXOdW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Apr 2023 10:33:22 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF36F65AA
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 07:33:20 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-74ab718c344so1263380485a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682346799; x=1684938799;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U6v1tELdSVKpFRTmHhrzkn0HKnpcJ3gllZlxQmLo4XI=;
        b=nx1K2MQPEQPX1ttyG2k39bNWgTzgZXUszSfwRrD7/yUswv+n0BvMlzU8NWpEoR7fy1
         T3qPituOsBi8Jer3iIzhZGh3ySJgtBLfERsmrfqWKDsaWEES24u2R22jssun4Q13tAal
         qB4bigrYi77485hX5iajL2zd22paY3agm69s4GHRm3iUSK/tpu8FcdLPIY1mx5Zrpayv
         IAKpp1o6l3undwenDFXe6J1OHp01PKAJKA7saHkVxvmP0oOn2M7Iw5stbrQ7XSQVd/+a
         gKfPph8NCpw03TYoV00DULv6ZEGHYPfI0pifq4D5GXbmwXMChDXjaMhXiSsVo2/RNxgm
         rqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682346800; x=1684938800;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6v1tELdSVKpFRTmHhrzkn0HKnpcJ3gllZlxQmLo4XI=;
        b=hsb3VYgItxG13hisoG5eopu/ks9JXNMJTVd3RyfPl5Kq0d58pA2/qScSbjY5hfp/Z/
         1wrhfQQL4hivH3rNMyAiM7Q9eONhsZTv0IcpOx2g3L08KAxb4wvOR977oWCqDkzQXuRC
         euLb8oYlBc5VrBLAb+SzCa8B+5Fdu6BvAIRXbA5fMuUfJkLg9Jmhgb1CJJHOKW1XDpP9
         F1P8NGqVgNw7DG2yj3PjDmeHK+HxTIt4Zn+GHe4vEV1TteFfkt2T2sGY/VAz3vdMWIBz
         UH9Q6fXIQvWsi3F/cpGo+0inl85uYrECN3vSFYf5YlQsKqqnQ2HJ0SAbtFfctPzBW1vt
         6OXA==
X-Gm-Message-State: AAQBX9f2MGu7x1rMqo94BXbm0FtnAcq/4HHv0Ad7eEn/w4AVaCN0T3Tg
        LYc07I/+4ebJfE2PJzngOy5c2PASa1A=
X-Google-Smtp-Source: AKy350ZyXdasH92OLzmPDvIqePo9KttIajPXIwj1rtNV4YzQf7HattJk0zX4Nck25j8c8iUAi5yttQ==
X-Received: by 2002:a05:6214:27ed:b0:5fd:93b7:5a96 with SMTP id jt13-20020a05621427ed00b005fd93b75a96mr21546883qvb.26.1682346799721;
        Mon, 24 Apr 2023 07:33:19 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.137.180])
        by smtp.gmail.com with ESMTPSA id o3-20020a0c8c43000000b005ef527043e6sm3360708qvb.75.2023.04.24.07.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:33:19 -0700 (PDT)
Message-ID: <6446932f.0c0a0220.4982c.b725@mx.google.com>
Date:   Mon, 24 Apr 2023 07:33:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4247658539100240454=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: fix bdaddr quirks
In-Reply-To: <20230424133542.14383-2-johan+linaro@kernel.org>
References: <20230424133542.14383-2-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4247658539100240454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=742739

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      0.70 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      33.28 seconds
CheckAllWarning               PASS      36.79 seconds
CheckSparse                   PASS      41.35 seconds
CheckSmatch                   PASS      112.04 seconds
BuildKernel32                 PASS      31.97 seconds
TestRunnerSetup               PASS      455.91 seconds
TestRunner_l2cap-tester       PASS      17.25 seconds
TestRunner_iso-tester         PASS      21.82 seconds
TestRunner_bnep-tester        PASS      5.68 seconds
TestRunner_mgmt-tester        PASS      118.17 seconds
TestRunner_rfcomm-tester      PASS      9.22 seconds
TestRunner_sco-tester         PASS      8.57 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        PASS      7.28 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.08 seconds
IncrementalBuild              PASS      36.91 seconds



---
Regards,
Linux Bluetooth


--===============4247658539100240454==--
