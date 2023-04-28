Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57259C77B60
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 21:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345755AbjD1Vnk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 17:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjD1Vni (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 17:43:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2BB26BA
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 14:43:37 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-74df951e897so17003685a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 14:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682718216; x=1685310216;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hDFTrl5JCidlVywJtPNae1VR8Jxc/ZEcm1TzlaFiRjE=;
        b=jb1deUVXHhWoCurYGvylCj9UkQ6O6rBoTpyTKnFyap85Q48DoeRJbZrW08SiDKlpDC
         fyLCZ5VjFvzWZnBt6DEVGzzzF5rkiW33/3CS86J8u147SGJepE1myR4oMfqcmKYY76Vh
         2T0ZXUueq3bYdQAVS4r/DQ9k0C7GXkOQoJpOvJmLR3VUD1IQiMh9oK6koe1wF7/jzxfO
         631wjmkOQ/9O21qwCywl+4OmJnqVH0ZVUJfsAOcfn8MomH2IBMKltlA0HiGu7EgCXEga
         cf1KksYmkRKDZSXcOxxa6AfOa355sAyAFBbT6FYDOSI509WbK3OcIxCTM/sFAoxvLeXg
         WlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682718216; x=1685310216;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDFTrl5JCidlVywJtPNae1VR8Jxc/ZEcm1TzlaFiRjE=;
        b=LF2ta2bkw+uJITYwi6CJYVQuuWroYtvO7QvDxBhL6X7QiHhOxflBzUNvWtd4YRARPD
         yBq1YoN3R0TKeyzmqalB7VZQe4/d+DR4A50rpniRsKnnpKsTXLI4iROeRo4dBlLq0gx3
         tgAyAYSppfNIZ7W4XI7QgpDtP9H4SYEytkXH36ObMZOIKyYUAuekEdkOhbUM6rim8UER
         3EntAYbRS6UWu0eLls2YYB3Ee3yCjZiq0GvhLSsJrT5Z1UlXwhJdCSbR7N0YTMdR/vUM
         /RHTLI8NqERW/CYAgx7kmVxcSVtOitmn/q291nv9Kbt9E2CU/dR+81M/nfp0Ezsx2MrH
         RcpA==
X-Gm-Message-State: AC+VfDyC1e9hGIGET8T4KHMAHRRdZGEmodBdMCYZVjz+w9HbqaGc9Bsw
        CSuHcQyJ83aExlqGCSsfy8CJiNK7XQo=
X-Google-Smtp-Source: ACHHUZ76PgMwApdahOUBgXUcwuAZ2jdYs0kzfaAKbPM45qPRA8otMJ+IKZCOn15j4n+a8YltbD51KA==
X-Received: by 2002:a05:6214:29ec:b0:5b2:fb2:4b1d with SMTP id jv12-20020a05621429ec00b005b20fb24b1dmr10698442qvb.12.1682718216055;
        Fri, 28 Apr 2023 14:43:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.13.56])
        by smtp.gmail.com with ESMTPSA id h19-20020a0cf453000000b005fe956a64ddsm6344752qvm.103.2023.04.28.14.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 14:43:35 -0700 (PDT)
Message-ID: <644c3e07.0c0a0220.9017.abd4@mx.google.com>
Date:   Fri, 28 Apr 2023 14:43:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2414255601539474281=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4,1/9] media: Fix not storing Preferred Delay properly
In-Reply-To: <20230428184640.849066-1-luiz.dentz@gmail.com>
References: <20230428184640.849066-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2414255601539474281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=743913

---Test result---

Test Summary:
CheckPatch                    PASS      5.30 seconds
GitLint                       PASS      3.16 seconds
BuildEll                      PASS      27.05 seconds
BluezMake                     PASS      860.46 seconds
MakeCheck                     PASS      11.82 seconds
MakeDistcheck                 PASS      151.47 seconds
CheckValgrind                 PASS      248.07 seconds
CheckSmatch                   PASS      333.33 seconds
bluezmakeextell               PASS      100.40 seconds
IncrementalBuild              PASS      6367.43 seconds
ScanBuild                     PASS      1012.27 seconds



---
Regards,
Linux Bluetooth


--===============2414255601539474281==--
