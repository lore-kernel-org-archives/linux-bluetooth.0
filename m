Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6631C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jan 2022 20:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377565AbiATUOT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jan 2022 15:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiATUOT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jan 2022 15:14:19 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C3C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 12:14:17 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id j85so7507122qke.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 12:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=dD90yDvunec/UoJXSNG6vN/yCU1Luzp6Ereo+lDHbrQ=;
        b=fRSoRTKQH4QutW4RbCLH/zK3SNtfKbFGPnEE0vgkdDXXM6imELas+u8zHQi8LxxpO3
         Wz1MEdChcHgU1l65PSlGfW8eCDJIGSeaS9ttoqCN8urw2E2v8W8JlJQTyx9e0uS6I5Ba
         2WTU5jCcvDWwEFvwcmHDw/+8FBUhTe5lU/40RcpZV5Rf6o20zi7fK/LQcumHwx/aOw+j
         D6oSdke9isQJJA7SyFMUUuztKV+xBgybMwdcCG2ikXU09mDnEDV7F0qdXw4eRfOkKNwd
         KeaZ0L+83fxsHOYIzKdwc2UHkf0ctf5ZFW8a+r8whV1157RCY84Dz53tMYGeiiAv9z/a
         CnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=dD90yDvunec/UoJXSNG6vN/yCU1Luzp6Ereo+lDHbrQ=;
        b=aT7kbobvKtPkQDGz3whMjmzKvSap5fOj2y1LvflXzT9PY8+/ZUYdPk9hb8tATUhjl7
         MatUcyrlXwP/T5CDtIaCiEEuwGRIHZmBbP2Ppo8QD2yR7DsDU3+zNWRka8iWJHM9GkX2
         0wIZ250gAUtA8i6xdJHv5IJbgLl75mvtpHIHlA9tdXMC96MiMKZeZX5J37tptWD0v2in
         6bXBIVhTrgtzqw+w8PYs0I0DK+yfo4OR7Qcvqte/rUKf9INZ2DO31OfTYTm98HvvRnug
         /RlvHSvmpqUADnajxf/R+Ul7LnF8w+/z1gazTcmb/3A7Kgz+z94KQJNxfSxRlN8zfHHG
         PviA==
X-Gm-Message-State: AOAM532HW5cPNNlqXvQn/7dQHCvn05ZZlSqCwjQNNOoCtM3dsvhAdvAK
        Frmt3DHRoQ3yXSyCRwV/CzMpT292IYw=
X-Google-Smtp-Source: ABdhPJyZT99dskkE/DdCvWoCSr/N8Yeew/1eGxm466Ib1TbHoxkpWst5I/lJijFJpt9xyXn5z9BMHw==
X-Received: by 2002:a05:620a:b85:: with SMTP id k5mr393314qkh.373.1642709656231;
        Thu, 20 Jan 2022 12:14:16 -0800 (PST)
Received: from [172.17.0.2] ([52.242.122.55])
        by smtp.gmail.com with ESMTPSA id m22sm1910853qtk.37.2022.01.20.12.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 12:14:15 -0800 (PST)
Message-ID: <61e9c297.1c69fb81.20b5c.d063@mx.google.com>
Date:   Thu, 20 Jan 2022 12:14:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0275427623421496987=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [v2] Bluetooth: btintel: Fix WBS setting for Intel legacy ROM products
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220120194418.349438-1-hj.tedd.an@gmail.com>
References: <20220120194418.349438-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0275427623421496987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=607041

---Test result---

Test Summary:
CheckPatch                    PASS      2.14 seconds
GitLint                       PASS      1.03 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      36.20 seconds
BuildKernel32                 PASS      32.11 seconds
Incremental Build with patchesPASS      44.45 seconds
TestRunner: Setup             PASS      569.11 seconds
TestRunner: l2cap-tester      PASS      15.61 seconds
TestRunner: bnep-tester       PASS      7.12 seconds
TestRunner: mgmt-tester       PASS      119.34 seconds
TestRunner: rfcomm-tester     PASS      8.79 seconds
TestRunner: sco-tester        PASS      9.20 seconds
TestRunner: smp-tester        PASS      8.81 seconds
TestRunner: userchan-tester   PASS      7.34 seconds



---
Regards,
Linux Bluetooth


--===============0275427623421496987==--
