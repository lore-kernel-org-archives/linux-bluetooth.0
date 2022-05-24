Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F484C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 21:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbiEXVGd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 17:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241858AbiEXVGN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 17:06:13 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853A23880
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 14:06:10 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x65so11739430qke.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IrtocWbEaih1XmkUR+T4ttx7c5nkUFxnuvGkS3kpgGo=;
        b=nHKCpTCX1O+bXc8idP0R2L1mNc5QYhxK+Bu+sJJBfqkpRcyeBQXno8BM5Zka8+b45I
         A1u8ZNqv8nfe8/7CJyVKFh53hOlxmFFuLtvcakcnDeQTH98FP5OXryYDxeUuA0pKoxV3
         ZjyFVnv5rm+z1NxupBxOBe+tPaiaDgVOh5RCP2w7hkV6tmNVjd7RSijcBTibIxbk20rt
         7GGATh7zXe0tfibMyUfOVy3RAYr5WZjyCc4sRYdbEtj8bNeW24+ZiazqfkCmi696A/rx
         1pPBLQcYcJdI55gVnzYLZfoTGxj7vpNa1yHyADzDa538LRklC/iuPwhxUranDJuIFDtm
         pidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IrtocWbEaih1XmkUR+T4ttx7c5nkUFxnuvGkS3kpgGo=;
        b=oo2kLRTt8Vu3eAqlPdas3d641tKfWYIs93PjCRHWRQasq5m881lhuPsnG4cQh099qU
         PWSpXyByGkRXDt9f8O596ub4dSLP1W9JDsiSlk4YDTEcCludzdlLMzFMxKcp+vCKwFG1
         EfGFRU4lQwyr57uHafDUzSj5LcB1nXpjg1RnWH8BlUSkN3Cxhncghqkp+B9D+wxUXUmG
         OnufoXAHAfAne/qv17eRqm+OCCB8A+aGKhk/z/F3D9XeyC/jHhWXes7SRVJ2AhstlNSc
         YhHhdscQRXd+CbKKuniElWaKag4Kbp6Pq+76dofR3N7Ir2GbtYOg65w+0ggb3BJ5cgrj
         pSsw==
X-Gm-Message-State: AOAM533QTM3gOj5z45mjBqZS09FdV34/UKfHuNA1A6bkkwke5RUDnCrv
        XstcaYB+Wksbbi7KPlS9HvKlLXrjjLk=
X-Google-Smtp-Source: ABdhPJzBi5sfo6P0JVEa0y8rjldaubx1DNgv0AePL3A72KZmtEZAjEI74FNYFTOw98S+w2XmqNa8AA==
X-Received: by 2002:a05:620a:4115:b0:6a3:8dda:2914 with SMTP id j21-20020a05620a411500b006a38dda2914mr7920034qko.536.1653426369197;
        Tue, 24 May 2022 14:06:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.120.85.42])
        by smtp.gmail.com with ESMTPSA id m21-20020ac85b15000000b002f39b99f685sm314423qtw.31.2022.05.24.14.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:06:09 -0700 (PDT)
Message-ID: <628d48c1.1c69fb81.e74f0.2336@mx.google.com>
Date:   Tue, 24 May 2022 14:06:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4191041619250944583=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [PATCH-stable] Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220524202630.3569412-1-luiz.dentz@gmail.com>
References: <20220524202630.3569412-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4191041619250944583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=644763

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      1.01 seconds
SubjectPrefix                 PASS      1.02 seconds
BuildKernel                   PASS      42.01 seconds
BuildKernel32                 PASS      28.58 seconds
Incremental Build with patchesPASS      39.46 seconds
TestRunner: Setup             PASS      471.79 seconds
TestRunner: l2cap-tester      PASS      17.46 seconds
TestRunner: bnep-tester       PASS      6.04 seconds
TestRunner: mgmt-tester       PASS      101.14 seconds
TestRunner: rfcomm-tester     PASS      9.66 seconds
TestRunner: sco-tester        PASS      9.32 seconds
TestRunner: smp-tester        PASS      11.81 seconds
TestRunner: userchan-tester   PASS      6.36 seconds



---
Regards,
Linux Bluetooth


--===============4191041619250944583==--
