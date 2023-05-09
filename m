Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7078C7EE22
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 May 2023 20:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjEIUl1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 May 2023 16:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEIUlZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 May 2023 16:41:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1617A116
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 May 2023 13:41:25 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64115e652eeso45512144b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 May 2023 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683664884; x=1686256884;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A8D89oNRMuUO1Ne8Zj4u7TKNyKBDA7l/LEiwV8tJfKQ=;
        b=fTprvKraphTBkj4wjre21AHlZHcvIZlUXliJn1mx309b03OJNm/59u1BlkPGpoa41k
         Fvr6TTCfR153l3I4wCuKqlBFY68sLCK3X8lFfUFVWpEQcDK+FkDKwy3cKfG2TLz8wQ4B
         o2QKMKDS/QOBRo2XK684YCCd0nHqEkvOgyQUADFwT6540oz7Qql36HlOtS/qMgMIWtUi
         7uq2MfHy/4PLF6opU9VGu8F9rai6zP87hBLj1MEuoIyLWraFgOOuvhhAnCUZ5ctcO/qX
         pL2KpaypdPuhRKMzUVcMjVg1Y2ZSd/TE+ABpW+fDUJ4DFNHV7u77F2NfXicxSnUjOabW
         7/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683664884; x=1686256884;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8D89oNRMuUO1Ne8Zj4u7TKNyKBDA7l/LEiwV8tJfKQ=;
        b=B+jmfsV83W0ZrzyCZqsSOgV+eIdNBBWTczubexjh8yghg0j9XeRrVLO1LodxxYz+wk
         61j6a3oV2r69HkpAhks1OQXP5JrlY3O1q+TAqQfvunFh8Ux73eFAR4P8GRAwm5BYg4Qv
         n4gjgRszQ2q3ZzT8FsoE6SrjU5Ol4eJcgn+1eKeInTCRX1RzsGS1RjPpbk6/5S36JvLq
         QYSxv03sx3zYhBWB1PpgYdL/lighJlktIBkUH1xSH17Ohh+GA9EwZgnKhzaJPDt1xAuK
         mCQXbH6gsHdo3efVlXZ3gDhnojsXq2ELCqq5d860qv0uuJcErW6G3wHV4wgPqy9DgVHA
         NsNA==
X-Gm-Message-State: AC+VfDwqDH1fkvrHdEKKnfuzht01kwt1vBT4dhylFiQ3ZLKC2DttJGSt
        GzbXZ0xkn2dz9ESTrgdm5O8Go2NA7cY=
X-Google-Smtp-Source: ACHHUZ7XW4g2fJFR0fxW7WPVE4eImWwt+fhUYCQ6H4CJnEa+Hnnrd16EqD0ILOcCia12/DDUJWy9xw==
X-Received: by 2002:a17:903:192:b0:1ab:1260:19de with SMTP id z18-20020a170903019200b001ab126019demr19365736plg.11.1683664884136;
        Tue, 09 May 2023 13:41:24 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.244.135])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b0019a773419a6sm2042640plg.170.2023.05.09.13.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:41:23 -0700 (PDT)
Message-ID: <645aaff3.170a0220.ae0c8.4332@mx.google.com>
Date:   Tue, 09 May 2023 13:41:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3468527092424953719=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.gora@gmail.com
Subject: RE: [v2,1/1] Bluetooth: btusb: Add device 6655:8771 to device tables
In-Reply-To: <20230509194524.9361-1-dan.gora@gmail.com>
References: <20230509194524.9361-1-dan.gora@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3468527092424953719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=746240

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      43.01 seconds
CheckAllWarning               PASS      47.21 seconds
CheckSparse                   PASS      52.86 seconds
CheckSmatch                   PASS      142.61 seconds
BuildKernel32                 PASS      41.93 seconds
TestRunnerSetup               PASS      596.64 seconds
TestRunner_l2cap-tester       PASS      20.77 seconds
TestRunner_iso-tester         PASS      28.53 seconds
TestRunner_bnep-tester        PASS      7.35 seconds
TestRunner_mgmt-tester        PASS      143.14 seconds
TestRunner_rfcomm-tester      PASS      11.92 seconds
TestRunner_sco-tester         PASS      10.73 seconds
TestRunner_ioctl-tester       PASS      12.62 seconds
TestRunner_mesh-tester        PASS      9.45 seconds
TestRunner_smp-tester         PASS      10.37 seconds
TestRunner_userchan-tester    PASS      7.93 seconds
IncrementalBuild              PASS      39.49 seconds



---
Regards,
Linux Bluetooth


--===============3468527092424953719==--
