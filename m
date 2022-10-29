Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5C6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 22:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJ2WH1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 18:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2WH0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 18:07:26 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9CE38B0
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 15:07:26 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13bd19c3b68so10005775fac.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RSwqjysoSY8+Dg8HmWNTCuDQTtHB0p2hvVk0EoggGvU=;
        b=aw6V3w3pJUorI7iFQCTJT4NaQpzBLBblKYnLcoSX4D59jfajuoI4tYxTOBA69rHpld
         Vt+99hd+KDQbIs2oHbh3+NuziSnf7fKh2fteeKiY3bdpGWmukvc3kh6g2q5g7mrAi+vx
         e/dCMcVod6AMJE7GdCKRq20FNVW/fFeLzPBp3Kteo+GegG0zLNvkc5P8eO1+DbmS8dKh
         C36Ew+JFfBGkq5RZYWe/302RBWQzcu0qwbn+pYOlcISujssDaSRAk3xRk+zbPZ9FUpQd
         HleKoY8REWY1iZ+dm9Ezznd2zGIEkqahVUGSJ3IZlK+NVQiou5aqEfA2gI7kmdgU6bkZ
         jceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSwqjysoSY8+Dg8HmWNTCuDQTtHB0p2hvVk0EoggGvU=;
        b=QQQzUs/HkhAuHaRLp8nXtaWYaEdHRk3xCdoRKdrABdA1q4znuTyfUUzbECGikyceMD
         z17IVYH8Z6zm63lRt2o+n1nceNdoeOeqlJn2vZxjgPugHw1E1dus960Fac2jQwb7S6Qt
         uClV+xGrW6kpjfZQZgQIVRxU/1PxFI4NstkWL2behPkcvIlMz1lrxFPUxKdoqu9w8LyE
         sw2+vvpRYksQNS3Umq9wPh5iiVs1CqI62fF6bhdDLSf9OjMe9ViwYkh4w3gV4aZp8Vrv
         J+nHZB7XRSk+8zjmZavOqfDMUAN31lAPqfrfn+qeD4eChrubHnGFtMHx2ld/2ZFhlaYk
         jGHw==
X-Gm-Message-State: ACrzQf2yWUNaay1TSRXqqM4z/dTGs8K9zcNO1VQe1kEy4MzAoalwnwT3
        1VL5C8hC8ZgHIZYWn2uXjicosmQZqzw=
X-Google-Smtp-Source: AMsMyM6H8n4PcVPehPfII917961Y6nKdkqxNgpOm91ZZdfQhxjiNTiK3KErxxG2t2wd5qIsN3A0IQQ==
X-Received: by 2002:a05:6870:64a1:b0:13c:d09d:79f9 with SMTP id cz33-20020a05687064a100b0013cd09d79f9mr641389oab.112.1667081245413;
        Sat, 29 Oct 2022 15:07:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.165.64.185])
        by smtp.gmail.com with ESMTPSA id b11-20020a056870390b00b0013cd709659dsm177759oap.52.2022.10.29.15.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 15:07:25 -0700 (PDT)
Message-ID: <635da41d.050a0220.7f252.0846@mx.google.com>
Date:   Sat, 29 Oct 2022 15:07:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4760926345018539037=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tegongkang@gmail.com
Subject: RE: [v2] Bluetooth: Use kzalloc instead of kmalloc/memset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221029214058.25159-1-tegongkang@gmail.com>
References: <20221029214058.25159-1-tegongkang@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4760926345018539037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690188

---Test result---

Test Summary:
CheckPatch                    PASS      1.40 seconds
GitLint                       PASS      0.89 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      41.75 seconds
BuildKernel32                 PASS      36.54 seconds
Incremental Build with patchesPASS      56.77 seconds
TestRunner: Setup             PASS      607.79 seconds
TestRunner: l2cap-tester      PASS      19.67 seconds
TestRunner: iso-tester        PASS      19.76 seconds
TestRunner: bnep-tester       PASS      7.30 seconds
TestRunner: mgmt-tester       PASS      127.25 seconds
TestRunner: rfcomm-tester     PASS      13.28 seconds
TestRunner: sco-tester        PASS      12.15 seconds
TestRunner: ioctl-tester      PASS      14.10 seconds
TestRunner: mesh-tester       PASS      9.79 seconds
TestRunner: smp-tester        PASS      10.80 seconds
TestRunner: userchan-tester   PASS      7.76 seconds



---
Regards,
Linux Bluetooth


--===============4760926345018539037==--
