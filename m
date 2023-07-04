Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6A5EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jul 2023 08:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGDIip (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jul 2023 04:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjGDIiG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jul 2023 04:38:06 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BCD1711
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jul 2023 01:37:30 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-766fd5f9536so392592385a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jul 2023 01:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688459850; x=1691051850;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2RSypgbizX2fb6ywpdcMraP4R1L0Ui34FiRpmsmEOA=;
        b=WKY+NAWv01+kSTq6U+KegAXP2SKrstwBRYaigLtR6ICL2aeL4SX93NZTzNHkqpwwbu
         Dx3YnJHaV8usp4FGSXcn0Mjgj9DVABYlAtzstIwVaA5FBWA6u06S3Om0kDL4ObAWVwhP
         AwkbbcCgHNAvIpaVosmTGBYKSuM6pCmNUTB5VlVa7ad+CG1qFzw1heBjufF6kAcmZnVW
         7UjbxAlZlNDbFwIXUFEEt/t/02EnjH1e6SDtmX1EmTTJe3vkKyikHXDCQhpPezkk8I5N
         48XjWMQiZyD4uSxYp52vAYdCWAQwUogiqYhAR8iTrRS8HcuTG7G87GRhQrQqG87sYTjW
         l3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688459850; x=1691051850;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2RSypgbizX2fb6ywpdcMraP4R1L0Ui34FiRpmsmEOA=;
        b=AklXsj1DA8BkkknWGSaI7feWwvhTNH3stp1YGs+prk5CH6Rs0w1dK/q4EVR34uxQOI
         cw+HGng/ARX5PFfN3KtZousyOlTLwr4gxWCF+yd+UM06o5EYMfZ4zdZRzUJ0cokxn6Bp
         iDZbFBjs6TXPBprKxuo0WOVgYSz8EEbJH/a0/ZIkFNPm0NVy3bvFUVi9fSlvakCXECAN
         OGqYSLSYPZV7W4LOcUNrUXkJYZwkddlDkKeIjnTH77jUXvefjowo3UkRToMrENa28nlM
         HamVgqFh94vCtpszntNVz1IOXMPLaUZM8ydFDvpw+giIdS6be/hkeTSZHcaNOYtm7wP4
         x7wg==
X-Gm-Message-State: AC+VfDw5LjdT7LFsM6xtykQ5tCbLhuFOVjBU5x5ed7v3FpkbSSv8hP+v
        yJVOwUzlv8Yfec+UbBWFpKm7YzgEdWU=
X-Google-Smtp-Source: ACHHUZ6FC6pDAc1t7zJAfjPw7XVLyExJkaTfCx8cl8gNyc+rfZDl24vE5VfTL7oWbhPyTutmekWItA==
X-Received: by 2002:a05:620a:29c5:b0:767:14d0:150d with SMTP id s5-20020a05620a29c500b0076714d0150dmr13933115qkp.1.1688459849906;
        Tue, 04 Jul 2023 01:37:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.76.128])
        by smtp.gmail.com with ESMTPSA id s26-20020ae9f71a000000b00765f8e5ac83sm8956494qkg.53.2023.07.04.01.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 01:37:29 -0700 (PDT)
Message-ID: <64a3da49.e90a0220.b943b.68ea@mx.google.com>
Date:   Tue, 04 Jul 2023 01:37:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5082376241320588395=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: Add support for Gale Peak (8087:0036)
In-Reply-To: <20230704081651.857493-1-kiran.k@intel.com>
References: <20230704081651.857493-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5082376241320588395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=762243

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.40 seconds
CheckAllWarning               PASS      35.90 seconds
CheckSparse                   PASS      40.38 seconds
CheckSmatch                   PASS      112.88 seconds
BuildKernel32                 PASS      31.30 seconds
TestRunnerSetup               PASS      452.28 seconds
TestRunner_l2cap-tester       PASS      13.21 seconds
TestRunner_iso-tester         PASS      23.63 seconds
TestRunner_bnep-tester        PASS      5.66 seconds
TestRunner_mgmt-tester        PASS      133.01 seconds
TestRunner_rfcomm-tester      PASS      9.17 seconds
TestRunner_sco-tester         PASS      10.56 seconds
TestRunner_ioctl-tester       PASS      9.78 seconds
TestRunner_mesh-tester        PASS      7.11 seconds
TestRunner_smp-tester         PASS      8.32 seconds
TestRunner_userchan-tester    PASS      5.89 seconds
IncrementalBuild              PASS      29.87 seconds



---
Regards,
Linux Bluetooth


--===============5082376241320588395==--
