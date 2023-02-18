Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0F3C6379F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Feb 2023 02:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBRCSt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Feb 2023 21:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBRCSs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Feb 2023 21:18:48 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEE43B21A
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Feb 2023 18:18:47 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jk12so87268plb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Feb 2023 18:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=42UwNfKBf7BFGEsZR/cm6z+mgdBdbsdTxKGfDn2B20s=;
        b=AGvv9+mZgDSJP3bNjd/0erFlIIcGpOVxQMoeAkk7xAV3iRuP0QEnd4IA0bnFQQg7Hn
         iXISwpqFiOOsi+BNiSp5HJSOoq878/ZWQ6rAUDP/+YbLA9IjrZXpT7CaNst6eINZZhL9
         n/7V1DyzBhUVQtLlRPfitMb7/HbLteJx56wRyjJ4XzdPGE/oWStYQl4Xhl8+warQ0HZI
         /V6692edy8vxJGZaxyYOQ4ZgIiWdUlldefclKOj/w3JKT7G0kDVMNhtRk9vt/X1WN12y
         S+29cbiO26M0wpBS1US9byn82RedEmJZZ+cPMbeTI7ETzqnBrZ6M0xYDnjhL7fV2oUJL
         ZYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42UwNfKBf7BFGEsZR/cm6z+mgdBdbsdTxKGfDn2B20s=;
        b=DMCKKw4OqobxNmTjTsD9f00quQVXDIGcH1fSqvFffDBXB0ZKhAXdzNFdiiWtkv0J7X
         sBkEmgY5oHkKPpE4wGksIJOFyMjbahFUv1Rh8T5gaIgYWXeFXhN7frfHpsA4XKoN6QFG
         XvuxOhlmtvZ+K3xlDSSXRrMgo6+wpVyDpk+3sc0J+xxP3zFwLZ0srujHCKtoS/zc0C+j
         6l2Hqai+zkEuf/6MxEtrHJw9sBONlzmOoYBvmOFS662A3kohe92KvgYW7ytT3C0QhjtS
         PXD4sTpc79CgARkz9oPP0NbU82p75YerFxIYHkN8yxbSifCnQ2YUB8Tl/bT063tHEZQY
         mCSA==
X-Gm-Message-State: AO0yUKU1+pXO9ESaEBzy6WYdg3+csJ6Lf8XM6gLt+HEsEA0Uws7eEvV5
        l5mpnZ5ddna0AhQYfC/8BOfKTFtuGwE=
X-Google-Smtp-Source: AK7set9GxWvY/oxpt3E7CeVqNzSVRNT0djjCZOQir2cvl18ucqXPSH/h3A9eKbCz8IhHyf+Mq/Nmxg==
X-Received: by 2002:a17:90b:1c8f:b0:233:c301:32ac with SMTP id oo15-20020a17090b1c8f00b00233c30132acmr3332464pjb.31.1676686726525;
        Fri, 17 Feb 2023 18:18:46 -0800 (PST)
Received: from [172.17.0.2] ([138.91.86.160])
        by smtp.gmail.com with ESMTPSA id d2-20020a17090ac24200b00231227781d5sm977018pjx.2.2023.02.17.18.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 18:18:46 -0800 (PST)
Message-ID: <63f03586.170a0220.55618.217f@mx.google.com>
Date:   Fri, 17 Feb 2023 18:18:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0537290313074910876=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] configure: Check ell path
In-Reply-To: <20230218004555.415122-1-hj.tedd.an@gmail.com>
References: <20230218004555.415122-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0537290313074910876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=723140

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      32.23 seconds
BluezMake                     PASS      1068.41 seconds
MakeCheck                     PASS      12.67 seconds
MakeDistcheck                 FAIL      30.47 seconds
CheckValgrind                 PASS      292.83 seconds
CheckSmatch                   PASS      400.75 seconds
bluezmakeextell               PASS      118.62 seconds
IncrementalBuild              PASS      897.90 seconds
ScanBuild                     PASS      1283.01 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

configure: error: ELL source is required at ../ell
make: *** [Makefile:11618: distcheck] Error 1


---
Regards,
Linux Bluetooth


--===============0537290313074910876==--
