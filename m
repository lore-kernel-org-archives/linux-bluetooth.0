Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7C3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 03:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiKSD7i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiKSD7R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 22:59:17 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD80C72EB
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:56:17 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id s18so3062169qvo.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bbN7wZOl1FtxaQeH0Hn7DV22nOgSmE0eSW2lUTbSYdg=;
        b=MTtU8MyFCCaFnN6LnRpSF8T/wIJUfzn9eXSuZV2cDdMqAKySGCoiDZpbxlv+Wx3po9
         kwx1OrWt8VSb/ldnzcNim135VkPcgtvjqqctscFYdHe03Qj2cW7mQ1Tw+Ctm9e8e9dbr
         ryte6l1SWnCHCx4+flCp7Nbu1732f29WoTs7WFI4O1vY9Zsx+mksuIJcfvr3aZWgkzOu
         sb20r6lill+vmRqUMA8yPeMHwAkfpOrV5xR/tvObX7AwU84IRe9zyGY8id5glX235v4w
         ubHTimaA0d/sQvE+n0FN9TuWjqMnBupHhhCwYn0DM6xNCfK9SOtxJWxmbV78cGkfmSXj
         QiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbN7wZOl1FtxaQeH0Hn7DV22nOgSmE0eSW2lUTbSYdg=;
        b=v6XZdTVIr5P5NKfQ0x+8A9GG8z8sHfdv78CvpHEW0HuQGrvS6ml6l7Rj//mZvUrlMP
         HA+40k7bTvCUgKu4Epvs5YZY5k49S8ukjBZdIx2+H1y3WyDCnlmmShB0VQVrlAX7cUW8
         CGm4fR7d/i61PoTO4kUqxRv+7peyVq4i4L7HH4k9Q4pKoj2ODhONL9YND6kRcnOVcr9C
         Q2Fm4ZVCcsyYVuGWPZ7Fsk1ofY2esiThPAAMthtETBO6cI+4bWJp5qtnIddIz4LEpP6w
         9UK710Kk0qDZK5G+cNIxWXk54BPozs8li+5oLsCc9z9NSBfsLOZ+q/8ZKi2PbkPz/jcx
         s+MA==
X-Gm-Message-State: ANoB5pkwez/q1WzrkyCkjFKI5bTdu4YRscua6h9m9LhdV+WMQHZUaxHk
        BJL+FV4YWa1Mi3e4HSbWVTuzq51Fl1ZJrg==
X-Google-Smtp-Source: AA0mqf6qfUeNu35kv+V9nqy54x4Qf7tz7blfTVbEpaS5+PYNmdbliiCY+wVbWUyhdtg/f2QY6PueXQ==
X-Received: by 2002:a05:6214:131:b0:4bb:653f:2a6b with SMTP id w17-20020a056214013100b004bb653f2a6bmr9568743qvs.124.1668830176495;
        Fri, 18 Nov 2022 19:56:16 -0800 (PST)
Received: from [172.17.0.2] ([172.176.197.81])
        by smtp.gmail.com with ESMTPSA id fy11-20020a05622a5a0b00b003a4f435e381sm3189510qtb.18.2022.11.18.19.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:56:16 -0800 (PST)
Message-ID: <637853e0.050a0220.a4bb3.ea57@mx.google.com>
Date:   Fri, 18 Nov 2022 19:56:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5904395173648718943=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] bluetooth: Remove codec id field in vendor codec definition
In-Reply-To: <20221104071810.22720-1-kiran.k@intel.com>
References: <20221104071810.22720-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5904395173648718943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691972

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 FAIL      0.43 seconds
BuildKernel                   PASS      33.80 seconds
BuildKernel32                 PASS      30.08 seconds
TestRunnerSetup               PASS      417.72 seconds
TestRunner_l2cap-tester       PASS      16.06 seconds
TestRunner_iso-tester         PASS      15.93 seconds
TestRunner_bnep-tester        PASS      5.50 seconds
TestRunner_mgmt-tester        PASS      106.46 seconds
TestRunner_rfcomm-tester      PASS      9.48 seconds
TestRunner_sco-tester         PASS      8.78 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        PASS      6.98 seconds
TestRunner_smp-tester         PASS      8.82 seconds
TestRunner_userchan-tester    PASS      5.81 seconds
IncrementalBuild              PASS      37.51 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============5904395173648718943==--
