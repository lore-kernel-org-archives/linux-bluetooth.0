Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23951EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 22:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjF1W7T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 18:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjF1W7R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 18:59:17 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A461210DA
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 15:59:16 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-783698a37beso3524439f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687993156; x=1690585156;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OuLUAz/+BEftB3i4mhIoYxM0s+5YoyJy2nN3gcXty/M=;
        b=LZ9eBGZCQQwW1BEllWHmThBydKm9LxW4D7DQCAIsE6xCnX5cjZFyHsc9/9+FyVhd/a
         rYPvPuUpdVAiX231CxJy7n7yIndbMsijtU+aRvhavAkobFbEAAAU58ilFQJh5Cv+vT3P
         dnAe+KSkbY6GThToihAaCevDgZIJxoQLwRLC4dCTBEwr+rR+EOltAFHMQ5PrmaGQflQx
         0ASWVUkxWUmyUD+HpZAZt0z/RXBPQtLKm4Xvjj01dhDvgwA9Yc6r4/iLpnoHORb4zMoL
         zBr7eHS2lWyhfKShAZNd/zPp9m5M3mGaDEniLEyg9fB5GzrCAnnSAqXXd0aavLfKLvUK
         bv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687993156; x=1690585156;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuLUAz/+BEftB3i4mhIoYxM0s+5YoyJy2nN3gcXty/M=;
        b=L1j4vCnsgSGAsFahNij+VDj13zUIMtVkGYpxmv0afjbf+Jmw2FIDTyvALHYY7HVHK+
         MMrGhZ/i0jvm/+rkOVB7CuVVQ/lomdcvc+xJEBbPiRSZ3IbtAHYmCi1hKI24mdQfMR/E
         qqnivhgTus03z4MdPzN8E4JY4EzESfzyTmLTRM+Bv4lpmiFDXtpsdDog8OLEBoMjBurN
         ZaW3ztT8a0e31SwGJ29K+w3U1LGJqlv7d6qjeBixIV7FfnkmQtF/1FsVRlSqieq0+Lbe
         onMNJQrlyl/7D98G6QZdMzRrvyqG6zNVUrJ+LSWrMj7l45DsRH8cEMWBfBndYm6tm34f
         Da3Q==
X-Gm-Message-State: AC+VfDziuAPoTwIUl3Md7jvz+pWAuxOsMZV+J1qu2MFZb/MO3JbN4eOU
        dEd8Anuskh3htbkfXYK1XlTGaybX2JA=
X-Google-Smtp-Source: ACHHUZ4irV12G4VA6/pggz5+XmxcKHzoiPc5VxhGyB9ZulUGRbo+gZ/uXlG56JnWyNHTSoQ1ezfjfw==
X-Received: by 2002:a92:ce0b:0:b0:345:9798:9f7 with SMTP id b11-20020a92ce0b000000b00345979809f7mr13647905ilo.14.1687993155387;
        Wed, 28 Jun 2023 15:59:15 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.243.91])
        by smtp.gmail.com with ESMTPSA id v8-20020a92c6c8000000b003421231fb8csm3684870ilm.74.2023.06.28.15.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 15:59:15 -0700 (PDT)
Message-ID: <649cbb43.920a0220.6028b.4722@mx.google.com>
Date:   Wed, 28 Jun 2023 15:59:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8082147374863283879=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v3] Bluetooth: btmtk: add printing firmware information
In-Reply-To: <1c40a12b51ccd6ee2ee002276f5b1ba92c377100.1687990098.git.objelf@gmail.com>
References: <1c40a12b51ccd6ee2ee002276f5b1ba92c377100.1687990098.git.objelf@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8082147374863283879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761058

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      37.03 seconds
CheckAllWarning               PASS      34.78 seconds
CheckSparse                   PASS      39.96 seconds
CheckSmatch                   PASS      111.49 seconds
BuildKernel32                 PASS      30.79 seconds
TestRunnerSetup               PASS      438.73 seconds
TestRunner_l2cap-tester       PASS      16.62 seconds
TestRunner_iso-tester         PASS      22.39 seconds
TestRunner_bnep-tester        PASS      5.27 seconds
TestRunner_mgmt-tester        PASS      126.12 seconds
TestRunner_rfcomm-tester      PASS      8.42 seconds
TestRunner_sco-tester         PASS      7.77 seconds
TestRunner_ioctl-tester       PASS      8.99 seconds
TestRunner_mesh-tester        PASS      6.65 seconds
TestRunner_smp-tester         PASS      7.77 seconds
TestRunner_userchan-tester    PASS      5.51 seconds
IncrementalBuild              PASS      29.42 seconds



---
Regards,
Linux Bluetooth


--===============8082147374863283879==--
