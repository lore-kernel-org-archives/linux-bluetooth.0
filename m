Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568F9C77B6C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 07:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDMHcV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Apr 2023 03:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDMHcU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Apr 2023 03:32:20 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0A59F4
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 00:32:19 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id dd8so1854162qvb.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681371138; x=1683963138;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/x7IFL278CB5Co2goi0FWM9lY7++jx9KwkGdLBnKnNY=;
        b=qVNxbkSCz94vt3+dx33Y1F9WhAbzsGBDr/MYtKF8kd3WUAk6+jefNUu77Kab+bx/tE
         Yz9dn+7O8Lz7ZJ2y/hMr6LbfOFp7sGofIMR+5zfdMvfRYm3WuTRdt7PjEvNVj5ZfU5L+
         pBOdoCWfYOct6Q0T0FZ6vIsPq2s+5A7r/+JITY057HOAeYZWNAf4uNO+c7WoXQgvq/8F
         P2LIAYPsfVYe3mLM7eQvOxDG/Z098EipB9tXMR0P0uWE4R9v6n4m53BV5NTsZL3FoPd+
         N2+Geq0ZrUGYpqEwG/1G0jD5wvvDjKGL4z2iakm3eTu/fwxXlQDY91RNikEy776djW4o
         Anzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681371138; x=1683963138;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/x7IFL278CB5Co2goi0FWM9lY7++jx9KwkGdLBnKnNY=;
        b=FKMjEXDUF3byWwYxzSpjuo/fbgKbOy76emOXqJFoKuWn7kKkm/AOTx+uXc3UWRJ47u
         UfTliveJL+oUcKoD0isIq2WZJWVsrESj0dO8uDWTzlIULo2Pc70hhD7KIat7ZOtnFxaY
         Grf1w7fsFnUAUAIGzAztbooo+JpjcJlVgW6LKJTz5+vSR19A3oWNmpqD64RhJKAeqq39
         L6/xG5++a5ge5wE6v204Eo73UM2b/Kbz4pmRD2u0dnE0J9OKkKUX9nJAExMd4jKWHOdS
         OISxAyh7v75qU37sWrWqBajTLDsiQCqsJTu40bVpSemMTD12fQjeL3WZ3bh2HgMgGOS+
         UMFA==
X-Gm-Message-State: AAQBX9cPsWLeFa7yrEfH4UphikjsiPTaWPH3Lfa/s/y0hRvciwIpfvt3
        K0QW7ePxqrmBcUx3xkpXKsaZiArPdvg=
X-Google-Smtp-Source: AKy350aTOPL47q9VzNlfljhAFrkjBDCms8JFensfbzGLVcajd9qXbypY64U04XB5aCDTO19MKPizQQ==
X-Received: by 2002:a05:6214:e85:b0:5e8:ea1c:69fe with SMTP id hf5-20020a0562140e8500b005e8ea1c69femr1972900qvb.42.1681371138637;
        Thu, 13 Apr 2023 00:32:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.124.88])
        by smtp.gmail.com with ESMTPSA id ne3-20020a056214424300b005e8f61012e9sm254579qvb.26.2023.04.13.00.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 00:32:18 -0700 (PDT)
Message-ID: <6437b002.050a0220.fb86a.096a@mx.google.com>
Date:   Thu, 13 Apr 2023 00:32:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3050569172337166236=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v2] Bluetooth: btusb: Add WCN6855 devcoredump support
In-Reply-To: <20230413064344.18714-1-quic_tjiang@quicinc.com>
References: <20230413064344.18714-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3050569172337166236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=739370

---Test result---

Test Summary:
CheckPatch                    PASS      0.85 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.05 seconds
CheckAllWarning               PASS      34.86 seconds
CheckSparse                   PASS      39.41 seconds
CheckSmatch                   PASS      109.83 seconds
BuildKernel32                 PASS      30.62 seconds
TestRunnerSetup               PASS      437.68 seconds
TestRunner_l2cap-tester       PASS      16.52 seconds
TestRunner_iso-tester         PASS      16.32 seconds
TestRunner_bnep-tester        PASS      5.23 seconds
TestRunner_mgmt-tester        PASS      110.48 seconds
TestRunner_rfcomm-tester      PASS      8.42 seconds
TestRunner_sco-tester         PASS      7.88 seconds
TestRunner_ioctl-tester       PASS      9.04 seconds
TestRunner_mesh-tester        PASS      6.75 seconds
TestRunner_smp-tester         PASS      7.69 seconds
TestRunner_userchan-tester    PASS      5.50 seconds
IncrementalBuild              PASS      29.10 seconds



---
Regards,
Linux Bluetooth


--===============3050569172337166236==--
