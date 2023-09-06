Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382C6EB8FAD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 04:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjIFEnE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 00:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbjIFEnD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 00:43:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599121BB
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 21:43:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c0d0bf18d7so19412685ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Sep 2023 21:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693975379; x=1694580179; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYeg/+wXupKnQ00S8uj1c4p1UafXkFk5WUf4PBorA4I=;
        b=NQxnN0ZcQRh0F4afB+6iEckrBH5oiU8/R44wFktTgjLIOwYj1DijTrUxX1qvzsVZCC
         YkjTe6SQ6JVZ6xnFCLhAs87KfYJ/7E4oVBQUUWTPnLjmLHVWpF2AUXknntGimnxxA5Bs
         ZdS6AMGMZL0mskIiukf5/tzmkXvGFltffxWYPxwthEqJYryKNQDclYPQDZ3aS2zlHyRA
         XYq+tTId1yeUeVP/tnY2K1MAAwnAe88avJT/OC3ZzGfReViZYht0lGRABL2uBQxUZpnE
         nQUoRXDN/VYMbRNBTcu5pgY8XHhJaXtx1Ghk+rQuQV9eOAYLg0jWiOQPQl+4Cy1w58yV
         IDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693975379; x=1694580179;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYeg/+wXupKnQ00S8uj1c4p1UafXkFk5WUf4PBorA4I=;
        b=MPsek1IMb8IVg8p4JeUFJypubWBdQiSEor492A3MIJPBrVHK77zuTdh6bPbgd1jnkn
         50U3FqLiFbRqiq+MVaiLpCWCU9j82LEt3zOGEGr5jUdLum1zn1deXhGGBF9L9eO5JX1J
         65qcDO3SUEKb3s8iid81JkU0lI+lgCE4cd8cte21MmuwR6qEla2NvxGrxvgZG1/tgXiY
         iUUebLSl6DNoe0lLx96UK0cyhLEbVp526uSbOXs8k2WvQkEzJ8Lb2f3lwrHGJSV4msK6
         QQpbg7VarkRfWsPn1sCH4GbOdcUL9tsNoy24jI6HZeWFev0f+TFiCmqqmfwhVYAjhGLV
         GuWg==
X-Gm-Message-State: AOJu0Ywxxtj4LNHF7AQUunsaw7tKBmiLsR5358DTxM1Vl6VMMS3yFal9
        lDjyb3M/3CSzFmANXAFdXaGKfqZvfzo=
X-Google-Smtp-Source: AGHT+IHd6S5+rZtNrbCcPIUhLnP/3QWFFxnPuwBgoXImVGh5rN0TWkAOurhHmnofzmSxnyRBlKe0Ew==
X-Received: by 2002:a17:903:2810:b0:1bb:891b:8bd with SMTP id kp16-20020a170903281000b001bb891b08bdmr11043310plb.34.1693975379489;
        Tue, 05 Sep 2023 21:42:59 -0700 (PDT)
Received: from [172.17.0.2] ([168.61.75.143])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b001bdf046ed71sm6711256plg.120.2023.09.05.21.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 21:42:59 -0700 (PDT)
Message-ID: <64f80353.170a0220.a52c3.dc22@mx.google.com>
Date:   Tue, 05 Sep 2023 21:42:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4446090137049402236=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: Bluetooth: Avoid redundant authentication
In-Reply-To: <20230906034754.1.I0cd65c6ecb991a13b224614c32c1946f9eecea3d@changeid>
References: <20230906034754.1.I0cd65c6ecb991a13b224614c32c1946f9eecea3d@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4446090137049402236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=781869

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      39.68 seconds
CheckAllWarning               PASS      43.41 seconds
CheckSparse                   PASS      48.95 seconds
CheckSmatch                   PASS      133.42 seconds
BuildKernel32                 PASS      38.55 seconds
TestRunnerSetup               PASS      581.13 seconds
TestRunner_l2cap-tester       PASS      32.76 seconds
TestRunner_iso-tester         PASS      70.55 seconds
TestRunner_bnep-tester        PASS      13.60 seconds
TestRunner_mgmt-tester        PASS      246.02 seconds
TestRunner_rfcomm-tester      PASS      19.89 seconds
TestRunner_sco-tester         PASS      23.17 seconds
TestRunner_ioctl-tester       PASS      22.51 seconds
TestRunner_mesh-tester        PASS      16.90 seconds
TestRunner_smp-tester         PASS      17.71 seconds
TestRunner_userchan-tester    PASS      14.09 seconds
IncrementalBuild              PASS      35.72 seconds



---
Regards,
Linux Bluetooth


--===============4446090137049402236==--
