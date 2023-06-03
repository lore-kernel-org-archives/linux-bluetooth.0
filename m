Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C29C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Jun 2023 13:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjFCNLN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Jun 2023 09:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFCNLL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Jun 2023 09:11:11 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F8718C
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Jun 2023 06:11:10 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6261890b4d7so28208736d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Jun 2023 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685797869; x=1688389869;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qVKgWzfTo36UdHqT9lFJ1n0kpOLrAlfMuuQty9eF1To=;
        b=pW6yf9IN8EZuhiUQ2YygV+4r/u+BB5xKHyNwPHdTxW4XI3U7w2Q2RwmbKRamtO8o3g
         eOYf7awSs9/Oo3w0bug64C4xfhYE0vlX2UIny2+K0dFEJtmAjng0FZtwKP5R0p6C6bsU
         vZ7+VRJLTXY0bOKWVmJXdhrtQbDpsbG+nk4dF4e/23lbkDPcirM75SoFDdxrNe7ga4wU
         Ut95uqkJ5DkWJ+pVbiUJhLULiMWd0j2SU4NZgeSREwhd0cJJtCwbg3c/VVZreGLfv8TO
         uCR19oS/217wsmoq1cv7cgL8RVvGb5WBvu9R7LP6WgVa3YxXS5au6dQQUbj4ocSjRV6u
         9K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685797869; x=1688389869;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVKgWzfTo36UdHqT9lFJ1n0kpOLrAlfMuuQty9eF1To=;
        b=E3iYMymhPo1rZUSTByHHb2vUKFLUEtjaYoRejxMB9jwbXSXh4k2+/Pkrfmmkpvnri9
         1AUWv870KKsBgqfqQVbuoAcZ7iYEXyyUv+WyQ3jSHaQqDYjdTzauPieV4Jh+DQPLEZJE
         UIwHVt4M1p0g7SiI/3+9bswm0yc5WJ+oBwbV2iu1/k9+zag5jnCLt0zDjRPtp62lEzGy
         qh8C+9Bp8kQuDeXotwzNZ17FjjCY/Pkzdy7J5HumDcI3ALgX9YNJZY8YTCW0SOqhLIAn
         LpxReXoQO4m5FzGebywSm7u57zhIUh7wPb1G9K2CdNUf2Ujd6YpbiAiowqvX4fG14Rul
         HI1w==
X-Gm-Message-State: AC+VfDwkTyH7/VYBHMOuGF0AN6C+9nX+Xl+UkcM9EMLlw1+JHD1qjh5p
        iA7y1LZyu26xfsCDbIVHmiDaGC9m02o=
X-Google-Smtp-Source: ACHHUZ7KjLmvss2qzQE5R6KWfR99yjzPpy3N8a6OzTGZSv7svak+YUK0mpLl8K+VV+0aiHL3oJykmQ==
X-Received: by 2002:a05:6214:29cb:b0:616:5755:ca68 with SMTP id gh11-20020a05621429cb00b006165755ca68mr1444067qvb.25.1685797869623;
        Sat, 03 Jun 2023 06:11:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.214.57])
        by smtp.gmail.com with ESMTPSA id e11-20020ad450cb000000b00626234be222sm2160082qvq.57.2023.06.03.06.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 06:11:09 -0700 (PDT)
Message-ID: <647b3bed.d40a0220.fbcd4.51e0@mx.google.com>
Date:   Sat, 03 Jun 2023 06:11:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4901791491551494161=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: L2CAP: Add missing checks for invalid DCID
In-Reply-To: <20230603122808.1633403-1-iam@sung-woo.kim>
References: <20230603122808.1633403-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4901791491551494161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=753751

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      33.11 seconds
CheckAllWarning               PASS      36.05 seconds
CheckSparse                   PASS      41.35 seconds
CheckSmatch                   PASS      111.10 seconds
BuildKernel32                 PASS      32.14 seconds
TestRunnerSetup               PASS      457.37 seconds
TestRunner_l2cap-tester       PASS      17.54 seconds
TestRunner_iso-tester         PASS      24.19 seconds
TestRunner_bnep-tester        PASS      5.88 seconds
TestRunner_mgmt-tester        PASS      118.33 seconds
TestRunner_rfcomm-tester      PASS      9.11 seconds
TestRunner_sco-tester         PASS      8.40 seconds
TestRunner_ioctl-tester       PASS      9.93 seconds
TestRunner_mesh-tester        PASS      7.35 seconds
TestRunner_smp-tester         PASS      8.71 seconds
TestRunner_userchan-tester    PASS      6.01 seconds
IncrementalBuild              PASS      30.61 seconds



---
Regards,
Linux Bluetooth


--===============4901791491551494161==--
