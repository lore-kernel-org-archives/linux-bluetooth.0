Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D426C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 22:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712856109D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 22:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhKBWj2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 18:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhKBWj1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 18:39:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EF2C061714
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Nov 2021 15:36:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o14so1125443plg.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Nov 2021 15:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IdlXh3FFePIHwOwOiG0a8VB/mgLzHjViNmw5yAuCgAw=;
        b=MKcaf2DFbKIBWPlZXuTZtiM/CxuzQES4R8W3QmkbAKknsl5m86dSgfDRudZ+3Etn6W
         pAkGw5+jajuiTuRUfaGqz0Ez9sa/0XL8SJsqyADBT12BAETQf6cRZlxDYB5EgNHSuVfi
         FLGwZyr2WhWUsEYr3ybOCThgvIimkTT4ONJq619dMqDzEQ9ZeLfTuFW/JiSj9J3bnG8u
         lnQq6BAhpBBRLgc+wBGKzMFRMVH+LZb8fjtVyQMFpnlrXNc43F4mXEvrGus8urpOGYd2
         0I2slIea7cmUEjIew5k2PtUX2Iw5FFjWkergOe0jR0T25CCVMjMo7qnUjUbBg3U/7RRz
         H/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IdlXh3FFePIHwOwOiG0a8VB/mgLzHjViNmw5yAuCgAw=;
        b=MX1bj5Q1wwCV8fXjHOYzB2qOA0lzEiQy/kih3gnXqaG91+94MKREPYoHtHBkSbCmht
         8x43Xqq7St4dOBacEjAjV3dGwTF/H3VpnD4sETFbdIbpEU5JVwv/i757IhuDa8R+SBNK
         VY32ptyZ4becCiVUdTN5NiH3g/NXnqsBgisWJNEdvoLi8rLxHTSXSGyoDbsuXQj76HFr
         T2txSyk0hHzlW4laWpKSg16x16/G+g1LOju2fPUS0U47mzJhFCF/+OPLl5Lx4IEW0Zsn
         fhBz5lN2oY+KN/WhC2EssUjjvKJWFUYdd9ZDm1xa/KM7k75OD/aPgZVRFfrCHeJh4+MR
         k8pQ==
X-Gm-Message-State: AOAM532bfo1/Rfj4nxFeapWlH30qg+0ERYOgspEssjJE30+mx+qBA9MR
        aBr3bk92fjnfrrUMcgGa5jgnIRQKLTGFxQ==
X-Google-Smtp-Source: ABdhPJxC95mfwBmWsHZt8TjPUkkPJGSi+wSliBQE/ubMHybW4w8m28s/j5hAeke3nagGTHKj7v5J0g==
X-Received: by 2002:a17:90a:d582:: with SMTP id v2mr10229093pju.46.1635892611760;
        Tue, 02 Nov 2021 15:36:51 -0700 (PDT)
Received: from [172.17.0.2] ([52.183.8.20])
        by smtp.gmail.com with ESMTPSA id d6sm176861pfa.39.2021.11.02.15.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 15:36:51 -0700 (PDT)
Message-ID: <6181bd83.1c69fb81.ceedf.0f7a@mx.google.com>
Date:   Tue, 02 Nov 2021 15:36:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5131136197724820362=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] mgmt-api: Add new action to Add Device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211102221046.23293-1-luiz.dentz@gmail.com>
References: <20211102221046.23293-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5131136197724820362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=574409

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.28 seconds
Prep - Setup ELL              PASS      44.42 seconds
Build - Prep                  PASS      0.26 seconds
Build - Configure             PASS      7.85 seconds
Build - Make                  PASS      189.35 seconds
Make Check                    PASS      9.16 seconds
Make Distcheck                PASS      226.19 seconds
Build w/ext ELL - Configure   PASS      7.99 seconds
Build w/ext ELL - Make        PASS      177.76 seconds



---
Regards,
Linux Bluetooth


--===============5131136197724820362==--
