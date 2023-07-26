Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98280C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 15:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjGZPAN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 11:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGZPAM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 11:00:12 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F4294
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 08:00:11 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a43cbb4343so3741205b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690383610; x=1690988410;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yMKwFA35Yp49Z60ioXoiuqL13x1fUudqTYv3DIejnOc=;
        b=F1Rq190l3FgGnzSUfNNYd9Qaomi+ojSSv+1D9QJfYF/yUA+QCFY2u0SEBI+cL7iX2H
         onCwCYyOpmZzOfFCYA53b8ul4YkvdTGGksWa4C8kiQMk7hS2u2mbqHYNi7eZuVWaQD5u
         WQG57nv3MsD/5KwbFc5RppV0EQzm5GZfHu9svzcaU+x+qUlHnCs2IJww34d4DhkHWcPZ
         B5h518AxPTZFYYnqhU5/4eSV7j4ocYswZ6NBSs7f4gGP8/cXqDGY7zTMQGR3nx7e6fIt
         lVCEVwGb7PFo+jYN8V/hFqRtPJ+tQgF/85wXniFmgurAY5+wHnCcSoiMvBItRi4dALG4
         Y6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383610; x=1690988410;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMKwFA35Yp49Z60ioXoiuqL13x1fUudqTYv3DIejnOc=;
        b=OzFUt+0lHJGBnpb1cPmybRvmWt57PzRaL62Vzqi160sO3n80tSpLrP/tU+mS/1HXss
         T7TM8N3PM2OUTM38eUwuzmC/iN3viCys1Sk6xknvut1bH05gx2K+QeAahFbc63ksiLrS
         AcBjgyQcEQc02Flpmdr8qo+LrdlHOZ+BIYX+5+kGOlIOsfM9cWE9KdB8Wjc03TFOp9G/
         1x+BEMc7LA772UKri+Unfn0VIFIv9RvssotiQA6/9hfOmZx3NtlxdAoJ7x4toWIJ2FIG
         L8/MO58qjUf3Gh/WLNdbvHnzraS9gQiPGkOfJxdH3DipYo1KxNbHjVltHamOk01HK10V
         Bd3w==
X-Gm-Message-State: ABy/qLbXG8ZDvDR3BeFoNl0SZYPMzN9v/K4uXcdGqIsZGvTlRXw1PzMo
        A2fjlkr7m4n5hcZ28RS+ABxdtBE51y7FxQ==
X-Google-Smtp-Source: APBJJlEGPIsT0kiEpt0Ze+pPyj7i31WR4OjhuF6EXjvGrfW18C8N8ERhFwu+ErKRBHhb8Oy5HI5Nmw==
X-Received: by 2002:a05:6808:2102:b0:3a3:7ddd:1abc with SMTP id r2-20020a056808210200b003a37ddd1abcmr2630111oiw.36.1690383610523;
        Wed, 26 Jul 2023 08:00:10 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.245.50])
        by smtp.gmail.com with ESMTPSA id c5-20020ac86605000000b003f9b9d7f319sm4834306qtp.70.2023.07.26.08.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:00:10 -0700 (PDT)
Message-ID: <64c134fa.c80a0220.9968d.5c6a@mx.google.com>
Date:   Wed, 26 Jul 2023 08:00:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2984463540863198970=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yuehaibing@huawei.com
Subject: RE: [net-next] Bluetooth: Remove unused declaration amp_read_loc_info()
In-Reply-To: <20230726142817.20504-1-yuehaibing@huawei.com>
References: <20230726142817.20504-1-yuehaibing@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2984463540863198970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=769739

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.41 seconds
CheckAllWarning               PASS      35.17 seconds
CheckSparse                   PASS      40.40 seconds
CheckSmatch                   PASS      109.71 seconds
BuildKernel32                 PASS      31.02 seconds
TestRunnerSetup               PASS      473.12 seconds
TestRunner_l2cap-tester       PASS      22.45 seconds
TestRunner_iso-tester         PASS      40.68 seconds
TestRunner_bnep-tester        PASS      10.23 seconds
TestRunner_mgmt-tester        PASS      213.42 seconds
TestRunner_rfcomm-tester      PASS      15.48 seconds
TestRunner_sco-tester         PASS      16.44 seconds
TestRunner_ioctl-tester       PASS      17.36 seconds
TestRunner_mesh-tester        PASS      12.89 seconds
TestRunner_smp-tester         PASS      13.92 seconds
TestRunner_userchan-tester    PASS      10.79 seconds
IncrementalBuild              PASS      29.27 seconds



---
Regards,
Linux Bluetooth


--===============2984463540863198970==--
