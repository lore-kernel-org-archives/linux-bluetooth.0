Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37681C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 May 2022 11:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiE0LHX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 May 2022 07:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiE0LHW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 May 2022 07:07:22 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F3DE039
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 04:07:21 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e3so4290594ios.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=83mRf5e9WqBvam3oVaK+oAGHY+xLqJ4cBz+PACJFz2I=;
        b=GDImqLWhhol2IA4pzmOuNKOQAJ3yht6f0r4B2NwXLJSF3i1I4xSzf/crIMm23/MGEP
         Ig5ovUNBfQziw4a4RRbZzcgnR6PhCFNZzQRq8UnUWz3tcC/K8N1gtXyzxA6csjFGSNgf
         NUpxXGxzKa8aEfewC44zddD04hILbkC2Hq1HbnHCwB9cMJg55zq7+cz0pKLwgWpNlRIk
         5nIqFQqCQzkCN27blSnoODLZgvMBRYjH/nL6DYZmbLavwogNXXxvphbXFdm1yIOQgpfD
         RJ9bZ9RwWofPL8ubCkeZxe3zKcS21NAnCpelhVNIrSGz9p21p/mfe3EzKEw2sEyJCN2w
         L36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=83mRf5e9WqBvam3oVaK+oAGHY+xLqJ4cBz+PACJFz2I=;
        b=8R1MyDIUjkYB+QsPNNnkEjKIN+QSx2bCFEIS6qmQHuKKefe2D1vt58ounDzFXfuzpQ
         0KKWpJ2mF3y34p/bgEyoP4SV230xRfeFdoG6zX+O+6ofCdqTGqEcq0Em9if7a8vrNkTf
         qxaEA98rXwpRW9Fo415OB1KdXaF+dTnWnbLUW9CMxZrEwsztAaFeBx8KTqcHGx4fd8C6
         tTiLRmnewQN9IKt7/EbRpUHcIsAtjcNfI7LzrhSinXWV7vf2ellINDctF40+d4RuuqPa
         EjLlb2MkCWfA9Z5ELDMlLH2a/kGHshfCgkPej+pR55mEMPliD2ABNLY5hZq4C8qode/v
         UseQ==
X-Gm-Message-State: AOAM530Q2Uglm9Sr56tlZKIqXd+Wr2cutWuKiZbKEsvNvjQvSvken8Th
        l4gadhAmr0mbBOZmu+J/O15bu+g8X3Y=
X-Google-Smtp-Source: ABdhPJw1o7KIHki6hjNvGtFkT5adoN5iOrEWkiac5BhcGwLFl7fX3k5cDtLZ0hJqRZGfI2Rp2cj/TQ==
X-Received: by 2002:a05:6638:1607:b0:330:f07b:7c5c with SMTP id x7-20020a056638160700b00330f07b7c5cmr1792900jas.68.1653649640459;
        Fri, 27 May 2022 04:07:20 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.40.243])
        by smtp.gmail.com with ESMTPSA id w15-20020a056e021a6f00b002cde6e352bdsm1218277ilv.7.2022.05.27.04.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 04:07:20 -0700 (PDT)
Message-ID: <6290b0e8.1c69fb81.603b0.5290@mx.google.com>
Date:   Fri, 27 May 2022 04:07:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5605467971035402908=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_saluvala@quicinc.com
Subject: RE: [RESEND,v1] Bluetooth: hci_qca: Return wakeup for qca_wakeup
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1653646543-349-1-git-send-email-quic_saluvala@quicinc.com>
References: <1653646543-349-1-git-send-email-quic_saluvala@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5605467971035402908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=645563

---Test result---

Test Summary:
CheckPatch                    PASS      1.32 seconds
GitLint                       PASS      0.75 seconds
SubjectPrefix                 PASS      0.59 seconds
BuildKernel                   PASS      31.43 seconds
BuildKernel32                 PASS      28.44 seconds
Incremental Build with patchesPASS      38.58 seconds
TestRunner: Setup             PASS      480.41 seconds
TestRunner: l2cap-tester      PASS      17.34 seconds
TestRunner: bnep-tester       PASS      5.93 seconds
TestRunner: mgmt-tester       PASS      101.94 seconds
TestRunner: rfcomm-tester     PASS      9.54 seconds
TestRunner: sco-tester        PASS      9.29 seconds
TestRunner: smp-tester        PASS      9.36 seconds
TestRunner: userchan-tester   PASS      6.34 seconds



---
Regards,
Linux Bluetooth


--===============5605467971035402908==--
