Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD232C761A6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 14:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjDDO6t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbjDDO6f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Apr 2023 10:58:35 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19863C3E
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 07:57:35 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id ny16so427608qvb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Apr 2023 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680620254;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mog4NVMfO99JvdWH/7viPU5MJO3ftJCcpUY4bf+iBg8=;
        b=kFgSuHVAuEnVAfFAJioiggw0iz9GLT/U54l1PC/ceucPDZ9o7T42my2W3i9dmGYFgK
         3vnmEHGPSIkAYgW+AWKI1u6SQEf5Y4RXt+vyGpm7lkZShxN/5WVv94HI9LcGRPgQzqmj
         hNObID4uWUyB7bFs6eTqmq8wTIil4eBYbV4i/lOMcKEs0POtCt5bqj9Hzm8QPcQxr6hY
         3XC9pZlJQSP8cxPiqgJyoBzcWPmWAIq0TjAo9+FPJCFIYryVMkT2zYBKTMIEq0F8muBA
         6DLRh53FTjpuUrHY+UqNDbrD8yzy+4zxrOF0IULVyJezC+ELdo9EtuMEpK4Q+xrDDcdq
         tH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620254;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mog4NVMfO99JvdWH/7viPU5MJO3ftJCcpUY4bf+iBg8=;
        b=UakxnSit0p5wk6K7oUVbw3KVzEuookPcCkeA3hjnL+qAMFLvR2vhpX6e6qByzZhwpm
         rkKJ7u7Y94TJ6/ekhqTEf/HetyPjCl+ykAu8XVg8La8DLp0GvqrcwKRwQyaC7bKESJAf
         QWTH+Ut8+pwaW4hM+ucqNFGyCNlnxVPZDL7VOJ0hhS+WMVZLOkaRAPPccLALBvBJ2mNM
         eDSUy1Qrii5JvUXAHQYrSFfHZBR2qf6LAi5NlkGjstmv76Ub2oujClZumkm9ploapZTT
         hC6qzJ3kDd1Erl6vu37X+KEhp3AIeS98Sm7QjAl9o5qboIouz6+yL4mfrD+vEKfyeBts
         1x4w==
X-Gm-Message-State: AAQBX9eviTaJnqKWnbt/gzG6tkmdyhfiDje9yWuHjq8OaOov0QR2gHcC
        7da1xzi4hq3cPPRaPzuVJt45fNTfKkQ=
X-Google-Smtp-Source: AKy350ZjQqthU3hG4LMzivoDAiI0TNq67iGoscqZc2ztU6s0P8clV/or2M1WF5X0PjptyO/NpDw0OQ==
X-Received: by 2002:a05:6214:c8f:b0:5e0:3825:9ad9 with SMTP id r15-20020a0562140c8f00b005e038259ad9mr4203357qvr.2.1680620254596;
        Tue, 04 Apr 2023 07:57:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.213.84])
        by smtp.gmail.com with ESMTPSA id cu12-20020a05621417cc00b005dd8b9345f5sm3424938qvb.141.2023.04.04.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:57:34 -0700 (PDT)
Message-ID: <642c3ade.050a0220.8b837.f517@mx.google.com>
Date:   Tue, 04 Apr 2023 07:57:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3313364341109841136=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Set ISO Data Path on broadcast sink
In-Reply-To: <20230404141853.4868-2-claudia.rosu@nxp.com>
References: <20230404141853.4868-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3313364341109841136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736842

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.03 seconds
CheckAllWarning               PASS      34.62 seconds
CheckSparse                   WARNING   38.95 seconds
CheckSmatch                   WARNING   110.42 seconds
BuildKernel32                 PASS      30.43 seconds
TestRunnerSetup               PASS      434.75 seconds
TestRunner_l2cap-tester       PASS      15.84 seconds
TestRunner_iso-tester         PASS      15.65 seconds
TestRunner_bnep-tester        PASS      5.13 seconds
TestRunner_mgmt-tester        PASS      107.96 seconds
TestRunner_rfcomm-tester      PASS      8.35 seconds
TestRunner_sco-tester         PASS      7.45 seconds
TestRunner_ioctl-tester       PASS      8.58 seconds
TestRunner_mesh-tester        PASS      6.39 seconds
TestRunner_smp-tester         PASS      7.38 seconds
TestRunner_userchan-tester    PASS      5.31 seconds
IncrementalBuild              PASS      28.63 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============3313364341109841136==--
