Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C1C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 03:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbiKRDxG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 22:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240885AbiKRDw6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 22:52:58 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B288C905A7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:52:49 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y13so3724899pfp.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5qnnpmnDTddHB2gLJFK0kLpyry+VCmu4qfXi5WOXWXA=;
        b=n7bCVhCGdo2d6ciwXhiETzY4zWXZinhINEPXUt+O3gMvlnTbEpLRw8FHveix12SmEb
         9F0HSdhfanGOhO2RwTyF8GVGhpC/Ue4GxBrSNG1ouBVTRl9WWx1ntMv69fk7P5enqd8v
         jdsV7tIfp4GS2oYhOqWwULOn80OAUdhbbWWyk3DCa5kqi/rZJCsik9xcxuEPK3DFD2i8
         qoLd0AAdTqeJVKrxCiBd3MdKTdOTj1c1x+VLjoSzgy+YFcXGlvVHrxTAvXj43sOxMoYz
         kV0QOlMbKJb1zpTDLfuPwfl1zSxwqykR4tIYnGXscizlhiVibt+gVT8YbQEC2R9ZVCNJ
         uiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qnnpmnDTddHB2gLJFK0kLpyry+VCmu4qfXi5WOXWXA=;
        b=04D/WHOuPI5naWE4zQfGGH3oxum8/rUJTrQQsrYg1aWEIDAs6ejhKrd6RNUJEPLzHH
         tIPBHY/qrHgchwBVtVPQoEUUk7vA4KvuVqUY5NNPPG/5SQnt5Vtu3+es3oEl9psZhtys
         Nse5LH0AsOLzzSbLrP9OazPi8iLWhqff5m8VUr0swrjeXvy71aSYhP6B2EwIVGaOAzvx
         PAn8uNIjfUFrfwW+eJW800Bup0n7rP973WlXc44yB1aqQBglebSaLfadmdu0NEM/5Wuy
         38WN/3vmDrD2llSzyb5OEGV7y15kOwDsTAuuZcskpxYgTAeXRSGn437VJFauedgsDJvI
         oRTA==
X-Gm-Message-State: ANoB5pkAKv13tEz3VexBf12a362eQoOriko2/YEYVLeEs/WHCWIds1ZB
        DeUWsd7mIbETgJYlH4yEwi/jY/Zyyxk=
X-Google-Smtp-Source: AA0mqf5Ov86Lgs8HhyJqUfXdEsLEibFTYE5z0fFLFNHiRWIvEoKkMwCtp3pTXmFfpx02gvkvn41+KQ==
X-Received: by 2002:a63:114b:0:b0:46a:e00b:ada0 with SMTP id 11-20020a63114b000000b0046ae00bada0mr4947899pgr.409.1668743569018;
        Thu, 17 Nov 2022 19:52:49 -0800 (PST)
Received: from [172.17.0.2] ([20.228.124.138])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b00187033cac81sm2301534plg.145.2022.11.17.19.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:52:48 -0800 (PST)
Message-ID: <63770190.170a0220.65595.4107@mx.google.com>
Date:   Thu, 17 Nov 2022 19:52:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2781841376248032537=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: Fix enable failure for a CSR BT dongle
In-Reply-To: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2781841376248032537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=689388

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      47.39 seconds
BuildKernel32                 PASS      42.48 seconds
TestRunnerSetup               PASS      593.56 seconds
TestRunner_l2cap-tester       PASS      20.08 seconds
TestRunner_iso-tester         PASS      21.41 seconds
TestRunner_bnep-tester        PASS      7.16 seconds
TestRunner_mgmt-tester        PASS      139.48 seconds
TestRunner_rfcomm-tester      PASS      12.68 seconds
TestRunner_sco-tester         PASS      11.51 seconds
TestRunner_ioctl-tester       PASS      13.49 seconds
TestRunner_mesh-tester        PASS      9.49 seconds
TestRunner_smp-tester         PASS      11.08 seconds
TestRunner_userchan-tester    PASS      7.75 seconds
IncrementalBuild              PASS      44.37 seconds



---
Regards,
Linux Bluetooth


--===============2781841376248032537==--
