Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1D5C41513
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 16:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGYQOX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 12:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGYQN6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 12:13:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7479B
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 09:13:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668730696a4so3222022b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690301637; x=1690906437;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GdU5gkNTGuCkRWwCEdumSBGbMUbmmFjFnMrvvDawmD0=;
        b=TloiRfHhb8bPsaGTIKyVOVGrfXYOnUzhb0Bhd4lBA1LRLkcDGOyb/HWQnsil6c4NWC
         yOa3UtUiT7TUBRDi5vl2VdGBwvK5jvE1OKUKvSZiukHWEuxCKCCsusznfocTml+uptvf
         miV96TFMi5JPXC85NbaPduMa5kg71VzW3xQ+EmrwA3cLTbAbqh/AJQ89F/KHkVENO7+z
         vIP4fwLYjtkqBGPf130y+KJg4tQM+uBzkdMBCeHQH523XsKV0kVeJVdgh+/PwjhpnvCC
         t+EhDmw44ErHVFoba59T2cEuig0vS0Ozvs5FRqnghYIK2ORGOqiefAnkZ+dZn2T4QeQp
         XXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690301637; x=1690906437;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdU5gkNTGuCkRWwCEdumSBGbMUbmmFjFnMrvvDawmD0=;
        b=RhEL00nf7aqE5YZkBS5U/RYu3RbmWC/Kj+tbF4WbEZvZFti+3OSRtiUvaANpyLQn2/
         7VGZXEZOXu7ty5AvTlwibSIXsat4dFjEEO4oFEKxC/JhlO5zQJEdbPV3E48Hacc5WfJM
         oTj70LhzmZlzIYNjFwYikDXmwph2xiy06T6dHMr7JJczEc0NInglw4tbuxoSqRN9lPyr
         5qatRJOeP4I4RR5g9bGQww7vkp7amqF4yiV7UqI65UI5CTc8rXl7kYyjZ/Lcy+vhlv0i
         3PrLwbv5DbZ8SJgCDrIKeEM2W627P9IgSwiScFhzRKdVCnytYelutKN/Uaq73E+55u+A
         7GNg==
X-Gm-Message-State: ABy/qLY69FBop6/Cz5u8EdfgpIcSe/vTrJK9Wr5OMgcw3Z03xpeO7CL5
        0oV7tDf5iPPekgDypOT0b8J2VE1zgWM=
X-Google-Smtp-Source: APBJJlFOzvWLhD7SKSp08IBlBt4VfqTip5vkBOY1GJupiBretkQwuFaU5LBc2Bfagkgj6/DbZQG9Vw==
X-Received: by 2002:a05:6a00:b45:b0:676:20f8:be41 with SMTP id p5-20020a056a000b4500b0067620f8be41mr11886613pfo.16.1690301636634;
        Tue, 25 Jul 2023 09:13:56 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.177.207])
        by smtp.gmail.com with ESMTPSA id q14-20020a62e10e000000b0064cca73d911sm9825043pfh.103.2023.07.25.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:13:56 -0700 (PDT)
Message-ID: <64bff4c4.620a0220.6f65d.1f27@mx.google.com>
Date:   Tue, 25 Jul 2023 09:13:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3252519973083669990=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nitin.jadhav@nxp.com
Subject: RE: Fix the crash observed with VOCS
In-Reply-To: <20230725134742.51651-2-nitin.jadhav@nxp.com>
References: <20230725134742.51651-2-nitin.jadhav@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3252519973083669990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=769321

---Test result---

Test Summary:
CheckPatch                    PASS      1.20 seconds
GitLint                       PASS      0.76 seconds
BuildEll                      PASS      35.83 seconds
BluezMake                     PASS      1251.83 seconds
MakeCheck                     PASS      13.06 seconds
MakeDistcheck                 PASS      212.03 seconds
CheckValgrind                 PASS      334.16 seconds
CheckSmatch                   PASS      465.97 seconds
bluezmakeextell               PASS      138.70 seconds
IncrementalBuild              PASS      3262.86 seconds
ScanBuild                     PASS      1483.32 seconds



---
Regards,
Linux Bluetooth


--===============3252519973083669990==--
