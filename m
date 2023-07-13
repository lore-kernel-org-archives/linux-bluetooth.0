Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F45EEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 08:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjGMIIh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 04:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjGMIIK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 04:08:10 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9823A9A
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 01:05:45 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-78360f61ba0so13332339f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 01:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689235545; x=1691827545;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JDB1gei3Za2RZUrTwvvipU48NWDiWx2gvc4ga5/Y+tg=;
        b=CW/puRz9CZUROHCfKr9ZlVraXWoS/uU/pViGTxlbZme1svENki5Rq99Ts/jYC9cUII
         HhHsR72R6fx7alb4vh6HChZB1vUCioUfh8LN7QuaXHAT2HUCxJ/JnilsbSd3M9X4hJW8
         vWAgZuIqOJiaChHEFagNIyQHwcRajZwyaGcqpYjjAX+9ntARV+VF7MHtBUIEBxKxu3xR
         NFK/oxBNpm9thnZ++eO3PQNbletUVEG8NoKE/9j3nPe4Q4rOqHHN7M/Q25uWSS23r+03
         R6WXnZe1FpUrX00eRxwW2dR9GMzWdGGSd2cz1Oz8YnJaXeiORRfsQQ2z3k92bomVhdbn
         Hdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689235545; x=1691827545;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDB1gei3Za2RZUrTwvvipU48NWDiWx2gvc4ga5/Y+tg=;
        b=iNjtCHvbOX1jd9gRXcACd9Y6uQX/cSQjLiPYWoMh1Ybuz9VbjHcXGxwoosXI9dAvRT
         0O+QQ4eqd2fKOwN1wuJ12MlE8A0EJ6tssdnCOcINwmfNHVCO38Pakl1OyD3QJicuUOsw
         WWJbVLUlLAVi34r5wxASFT6fZBBqnsjbyZVo0fduG9GjoStey921yQ65cyKjZzyun//0
         MklkIt+yTEzmbD+wxJFTPM3g0YddhTwh+y3/5PNTVdfacNYYzBgAh9fhZuJn2Cl6+O/Z
         5C+Vdg1E2JlUOuEceCw8mUjqydk4tBnai0kkGTMIiT8JSvgCwdYyYlNlF0u2YamTXoew
         E3yw==
X-Gm-Message-State: ABy/qLZQ5OJKu+TqIg4HQ9EysCLAbU33W98LzLE33RJKEuM9rjBdGUch
        sNlL4+mYWtDhyo3KMDUk75qxjotb880=
X-Google-Smtp-Source: APBJJlFxbigpwn+hstkTXN+GCWZ3VD+cHDojvxUPD0Fgv3C6E+SMUWu9qIcz8uNMUBQGy9nzZ8lpdg==
X-Received: by 2002:a6b:3113:0:b0:787:129a:1e6c with SMTP id j19-20020a6b3113000000b00787129a1e6cmr1138399ioa.4.1689235544759;
        Thu, 13 Jul 2023 01:05:44 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.43.48])
        by smtp.gmail.com with ESMTPSA id c3-20020a6bfd03000000b00786582eb9fbsm1898775ioi.15.2023.07.13.01.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 01:05:44 -0700 (PDT)
Message-ID: <64afb058.6b0a0220.583a3.36b2@mx.google.com>
Date:   Thu, 13 Jul 2023 01:05:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0533557633470149108=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v6] Bluetooth: btmtk: Fix kernel crash when processing coredump
In-Reply-To: <20230713071105.26248-1-chris.lu@mediatek.com>
References: <20230713071105.26248-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0533557633470149108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=765155

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      41.97 seconds
CheckAllWarning               PASS      45.39 seconds
CheckSparse                   PASS      50.94 seconds
CheckSmatch                   PASS      137.65 seconds
BuildKernel32                 PASS      39.50 seconds
TestRunnerSetup               PASS      606.53 seconds
TestRunner_l2cap-tester       PASS      29.11 seconds
TestRunner_iso-tester         PASS      63.31 seconds
TestRunner_bnep-tester        PASS      13.25 seconds
TestRunner_mgmt-tester        PASS      249.14 seconds
TestRunner_rfcomm-tester      PASS      20.03 seconds
TestRunner_sco-tester         PASS      20.78 seconds
TestRunner_ioctl-tester       PASS      22.75 seconds
TestRunner_mesh-tester        PASS      16.63 seconds
TestRunner_smp-tester         PASS      18.05 seconds
TestRunner_userchan-tester    PASS      14.12 seconds
IncrementalBuild              PASS      38.05 seconds



---
Regards,
Linux Bluetooth


--===============0533557633470149108==--
