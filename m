Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C61C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 19:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353173AbiETTLv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 15:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbiETTLs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 15:11:48 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF959D065
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 12:11:47 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id y15so3596642qtx.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=27UJFz5SfC2ek7CCbsKscn2NB4MKmLjhbUs+K41637Q=;
        b=UYh7CK7Bv5/AHZWqJZjZGlqfh2+vV7rC0nH5aQKXrGQZB6CPpyVPNkKrSmkuhT1pei
         kf5jqu6CdX1CpHP0NSmBbIyxwfSDz4B5U42lQGZy8RTuKAW6WVML1J7znBU9bVnmvs3J
         0nmVU+Hfu+ELabC87hmyzLhlWhjno4U15Dgf/th5iG02TAHfdn0iqQi2EMkuAE4TGDqJ
         i+3XkyZwXHqKho1g3e0cPPDAR6/by2J30iFU3ShVkEw2A8IP0J1kR7M0t6g3VqD2tJTJ
         vT4MQP3eSVWAS8wPbgHY/CRA82wIoLOD/t9tBLT5Bd/8iZXTTKtE4Yjim179nWU8op76
         S26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=27UJFz5SfC2ek7CCbsKscn2NB4MKmLjhbUs+K41637Q=;
        b=q0D0nAVTnO5T/LzbfFu/A5oVCuuPqhnQrugHYwCRxZTATtmdmBDqXTdZ0Wws+VAuah
         oE17R0SYA4CXo/J+XuCTY0h/Em8nCRO5K4BkQWKCe7WMyf5/+m9hUSx00TS68+jfDKb6
         y5ICWTTm84RGKoWk+Qd24TTmALR4/reC4waGLLU6UECyKQKBlmM7gxVXWNqO3hf7LP0h
         9e2oz1Ns0Ef6MboNCx1JmA/U4bJKQOLOfM2i654jroqZjyBf3EiWW8dcbgHcvhKTsoJU
         MVON1v/9ly1WN9qy+oSHAsfUU5FEHDjd2UdCmFPqKRn9T8wRBtoE2COeEVAsFP4Bn/vZ
         ILuA==
X-Gm-Message-State: AOAM532h+KkMFDsb9N3yGFCFl4pFU4S46/zT68P56khF1CxibHwoNpUn
        dZsAmb1jaQR7ZiSg2UkTNOhZhF2duBOh0w==
X-Google-Smtp-Source: ABdhPJyQBzM4euonYGSdvYYofn/M3scfwayhqV9fF3Z8U7lScrtDKa4Ic0TzUbw2GQEDYyVBYSuuzw==
X-Received: by 2002:a05:622a:14c6:b0:2f4:730e:40fa with SMTP id u6-20020a05622a14c600b002f4730e40famr8885705qtx.495.1653073906354;
        Fri, 20 May 2022 12:11:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.247.38])
        by smtp.gmail.com with ESMTPSA id u3-20020a05622a198300b002f92a5a396esm242254qtc.3.2022.05.20.12.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 12:11:46 -0700 (PDT)
Message-ID: <6287e7f2.1c69fb81.d166c.1e3d@mx.google.com>
Date:   Fri, 20 May 2022 12:11:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4503179052462898884=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [PATCH-stable] Bluetooth: hci_conn: Fix hci_connect_le_sync
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220520183713.2641513-1-luiz.dentz@gmail.com>
References: <20220520183713.2641513-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4503179052462898884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=643739

---Test result---

Test Summary:
CheckPatch                    PASS      1.85 seconds
GitLint                       PASS      1.06 seconds
SubjectPrefix                 PASS      0.89 seconds
BuildKernel                   PASS      37.24 seconds
BuildKernel32                 PASS      33.03 seconds
Incremental Build with patchesPASS      43.64 seconds
TestRunner: Setup             PASS      538.97 seconds
TestRunner: l2cap-tester      PASS      18.95 seconds
TestRunner: bnep-tester       PASS      6.88 seconds
TestRunner: mgmt-tester       PASS      111.80 seconds
TestRunner: rfcomm-tester     PASS      10.68 seconds
TestRunner: sco-tester        PASS      10.41 seconds
TestRunner: smp-tester        PASS      10.40 seconds
TestRunner: userchan-tester   PASS      7.14 seconds



---
Regards,
Linux Bluetooth


--===============4503179052462898884==--
