Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B62C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Oct 2022 21:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJUVQ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJUVQZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Oct 2022 17:16:25 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F2A13E21
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 14:16:24 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id z30so2842844qkz.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CmtpDrZTk48oXkCqKWbx/5AyDRmEgQrLduz5OGCfYBk=;
        b=DFm+7co/ZAQTRRCMNVTZhAWSFvCiMt6W0oBaJPfYUb7zzUpqIDyTWBM9IZDzl7k9VG
         DsNcKIrZuciQIEdxwx7QbC/wJlGAXuxcp27Myg0t2KJ1uUVGmaDHjWy5wTvWyj8SF/qL
         RwA7lcLI9/5nKEPEJfraE69GEISY95SOMx4UElYo6zIuF28WblD/2iXxvx5/gjwFgTVU
         JPYtqi7k3vHZKY8rSQ0IJU+az5KtoVeb6fctLAc/P6pWLDZYSbc3B2BrpNb/iz7z2NFv
         8YKa2frZFgWviNjgR/KbZhpa0pG3GOAiF+dh14XzQ3dlU9+3C2gu5GElBiK8VJMG+CyQ
         61Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmtpDrZTk48oXkCqKWbx/5AyDRmEgQrLduz5OGCfYBk=;
        b=UAOnNSDcbO1GkoyQpFamXcJzJCtTILS441WiklkmT4Wkr0hzoV7KBOMBGz+2Aj+qou
         AeieOGygFIvGbqvSJeknr3ujWuKa7zhJkLJ+k+yvEC3YBoaXZiI4cOkxdDHIgksqH78V
         hnri/MqpTUCpnYpSUeTpHZnELv4IKXVNIkt5BY8l+rIKiLD1rwaB1DMy+/BnomuzCGYE
         +7F4JNJhNLGQP7XV4AdLTIZ4rBwmFMRSH73v6X8tkRauvywSE+WPkcXwwddXjbrNRpH9
         gth7tN1MZ/NdcGhQC59NyhSl4WaLFthu4ZbP3s+F4NP5ZJySMN965WlgW4UWT9idliNu
         XKJA==
X-Gm-Message-State: ACrzQf1+WUI3uu6drCGPQm9j2Jnmu0qJop8Ez5pZfPejV/9FcTBsYuUv
        6N9bb/bK/B3SxrTj1qup8sk380c9gEsFLQ==
X-Google-Smtp-Source: AMsMyM6e/h1t4TIeWO1WMJnf2d0KRACPZdx/hkqCl1enzoPZnnevoCGNNjUggFyddZG2xDqCdI36Qg==
X-Received: by 2002:a05:620a:25cc:b0:6c9:ab32:7621 with SMTP id y12-20020a05620a25cc00b006c9ab327621mr14490903qko.533.1666386983241;
        Fri, 21 Oct 2022 14:16:23 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.223.132])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006af0ce13499sm10421754qko.115.2022.10.21.14.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:16:22 -0700 (PDT)
Message-ID: <63530c26.050a0220.cb9b6.532b@mx.google.com>
Date:   Fri, 21 Oct 2022 14:16:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1056859541281380273=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ] shared/bap: Merge PAC records of the same type/codec
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221021195743.490649-1-luiz.dentz@gmail.com>
References: <20221021195743.490649-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1056859541281380273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=687658

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
GitLint                       PASS      0.94 seconds
Prep - Setup ELL              PASS      28.28 seconds
Build - Prep                  PASS      0.83 seconds
Build - Configure             PASS      9.25 seconds
Build - Make                  PASS      1029.51 seconds
Make Check                    PASS      11.98 seconds
Make Check w/Valgrind         PASS      302.50 seconds
Make Distcheck                PASS      253.24 seconds
Build w/ext ELL - Configure   PASS      9.64 seconds
Build w/ext ELL - Make        PASS      89.76 seconds
Incremental Build w/ patches  PASS      107.48 seconds
Scan Build                    PASS      577.60 seconds



---
Regards,
Linux Bluetooth


--===============1056859541281380273==--
