Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50E3C0015E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 12:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGXME4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 08:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjGXMEy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 08:04:54 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BD510C0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 05:04:49 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1b05d63080cso3363609fac.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 05:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690200288; x=1690805088;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6IKwMmd95gcKn8aG84MXzq19FY9HHVMGxCiq49Ocloc=;
        b=ZVipTkXe5+oy5kyZjw6WFIkKilwie77K/NDNsAPw+ps3rpdsLQPiLivYmA2HsvHCzZ
         SdrtK7JzDN6A9PbEHJWplut3/y5rYWdQigy6H7JM9szAF0cSufiCkgkGfmvmhI6QVMHb
         9nbJZa7HVlHYDR2g06VF2xf1BZsBFJ98ktKGB/v/TlGT7euxcPzY8yk61ykP1DF9PiQu
         5yzjHUsiyo3EKEP6IiJelNEQ1wYy74KfOpZWrdA8JHTFm22GI/xTqj9bXvNyxbdJoSzk
         3L7WHBYVUz2rLH7VVH9ZBMrmz+aKpkxugc3unXi13ge0usJY+HTdD/xRJqscUvMmoDqm
         AqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690200288; x=1690805088;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6IKwMmd95gcKn8aG84MXzq19FY9HHVMGxCiq49Ocloc=;
        b=Q5CFrWRGOS0CWqjEv8kkKhD0JvNxuwJ9vALDpt/49MeR7HamRRpxem8kDsIkSYpmhF
         GkRQ8xURCN//xucUgR3Oe1FnBg2wjyfjqPRbjQ2miz067j0RSK+PaVr9oLnzyNmda6Eh
         +x9tapFu/G0ZHIbYrDHuJGvFcd3VCFcSehwgSEmnAkTSrpjTNAHgLWV1B2lXw8ziQdm/
         zBtRRDvV6XfmjlxT+dfMkKVhvAkmhc6bcRVp7PS4HfnGkLXkKlDgG7n33kQ3W17D25KA
         842XskR8jw4RO8dOQM96u0DIzU6tlGRcnyg5RqS2T3tjw/ckp7GBuvjWDtBKmdqV1Hcf
         oxPg==
X-Gm-Message-State: ABy/qLZl1w0pRn4xxs/rgo3dII+xN/d0ix/gXWUYtMEbQk/YkzSwYbEh
        GGPjYnO20Si7w4sC5KWCFopWtUvDoZk=
X-Google-Smtp-Source: APBJJlHg1KICKR9iHxseSO7FFVa9dxymNe950rhwE/8oxgLuuyNC5nEZ2m5Iw28s7xaHqshAt8E8Lg==
X-Received: by 2002:a05:6870:8a09:b0:1b7:8950:c881 with SMTP id p9-20020a0568708a0900b001b78950c881mr10786958oaq.13.1690200288483;
        Mon, 24 Jul 2023 05:04:48 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.139.221])
        by smtp.gmail.com with ESMTPSA id dv6-20020a056870d88600b001bb5b2a958csm1495790oab.23.2023.07.24.05.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 05:04:48 -0700 (PDT)
Message-ID: <64be68e0.050a0220.3e77d.5379@mx.google.com>
Date:   Mon, 24 Jul 2023 05:04:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2196101621875364805=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [v1] Bluetooth: Add timeout in disconnect when power off
In-Reply-To: <20230724111206.3067352-1-howardchung@google.com>
References: <20230724111206.3067352-1-howardchung@google.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2196101621875364805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=768858

---Test result---

Test Summary:
CheckPatch                    PASS      1.32 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      40.15 seconds
CheckAllWarning               PASS      44.04 seconds
CheckSparse                   PASS      49.87 seconds
CheckSmatch                   PASS      134.79 seconds
BuildKernel32                 PASS      38.62 seconds
TestRunnerSetup               PASS      584.62 seconds
TestRunner_l2cap-tester       PASS      28.42 seconds
TestRunner_iso-tester         PASS      56.98 seconds
TestRunner_bnep-tester        PASS      12.70 seconds
TestRunner_mgmt-tester        PASS      247.32 seconds
TestRunner_rfcomm-tester      PASS      19.68 seconds
TestRunner_sco-tester         PASS      19.99 seconds
TestRunner_ioctl-tester       PASS      21.88 seconds
TestRunner_mesh-tester        PASS      16.37 seconds
TestRunner_smp-tester         PASS      17.27 seconds
TestRunner_userchan-tester    PASS      13.62 seconds
IncrementalBuild              PASS      36.82 seconds



---
Regards,
Linux Bluetooth


--===============2196101621875364805==--
