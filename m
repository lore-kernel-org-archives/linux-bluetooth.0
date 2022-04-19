Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651B1C47093
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 16:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355229AbiDSQsj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 12:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354181AbiDSQnx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 12:43:53 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3AC2AE1F
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 09:41:10 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id s70so7181951qke.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/HyzczhBDGEGrsTFzlU6EToZcE76j28XfMQ36KWnGxU=;
        b=NTMNEDGglGF2Nj1XQzPWeANB5/nBF2v87wkY3ZBHWoGMX4JfCTbFIYdkJyeZrZjitR
         exD21/hwJunkf24l40tJ+Ht7Orf5woGaDsGNmunexSu7Kw5QM74AeDO6Ea88zQTI2CTL
         IB+oSE/pBlj4csFb8gtbQNUaRn8eU0Gz3p6/fH2w7WQKuetQreDsV472t2MYeLPxhD8D
         XECRekvSW5scly366XTDplE0Ye2hXEdYHcC16e1fhqrDe5ewVg9OsNqBE+J/IB881MCn
         7EpUVD4Us3yFF/qkeXUzsnkkl1zDFVJ+amV2MKEGoU5djLvl4/yOWAMbDhS0pfXmXfci
         bt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/HyzczhBDGEGrsTFzlU6EToZcE76j28XfMQ36KWnGxU=;
        b=WtJSim1V6ewzFnFjWBLmocypuf7E3OCxavllOWvtqmDNOSa6vAAvOg72fZ3RKpRHUq
         NAHletIPwANcDYNk5tBk6m1cyRl6MMN37lJAngbg7PiVm3Q0XUmA+Vta59CMn6IoHIiF
         GjocXzln4hZC7WrqirHFrB/9/OVrHDJej3tbnajbBJvo/rqU7LxJUPNWXtVDbfgfz2bb
         /x70ije+6Db9dPIswfJATTDWhSiMxQ0flTUH+hrX/Xdy2etmNU4W9gwF1S6vqkkjhOpo
         tMnmIRBeji9NmvoOk0WsWhq37Vcixd3vWesTeUnnj+ZITeiCil3CE/TABc4zBd3xlmAP
         Fl4g==
X-Gm-Message-State: AOAM532Ca+gDPxFYKRFSPH9FSh5t/P225pCvNelKwX57oE34DOGARM5Q
        atD7EhJ4s3ilMjLZ1/h1v7sQQaI+J7L97A==
X-Google-Smtp-Source: ABdhPJxq3/I4EV0GxuhBk+9Y4auo+GdHZHc4q8JiHzzEAksdwxZrQZwj3SvIiDSiy6SReQtXlLWl2g==
X-Received: by 2002:a05:620a:4148:b0:69e:75a1:9609 with SMTP id k8-20020a05620a414800b0069e75a19609mr9466571qko.566.1650386468738;
        Tue, 19 Apr 2022 09:41:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.124.8.10])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a099600b0069e5db6be55sm249287qkx.36.2022.04.19.09.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:41:08 -0700 (PDT)
Message-ID: <625ee624.1c69fb81.c74f5.26f4@mx.google.com>
Date:   Tue, 19 Apr 2022 09:41:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0083192850654669249=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, diego.rondini@kynetics.com
Subject: RE: [BlueZ] test: changes for Python3
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220419150356.694346-1-diego.rondini@kynetics.com>
References: <20220419150356.694346-1-diego.rondini@kynetics.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0083192850654669249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=633421

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
GitLint                       FAIL      1.13 seconds
Prep - Setup ELL              PASS      54.16 seconds
Build - Prep                  PASS      0.76 seconds
Build - Configure             PASS      10.41 seconds
Build - Make                  PASS      1445.99 seconds
Make Check                    PASS      14.36 seconds
Make Check w/Valgrind         PASS      511.25 seconds
Make Distcheck                PASS      262.61 seconds
Build w/ext ELL - Configure   PASS      9.94 seconds
Build w/ext ELL - Make        PASS      1380.24 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] test: changes for Python3
6: B3 Line contains hard tab characters (\t): "	AttributeError: 'dbus.Dictionary' object has no attribute 'iteritems'"




---
Regards,
Linux Bluetooth


--===============0083192850654669249==--
