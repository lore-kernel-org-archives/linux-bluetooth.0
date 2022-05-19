Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 06:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiESGFD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 02:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiESGFC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 02:05:02 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D956D1AA
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 23:05:02 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id 11so1901014qtp.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 23:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=0Y9ZBsmX6MFXVYj+n3qQR3o1daPIU5gYzyQSTlYSYb4=;
        b=XgZhcdMOAvUvNm2JwfL2M82GTB2MIINzZDsL2aVVV5rrw8Pc2GByKToHIzg6JdnI5Q
         4zk1Lz2/t6yLomTAB5GMVF8RcxiYlVRq+0MU7V8XJxwLP5OktMGXzUH8jEH1n5opF2Pq
         NdgBSbtj8+RICe2CsD7EX4phZHT+fsGT6OMKZZ12E8G3nsaxoO++E/7Bbk4Ux/hl1RN5
         4uFXTbSiImJwXTTSR+IIHMOvQuBDw49x8v/YRVHKsVbthv+IoBSc4LtDS89hCmMpVE5D
         cFLj1guqD3U+LsFE5UZH7mZ0hSDk0NlxgnguqiNlFro/ApgFnHy6igxLNF4Dj0YHkIc5
         sXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=0Y9ZBsmX6MFXVYj+n3qQR3o1daPIU5gYzyQSTlYSYb4=;
        b=YvDzvHJa3VKHS10uGUBtUyIuOCDzQEE/yguc6dqx8XzhNuPpHzsBPGsmDo3yPBq8tI
         OcDIEdZq6/EqofIQuP0W3no6uHVDbkdq383CFpceRfPCH2wl/UH8TnLyyr8Ep+yqdGo2
         /Fa9VBFrA+WngfoJt2+pTTVsbMQBzSYPgPWzPPRo0wanKB4HobF0OdHdWkWg7w0WW97C
         cBHAiQviBfc/u1RSjKrM0DX8z/QrwM1gY93aQOUnGu8z368Z0Fm7vCD4QDCWJi6a2+w4
         wm8bNRaXkg7SIDwW7QaLyeLysgylaK15zFjiDC4stJDVRppcZuYky4j49pPNT8kzxroh
         sCwg==
X-Gm-Message-State: AOAM533UQFB7IpwHM95oJkz+Pe0imycsM0DJ2+ZU2/hfTPQNqM0qQRH3
        YxuAWzokUYq1jXyvijDjSz/oYvYncMpzRA==
X-Google-Smtp-Source: ABdhPJyz24POIwqhrjRXXseNQzwzlL0tfKW2ly1jcuNFC93jvvnq/vnf6tfsjViU6fFgreoNhJbUoA==
X-Received: by 2002:ac8:5c91:0:b0:2f3:bd33:f412 with SMTP id r17-20020ac85c91000000b002f3bd33f412mr2666519qta.15.1652940301070;
        Wed, 18 May 2022 23:05:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.232.181.170])
        by smtp.gmail.com with ESMTPSA id y1-20020a379601000000b006a323e60e29sm761087qkd.135.2022.05.18.23.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 23:05:00 -0700 (PDT)
Message-ID: <6285de0c.1c69fb81.e8715.3916@mx.google.com>
Date:   Wed, 18 May 2022 23:05:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2940699804670887687=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_bgodavar@quicinc.com
Subject: RE: [v1] MAINTAINERS: add maintainers for qualcomm uart based BT drivers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1652938824-28976-1-git-send-email-quic_bgodavar@quicinc.com>
References: <1652938824-28976-1-git-send-email-quic_bgodavar@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2940699804670887687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=642979

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      1.03 seconds
SubjectPrefix                 FAIL      0.81 seconds
BuildKernel                   PASS      31.36 seconds
BuildKernel32                 PASS      27.71 seconds
Incremental Build with patchesPASS      37.72 seconds
TestRunner: Setup             PASS      457.55 seconds
TestRunner: l2cap-tester      PASS      17.04 seconds
TestRunner: bnep-tester       PASS      5.89 seconds
TestRunner: mgmt-tester       PASS      98.10 seconds
TestRunner: rfcomm-tester     PASS      9.31 seconds
TestRunner: sco-tester        PASS      9.12 seconds
TestRunner: smp-tester        PASS      9.02 seconds
TestRunner: userchan-tester   PASS      6.00 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.81 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============2940699804670887687==--
