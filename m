Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B569CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 23:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiBNXCI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 18:02:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBNXCH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 18:02:07 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574321954C3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 15:01:58 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e16so16922660qtq.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 15:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ivKMTQCN6Ia2RQGirVHNuwwUYqgOzCXTsb3JIXC9vGE=;
        b=M8ZyOM9zoYn6FEMuk9ffFnHj4pwDk0h7Bh7PljCqZ/6s4TG0BFDwLeOav3Ksmd0lN6
         YAm1E+/j4NMOc9doHqtOjQrcs8yEHHHen4qXqSjkZBIGF+xipiJBEFzRoFPieVckxsHD
         beJPEIsDSNSG2LtX3ZW4m3EO8a4qDOXlLB7uzxOcyzFy9ZJ+ttGH1VBQRitAPR4irAQ4
         s5gDaHNk02t9BLZam0oVBSw7dpBtOz5mc7jTR+XzTcDYO3JKpkzepKvJB+i1aIa6cYf1
         9U69a+6kFCN9cMi8RZ3sVHD37Gju/mYixGiygNXn9bRC03S0/RmhdZUJuTjioUUubqYu
         E9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ivKMTQCN6Ia2RQGirVHNuwwUYqgOzCXTsb3JIXC9vGE=;
        b=Zc3UkY786Dh6ockvznVhh+YwanN043cj0SiwtKkt+C7Rm/e1mcCjeel3TcCouuuja7
         jM9Xx55tKnQbddX87fKEZkkTIkxWp3UADh2VdLoX/CSq/RtxiCJP31G0fI307f7HoUGo
         yZE9Ra+u+RF5o8/bxOC7f6IA/t+LuiXjILOV2O894LZ1jP2fG1MnELE9Yi8/QxsWC8aM
         HW5u3r/pIMeveOcNzFI0CPX74ekZiuMCKLUBNnTZOqCemhKEsAXKcKmY2oA3wU4PrHRe
         sdl3QFwXAi6u37MmURQr7rNFrNChwYYmBp6sthSnM9rUL4c0eSgN10NgbjGbG6WhnVHf
         Lgag==
X-Gm-Message-State: AOAM533tY+8jgh+bJ3kRdb08SqJclYJUabKoP1HQG4J3eu5kMXzR+L92
        b1+Nwua6QFV4jv/wpHzPqHncJQzIrx/5nA==
X-Google-Smtp-Source: ABdhPJwGbNisranDNs1IicoTlZaonf6PdErSM+5kwB6sYZDYYslbqfbEL+okagNkt61IWun8KXEDbQ==
X-Received: by 2002:a05:622a:14ce:: with SMTP id u14mr920795qtx.370.1644879717357;
        Mon, 14 Feb 2022 15:01:57 -0800 (PST)
Received: from [172.17.0.2] ([20.98.202.21])
        by smtp.gmail.com with ESMTPSA id k6sm17297816qko.68.2022.02.14.15.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 15:01:57 -0800 (PST)
Message-ID: <620adf65.1c69fb81.1478a.cfc2@mx.google.com>
Date:   Mon, 14 Feb 2022 15:01:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4194323442469663584=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, colin.i.king@gmail.com
Subject: RE: Bluetooth: make array bt_uuid_any static const
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220214215130.66993-1-colin.i.king@gmail.com>
References: <20220214215130.66993-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4194323442469663584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614273

---Test result---

Test Summary:
CheckPatch                    PASS      1.72 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      35.83 seconds
BuildKernel32                 PASS      31.55 seconds
Incremental Build with patchesPASS      43.09 seconds
TestRunner: Setup             PASS      551.11 seconds
TestRunner: l2cap-tester      PASS      15.52 seconds
TestRunner: bnep-tester       PASS      7.08 seconds
TestRunner: mgmt-tester       PASS      116.61 seconds
TestRunner: rfcomm-tester     PASS      8.96 seconds
TestRunner: sco-tester        PASS      8.89 seconds
TestRunner: smp-tester        PASS      8.89 seconds
TestRunner: userchan-tester   PASS      7.47 seconds



---
Regards,
Linux Bluetooth


--===============4194323442469663584==--
