Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8EACDB465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 16:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjJPQtN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjJPQsn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 12:48:43 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22600390D4
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 09:40:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7757523362fso324561385a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697474409; x=1698079209; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z5NaASCP0iGUkgW0k3GImNRiywnGVzRLqVXbrf8t5cY=;
        b=iGzznv0QIWEkEodzmgmzl9ECp12J1wyF8VErP0b2L+GloNPnAlCvfT66nhdKR9VQbW
         Mc5SLj7cIwZQp8qvipWjVBuJiLiB5P/mfbJJ+4bhZDxQ1zXUvR7FipytN5CZQnCb+vX6
         AtgEfPpWybDQOCi7ibIn9ScRrLJ2gKaVoFdSazdkNgPPJjcqcaG+22kaN+3zrMDz2ZqX
         FYn4BH5UAyfO2WrPbh6CDwjiYbBayF9+A94+Qqfq/gS2Vd2KUVy9rfVOzR0oD9qGKcC8
         Oztvngcu7Lz+y5hhAjYwkyYsiqPqhKfZ3pVOrqluQQEhCe9TikY0A0mUo60zZUYguEQR
         ToBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697474409; x=1698079209;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5NaASCP0iGUkgW0k3GImNRiywnGVzRLqVXbrf8t5cY=;
        b=AcMO8++qqOd9JcqvgxIaUDyvllmd5ad/pG61NZdPGexZ7TKTMXrXMfrWs2olLtxw6H
         iv2l0N6JomyS3BRZn0L/ALOni/7ipfAkZua98eCUsTGN3UDXOTnwCNkr/MNBU3cO+X78
         YHCcJ+4Ueo6oIQhHLmlkcqGH+kXWW4RuJ+2GocrDLEi8OFRj5xSVXhZ51S0WPQEnIa5X
         sMr4hD7ugCWBLqDBUeb7E+9aQ7neJro+QcKwH0R3/k3/YdjK7FY3w060N/uox/jqDwtr
         kFjqxZR0yXZIboB0fqj+Tbf31/byUgt8uQokrLaO7NBKgiK4R8TyF5MjcieeqgWVk1s2
         X54Q==
X-Gm-Message-State: AOJu0YyT8Ujp6aMo/1ucheemwE2rF9jk6WctLXD+otG+0x7VbVV7eM2O
        7P31SZdtlWIVkzwbzvynDmdnB5xgsdg=
X-Google-Smtp-Source: AGHT+IEZA9Q9+QtofIceby1ohnaHhISzDzw8ffCFmjss95U5tKOBTtRDmps745TF+2qTYd/4lHXCPg==
X-Received: by 2002:a05:620a:4554:b0:767:f49c:1d67 with SMTP id u20-20020a05620a455400b00767f49c1d67mr46390364qkp.1.1697474409530;
        Mon, 16 Oct 2023 09:40:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.44.152])
        by smtp.gmail.com with ESMTPSA id b16-20020a05620a127000b00767dc4c539bsm3112699qkl.44.2023.10.16.09.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:40:09 -0700 (PDT)
Message-ID: <652d6769.050a0220.6a568.d483@mx.google.com>
Date:   Mon, 16 Oct 2023 09:40:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7438089595934283802=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Allow binding a PA sync socket
In-Reply-To: <20231016154545.2883-2-iulia.tanasescu@nxp.com>
References: <20231016154545.2883-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7438089595934283802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=793605

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.15 seconds
CheckAllWarning               PASS      37.29 seconds
CheckSparse                   PASS      43.06 seconds
CheckSmatch                   PASS      118.74 seconds
BuildKernel32                 PASS      32.85 seconds
TestRunnerSetup               PASS      514.29 seconds
TestRunner_l2cap-tester       PASS      29.83 seconds
TestRunner_iso-tester         PASS      52.79 seconds
TestRunner_bnep-tester        PASS      9.81 seconds
TestRunner_mgmt-tester        PASS      212.32 seconds
TestRunner_rfcomm-tester      PASS      15.15 seconds
TestRunner_sco-tester         PASS      18.70 seconds
TestRunner_ioctl-tester       PASS      16.92 seconds
TestRunner_mesh-tester        PASS      12.56 seconds
TestRunner_smp-tester         PASS      13.44 seconds
TestRunner_userchan-tester    PASS      10.31 seconds
IncrementalBuild              PASS      30.85 seconds



---
Regards,
Linux Bluetooth


--===============7438089595934283802==--
