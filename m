Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34A2C7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Aug 2023 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjHYWM6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Aug 2023 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjHYWMa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Aug 2023 18:12:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6899E2120
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 15:12:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a410316a2so1171628b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 15:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693001548; x=1693606348;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iOAYbJpTF0Ffc909HyT2MEPvFfYo6lqptiYrOrgddic=;
        b=Uz0biMLG3wrUyKbyaet0SuiR2cKWbDIxVMvzYwz+LQiRN3cJKPTBfQ5RKYv3Jatatz
         IOrjQzv1QEGEZwv+acUpveISVq8u6MEMBBPGkA/2kxxrfXp64S5vJsnrmc+BIn/BeRWa
         MrMmpaIn1x5L1mRR9eNu55+M7f+P8ubgM6nXpAoOTdaYfA5rmIX3Dalw/JzAsQbaTR+Z
         tWRRgOLutfPsvDBiIIRi2A7+PNUiCHre0tJgU7Gheh4g0MhvyDX3XdN0YVzYfTRWBSmK
         P/SERlMXoLq1U/AIuZvpPzTpJVmPOqgOixLCuJDR6DP3y/yE27ysb076ed0n/jN6Bw43
         dYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693001548; x=1693606348;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOAYbJpTF0Ffc909HyT2MEPvFfYo6lqptiYrOrgddic=;
        b=MfClF1Ng287plKInsKxPcA91lJUvTJF/TOlLPQXMn8BMn+73/OFSyCcpJ+VNrzxYkf
         Nlkiy9DD327wyBFhn7djvhCCKw387jFFMPQzG7dmbHVNm8SFNTavM4jcwrkt/asIKhVb
         0fb0Has45nb7zG4fjjlZBgPBt1NM/jxwIwwJV1yRjdHjYOinLDk/U5A7PoJYPYXhzY42
         iPNUb1C5eGwsDEMCYoWN55ov5y+w6MYAelmi8ua9s846pHDuWPGk6tBNZq+oKyvGbJ3F
         88/NRUbRSSpDsqNMvcpWr/Hsxua1wL781Ca/Qnq/icBKNdIUZkda+/qSSZJ1YIt/apTj
         hm4Q==
X-Gm-Message-State: AOJu0Yyyu30wvlGf0X5wmYgrwC9jSnvy2SPo6S+L4Oc3aYx0q2gjB205
        9ZGBgM+3ekbfo8mFXJqsEgP0UOTxyLU=
X-Google-Smtp-Source: AGHT+IElod9R6o7TK/C/jUBonqUv9PsIrhthTeIWOp4mj1FLhtnjBL77citX3KOpCG+zNNY7RjFlNw==
X-Received: by 2002:a05:6a20:3205:b0:14c:c9f6:d67c with SMTP id hl5-20020a056a20320500b0014cc9f6d67cmr865222pzc.28.1693001547519;
        Fri, 25 Aug 2023 15:12:27 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.101.162])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001bdb85291casm2254272pla.208.2023.08.25.15.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 15:12:27 -0700 (PDT)
Message-ID: <64e9274b.170a0220.f389.44c0@mx.google.com>
Date:   Fri, 25 Aug 2023 15:12:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8118042427256072022=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_sync: always check if connection is alive before deleting
In-Reply-To: <43b78eefdc31e0ac1b24373ac71ef5a8cbb092f5.1693000169.git.pav@iki.fi>
References: <43b78eefdc31e0ac1b24373ac71ef5a8cbb092f5.1693000169.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8118042427256072022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sync.c:5374
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8118042427256072022==--
