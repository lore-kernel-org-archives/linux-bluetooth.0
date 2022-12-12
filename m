Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A75CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Dec 2022 13:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiLLNn6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Dec 2022 08:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiLLNnl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Dec 2022 08:43:41 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECEF55BB
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 05:42:54 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id d14so3340833ilq.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 05:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xV602oyHTym/ZXpUxfXCBbRmlkYwMCRLodFLoR8wjz0=;
        b=KB4haXXyhZ3e4jo8TOblceDu47E3x/Xh6PkH0NDpE9sW/RSYcuvffmBClXLvEKveaH
         8vXkR5VBm4cZAx09iPNaAJAIze/wI1eZCMAchuJmnV7BrSlcjusQ5DHRpEdcaRcGyT6f
         8bJCoWBAeke8/20hPDiNw44QHASkz0eEu7PcwrOgrXuC+Xr/hw80+lzftf7BlCF/V69b
         /NXkSs1/4TBGmmeBfImbhAqnZd5U0O/Za07PURf66HjfT4eVCZkzcLtuRw2pP1T2r3Ue
         3FhIA4TYt8XV6szlmuUJg05wH5qvBRJURTY3Xfz9keL8C/7cRdAsyWv+8NY0/iVBTjza
         hv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xV602oyHTym/ZXpUxfXCBbRmlkYwMCRLodFLoR8wjz0=;
        b=6xaMJXjqYwguKAeZi6fCZUNErPUCi/9D1PpaBrfeOiCI0wJfxjmEWaqeufq5nvDDlZ
         0hV+TDZ1tu28M4kozuZGaFWYphOdPUzfkCS+QpHGPR+agPae4SLcD7bRv54MtW/B2ySq
         YJFlo6pfjMl66apbC8QPeICtCe0dTMpGdqeuI7bvDYBTZDfyENzHVlKRHrRWVyglupxU
         uNpmcc7oR1tf4oZDjKJITfIg3RqxItzh/aMzUXrZkObAe5PPkWYO4CGzsQCdQGkdHLkL
         0VlbZDJV2+17dMCDWpK0uZTWqJcnH3NOqGihnRArpl9dPSmsZzoOw9JAfEfEFneTz2j/
         rW2g==
X-Gm-Message-State: ANoB5pl4p/WGkEPa3mSqyJsKMDvSm9AcZbXbC22UA/5QS/m6CMmNx7tx
        Pu/QA4aHbN2kaoLJag+SpFG+XoPqxSY=
X-Google-Smtp-Source: AA0mqf5zp1qE4o2+cu6Noc4STMRQKS5b4fNRQdeY8xtQiGuXKQ28eccar00PBzHV1nSxFsFqGDGVlQ==
X-Received: by 2002:a05:6e02:b2a:b0:303:3e96:a16c with SMTP id e10-20020a056e020b2a00b003033e96a16cmr13798700ilu.20.1670852574267;
        Mon, 12 Dec 2022 05:42:54 -0800 (PST)
Received: from [172.17.0.2] ([40.77.45.149])
        by smtp.gmail.com with ESMTPSA id f26-20020a02cada000000b0038977b9ca9dsm3053447jap.131.2022.12.12.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 05:42:54 -0800 (PST)
Message-ID: <63972fde.020a0220.bbac3.4601@mx.google.com>
Date:   Mon, 12 Dec 2022 05:42:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0082736838949548595=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, harshit.m.mogalapalli@oracle.com
Subject: RE: Bluetooth: Fix a buffer overflow in mgmt_mesh_add()
In-Reply-To: <20221212130828.988528-1-harshit.m.mogalapalli@oracle.com>
References: <20221212130828.988528-1-harshit.m.mogalapalli@oracle.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0082736838949548595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=703836

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      31.00 seconds
CheckAllWarning               PASS      34.14 seconds
CheckSparse                   PASS      39.21 seconds
BuildKernel32                 PASS      29.85 seconds
TestRunnerSetup               PASS      424.74 seconds
TestRunner_l2cap-tester       PASS      15.64 seconds
TestRunner_iso-tester         PASS      16.09 seconds
TestRunner_bnep-tester        PASS      5.29 seconds
TestRunner_mgmt-tester        PASS      103.67 seconds
TestRunner_rfcomm-tester      PASS      9.11 seconds
TestRunner_sco-tester         PASS      8.58 seconds
TestRunner_ioctl-tester       PASS      9.71 seconds
TestRunner_mesh-tester        PASS      6.62 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      5.54 seconds
IncrementalBuild              PASS      28.30 seconds



---
Regards,
Linux Bluetooth


--===============0082736838949548595==--
