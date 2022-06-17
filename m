Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1F1C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 21:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiFQVYY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 17:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiFQVYY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 17:24:24 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598CA36E32
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 14:24:23 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id p63so4027754qkd.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=uyXCOT7IBbw6dd/sgdeZsJGU7pymTIGmI3TE47GVUaE=;
        b=EdAD7utguQ/Z6FD7q2ZkoPVIuO/iHqOm23NbN0KUn6XLfi2WHNIb0ECmP0BrhMjtk0
         ZJBsp/pE4W7VfHdnHoFnP6PNv8M5BYmh+Ub4KVZrXH5ozEUGUbivljEozRm0VImx4so+
         IoZbMXtRdlqcoH3ZiidKxRE7+oxr6iEL0frEvbd12bdFPd+g6zUU7WYv+Um+ABsmtlQY
         lzudAC/F0zBjvpfmcL8raRJoQzkSArOPixtxEMlcP5RD+rkKrrnOTZBcDVBmPtDiPWgS
         rcIVaVzLwhwDLgOY1KLrfgqa033skaSSr908MFHCjFTRuv+BHKnSP3weqMs8cGro74BO
         08Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=uyXCOT7IBbw6dd/sgdeZsJGU7pymTIGmI3TE47GVUaE=;
        b=LJtGyMvZ/nED3AV93d3EcjoMs2DSlK1Bg8iA96dwTWD5IghaINPl04NIfi+fi/Wb1p
         rsUdAxvF3flgyQllWHMGcANAWTbHENr+5EbXpbIBV6nLIo/3vuQ5n7xrFhG7e0avzYYP
         ECDoDz3/iLJQpt8lD11LJXYgSJDDqm3O/LbBZ4JxtyAazK6TKDMNSRmUakBMJQ3+JmiX
         /RnHoMxUWNtZj3T42q/yar2A5Ahbzug4Rqm57c/MYyrGrdUwhLZoGdIcZ8r05OvSHY6/
         7gjvB0bfvpOtWj33vspmla8ISOj3QqTG32srO3Yb2bAJTMoP1RWdyY39sDzm2F5Girzl
         PsQQ==
X-Gm-Message-State: AJIora/KTE9chC2DR7pMtZnMUK0tO8gY1hzPXLinQH9NGh3RtD+84tlq
        /p2x1tz1GVyVIuRhW1hItGex9YAdcnwMBA==
X-Google-Smtp-Source: AGRyM1vtM7Ary5iuhjK6c//P0g8FcYzFfWaNjZ8gJwHWyVv0gvaUo5JwlRTHSHNSvHb11kr7gx6x8Q==
X-Received: by 2002:a05:620a:28ca:b0:6a7:c27:eab2 with SMTP id l10-20020a05620a28ca00b006a70c27eab2mr8526075qkp.431.1655501062241;
        Fri, 17 Jun 2022 14:24:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.104.149])
        by smtp.gmail.com with ESMTPSA id y17-20020a37f611000000b006a69f6793c5sm4844454qkj.14.2022.06.17.14.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 14:24:21 -0700 (PDT)
Message-ID: <62acf105.1c69fb81.1b86f.a93f@mx.google.com>
Date:   Fri, 17 Jun 2022 14:24:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3750915392975166541=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] test-runner: Fix issues found by coverity
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220617194929.95991-1-frederic.danis@collabora.com>
References: <20220617194929.95991-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3750915392975166541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=651543

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      1.03 seconds
Prep - Setup ELL              PASS      43.93 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.76 seconds
Build - Make                  PASS      1362.74 seconds
Make Check                    PASS      12.30 seconds
Make Check w/Valgrind         PASS      456.93 seconds
Make Distcheck                PASS      239.35 seconds
Build w/ext ELL - Configure   PASS      8.90 seconds
Build w/ext ELL - Make        PASS      1322.51 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============3750915392975166541==--
