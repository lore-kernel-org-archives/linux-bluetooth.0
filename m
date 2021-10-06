Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFB8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 21:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380B7610E5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 21:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbhJFV5d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 17:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhJFV5c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 17:57:32 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD3DC061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 14:55:40 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r1so4218265qta.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=W2LGQL6vslGC8CNvDm8aq6oDWF+EZC/fWKJquItGrDI=;
        b=XGWr3bfj/FCQTHJ95gC0J2NQiYqxW7lnj8ppavl5tXgFiFfLzJmwy3A25+ciMalOhR
         mcY8Hi6xNSLXzxR/aoj9kRdUOoc4PQMe1BKZJXaTnQFqgaZXH/PJGD+ZJQapibVKQ9Eo
         ulLNTfoOXJpB5dNb/UB8qB6zWnMRbxbmZgDZwcZsHQ8nsbchFuPKOQEGDJu1vKv+FTmn
         Z5M8gCPyaHg9xxNUu6EaPAD/prtN1OE46G4VI3eneUm64RyKpv2nMoSV5qZkLmXDnd7p
         v2pT+5I8QouSrDXQIm8ay/PK1eOJhVLiLY0K74j8fPO+HPlEztxFYITsw2qbQYBQUift
         7iEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=W2LGQL6vslGC8CNvDm8aq6oDWF+EZC/fWKJquItGrDI=;
        b=tqmOGvlk7dlHCfWMaZnv9bnLnHv3eIwUp8OoKynwL8JVFCNiAgmIE4vIJhiNFV5MUO
         y7q/YkbZz3GTYtA0QWYzxtdUkXVJNfIjkg5TGakSuR/2d1XxZICscbTkTgVyTLB2ve5A
         qfsLzp86pJs+Q73o1a1Qxq+KMx97etYlEDUG0uBPpXasFJDXajM7hO3jvuH1ZFr09Yiu
         zlyKPLr8xKSj6TPHdKsUszNVL5A5r5ojJNe/MH49OSsTfe8QJz3h7Bpqtd2m3lwCX4sr
         fH2eGGPT8nq8CAE/4COnBYuECrXbXP/49ghE0oDDNcQ/Et0UA8+jc9vk4GNeES6JP3pK
         3CTA==
X-Gm-Message-State: AOAM5302mhLn1RDbXZpQ+qr64oLZZFytk+x+ZfQ36sbXVsc/r5yQXYEC
        kyYncIFIeQ/GYierokBm+dhXZZlgcZ0bdA==
X-Google-Smtp-Source: ABdhPJwcHbmi/WYUdWeTVfvdrISUUeZMzIAwODm+FbLBDkmh1YWzlVjpzFWjPiUxTpGYNB9rY5zhQQ==
X-Received: by 2002:ac8:4296:: with SMTP id o22mr735156qtl.222.1633557339055;
        Wed, 06 Oct 2021 14:55:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.160.136])
        by smtp.gmail.com with ESMTPSA id t64sm12583096qkd.71.2021.10.06.14.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 14:55:38 -0700 (PDT)
Message-ID: <615e1b5a.1c69fb81.a4f79.9f91@mx.google.com>
Date:   Wed, 06 Oct 2021 14:55:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4324367549392438527=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/att: Add bt_att_resend
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211006213704.1093265-1-luiz.dentz@gmail.com>
References: <20211006213704.1093265-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4324367549392438527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=558803

---Test result---

Test Summary:
CheckPatch                    PASS      5.91 seconds
GitLint                       PASS      3.81 seconds
Prep - Setup ELL              PASS      50.39 seconds
Build - Prep                  PASS      0.45 seconds
Build - Configure             PASS      9.02 seconds
Build - Make                  PASS      207.69 seconds
Make Check                    PASS      9.60 seconds
Make Distcheck                PASS      248.44 seconds
Build w/ext ELL - Configure   PASS      9.30 seconds
Build w/ext ELL - Make        PASS      195.77 seconds



---
Regards,
Linux Bluetooth


--===============4324367549392438527==--
