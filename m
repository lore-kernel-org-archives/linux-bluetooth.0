Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD518C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jul 2022 22:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiGYWGK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jul 2022 18:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiGYWGH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jul 2022 18:06:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C549FED
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jul 2022 15:06:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q41-20020a17090a1b2c00b001f2043c727aso11511025pjq.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jul 2022 15:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wcr6btsjB46HRJg5TlOClM8kQW/E3U/48EaD5DuqsUg=;
        b=PFsZE38yEZk/KmJaIXrwuCLfYAY8398AS0c5Qrxq3ZVpj4TCPKVeRRxnQqDG1s9fo7
         mjLxaSwvAK1iFFu/tHgy/ycUmX7eQhf2+MS/HwvcBmWyVFI2dTT/DfXN87nfc5KLXu+P
         VoKMEQJ3X+LYWt/lj0aleQ3nVXbBsji+RL2/k2Ci8UKafqkSpoL2F0dsoQOIxoa4ifiS
         xTqmWdcd4+CQGV9wHDp6qInQT81jFWVzRJvbLB6CenAlaCA9h3qlbw/xoQzOmCPZYSfj
         k0A7HHS9oIlRcepgOR+KDwi0YM60h6vN3neOvANGIFjfsUEdZZ4Pb5iK7B9RtBefHxtA
         PNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wcr6btsjB46HRJg5TlOClM8kQW/E3U/48EaD5DuqsUg=;
        b=6WojrwuM/+nfdU6cnTDOOatJgN2wLDi3JmrVSLVj13BKyCPVBUGktgW9OxvED7RmeM
         RsmiiMz+IoDEehlQ3oMgfwDuygG8JM1hjGNd6qFCbimLOeXYelxzaVc0J7H/ECVud6IS
         1myaU4daXzXcGEYM4uoBZJbc+7Zk1DPopOY+WPFnVCb4U0UeCmD8Y2f4etG1vkr/5/kJ
         opNAojLQ24wyqc2Ynt8UfGDVomCJPIwBXocr3ISV/rAMCptXkCcnDhOZ9qyqGvpCW/Ow
         yDC4UFll4LJqXpJ/Yqzp0m2dcKFo/LkADxorMtTrPwtDOcaSawVa4EJDYvY9RfW1dCWs
         O3OQ==
X-Gm-Message-State: AJIora9YNOQoMnnTBVAvzgVXstztMcx6wEVk5eeTKRAUH5cIamh2DaHF
        PoiDXRKbwX0mf9tE0wGOza3274KUVl8=
X-Google-Smtp-Source: AGRyM1uOV+pPplwir5HYi56h8QiPVuou3Vnw4DF8BJ7zHXrOHzgfVsMCJixYAorxbyqzCp0oLpG5mw==
X-Received: by 2002:a17:90b:360c:b0:1f2:6436:9e54 with SMTP id ml12-20020a17090b360c00b001f264369e54mr14432928pjb.186.1658786764718;
        Mon, 25 Jul 2022 15:06:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.127.250])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b0015e8d4eb1d3sm9818222plg.29.2022.07.25.15.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:06:04 -0700 (PDT)
Message-ID: <62df13cc.1c69fb81.474bc.f52a@mx.google.com>
Date:   Mon, 25 Jul 2022 15:06:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3186610675752153858=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@google.com
Subject: RE: Bluetooth: Always set event mask on suspend
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220725135026.1.Ia18502557c4ba9ba7cd2d1da2bae3aeb71b37e4e@changeid>
References: <20220725135026.1.Ia18502557c4ba9ba7cd2d1da2bae3aeb71b37e4e@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3186610675752153858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662855

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      44.63 seconds
BuildKernel32                 PASS      38.89 seconds
Incremental Build with patchesPASS      53.29 seconds
TestRunner: Setup             PASS      648.91 seconds
TestRunner: l2cap-tester      PASS      21.11 seconds
TestRunner: bnep-tester       PASS      8.16 seconds
TestRunner: mgmt-tester       PASS      128.88 seconds
TestRunner: rfcomm-tester     PASS      12.28 seconds
TestRunner: sco-tester        PASS      11.97 seconds
TestRunner: smp-tester        PASS      11.86 seconds
TestRunner: userchan-tester   PASS      8.47 seconds



---
Regards,
Linux Bluetooth


--===============3186610675752153858==--
