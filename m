Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE0EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 16:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiBXQIf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiBXQI2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 11:08:28 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF317B8A3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 08:07:46 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id g23so4352940qvb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 08:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=00fDgM6vk/fxecRlJ47+xgsuO7mgzuEJ9//gvfi7Jk8=;
        b=m1l6GByRRCcfnPbbL0qSsBaeNS9uzRp4aJzfvQ1Co8uA2lbM4IeUG0nKCO28Fjhjji
         t2zQSnAKqt1KVjYqQAMQZ7ZWmfGJ9Hqjce/fF3asBlVPEuehCaqxCvxJKHZAJ4tJXHuk
         VWq2NyQ4evLX0UiKuhjzOVFxwB2tU7RA2DK09RudLQZmVRRvOpyJDym+7kYEdyz62vq8
         ZZgWyhFgbc9NCl5LxUmTcwsalM7RbyQ/eo8Evk/cLHLy9ZTsj8lQ7ht3LTqg3pBs+Mhv
         1/hzMD1y/IwFqU612YR0hLZ3wu53ygrKoukj7kuomJ9jPphgYsB91iXYtVNQWoYLOA7b
         EPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=00fDgM6vk/fxecRlJ47+xgsuO7mgzuEJ9//gvfi7Jk8=;
        b=5/0u7Q6KQc9/tm4/r58yNoZt+NpzfCJ7K/bmgwAv6c9TcWfH9d/YJPB8ncDbRgGEzV
         HETXXOw2PGmMgvxryKR1/Op2s/9uBmOxiSWQxV7irFw2AxiZhsOM5E1zWmdfAUBqMf9G
         cn5mLWlchGR3fVGKEZ0kgfHLNUIpS/YsmJfaOal/TCRo46CHu9SXeeraxYlON18wUgHE
         bpyVXL5P7hDJ+trmQtdlqLZ6yzSovAlUWfaPbZGYpGi1mZrZ+OZwMsDpouZdrhPzajDI
         avRqVMAxhXuwS9xizqMU3MS0CTUfgbwG3XjlW+Ig41NSuWecYRLAJbYlQHK2qxmDm0Fd
         Rnxw==
X-Gm-Message-State: AOAM531wXifZq+X3dnvoRQogfwSjLPqUe84d1t038vnmr0FtqJUI6hBF
        dkI1niAn5/6O/F4Dq3eWNY8p0vkHHOJnLw==
X-Google-Smtp-Source: ABdhPJy5bYmDe/xWA9z4i+ToAuAOkvgY1cWhZUbtfC/TEGKAfXR7t+aNwydZzuMGk+F0j4L4bq4v8Q==
X-Received: by 2002:a05:622a:18a6:b0:2dd:2c5b:ca00 with SMTP id v38-20020a05622a18a600b002dd2c5bca00mr2870107qtc.549.1645718661199;
        Thu, 24 Feb 2022 08:04:21 -0800 (PST)
Received: from [172.17.0.2] ([20.185.24.225])
        by smtp.gmail.com with ESMTPSA id h18sm1042284qtk.90.2022.02.24.08.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:04:21 -0800 (PST)
Message-ID: <6217ac85.1c69fb81.69871.6183@mx.google.com>
Date:   Thu, 24 Feb 2022 08:04:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5071219737125073967=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix hci_update_accept_list_sync
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220224151147.119619-1-luiz.dentz@gmail.com>
References: <20220224151147.119619-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5071219737125073967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=617616

---Test result---

Test Summary:
CheckPatch                    PASS      1.63 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.89 seconds
BuildKernel                   PASS      33.05 seconds
BuildKernel32                 PASS      29.40 seconds
Incremental Build with patchesPASS      39.56 seconds
TestRunner: Setup             PASS      514.51 seconds
TestRunner: l2cap-tester      PASS      14.40 seconds
TestRunner: bnep-tester       PASS      6.53 seconds
TestRunner: mgmt-tester       PASS      116.47 seconds
TestRunner: rfcomm-tester     PASS      9.05 seconds
TestRunner: sco-tester        PASS      8.87 seconds
TestRunner: smp-tester        PASS      8.63 seconds
TestRunner: userchan-tester   PASS      7.40 seconds



---
Regards,
Linux Bluetooth


--===============5071219737125073967==--
