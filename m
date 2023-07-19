Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D65EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jul 2023 03:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGSDby (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jul 2023 23:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbjGSDb0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jul 2023 23:31:26 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BD0E43
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jul 2023 20:30:18 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-76c64da0e46so336036839f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jul 2023 20:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689737418; x=1692329418;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ddh9w0uq4OnokpDIPEwA05yv8Kl24B0Oy6nYa6e31E=;
        b=NY5PMd/tzh1xc/pPW/oANAkg0Q38naHyH3t1FAcBxE9mkiKtw3BAel+kh53w6GU54w
         Dx4E3YCltsSHap62GXud0lvBleMlK6hvwcdtktVONlJ8OUXBFhogWwZuwcAm1QXvt+qb
         zG/D6ma7zHMMWpBy3gzGFp1Kt69ttR7PpXR1p/aU2DdF8NQQIwyHGR1eH8yItNkIroVV
         Hm0L25JYQcKqY5afCZn4i+XZrGuxYDmO/vi+4gZ4crRFbyG4dm1spig2V/xsVpJrexox
         efsZZ3tm9DFNBPi9xOjJN9xjtuNKOZaajbapGsZ1U0nD7GKoD78LgMlXND1R1ah1BTKz
         7xBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689737418; x=1692329418;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ddh9w0uq4OnokpDIPEwA05yv8Kl24B0Oy6nYa6e31E=;
        b=kSPlCBLA5bmsFiTIixJAcB3aODG2zznqJUkIokJtaSTwekpKOJCc6h3JESp8AFDDqT
         Vqv34AafvSb1nhcbg3+u6ZSBlWI1wL5NWW9veqWhDUpgwz8pJH63NH1kmQE7gbQeFTXx
         JXRR8/P5w3qYVpD413pPUEnkUa/hP8ObA84nebSS5BmNLLM+blo/s2nvNb8HWkAB7zl/
         gtCkaGOjryuHquQkC25Bu+GAbW4osQ646oR5tLacOE7feDuz2Cwre18ZrqXAxeQPHF8g
         sBYjrqsjGTLVmRrmygzcWOjcf2TSp+8ZIhQ1CbMlmfpq0pRYEBzN5fVD/eEY2bF+V6pm
         iRDw==
X-Gm-Message-State: ABy/qLb8xswKlfqD+s9vpjIgQ3Xx14SiCfkjd5KkLUECbXidbvaXVxPw
        egnzjSNGjnrhcaC6+krSP+25V78U3JA=
X-Google-Smtp-Source: APBJJlENCxF7XZjQljqmr/eVzzp/APJbwRKMIxhFSgdJD2D9cLeJ5iyhgrIGqa7obDVqwRAXKTMbdA==
X-Received: by 2002:a5e:9918:0:b0:787:8d2:f15 with SMTP id t24-20020a5e9918000000b0078708d20f15mr1433191ioj.8.1689737418013;
        Tue, 18 Jul 2023 20:30:18 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.243.248])
        by smtp.gmail.com with ESMTPSA id v26-20020a5ed71a000000b00786cf14a8absm1054083iom.43.2023.07.18.20.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 20:30:17 -0700 (PDT)
Message-ID: <64b758c9.5e0a0220.d41cb.1cc6@mx.google.com>
Date:   Tue, 18 Jul 2023 20:30:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8862782095555090787=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3] btmgmt: Add man page
In-Reply-To: <20230719012012.232725-1-luiz.dentz@gmail.com>
References: <20230719012012.232725-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8862782095555090787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=767095

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      32.29 seconds
BluezMake                     PASS      1089.41 seconds
MakeCheck                     PASS      12.08 seconds
MakeDistcheck                 PASS      156.89 seconds
CheckValgrind                 PASS      258.06 seconds
CheckSmatch                   PASS      342.63 seconds
bluezmakeextell               PASS      104.37 seconds
IncrementalBuild              PASS      859.05 seconds
ScanBuild                     PASS      1092.08 seconds



---
Regards,
Linux Bluetooth


--===============8862782095555090787==--
