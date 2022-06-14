Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63C1C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 18:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbiFNSHz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 14:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiFNSHy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 14:07:54 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159CE13F21
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 11:07:54 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1011df6971aso11054799fac.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=UHmzY2N3/rS+XforMnMPN1IAoK3sVdzV8WwU/wYflP8=;
        b=RiBKk5wCujmhbDub3o49hOKvMMszGaKg6leZl2YNCEgOQgqwLZ4Trxjl1d90bQ7u3N
         pjnhbI6iWWdl2aLCcK8JkxmmVxxpX2qHUMU/ifcOVZdPijm3kwF1Tzb8WnFZmaFYCc1g
         4SaXlmi1liA57ZcHQrDZH6QAc9ODHUeuwKG4BN7CHoB9fcqR84HmR21aJSjVVM2QP7xt
         wrkIrGzPg0pH/CyipH7kRJaf+tF/sbSwwGZJt6jezc+43UXCyn0zaO4xf8JRt9X/ce3Z
         zN8iLLFp9Ia3lR0+dIVXBCih0xd7vQOy/ZZ5YpiH66y25zVNNI5obfnKzmywtLaDYhpA
         D0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=UHmzY2N3/rS+XforMnMPN1IAoK3sVdzV8WwU/wYflP8=;
        b=HR5u1Tln1PKUszwuAIyaspeD5gwEllfbepLGIh24F/VCvBM8D/0ZEh6SxSmD9lBp2f
         thtWLLMsA4h9B18lxhVx7eERk1CElxVshEclKuR3VLthDYbbgZnD6yBgAXHElWD3LvRe
         TNp4Fq/h/RrYjkQVOHLTMtMNcbnBIjdAoiFH1l0uRwkJXnzOrZNd1B3jg5cBd62xrH0U
         1mhfQIz71fzBzJPU3kaNzdBlXcTKFhRM+RLMYpjj/AAJ3egs9J3Gk4RD2GQ9bguozr+X
         jcixd5nruvUs9lYcMvQcIvT6aV/hIgSfMCI35BhwBBJFyJzXR9FbRyy3sLcF3pLLgebT
         iLfA==
X-Gm-Message-State: AJIora+OGiJfWNcdWLHdMEvrmO1iM0rQd0qVo5P9dDgafEymYEtRPnEG
        SPq25Jmkq9ZlCngJ2NiBxkIQgwAGulU=
X-Google-Smtp-Source: AGRyM1uKZcceDc8j4DnuJmhjat8shdBwSAB/rWdar9+SDhMorTzW1C1Fh/qm4Kw1wOjZXxs2drodzg==
X-Received: by 2002:a05:6871:721:b0:f3:24af:e506 with SMTP id f33-20020a056871072100b000f324afe506mr3114689oap.30.1655230073261;
        Tue, 14 Jun 2022 11:07:53 -0700 (PDT)
Received: from [172.17.0.2] ([104.215.101.70])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000f886139c51sm6000955oab.53.2022.06.14.11.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 11:07:53 -0700 (PDT)
Message-ID: <62a8ce79.1c69fb81.be5ef.f036@mx.google.com>
Date:   Tue, 14 Jun 2022 11:07:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4093685715246305103=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: HCI: Fix not always setting Scan Response/Advertising Data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220614174645.518132-1-luiz.dentz@gmail.com>
References: <20220614174645.518132-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4093685715246305103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650299

---Test result---

Test Summary:
CheckPatch                    PASS      1.73 seconds
GitLint                       PASS      0.73 seconds
SubjectPrefix                 PASS      0.60 seconds
BuildKernel                   PASS      31.61 seconds
BuildKernel32                 PASS      27.69 seconds
Incremental Build with patchesPASS      36.55 seconds
TestRunner: Setup             PASS      488.05 seconds
TestRunner: l2cap-tester      PASS      18.50 seconds
TestRunner: bnep-tester       PASS      6.18 seconds
TestRunner: mgmt-tester       PASS      102.56 seconds
TestRunner: rfcomm-tester     PASS      9.22 seconds
TestRunner: sco-tester        PASS      9.52 seconds
TestRunner: smp-tester        PASS      9.19 seconds
TestRunner: userchan-tester   PASS      6.08 seconds



---
Regards,
Linux Bluetooth


--===============4093685715246305103==--
