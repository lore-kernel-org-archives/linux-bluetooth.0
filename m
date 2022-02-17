Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202B6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 22:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343750AbiBQWC3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:02:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbiBQWC2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 17:02:28 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851191A38B
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 14:02:12 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id v10so11054758qvk.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 14:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Q0o8d65UeUQDyuBFDAmIw/bFzxA6vnsVwqyNByJhWpI=;
        b=OrtONLMXYgG2KVJhS5DTruOUh9gG+uJxZoJ5RUEAG2AqGvIO3zRe2gn6EQoV346c1r
         8A0Y1AMTiLkkcwAHRIO7QJWcoTkJmwawC+4ulEERUavbFGXASsx9Vw7+VS8LPFiL7/P6
         e/xWg1ZeB3Xy5OoKaRACd+8SxDyS+azr1DS7FW33v/HNzfoxPcqIcBDP1rHu7fxL/7UF
         mPQLI0nHdzAiZumecqb0w1fqhfZAq1i+351jf/1cXbIwZS6jKtdY6hxBMse7GYnDeWPI
         GYVh1GM7rR12d98g69GVlyQiTlxzpVYL/IM1XQTpezwow5d7Tj9tEbHCDWcpBUjXLbhh
         Nahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Q0o8d65UeUQDyuBFDAmIw/bFzxA6vnsVwqyNByJhWpI=;
        b=PXml9LblA6dun1grvCEocf5MwBno5dxDGVCjgKPH8oVPEvduOG5XmIGX4DWsckjg4q
         upz+o7VPFZjXr+dm2y8gbi97vGy50qw9lX/i0gFCx32q7KFr+qx3To4x4/e/19W9s727
         pPPbDIXUwjLz078pIhAnx1s/lDr5OwgCxewhvUD7waxeBh6i9LTQ91XTf2OQOxyLMHbh
         FnYMHOHm/dbbQi1lWZ33cUUpnRjWlL7fUDCDV6xFrBLIO5WKaWKQB4xi/usY9jZdX2zj
         Xa8uEQ2ADP8/3XthbEpJ+77WRRwORfCgF7MQX34GxplOXIgOoIEMm2gKo92/VjeacWWv
         k9ZA==
X-Gm-Message-State: AOAM532edIeRVMSb2CKFAN26sstnRJYDMSKHaqlsMjDfFAEmh4D4e+J2
        24CE3+rU//+bHkgqdwudxf4MTJzjb3E=
X-Google-Smtp-Source: ABdhPJxKrF8Xq+zAadUs7keC1sznsdhBy3FEWtVJnJnvFe8vEDa2OYQ1r2ZjB+Bn4J6n92PpQ8AodA==
X-Received: by 2002:a0c:d807:0:b0:42c:1ff7:7242 with SMTP id h7-20020a0cd807000000b0042c1ff77242mr3801448qvj.119.1645135331317;
        Thu, 17 Feb 2022 14:02:11 -0800 (PST)
Received: from [172.17.0.2] ([137.116.72.163])
        by smtp.gmail.com with ESMTPSA id y20sm23408350qta.9.2022.02.17.14.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 14:02:11 -0800 (PST)
Message-ID: <620ec5e3.1c69fb81.384e.447c@mx.google.com>
Date:   Thu, 17 Feb 2022 14:02:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0143539777866650791=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix not using conn_timeout
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220217212452.3067244-1-luiz.dentz@gmail.com>
References: <20220217212452.3067244-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0143539777866650791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615563

---Test result---

Test Summary:
CheckPatch                    PASS      1.89 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.90 seconds
BuildKernel                   PASS      36.80 seconds
BuildKernel32                 PASS      33.44 seconds
Incremental Build with patchesPASS      47.52 seconds
TestRunner: Setup             PASS      592.64 seconds
TestRunner: l2cap-tester      PASS      18.89 seconds
TestRunner: bnep-tester       PASS      7.44 seconds
TestRunner: mgmt-tester       PASS      126.90 seconds
TestRunner: rfcomm-tester     PASS      10.09 seconds
TestRunner: sco-tester        PASS      9.70 seconds
TestRunner: smp-tester        PASS      9.34 seconds
TestRunner: userchan-tester   PASS      7.85 seconds



---
Regards,
Linux Bluetooth


--===============0143539777866650791==--
