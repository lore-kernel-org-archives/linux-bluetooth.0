Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259ECC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jun 2022 23:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiFXXqA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jun 2022 19:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiFXXp6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jun 2022 19:45:58 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1998BECE
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 16:45:50 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id k20so3058190qkj.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 16:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=QBhxVthnGQTYBS8oigVNx5X8/TACYEG9b2Hu9Rmg/7o=;
        b=WetYRc7Nuf+jZERwObtJv8Ewq0oSsOeXhsLYFOlAvJg+UPkbfOOg0tNaR7flGG3kEr
         IgYP8CBbB3JsGy81iyH2KDWrJUltyZuBYLzxfsO5LPgW2bePjOhLnnkGfLyws24sNLI7
         bWeIYtuKlL2VUTqNbDFd7jJd+JjFDF6uDf4w3fz0+r/+u7THmPrAm/LPVWmsG46efbxB
         xMlg0pLgvTkT2iTRMINv0tjgQQgR5s/VnftR7Cs8wb5V4eyvdCK/LraqfdrngrutSrPj
         ib+pwrTon3cB9y4njqm5LHYTsxJWAWpIm9Nv8jxsCTEQb4S6mxgehdn4XDMYulY5Uk1K
         DMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=QBhxVthnGQTYBS8oigVNx5X8/TACYEG9b2Hu9Rmg/7o=;
        b=BvuR0WxrE+aUnC7ketYrJ7o3oaigJ3b/JxPmhLJh5gx1wwyOxsZ06mgldrOkVCkF6H
         Tro5AqrjqE2yb2bwa5TZFDvmfrAz9DS/jfOaREfhGke6MBQRutOyo4CxnMFLY5Sl8P64
         TSWTrHGL/yuo4q4MFErIop5Nryeol4nxVb+Fyw1zA+NwsmvjfVnpvm4ZyrFjS/u3gGCT
         Z3hUWnOErIoEHFDMAi9VrDBTGkPCxYrdzQt/pg0ZwHJjyLCRY5e0k0diemGaSib2TU8j
         OGju/86lJwcrXjinPlGD2p8WCk5wydVHyXvPxzPIADSgHr+7SZq2xkOxBpaT+2KQRTKG
         69mQ==
X-Gm-Message-State: AJIora9inVKUeJRyeKhPIjBko5tX9uGlHEF/wwTBGhl9m+Jeulyfgn10
        2oGjT9ukzjGOZMVbGVS2FKl9AQIztnxs0A==
X-Google-Smtp-Source: AGRyM1uA9pi50yDrIuTae4P9C+DuyUaItCh2WvYeqFVni2hlBSENdWD5tXCMmcSfoe4KnhnCYi9j6g==
X-Received: by 2002:a05:620a:d8a:b0:6a9:9102:3965 with SMTP id q10-20020a05620a0d8a00b006a991023965mr1388363qkl.784.1656114349359;
        Fri, 24 Jun 2022 16:45:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.186.157.159])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a401000b006a6a7b4e7besm3479943qko.109.2022.06.24.16.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:45:48 -0700 (PDT)
Message-ID: <62b64cac.1c69fb81.e65ca.8dbd@mx.google.com>
Date:   Fri, 24 Jun 2022 16:45:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8566755920013468667=="
MIME-Version: 1.0
Subject: RE: Linux v5.4.199: Bluetooth: hci_event: Ignore multiple conn complete events
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, John.Klug@multitech.com
In-Reply-To: <SJ0PR13MB575532A88E75738299CB1636FEB49@SJ0PR13MB5755.namprd13.prod.outlook.com>
References: <SJ0PR13MB575532A88E75738299CB1636FEB49@SJ0PR13MB5755.namprd13.prod.outlook.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8566755920013468667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: corrupt patch at line 11
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8566755920013468667==--
