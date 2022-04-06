Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCE7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 14:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiDFOTb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbiDFOSw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 10:18:52 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8442B525C
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Apr 2022 19:33:16 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id f3so1258013qvz.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Apr 2022 19:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6TqcBjLq5PiMEQTnSLsbDDJaUEWpVZWercMg3D2aO3A=;
        b=PkM3dSZ6YelxvIzeF3t0gqVBZbUFXiTwTNTyT3JoxamhdPjLY07zYaprPuYWIPvkqt
         2iFwjlYGO5iYudtWmmx/7AzxydYo/D+fspy8ZCQXRtPl1bacrT55TSX8wymqRppuIs3p
         CD7XvO77gmMIYe6Ib3G2JxNmAMvcFksOdaj69eVltvxY4aikt8FBozG8XXGSljrYSUaG
         BzHirrQL9z6rXB6i3H+l7C1AeX/YlnsT6DfZiV7hQl9MBElZetU6kIKdn2eCbtlSkP8y
         efPt55w/XZX7atPzOvOFh2PMHLoQnLrcY6Awq/Uk1ScAPz1t6aidHYRvNE9txtZWuYZ0
         oZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6TqcBjLq5PiMEQTnSLsbDDJaUEWpVZWercMg3D2aO3A=;
        b=VDOSvin8PkEj+69/+z4esi20XDdtT+gvqXvkpVKBg/oi1QOfpxRyt6ocGZ0u6u97aE
         c7uKl5Nkrma6JrIAqybtuliKW+tg9PGuFk39bPgyv2bnhzCjIMG8KkrqNORdZzljCKo3
         DfOHUyE32sem38JVoXfjyfEMEGMXJ+1Z7euA7j1nAFcALFzCz5v2RIukI+GNnJEO+p+l
         njWheJKziO9aIB0lfXlcJhRkRg5SMRPRE3xoAn3b0ITfMIPqzMNKvqhnLmdns7uN9yZT
         k5oD6R+Jo7nIlCHZc1gPTD6vA4awglQRW9Sgkv+s7p+dSZzkD0UCJxfRM8fgXHzIfPLd
         GH/Q==
X-Gm-Message-State: AOAM533shQY5LNIoGMTuaYllt9sNd6VOMcpfW4tidUZwbxZh54Y+rBQP
        /SGoueDj+dWCXVhaoLMtfhDYN4SZFmYEWQ==
X-Google-Smtp-Source: ABdhPJxT23QjUO3rKSVc9LcW6pjxf5hBbhkgNr4hH3pDRGEljHgfssfT0JwMn1XJJEoaneAUS9jpEw==
X-Received: by 2002:a05:6214:f03:b0:441:27ee:ba71 with SMTP id gw3-20020a0562140f0300b0044127eeba71mr5590326qvb.88.1649212395966;
        Tue, 05 Apr 2022 19:33:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.106.254])
        by smtp.gmail.com with ESMTPSA id s5-20020a37a905000000b0067d35f2fdb1sm8892893qke.37.2022.04.05.19.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 19:33:15 -0700 (PDT)
Message-ID: <624cfbeb.1c69fb81.f46e4.bf65@mx.google.com>
Date:   Tue, 05 Apr 2022 19:33:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8846296058100996342=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dossche.niels@gmail.com
Subject: RE: [v2] Bluetooth: use hdev lock for accept_list and reject_list in conn req
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220405173751.7269-1-dossche.niels@gmail.com>
References: <20220405173751.7269-1-dossche.niels@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8846296058100996342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=629298

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      30.97 seconds
BuildKernel32                 PASS      27.76 seconds
Incremental Build with patchesPASS      38.25 seconds
TestRunner: Setup             PASS      466.52 seconds
TestRunner: l2cap-tester      PASS      15.59 seconds
TestRunner: bnep-tester       PASS      6.09 seconds
TestRunner: mgmt-tester       PASS      103.36 seconds
TestRunner: rfcomm-tester     PASS      7.67 seconds
TestRunner: sco-tester        PASS      7.56 seconds
TestRunner: smp-tester        PASS      7.52 seconds
TestRunner: userchan-tester   PASS      6.33 seconds



---
Regards,
Linux Bluetooth


--===============8846296058100996342==--
