Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A7AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jun 2022 11:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbiFIL6C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243905AbiFIL6B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jun 2022 07:58:01 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A6B6327
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 04:58:00 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id n197so10452607qke.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jun 2022 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aTgm1p8YvlTUt2+erN6z4eyezL/iWE75cDZv1FHsqQ0=;
        b=CrDzbZbHJ22uLVSjJXAKLRAZ372Gkh+hB+FEtwEDM/OGL722jFIxd1LHhl0WrEHVDY
         gGLnXR8hKmG8qliYP7dhneQ6eG71U1QDqfeujz+F9LjLRvCtAkuQHPJZtZaxBmQrAHdP
         Qyfp9EWk0W0XTnA8hHB1ARYo7NhjhqVoAySab5IJ39Cn2LWrl5zmBNme6m9i2tmOjXJK
         ynTJHRg7kJtKGAU9WkUUUQor3VkVQ2tjszjbV3A/I8fmXUNTnlguhQKZEAt0b7gb2jri
         2XoSsbdtoBOWBXrm0OD/ambyzSbEu0tL3LCi727BKiIjqEE+kdFzlkmCOKy+3wfKfROI
         Zk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aTgm1p8YvlTUt2+erN6z4eyezL/iWE75cDZv1FHsqQ0=;
        b=cQu+yiodwMLJlyd+Y5b0nLTHLeDsiGPVIYsOjABzv+jk+vs1+vyLMGbN7Oqbf74EuP
         FErJdScfV5CtjZZcOfxGgPPiiyJ+hAwMlcJ1ODpXoOr3F7mR2csMHlF7nNCqmvVOklEP
         tChjehd5YJKXWD/zEN49lmQvHNlXDJvzpkBRer3JuCF3fhJK+0VlCtXwrJcqCD0C78vU
         Ng15Y575OtalG81SKREIgk9ZRWlcVWEbzH/7hSkpl47Ticz6ScVlI30OowUnLff81YfC
         D6UewQPbmDui2xIVuVLCwf9SIHaIytVaJRoCMISFnKtCOgOLX6zQbWJs/Hw3iQ/SD77S
         ziow==
X-Gm-Message-State: AOAM533+68oxeWLhgDmMShb+nTClA0dHb2W0ZrAAM8ZFVy+7dlM1AF6G
        LyGdJ5R28ulKvChM/9EYMTvO/HnIpy4VDQ==
X-Google-Smtp-Source: ABdhPJzDpB9JjH33joEP0e2s4S3S8XztyCnAGfBH4alAjz9xHqeExjFMS6xOr6s5jwHXjJHErqXksw==
X-Received: by 2002:a37:e202:0:b0:6a6:ab87:113d with SMTP id g2-20020a37e202000000b006a6ab87113dmr18947816qki.605.1654775879424;
        Thu, 09 Jun 2022 04:57:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.136.186])
        by smtp.gmail.com with ESMTPSA id c8-20020ac86e88000000b00304f55e56e4sm6163989qtv.40.2022.06.09.04.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:57:59 -0700 (PDT)
Message-ID: <62a1e047.1c69fb81.d08bb.f2f1@mx.google.com>
Date:   Thu, 09 Jun 2022 04:57:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8519234370847345739=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2] Bluetooth: Fix CVSD SCO setup failure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1654772974-10357-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1654772974-10357-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8519234370847345739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=648809

---Test result---

Test Summary:
CheckPatch                    PASS      1.79 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      31.08 seconds
BuildKernel32                 PASS      27.29 seconds
Incremental Build with patchesPASS      37.60 seconds
TestRunner: Setup             PASS      459.51 seconds
TestRunner: l2cap-tester      PASS      16.90 seconds
TestRunner: bnep-tester       PASS      5.82 seconds
TestRunner: mgmt-tester       PASS      97.39 seconds
TestRunner: rfcomm-tester     PASS      9.27 seconds
TestRunner: sco-tester        PASS      9.08 seconds
TestRunner: smp-tester        PASS      9.04 seconds
TestRunner: userchan-tester   PASS      6.01 seconds



---
Regards,
Linux Bluetooth


--===============8519234370847345739==--
