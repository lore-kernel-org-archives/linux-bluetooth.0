Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6687DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Mar 2022 00:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiCLADp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Mar 2022 19:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCLADo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Mar 2022 19:03:44 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A30C65B3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 16:02:39 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id hu12so8225970qvb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 16:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=iJyqzlLewpSAxt/W4/Y/6BWOdnOR98o9XkJKHRw/qdU=;
        b=gtXDKvnLx0Te+wD9tisrY3njxzlYa5GDo17XgQpVMAYpnDkrmqaue4oLrcqMEe8AJQ
         Nf87IvXIfuP30xX3h/woZFyc61ZGQgyTn2NMBb8pvveQVtFxSIuZD05AsVun+/5PvxDW
         56WdcvllkZAVnRiol8Bg85ZlLLMKS6vwBLapDz8Q6eJQF9OxRUVLir00h5fWBO1JsxSK
         jeC60N6K0SgBeiIfMuqcu0Br1+v1o3usyKx0SaDNbGij+WaSaF+0NalsJo7k0rZY6x7t
         i/08VAiOmCdpw+XIPnhuiOvIMIb1ri8xUS+u6vw5Xekyhof96GoVgy1r6lNQQUO3ED96
         vSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=iJyqzlLewpSAxt/W4/Y/6BWOdnOR98o9XkJKHRw/qdU=;
        b=n7sYvqJyMOc+NTw8X4kiPRNzuxS7GElQPXUhN0tq96B44P+CKnxGuN5sdkL5UyBZTK
         qXdjF+4kFtvC1f6sJ07YOrZlFKME1h9tCNfjrmsOooZcl36zjs1bquVwKxHCG1sjm7xZ
         Hnzt1x2y5nQAe+4ahuST97ngUDE3Xe/2amZd14kmoJ87MJPZg00lWm6i+RQu/g7hpSgq
         4xU4bpfok74KG6YmusTkR0Lx6hVZcbFnaXXyFXwU9oznEnNVe4zbH5QDv1l4Olxz7p5h
         d01LNp9SPTRdn2q2CDDmVmMxTeilMAqYgmbFKm7scGphXEz061CIU0a3PPVT4AWBZv/y
         CjrA==
X-Gm-Message-State: AOAM5334Nv3HtrdCn5Athm/fPHE1JPHX5XpVCVkOyew0tpn1TeAzWGSV
        p/emyAa29icpSShC8Sm6HcnViUyhU1bx8w==
X-Google-Smtp-Source: ABdhPJyqQjpA7wGcG+w+j1jNUGK/cMOHOGDAYtrnHSpbNSTYXjxw6w9Q45P61DXM8wkVfCRPwQip1w==
X-Received: by 2002:a05:6214:1cc4:b0:435:b8a0:1fe9 with SMTP id g4-20020a0562141cc400b00435b8a01fe9mr10060937qvd.54.1647043358141;
        Fri, 11 Mar 2022 16:02:38 -0800 (PST)
Received: from [172.17.0.2] ([40.65.202.54])
        by smtp.gmail.com with ESMTPSA id d18-20020ac85d92000000b002d98bca0656sm6322048qtx.30.2022.03.11.16.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:02:37 -0800 (PST)
Message-ID: <622be31d.1c69fb81.d74f.5860@mx.google.com>
Date:   Fri, 11 Mar 2022 16:02:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7433304237442786273=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Fix use after free in hci_send_acl
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220311211933.3285806-1-luiz.dentz@gmail.com>
References: <20220311211933.3285806-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7433304237442786273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=622789

---Test result---

Test Summary:
CheckPatch                    PASS      1.74 seconds
GitLint                       PASS      1.04 seconds
SubjectPrefix                 PASS      0.92 seconds
BuildKernel                   PASS      35.64 seconds
BuildKernel32                 PASS      31.50 seconds
Incremental Build with patchesPASS      42.97 seconds
TestRunner: Setup             PASS      555.28 seconds
TestRunner: l2cap-tester      PASS      17.46 seconds
TestRunner: bnep-tester       PASS      7.06 seconds
TestRunner: mgmt-tester       PASS      113.24 seconds
TestRunner: rfcomm-tester     PASS      9.13 seconds
TestRunner: sco-tester        PASS      8.94 seconds
TestRunner: smp-tester        PASS      8.82 seconds
TestRunner: userchan-tester   PASS      7.40 seconds



---
Regards,
Linux Bluetooth


--===============7433304237442786273==--
