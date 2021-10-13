Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81999C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 13:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AF7610EA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 13:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhJMNmr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhJMNmq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 09:42:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53439C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 06:40:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b12so2531660qtq.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=NcNDowgzcSl4x9Y30pbGPzoJVF0FVeMVoj4MbsZfo3g=;
        b=qhfoLeOM6e8TQpKK0ZeT/4bsyg06cvrVMF684XpvU2GPyEOecfWyOEKj2jvVHxUxpy
         xKdQdkMyuuVayVyJcq3tR26AlY5c7RT6H5mSNTvS88YR69JI1sFBeTw7XbFYM7Ayyovv
         bT06LCvKlksFMgm+q3J5f6g76VvAZb7+/oe+kZsyLI+8R+BX2+9qlEZjCgcqyh5+X2Kt
         agGVkg57u/3u/m2O4Lzm6DHxXgmxAvpf8gmacrZsi0WRyEgN7x+Se+NJRlwBY650DpJO
         LvKsice3N6wHmyNO2Gc0V1DE0MSLEk3Q62slyG5RzW7cXDNTpQTVF5cpon7vAqMUyr92
         I2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=NcNDowgzcSl4x9Y30pbGPzoJVF0FVeMVoj4MbsZfo3g=;
        b=hAuxao/huhIP5yvlwiQFg3iM6B+ppJuixhgLPia45kGg43aoOxfPa7vuQoeOt/Xn+w
         rjLWntduJ9j7039H8mkS/snDBGXYjbKHIv/RfJf3qvvrL2gU/t5i06WxWa5R0EcVEIRJ
         gj7yCpGnRX1oYAASYvycLHLvY4yL6EKyMgVibExHCKAO2Yr9oY7/cmWHOCjT2+0lxx2K
         bcNfXJIi+hBNFp4mn2cQeJ9K6HomKjTee+0vM26bbcooWOtDv3eCJeCZFzWUiAWRcpZy
         P5/ENXiYS3Dsrnr8wkAY9W48RLjkQPZbVA5/tr3Snnf5iVYUnRf3PLK7trAPM2kJVNWf
         Y3Xg==
X-Gm-Message-State: AOAM530GYszFokLOsBl5kiJt/uagSpPFMchlBmc+9tjZ7E4PYFSJrLv6
        IZrym5cMo4+G9cLF5O3IAFzatz3UgLM=
X-Google-Smtp-Source: ABdhPJyIEL1DCSncO7Vn2NQ/JFNiQM1UkLy0iMqcKuGl7plEyx8FzQMnipqj/UjcfHDohpSI+pPIXQ==
X-Received: by 2002:a05:622a:83:: with SMTP id o3mr3336664qtw.17.1634132442326;
        Wed, 13 Oct 2021 06:40:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.61.222])
        by smtp.gmail.com with ESMTPSA id o130sm4514171qke.123.2021.10.13.06.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:40:42 -0700 (PDT)
Message-ID: <6166e1da.1c69fb81.506b8.e8c2@mx.google.com>
Date:   Wed, 13 Oct 2021 06:40:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2687428678003162757=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: Update Device Found event and add Adv Monitor Device Lost event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211013053935.BlueZ.v2.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
References: <20211013053935.BlueZ.v2.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2687428678003162757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=562679

---Test result---

Test Summary:
CheckPatch                    PASS      4.43 seconds
GitLint                       PASS      2.88 seconds
Prep - Setup ELL              PASS      46.60 seconds
Build - Prep                  PASS      0.52 seconds
Build - Configure             PASS      8.49 seconds
Build - Make                  PASS      200.15 seconds
Make Check                    PASS      10.19 seconds
Make Distcheck                PASS      239.36 seconds
Build w/ext ELL - Configure   PASS      8.59 seconds
Build w/ext ELL - Make        PASS      188.50 seconds



---
Regards,
Linux Bluetooth


--===============2687428678003162757==--
