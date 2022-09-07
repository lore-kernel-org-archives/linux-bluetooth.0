Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA81C38145
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 23:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIGXZa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIGXZ3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 19:25:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E7D73924
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 16:25:28 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id cb8so11722870qtb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Sep 2022 16:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=0rIQ2h0R1N5OCB7s10iNVLiG5JkzbDxFGM4f83illQU=;
        b=l1DbJhQ1jhlK/a/7lpHimOaQGASGEBlAqhzSjBv9cdFxr4Sup/0HbFV/B2QbaChp5K
         EXm6TzPBJ9r0sWdBoqSOQVQa/xI/yz5GGslIOdrv8HxA1Wh51FDeK5QTzyX1Dda95WR9
         V6dY9cZH0Yen9v4Eqpc79BZnHGojlHNE8TB1Douljhf8t1xLaGA/q79A0vqiDQCmeyR2
         bjmXMxhjLCDzVmXda/PwmTfQXiZDCe+E37B0zjKJ7CRDfZinwX1os2ok0nHbi2V3ipqm
         xmtH8TG9IeEvsfSdBr2eHAWgh14K2cRBWdGjo7L0NDKKySsHCv6oGySV1ufA3MjODGh6
         4xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=0rIQ2h0R1N5OCB7s10iNVLiG5JkzbDxFGM4f83illQU=;
        b=KLXQVURDmCfcirDPp/F2vCv4pgkso3nZ/zqxPKxH38TDnEH3yPOablv/sureM8qLSu
         AAToIYHvqYdyjOSHxpxDK3r6NCdeaukOjNlaqU5rDASDpXoqDTAD7p7oyfdkzP4Vc/mp
         WeMi0fcqQkDIg3KIwuChG01Fh+IKzTFwxk2sNphk7ybECvDMkgaj1Xqt5sFeRRh1pb7s
         5rtcAzvQclLdHs09xrv43q78OOgP3cwTnbVhwVSWrjy0B+8YE3i2idYwopdldB81hNMS
         ByCl5F0abbbJ6BfDRWzt5SkXzeEmpKbEnVXHotXXL/9fV9IzlC/Xf5SoWiP2bKoQqyd9
         8gzA==
X-Gm-Message-State: ACgBeo1c+tbD/6a4QXlBbLXSLn//F6PAqyFJ2AWhytIQBxCxlPQUkv3Y
        6mV3Vzg8ejnRtuBTA3Ng3s5f6vUPfJA=
X-Google-Smtp-Source: AA6agR5vgG/IYBUk/fDL2QrLZW3S8BhKGxQtu+LiCUWmTF1njpNsEy5wkqs6DKfRJufsJNhrThJw+Q==
X-Received: by 2002:ac8:5cca:0:b0:344:9548:7bb8 with SMTP id s10-20020ac85cca000000b0034495487bb8mr5730073qta.347.1662593127890;
        Wed, 07 Sep 2022 16:25:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.41.47])
        by smtp.gmail.com with ESMTPSA id w2-20020ac87182000000b00342f960d26esm12812454qto.15.2022.09.07.16.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:25:27 -0700 (PDT)
Message-ID: <63192867.c80a0220.ddc68.ee84@mx.google.com>
Date:   Wed, 07 Sep 2022 16:25:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6166507660118305308=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v3,1/2] monitor: Add ADV Monitor events to btmon parser
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220907224416.62115-1-brian.gix@intel.com>
References: <20220907224416.62115-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6166507660118305308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=675013

---Test result---

Test Summary:
CheckPatch                    PASS      3.02 seconds
GitLint                       PASS      2.11 seconds
Prep - Setup ELL              PASS      26.52 seconds
Build - Prep                  PASS      0.95 seconds
Build - Configure             PASS      8.61 seconds
Build - Make                  PASS      752.99 seconds
Make Check                    PASS      11.19 seconds
Make Check w/Valgrind         PASS      289.60 seconds
Make Distcheck                PASS      242.29 seconds
Build w/ext ELL - Configure   PASS      8.63 seconds
Build w/ext ELL - Make        PASS      84.05 seconds
Incremental Build w/ patches  PASS      202.38 seconds
Scan Build                    PASS      532.34 seconds



---
Regards,
Linux Bluetooth


--===============6166507660118305308==--
