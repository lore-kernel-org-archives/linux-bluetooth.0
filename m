Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930C1E748E9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Oct 2023 12:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjJAMms (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Oct 2023 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjJAMmr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Oct 2023 08:42:47 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E468C94
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Oct 2023 05:42:45 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1dd71c0a41fso4149021fac.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Oct 2023 05:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696164165; x=1696768965; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+9KOgdCRuOORQGFH3FtuXv6lPZB3oImVdcst0eEZekg=;
        b=ZRfpN9NRhpS3c+QX1UUU0maykXQilOOHNO0NQEuN7ki0orhWnyyZ8Imu+Q6r4IxbEO
         1VKh0mKUIPyLlITwfJ+zPze1kVmLbBhIoxGuQKSAzh1i+JfgW8feGOmPE3gS3qMIbyxg
         rGLVcTOrhxeRLu055iXkvCkgx64MtPyyaKSG+9P26zAIxEhsZqzR1MNBtXdfXKpSIpRv
         50QbyyaHwBSPWY6w19B0gy9kgoSdV/bT7TZ/kVapfaEWoPJTKpypGAMIRDOcbAFQm05/
         5xduH6yVBYsSwJ4iRcZ1aXqpF8N38WEwprx+eCa/fBj3y0pXBuImK56O2beYcbA4Gv34
         K2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696164165; x=1696768965;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9KOgdCRuOORQGFH3FtuXv6lPZB3oImVdcst0eEZekg=;
        b=KYuLItlqFeekL24JqExZEIPJoko2Zvqj3sM+8XfAvr+Q/8j5ytd5Pt6/xwEjvRnwGS
         M+OcmnHTnMHEBsQZvhVv9lz9lCQIqdEicAXzT9GDTDCzVZBD/NMfwg6hfBKu9sSWIRAM
         cZHnanOiCzq+tjgj/BqWmHb3wU9gKLEwIrm1op9fMJnpF8wpdD+JzyvuFR25ocfU1b6x
         CB4/MTrmiW3v+5wqz1xYeer+w42EuhOL4aqtgF8v1M9X3jyDTPmIhIlocNIPSU2dkLrI
         78BSk0iEPqoKI3TT7umNIAL6s1oioQkEQcb3I5OPbqUBGVh9Y5LnmWoLpu4IdfrJiF78
         pweQ==
X-Gm-Message-State: AOJu0YxZaJ7kz6emQTdhZbKMHMoyK2+F9tHnWqSMvbngMmwJRekS613a
        L8N4wrexBTaOIAfT6EuAIanp9nrD52k=
X-Google-Smtp-Source: AGHT+IFuVo0PSRjuaIClOS52VhWTPhyKtirnnOyiSo+8dDZq58jDRb5/kNThVRU7jwCJYaod+fBQ5A==
X-Received: by 2002:a05:6358:591b:b0:14c:e2d3:fb29 with SMTP id g27-20020a056358591b00b0014ce2d3fb29mr10427350rwf.0.1696164164843;
        Sun, 01 Oct 2023 05:42:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.158.208])
        by smtp.gmail.com with ESMTPSA id j14-20020aa78dce000000b006906aaf1e4dsm17881346pfr.150.2023.10.01.05.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 05:42:44 -0700 (PDT)
Message-ID: <65196944.a70a0220.b89dd.15b1@mx.google.com>
Date:   Sun, 01 Oct 2023 05:42:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3845359680568821136=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] bap: use documented MediaEndpoint property names consistently
In-Reply-To: <3358dfd1591df242507755cea63d00db3d2c959e.1696157794.git.pav@iki.fi>
References: <3358dfd1591df242507755cea63d00db3d2c959e.1696157794.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3845359680568821136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789114

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.53 seconds
BuildEll                      PASS      32.11 seconds
BluezMake                     PASS      1135.00 seconds
MakeCheck                     PASS      12.92 seconds
MakeDistcheck                 PASS      189.54 seconds
CheckValgrind                 PASS      292.81 seconds
CheckSmatch                   PASS      404.20 seconds
bluezmakeextell               PASS      123.05 seconds
IncrementalBuild              PASS      1948.78 seconds
ScanBuild                     PASS      1355.02 seconds



---
Regards,
Linux Bluetooth


--===============3845359680568821136==--
