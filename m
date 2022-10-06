Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13C8C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 06:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJFGa7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 02:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJFGa5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 02:30:57 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787873F301
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 23:30:56 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1326637be6eso1140022fac.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Oct 2022 23:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wScVagI+wWjJ3JC3k8TBuMDFXSvo964pshM7dX3prNM=;
        b=AobfRXX/6CY3/UPy34CCz73lcLPfpz/+/Hx8hiHAIcP4F3oQYek0QNQnPElYgjBTj7
         pkyTsK6Z01EjEG+2gfOgROOeE4VsgWCnOs2Le3T9Q3HpE6BjngOnKADIYbcPV6Ox1OFW
         6n/nzf2u+l4lCawXjWOR3N2VeyMmP/4Lx28GPXnb9xmdovqEk1o5/6fc53QLkXxoFji9
         743j6ZODntFuyvj2P6GsLypUxNbTQk9PbS+pP2Bz3X/b114ThMI8BB+5k3bvwIltyIDO
         nUlMm3+DbUa8jCeiWi98dgzQuFTm9m1pYKT4ZJ4nZQ2bIL6sp2knve9wHYc1PXXUJKs6
         XypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wScVagI+wWjJ3JC3k8TBuMDFXSvo964pshM7dX3prNM=;
        b=YGlhJc7F39H+rZ4KIITvcTdsS2K3MW9hgj1zoQokIC3iLB3BcderJ8ZazH0T+njLIu
         R+LktAU169rlGt9uELHw97Y8jTR7QfDvrZ4s2YvPgmGIOiKhWeDOwscL/EFcXqT7byKM
         2M2zf8NQ7mSzdhO23Kc55cPVefQ+Zxn/ITK6naGX9kHpxk5uhxGowxnlx5hPMAS2/bx6
         d04b4wdVhOruNBv3alzQ+1g5UsTCiUzZZzDTOdUVfpriAFUAgbdniKiSbdPpOsfWhcpU
         R99A1ZHqDmzEi32g6nZJXlJysrzeS2+VsypX1u/bfszWo/yWdmeOE3fvDh8iz61j5MXp
         gtdQ==
X-Gm-Message-State: ACrzQf15iz6Mmi+wQijD5QrrdEKjEynif6CigfhzdZYb4uNn+4aNfTfy
        bckTIEEqENEz/Qb8mboEzwDvIR3PJ8g=
X-Google-Smtp-Source: AMsMyM4V+RNwJ9YyL68XXyXpJ2gOiQ1A+Rf4IDBhH219NFMU6QTuZs4BmmftivHRNr2VWBUM66wUVw==
X-Received: by 2002:a05:6871:28e:b0:131:91b0:6a1 with SMTP id i14-20020a056871028e00b0013191b006a1mr1735659oae.200.1665037855583;
        Wed, 05 Oct 2022 23:30:55 -0700 (PDT)
Received: from [172.17.0.2] ([65.52.39.99])
        by smtp.gmail.com with ESMTPSA id r185-20020acadac2000000b0035173c2fddasm5309934oig.51.2022.10.05.23.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 23:30:55 -0700 (PDT)
Message-ID: <633e761f.ca0a0220.2c6bb.06c8@mx.google.com>
Date:   Wed, 05 Oct 2022 23:30:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9024415342703316368=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org,
        nicolas.cavallari@green-communications.fr
Subject: RE: [v3] Bluetooth: Work around SCO over USB HCI design defect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221005150621.20771-1-nicolas.cavallari@green-communications.fr>
References: <20221005150621.20771-1-nicolas.cavallari@green-communications.fr>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9024415342703316368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683249

---Test result---

Test Summary:
CheckPatch                    PASS      1.32 seconds
GitLint                       PASS      0.75 seconds
SubjectPrefix                 PASS      0.57 seconds
BuildKernel                   PASS      42.23 seconds
BuildKernel32                 PASS      37.82 seconds
Incremental Build with patchesPASS      52.59 seconds
TestRunner: Setup             PASS      623.02 seconds
TestRunner: l2cap-tester      PASS      20.33 seconds
TestRunner: iso-tester        PASS      19.78 seconds
TestRunner: bnep-tester       PASS      7.42 seconds
TestRunner: mgmt-tester       PASS      123.60 seconds
TestRunner: rfcomm-tester     PASS      11.94 seconds
TestRunner: sco-tester        PASS      11.11 seconds
TestRunner: ioctl-tester      PASS      12.68 seconds
TestRunner: mesh-tester       PASS      9.28 seconds
TestRunner: smp-tester        PASS      10.98 seconds
TestRunner: userchan-tester   PASS      7.78 seconds



---
Regards,
Linux Bluetooth


--===============9024415342703316368==--
