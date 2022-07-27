Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9212AC04A68
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 14:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiG0Oau (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiG0Oat (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jul 2022 10:30:49 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB20A3C171
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jul 2022 07:30:48 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g20-20020a9d6a14000000b0061c84e679f5so13014407otn.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jul 2022 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6b1YUVFKc32BzArSxWlgTzxg211jeT9pP/3p9mgNQ58=;
        b=X6+jJktGwNziofyUH4cXTt+MXmGGKSHw2itMZe4UTDjH8dsVSy+dFVmVUTepNfeKrn
         p+4bn9Fk4xhQ+q+en5eqcHYAZd0uFWcGZ5Z20ZK79xCAOiGPGFOIR7FpDicRLz5iCrip
         rvGUPZR48zUy+Q05g2ILKT2/8Rcv3pROoHIfkWzcnm3mqBfp7eAKzzfinH1jxXnqs+mY
         /DD93cONwVmYatwwYA84BPRXMf54/ObjpRs77fhWdDIuyMn/wY6OAbVv+Ez/wRvfhBLi
         NcVbCzGXsDOSf7l0fSuGhz9tknaBiGyHc4MXCZtiOHfA7AJfU6I0j7hUfAI01TFVJZVM
         dimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6b1YUVFKc32BzArSxWlgTzxg211jeT9pP/3p9mgNQ58=;
        b=7Do4mT0CDxppOtGynAC9+pfLW8fjMfg+qRsujiYAt+BXw3Q51pqVMMYJZB7EDnNB/z
         EI6kfZWIxbD/xWhe4rhqjzuEJXhLpaFC2eIVvHY8woUidHoFC4i71HVTGhpcqSX31UUW
         u9cU2yGen+M3DL0wyiaKbP1hBYKlUxn1I7jPBlGCM6GNIYXL3TRovb5uH+4RF3I0wmxo
         diJJAlJxWuxsl+7z8AMVbnt2lBPQh9pZkDiO8/juxIHetIVXh740OjSZc92X48lMNcw0
         mzRcJ++UCPMxrMSDq00adS01ZoXX0PenC4pK4NB/ZKL4GccVdo35bNiwIv/SC8rWI3pD
         iIgA==
X-Gm-Message-State: AJIora/MwFVaX7yL+UEuTP91+TQh0asNJ2W2nWiJq2mG7I1iREFwxxfW
        uRucWpQPm/bGWB9fQE60ObZ2ZVLCRcc=
X-Google-Smtp-Source: AGRyM1uSeGN3l71YHUXWxj9oKEfhFaWS+ZbZDSGzIANmthHh3j96frtj8Omjx96ke6yhG0IUmh5pvQ==
X-Received: by 2002:a9d:ecc:0:b0:61d:219c:ea0 with SMTP id 70-20020a9d0ecc000000b0061d219c0ea0mr384795otj.217.1658932247861;
        Wed, 27 Jul 2022 07:30:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.149.55])
        by smtp.gmail.com with ESMTPSA id l15-20020a4a94cf000000b00435f5744be3sm2306735ooi.9.2022.07.27.07.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 07:30:47 -0700 (PDT)
Message-ID: <62e14c17.1c69fb81.9050a.938c@mx.google.com>
Date:   Wed, 27 Jul 2022 07:30:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3521097573380296846=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Clean-up stale/unused hci_request.c code
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220727135834.294184-2-brian.gix@intel.com>
References: <20220727135834.294184-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3521097573380296846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=663448

---Test result---

Test Summary:
CheckPatch                    PASS      6.94 seconds
GitLint                       PASS      3.40 seconds
SubjectPrefix                 PASS      2.37 seconds
BuildKernel                   PASS      40.29 seconds
BuildKernel32                 PASS      35.21 seconds
Incremental Build with patchesPASS      84.66 seconds
TestRunner: Setup             PASS      582.65 seconds
TestRunner: l2cap-tester      PASS      19.53 seconds
TestRunner: bnep-tester       PASS      7.70 seconds
TestRunner: mgmt-tester       PASS      115.78 seconds
TestRunner: rfcomm-tester     PASS      11.30 seconds
TestRunner: sco-tester        PASS      11.03 seconds
TestRunner: smp-tester        PASS      11.06 seconds
TestRunner: userchan-tester   PASS      8.14 seconds



---
Regards,
Linux Bluetooth


--===============3521097573380296846==--
