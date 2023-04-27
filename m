Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27762C77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 04:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjD0EAy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 00:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjD0EAw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 00:00:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9EF2683
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 21:00:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24736992dd3so5204979a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 21:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682568051; x=1685160051;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jkPw3eEAnOvssy/7KikHnd4QXWymkBeS74mVubQcLlE=;
        b=Ovds85e6/GHlQJIV4qz0jdK+laJUk5+53mpOswduU80e6ZnMbJNVlqdYvVnEYTq1kZ
         in3c4A/Sm5xPCWeaWlGp8ajINqoDd+b45aT16tYlpqiB1R7edDeLcE0++W0DZwVGJ/bf
         C1q2kaYztbfaWnw8ryyG99lyMWS5ZXZrwmShn6gZ2K/N6i1QHqhUlhYRyazitZMH4wiD
         L2OlCjPZw8KIJfW6i+xBlsdW5sMnhw2WVVcuZ16RZ/ARaPHiazRFM/nnPHNOUF4mFLWA
         BmMz0VMH01qEBXjs1tr3L26azdve4Tyy7ft6McfGtbUJD5dXiHuWUae9ojIzCuGOzZo1
         S9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682568051; x=1685160051;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkPw3eEAnOvssy/7KikHnd4QXWymkBeS74mVubQcLlE=;
        b=Xf+Gu5SF9Jt4625l58hKN1O+08OJv5TZW9A1WjrDyA61urvU3IkC0VLu666Vu9SN8Y
         5sA3xxgeoD7ezyDIAxlCWjT8+SlEff+hGd9kHCM8HEZ4RsoC78gkRjQdEjb+XzGeMzg4
         1vXenaoRwk+o7WcUE53Y9g1TxjCySCmS+HcdoGTBZAmAclhY+OacMefZGalUh/tjWYtk
         gZz9dMBrFqMNTlVd/cfQ4IWnczlc7o6ol1I7/GDFY+IhjbPZanYSMSI76uKwnCAkpY10
         +Ev2R/5jEdh5p7taePrfL0pY1ETZjzO4dFfVYsaKIIu7SfoMo7rUWAeBiCh85C9WYx2q
         /Kig==
X-Gm-Message-State: AC+VfDyMMymTKjC0GAqcgQ/hzq9SrflN7ZYfSp3Ehn8rXMrGf1zw/Yxp
        n2A2qhf1QPwFZS5/6W07zMXVb4xTWEI=
X-Google-Smtp-Source: ACHHUZ7oGR9OP6s7fHB/LYOsP7xqUzAz30sQQVNBqULrpMkf8q0JDBhMcSzQPt3pLH5TZ/N/cyuAHQ==
X-Received: by 2002:a17:90a:f581:b0:240:95a9:923d with SMTP id ct1-20020a17090af58100b0024095a9923dmr385919pjb.48.1682568050424;
        Wed, 26 Apr 2023 21:00:50 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.87.18])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902700100b0019a7ef5e9a8sm10654453plk.82.2023.04.26.21.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 21:00:50 -0700 (PDT)
Message-ID: <6449f372.170a0220.3fddb.64fd@mx.google.com>
Date:   Wed, 26 Apr 2023 21:00:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8186047400584367789=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v4] Bluetooth: btrtl: Add Realtek devcoredump support
In-Reply-To: <20230427032755.28519-1-hildawu@realtek.com>
References: <20230427032755.28519-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8186047400584367789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=743500

---Test result---

Test Summary:
CheckPatch                    PASS      1.33 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      38.75 seconds
CheckAllWarning               PASS      42.89 seconds
CheckSparse                   PASS      48.71 seconds
CheckSmatch                   PASS      130.61 seconds
BuildKernel32                 PASS      38.04 seconds
TestRunnerSetup               PASS      535.77 seconds
TestRunner_l2cap-tester       PASS      19.81 seconds
TestRunner_iso-tester         PASS      26.14 seconds
TestRunner_bnep-tester        PASS      6.99 seconds
TestRunner_mgmt-tester        PASS      133.64 seconds
TestRunner_rfcomm-tester      PASS      10.69 seconds
TestRunner_sco-tester         PASS      9.98 seconds
TestRunner_ioctl-tester       PASS      11.71 seconds
TestRunner_mesh-tester        PASS      8.60 seconds
TestRunner_smp-tester         PASS      9.86 seconds
TestRunner_userchan-tester    PASS      7.12 seconds
IncrementalBuild              PASS      36.71 seconds



---
Regards,
Linux Bluetooth


--===============8186047400584367789==--
