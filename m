Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0F1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 May 2022 03:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiENDU1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 23:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiENDUZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 23:20:25 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F21335E9D
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 20:20:24 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x9so8616045qts.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 20:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kmw3/U2w17Zes4t60fkacuWQPVeJHIa7ImITOTuYB4I=;
        b=YzoH6xTZrEBxyuH/WTPe9a8FXqdiX7205cUwdueha5iTP+ACYbCR7yABkNcv2yC/33
         6/wI7V6FqMBKR8MainWkn8UXHHu1qb9s+3sKKLYhOyfUnMBqjv56ilX7ywlEsq3jtza2
         IIYUumcsSOVGY8QhdN0W5xWHDSrqublDmq0ltDq3ZtJdMEZy3bB8VHEkv1IsvNeHzeOG
         kx7IPpUeMcpzuqLCTurgGz9UnxD85jjcN4gaU35227BhsbYwaJRj6eX551Nvo4jSlx+3
         xld3Nr0tupdiSqzP+qvGgIaI5fuuqANGN5XLLopYE5HNLkskgS+nv56kyA4+Z3WRpUXt
         F2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kmw3/U2w17Zes4t60fkacuWQPVeJHIa7ImITOTuYB4I=;
        b=D0zovm2NVu9pniT6ykwCE0RSviqdZwmLey8GAF5S1ENZpcclsb4t6URWhU0/iImIds
         6y2EhXY6YWx4Qqm6knAbHPSNSNlU0Wr0074RLviQ+kVYYvSxfg5QDkc0cR2hq5FP7MrN
         RdZo+eyAn2L8Bmon/c3ukN0OFgvCdSHx72OwPfcr7IZnmiNbNWit9b5YWskj7IKPqCae
         SXSUSwr54R7l6LrG2pLttRknbZ2Z6UhjzQ4hH6aOMZyYEF4vlk4sKPCe/udvyequziQB
         1iNeF6XJR4V2Ca/JgbGfn2P64jS++Oh+HgspZV+B061IuMtD+AzChnmhzg+L2lI4MsXc
         2P9w==
X-Gm-Message-State: AOAM532hrWckx7F1718CtJtsDy8bPUvnTkW7BdaqZOv5Gcln0xXDN5iH
        bc/bzaZqyGQLjp9ch5/e85uwIqrc/Ws=
X-Google-Smtp-Source: ABdhPJwNYCsB0IPUb6qAdh0yymeRm+lSJg3Yakne107dch/n4c/smzRWk090+V5bogFKDOodxGsIhQ==
X-Received: by 2002:a05:622a:4c:b0:2f3:a78d:726b with SMTP id y12-20020a05622a004c00b002f3a78d726bmr7361754qtw.621.1652498423214;
        Fri, 13 May 2022 20:20:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.251.251])
        by smtp.gmail.com with ESMTPSA id 4-20020a05620a048400b0069fc13ce232sm2201055qkr.99.2022.05.13.20.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 20:20:22 -0700 (PDT)
Message-ID: <627f1ff6.1c69fb81.073a.ce27@mx.google.com>
Date:   Fri, 13 May 2022 20:20:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3003172878297705784=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/3] Bluetooth: Add bt_status
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220513235125.1364692-1-luiz.dentz@gmail.com>
References: <20220513235125.1364692-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3003172878297705784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=641604

---Test result---

Test Summary:
CheckPatch                    PASS      5.54 seconds
GitLint                       PASS      3.02 seconds
SubjectPrefix                 PASS      2.57 seconds
BuildKernel                   PASS      38.15 seconds
BuildKernel32                 PASS      34.43 seconds
Incremental Build with patchesPASS      62.70 seconds
TestRunner: Setup             PASS      582.45 seconds
TestRunner: l2cap-tester      PASS      20.40 seconds
TestRunner: bnep-tester       PASS      7.47 seconds
TestRunner: mgmt-tester       PASS      118.06 seconds
TestRunner: rfcomm-tester     PASS      11.15 seconds
TestRunner: sco-tester        PASS      10.90 seconds
TestRunner: smp-tester        PASS      10.90 seconds
TestRunner: userchan-tester   PASS      7.65 seconds



---
Regards,
Linux Bluetooth


--===============3003172878297705784==--
