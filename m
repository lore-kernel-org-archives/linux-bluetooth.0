Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A874C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 May 2023 20:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjEIUko (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 May 2023 16:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEIUkn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 May 2023 16:40:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE48116
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 May 2023 13:40:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64115eef620so45399061b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 May 2023 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683664841; x=1686256841;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QxtjgRmz/vJRqRz7Djsq88vCpB7kOFLqyrm7byraDKc=;
        b=jblQm/m4XisROBoeb3KDopB244x4tXuMJN5Zs0pME9YxShzwTKNKw6pOKRebQ3AUK8
         KDqhJyQ3+PbaPjyB5Xeq+UZsxfnOcuZJu20C5h17IF3yVRfLaF6V/rUnz+I80K2e5s+Y
         gnjxBlYbEfX+/CC2QcX88goObUvozocOm2K28zjnZVIUVHpzvFcgkoeG2qp2hDuMdBTt
         la+6a01DnLryh9SlyJPS+IRQ2b2TPR0LvGGC9kuKDd0a9Jb3tAJBVc2QZCzWUmnOWVR7
         cDQg3ogHipLZrmmvypL6Zn7BMtAxDofGy7P7mumvw5OUgqTeIc5NCeWcBDRotVcwG51E
         pkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683664841; x=1686256841;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxtjgRmz/vJRqRz7Djsq88vCpB7kOFLqyrm7byraDKc=;
        b=VyCboneTVpW+nJcpYjVPVSB6IBEdkO+87cx11hJdRB8HgnnFIoPOhwXArcdnwV0OuX
         UrCoa4P/sA1ub5CbXIMaRMqvKGbiKp4PNe9sQAkn0bfVPHT9cWhWXkgwY+GLsprRmFdW
         F/YJohRGPVcn4aWsFzwr6btT1wu5l+CmU7ptmEs4eyK7bUUpggrfDg20D4XTu25sbsum
         +LYFv6iEMzo/4HUrGrRgTlMwBUUWXg2eQWTfCjwrxr7zdpJSrjdv+ER2py/if/uGlVzd
         0Fw3lMY37voIO2vPDBFnhIuZSUQqesuOvS8muuBv67KbPkDFwoAZXyhq7wkw8vmNJJNy
         UNUA==
X-Gm-Message-State: AC+VfDymFbazB1n8YLd4vppqlUDwirfNQD6abJKH25Sk3YsRQxjVO/p1
        cgs/u+7GbqdoVzqFBo7fA74fKwLAibg=
X-Google-Smtp-Source: ACHHUZ7lFN3N5atw27uigwyFbNdg4dm6hc1VQ8W+Ogd75nODfNKJ0j7VJSyzuxZCmmskVRFPXXjRTA==
X-Received: by 2002:a17:902:d505:b0:1a6:f93a:a136 with SMTP id b5-20020a170902d50500b001a6f93aa136mr24584336plg.22.1683664841507;
        Tue, 09 May 2023 13:40:41 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.175.192])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a195300b0023a84911df2sm20791800pjh.7.2023.05.09.13.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:40:40 -0700 (PDT)
Message-ID: <645aafc8.170a0220.65f64.9cbd@mx.google.com>
Date:   Tue, 09 May 2023 13:40:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3581478726646323662=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.gora@gmail.com
Subject: RE: [v2,1/1] Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations
In-Reply-To: <20230509195119.9655-1-dan.gora@gmail.com>
References: <20230509195119.9655-1-dan.gora@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3581478726646323662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=746241

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      43.54 seconds
CheckAllWarning               PASS      46.87 seconds
CheckSparse                   PASS      52.62 seconds
CheckSmatch                   PASS      143.60 seconds
BuildKernel32                 PASS      42.71 seconds
TestRunnerSetup               PASS      601.12 seconds
TestRunner_l2cap-tester       PASS      20.97 seconds
TestRunner_iso-tester         PASS      27.73 seconds
TestRunner_bnep-tester        PASS      7.42 seconds
TestRunner_mgmt-tester        PASS      144.04 seconds
TestRunner_rfcomm-tester      PASS      11.26 seconds
TestRunner_sco-tester         PASS      10.85 seconds
TestRunner_ioctl-tester       PASS      12.87 seconds
TestRunner_mesh-tester        PASS      9.64 seconds
TestRunner_smp-tester         PASS      10.78 seconds
TestRunner_userchan-tester    PASS      7.91 seconds
IncrementalBuild              PASS      39.85 seconds



---
Regards,
Linux Bluetooth


--===============3581478726646323662==--
