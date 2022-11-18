Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33105C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 07:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbiKRH3t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRH3s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 02:29:48 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9445713F82
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:29:47 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13bd2aea61bso5100862fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RdUNO1N/iL56h39PyiEZsNJfy8iKu8XMBRmKolTY4ls=;
        b=aKJ4oOBcEx7MucZnUVLNzDJQBKNlB1zBC1muJ1dU6xoXTbQfqUJDeiT6z3xyFwQA4t
         8lIhFSgjwYdEo2y+1BwIxEax4rMiC8trMX3FSfGTzaRUYSrFF6SAozVq0DD8Ox1Ruy56
         8lPRZ3CGEPcmuTS4OGp2WckVFFfKh64QBkzadxRIZ+cDlWjq23pQYNro+3d7KmHeQqCL
         NuGfC0ubdivJlLiV/fxZZvdIyOpwmq0aO+1rMfuoZNSbgmxhKHSq/4x6rB6yHDgOvkOJ
         +UgxeDRdObN6w306bPR68OTAIx5RGl8nG/hhIGG1gvAhT+E+SnxmCbdo+F2fm/h/+QTT
         TWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdUNO1N/iL56h39PyiEZsNJfy8iKu8XMBRmKolTY4ls=;
        b=jehcyA6YFXXnQ2FZuYpDCavZhqK1cMoqLEW+5eMo/0Io4AKrDKdHAemEV8U7lZ+mj1
         c5LIjdpttBS8/B08SnlF4jsm3+TV+zopUN3wWsSiXy85vuJ4/fTvAl5NL1dWEKZXMEC2
         gN5huxnc4b2Vc0jX8ELQCDqpK+6PaKJowwgX+otXkZOwZ6QurbX2812LNrNdKer8mXiw
         nfy5Y9VnxWbtWjrl47rqp4GJfuxpIvzuQda5vLNUNLRrAS2LyZPL35OOz6ZnVdFe+QfL
         I1FMpCpLpwtMRTLeFiFFRqhW/WVPzZf+UfE57D6JfW8s1w7iUHVeX6PQnqo9i8Hm0Eq4
         +tZQ==
X-Gm-Message-State: ANoB5pmY9WmmKesEO4sI3uWMbE17rev9BFHK0vSKxzg6yPc7mmBgLFzJ
        JH2tJKWPdsL/I8xTqUeEpr/RgPcZzcY=
X-Google-Smtp-Source: AA0mqf61KMf04KDYOWzuqqBjDm0WjD/GmZ+UL+EogCDg5W+n0NRtZyejFX3TOdxXQH87oeKNtB9Fsw==
X-Received: by 2002:a05:6870:bc0f:b0:13b:f58a:1b82 with SMTP id oa15-20020a056870bc0f00b0013bf58a1b82mr6321576oab.48.1668756586701;
        Thu, 17 Nov 2022 23:29:46 -0800 (PST)
Received: from [172.17.0.2] ([13.65.202.119])
        by smtp.gmail.com with ESMTPSA id h22-20020a056870d35600b001417f672787sm1564853oag.36.2022.11.17.23.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:29:46 -0800 (PST)
Message-ID: <6377346a.050a0220.89b9d.716b@mx.google.com>
Date:   Thu, 17 Nov 2022 23:29:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3195243653237585432=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: Fix enable failure for a CSR BT dongle
In-Reply-To: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3195243653237585432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=689388

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      33.07 seconds
BuildKernel32                 PASS      30.09 seconds
TestRunnerSetup               PASS      416.44 seconds
TestRunner_l2cap-tester       PASS      16.06 seconds
TestRunner_iso-tester         PASS      15.46 seconds
TestRunner_bnep-tester        PASS      5.48 seconds
TestRunner_mgmt-tester        PASS      104.89 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      8.79 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        PASS      6.91 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      5.74 seconds
IncrementalBuild              PASS      30.76 seconds



---
Regards,
Linux Bluetooth


--===============3195243653237585432==--
