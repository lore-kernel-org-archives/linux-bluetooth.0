Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E41C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 21:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbiEXVrW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 17:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiEXVrV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 17:47:21 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040C17CB7C
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 14:47:21 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c1so16050335qkf.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 14:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=jOBb1Wk6RnpvBu7TWiLb3eOlW2Cs6t7ffdkNm3GAzM4=;
        b=QExJZeP3WgeZcjCLR74AeMO/tmoYDAmylFJ0CVb5MvVmEWKDVuTB/JW77y2Z1CtKY+
         qP5M4ZzcjxC56+LCqYbfzpKeTLOJ9doJZWe4XylFzE7gE1ilXBYuH1ArzTyjn+XJNdBL
         YNwwWIfrGv45lGmGqAC/aJUEeJPhvwLy1RIqn+cP8b66A7XWMfO5w3twEcqWs2+xw5T2
         gPpVT7+4iMHcfFmq7pOQbkUivhN7sqY5AtXoJag9l6qIYHyoFqSTG/jEg3MMBXiGiMK4
         3pBV2d/ktNRFdwixTn6F7g4sj3B7egA9EpNzSgj3WAcZRwjfloI+n23SJ4/FFYNWLvXJ
         safw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=jOBb1Wk6RnpvBu7TWiLb3eOlW2Cs6t7ffdkNm3GAzM4=;
        b=v+a6Kp+I4fczap+esI2g0BNrNroJpAUpIB8ugbDcKIJVSxyTmCm2KucBtRqo7AUU5n
         DESvOYZ4X7GomoVUT+MNDBoPfjCeRSdklHg802im7iTfwPvyaF1wFTA5FLBAWCGJ7nd6
         VY7XKa784S7Lc3KZZd4p0moYEv7iUGbCH2npgPqWKalOBp3EQlK1rr/cYjTyXAP8EKrG
         RDad5gMvHkL5IVepphs9R6v49YdmZ3IPdALhfsB+YFRk9GPyBucmbajZa2J5iQ3NjeXS
         nVDZm6kHXyoEQtc8JtR2A/PG/Q8F3PaPg0ks1G/pLqUhw/dQcENzDIknDMLs/GeRPa5i
         0E8g==
X-Gm-Message-State: AOAM530nX4nn6FEIiStXgXtLYPZnlmGZ9HwDWsJuBhrD3I2JuetBd2Kn
        KHzW37rK6jOYbqGLs05OULjQ2qPIIsw=
X-Google-Smtp-Source: ABdhPJxWZ5JYsYT7hPALTJ9rLmE7+bvaS0tauqO7lzWOR1FADLQ3+vWpYMN0kIlLzOASHuhzFeVOIA==
X-Received: by 2002:a37:9144:0:b0:69f:789b:7581 with SMTP id t65-20020a379144000000b0069f789b7581mr18808105qkd.773.1653428839637;
        Tue, 24 May 2022 14:47:19 -0700 (PDT)
Received: from [172.17.0.2] ([13.92.27.59])
        by smtp.gmail.com with ESMTPSA id t71-20020a37aa4a000000b0069fcc501851sm222360qke.78.2022.05.24.14.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:47:19 -0700 (PDT)
Message-ID: <628d5267.1c69fb81.620c8.192c@mx.google.com>
Date:   Tue, 24 May 2022 14:47:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3234789300530069668=="
MIME-Version: 1.0
Subject: RE: arm64: allwinner: a64: add bluetooth support for Pinebook
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bage@debian.org
In-Reply-To: <20220524212155.16944-2-bage@debian.org>
References: <20220524212155.16944-2-bage@debian.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3234789300530069668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: include/net/bluetooth/hci.h:265
error: include/net/bluetooth/hci.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3234789300530069668==--
