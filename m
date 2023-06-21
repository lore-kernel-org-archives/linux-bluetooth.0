Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14BEEB64D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 01:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFUBZB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 21:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjFUBY7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 21:24:59 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EBB1704
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 18:24:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-762092e1fb7so465270585a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 18:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687310692; x=1689902692;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z7uF6XH/MHDJk25xyUtuGoFbi4z9/Rs4NEdcS3dTqHg=;
        b=a5SOGdggJmCRznt2MQsHCuHLJRTLTGD8WANtuZtyXpJXJeoSvi03zB2qdVEWfoGX78
         O6oS9H6t9kVbfCKbQ27AIGRjal8+UMpszT53gbm4gp1KXFVwg0t1uYEOw4U2xOR8yPao
         OgvxCU0j1FCIc7n6ci3pqBUPj6Czgc3tu3fpGJ0sc9y181VBwINaB3n1Sw8+7OPEdx+k
         IpEednHyCMUeRuQnxkeJRWx/ahicsvqEwA1lJlN64fDVkE2SMdxg++2KLt3agKO2uJg1
         VK1AZsAyuctdMYF/0tHocQqcy/gHQ/tqKqI3FafY7BOY0LkNzkU/IR+GtRjfgPMZU+1P
         S/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687310692; x=1689902692;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7uF6XH/MHDJk25xyUtuGoFbi4z9/Rs4NEdcS3dTqHg=;
        b=ANZSXUSCKH4nys1m5xabQTk7KnPbmAyQwq6E7bdiot0WvYtUTHGv1wNQlOWswCSSvX
         hr1cKMFI4fMiOA99a3ybWQX5Vn3mh5nva5XbA0Q8hzmjPt+RXMeEU3z/btGDPBfhf5XT
         CnemulCtsSi1iuQ+6up9uS24uoiwkgnPtWg+PsleJ+aSX84yGCR3tnCbolcNIbKNX2CF
         9mT1d9vLY9hE1i24QBIyeqnT06V0aBjBCJNgcoVn//y08obL4KKv2TGWsggB81LPPIPE
         Hwk9n+HbwsBThrdhvWfyahutlQkuw+kIuKSB6fjZU8fdakJoKjUuJAtVs3uCBACAwc2V
         DlnQ==
X-Gm-Message-State: AC+VfDwMhT/mPsMSj4kapEhskqpUXPZP6ihKKxQGe7ug5XWqNEF0pyLQ
        nb8UZYicCLwh4+1YKUdxya1TDQ67/0w=
X-Google-Smtp-Source: ACHHUZ5u1tZzr1cqXwTLfQcMhzPKenXZcfwSJx1rn+R/5CRbfVV514iZOkO5sFlOL1qcgKzt2fRZhA==
X-Received: by 2002:a05:620a:2b90:b0:763:a50e:dcf1 with SMTP id dz16-20020a05620a2b9000b00763a50edcf1mr5452996qkb.60.1687310692414;
        Tue, 20 Jun 2023 18:24:52 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.152])
        by smtp.gmail.com with ESMTPSA id i1-20020a37c201000000b0075aff6f835bsm1730531qkm.19.2023.06.20.18.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 18:24:52 -0700 (PDT)
Message-ID: <64925164.370a0220.d7d9.57e1@mx.google.com>
Date:   Tue, 20 Jun 2023 18:24:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6021874882226615102=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] Bluetooth: btintel: print friendly error message for acpi errors
In-Reply-To: <20230620235233.1845036-1-kiran.k@intel.com>
References: <20230620235233.1845036-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6021874882226615102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758885

---Test result---

Test Summary:
CheckPatch                    PASS      1.99 seconds
GitLint                       PASS      0.78 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      45.04 seconds
CheckAllWarning               PASS      48.94 seconds
CheckSparse                   PASS      55.45 seconds
CheckSmatch                   PASS      148.52 seconds
BuildKernel32                 PASS      43.23 seconds
TestRunnerSetup               PASS      614.41 seconds
TestRunner_l2cap-tester       PASS      21.98 seconds
TestRunner_iso-tester         PASS      32.43 seconds
TestRunner_bnep-tester        PASS      7.66 seconds
TestRunner_mgmt-tester        PASS      165.66 seconds
TestRunner_rfcomm-tester      PASS      12.41 seconds
TestRunner_sco-tester         PASS      11.16 seconds
TestRunner_ioctl-tester       PASS      13.26 seconds
TestRunner_mesh-tester        PASS      9.71 seconds
TestRunner_smp-tester         PASS      10.97 seconds
TestRunner_userchan-tester    PASS      8.08 seconds
IncrementalBuild              PASS      48.11 seconds



---
Regards,
Linux Bluetooth


--===============6021874882226615102==--
