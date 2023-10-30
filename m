Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6ADC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 16:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjJ3Qjw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 12:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjJ3Qjv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 12:39:51 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2ECDD
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 09:39:48 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-779fb118fe4so317005885a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698683987; x=1699288787; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq6USjYg3qMiTGUMZg1rO8Iwb+iQe0svvR2WfRWAwCM=;
        b=J9SPblFPPZlwxWuzkceOqQeDb1X57JxhhwlQWVd+zakog6W0/qnZN3TQIG8DWfPjcX
         gFNsTJEzyUhwPimOGXlky2t3Z1waPkqTCJ9aj3JXW+ky7qI/HLq84zStalRHN8xwmL19
         etRkiqsW9udM1j3xA5SU8M8t9aXuxp+KXtjsze7P8zegnOiVRhnG+hxSzVugJMCpQVDV
         Gcv/cJa3y24D9Mpkr2mxsKfClwm3nsafOX3q/r56bFbJGqigYhVWmisetyB29F0O2d/B
         fGUQhBArneJxviXlunY6an5Z6dOfDDTJpnfeSM10Oh2zxgl9PUC+CqpmO+ieyvGS9pX7
         MoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698683987; x=1699288787;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sq6USjYg3qMiTGUMZg1rO8Iwb+iQe0svvR2WfRWAwCM=;
        b=BCS2v2guaFLTUxIVRXno7J4s8VUY9Xw/cmasUjuRBI/62YY+sgpGhvun571u8iYYxB
         cY7QSYsfxHBXKxWI5IxaqkoC1ekgjwtONdgN72Ne/0fvD/vWxsI4yhJbK+9frbDPlWMJ
         TcxRzomTxkRkrPexpW0L4/QiVODJZIzWqmxL5U0L6qWzMlmUhEc9NhL3Z0cMh3FwZxwj
         M+vLQSOfyoToOSqhIa4LfJe20xWvMhuIVlIHPPY4Lvs/oHzX5SmUJJI/pbcQqnG6bYyE
         DRkALw95jvcFjmiVRe8nci51fmP5EhJJwM2UA1Ul1NoJuOGXlvCsQOeB1p7+dTRR8wiK
         Vf4w==
X-Gm-Message-State: AOJu0Yzgcth4aKcU2oTODcBQhjnt1JFqT3I3dxrAYxic3+hzErCz9cct
        Q0j121YagCc/zL9KU50eFhGiZwqhB3Q=
X-Google-Smtp-Source: AGHT+IF9pcr5tQWoPrqDPaj230QUSIdtzNoCNZ153qto1rBaNlqvkzV1yoRep5ozQUHE9SRNi4bxEg==
X-Received: by 2002:a05:6214:2482:b0:66d:a12f:7140 with SMTP id gi2-20020a056214248200b0066da12f7140mr13696279qvb.18.1698683987654;
        Mon, 30 Oct 2023 09:39:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.41.24.123])
        by smtp.gmail.com with ESMTPSA id z11-20020a0ce98b000000b0065afedf3aabsm3569759qvn.48.2023.10.30.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 09:39:47 -0700 (PDT)
Message-ID: <653fdc53.0c0a0220.2bb35d.d084@mx.google.com>
Date:   Mon, 30 Oct 2023 09:39:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0106587621436694177=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Reassociate a socket with an active BIS
In-Reply-To: <20231030154318.4339-2-iulia.tanasescu@nxp.com>
References: <20231030154318.4339-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0106587621436694177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=797654

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      33.39 seconds
CheckAllWarning               PASS      36.48 seconds
CheckSparse                   PASS      42.11 seconds
CheckSmatch                   PASS      116.34 seconds
BuildKernel32                 PASS      32.24 seconds
TestRunnerSetup               PASS      509.79 seconds
TestRunner_l2cap-tester       PASS      29.52 seconds
TestRunner_iso-tester         PASS      51.81 seconds
TestRunner_bnep-tester        PASS      9.79 seconds
TestRunner_mgmt-tester        PASS      207.12 seconds
TestRunner_rfcomm-tester      PASS      15.10 seconds
TestRunner_sco-tester         PASS      18.39 seconds
TestRunner_ioctl-tester       PASS      17.42 seconds
TestRunner_mesh-tester        PASS      12.93 seconds
TestRunner_smp-tester         PASS      13.30 seconds
TestRunner_userchan-tester    PASS      10.37 seconds
IncrementalBuild              PASS      30.68 seconds



---
Regards,
Linux Bluetooth


--===============0106587621436694177==--
