Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139D6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 00:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbiBPADQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:03:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbiBPADO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 19:03:14 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46490652D4
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 16:03:03 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id x5so502641qtw.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 16:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wU8+5goHElAPGEhN1o2xxrhtAEznIwYrwladNDo0h9Y=;
        b=VuYLc4GgJ1ygXVMl8zmvLTXVgd3c+iQik7sUBT12sE3A0SS8XROLPIInURIxOewhva
         iIRoKPCoHYt8JJE2LgV8PvNaZ2XwBFzUDFrFl4IQANRRq/74FVHG1wRLuGP9vrmkq1Bs
         9bCYCUD6Y2Ot75Neos6RSDFDwvkkq110MUj/yEH8iIlI8HZRL6A3qMChI4FOGgo2IDV6
         aWhA1h1R4jfisUb0dglQ4txZeC+C1/MEH3uUxDHpmuIYVE4yeQo3u+FWUEKMo8w4H5ml
         9L+2WZTLGUtJIrWvb1mhk/IJLlHBos/PjRqyYhb3ItLHv9dNt/WXgX7cZg8dzaTrJTy/
         +uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wU8+5goHElAPGEhN1o2xxrhtAEznIwYrwladNDo0h9Y=;
        b=KePGMazjFiK4GfaKakRXflLroLvuiBKxpM5mkzRIssXJoJ1ZBEde1XnVAXNfo6oC1W
         B6yTD473iRRBu9FPXtg4BHZAXyN8YdjKhfY+fkg9/5ZozYzjojO4NmJ3sLZTU9OABYcN
         gITcpVbsw4AuFn3YH1jIym2Eq8+J0wvJmeWW/ydV+G9NC0l6H6AV3+g3jnXrhZVPkG0L
         tPIVzHq1Zl86uQyjrcxdPyT9eLWxOh1g+aB/d+qTkK1EssW9Xr08u2LaBceCfA317LjT
         36aWpBAMq/8DRHng7TU5YEA9fJ4zg3sfKOQd74WxzTz64O3/D/DlQGIwHKOwlbA2eWuJ
         sRtg==
X-Gm-Message-State: AOAM530/Q8Mi7DoV2meDNuN89PkPnt5TSOdGiE177zkOwzlB6jkS7UNU
        eY8Q9P+Nvl9FYBy4k0/cSImIZ9H8wXdypA==
X-Google-Smtp-Source: ABdhPJwuXd8NHNSeH/vxnBcOzK5qW3eMk0bKMSNP5i40lq1KTacJxoSx86Mf8m7tydkktosMDNDxhw==
X-Received: by 2002:a05:622a:174c:b0:2dc:4f1:f3fa with SMTP id l12-20020a05622a174c00b002dc04f1f3famr326981qtk.535.1644969782329;
        Tue, 15 Feb 2022 16:03:02 -0800 (PST)
Received: from [172.17.0.2] ([40.71.163.126])
        by smtp.gmail.com with ESMTPSA id s2sm17307649qks.60.2022.02.15.16.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:03:02 -0800 (PST)
Message-ID: <620c3f36.1c69fb81.207d.d437@mx.google.com>
Date:   Tue, 15 Feb 2022 16:03:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4852467068394598918=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: Bluetooth: DO NOT MERGE: Test patch
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220215234140.3416-1-hj.tedd.an@gmail.com>
References: <20220215234140.3416-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4852467068394598918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614727

---Test result---

Test Summary:
CheckPatch                    PASS      1.63 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      36.20 seconds
BuildKernel32                 PASS      31.87 seconds
Incremental Build with patchesPASS      44.18 seconds
TestRunner: Setup             PASS      570.58 seconds
TestRunner: l2cap-tester      PASS      15.81 seconds
TestRunner: bnep-tester       PASS      7.32 seconds
TestRunner: mgmt-tester       PASS      120.89 seconds
TestRunner: rfcomm-tester     FAIL      9.18 seconds
TestRunner: sco-tester        PASS      9.26 seconds
TestRunner: smp-tester        PASS      9.13 seconds
TestRunner: userchan-tester   PASS      7.65 seconds

Details
##############################
Test: TestRunner: rfcomm-tester - FAIL - 9.18 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.188 seconds



---
Regards,
Linux Bluetooth


--===============4852467068394598918==--
