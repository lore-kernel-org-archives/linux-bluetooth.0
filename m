Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4013DEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 20:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjGTUeE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGTUeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 16:34:02 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A98271C
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 13:34:02 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b9aadde448so1006620a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689885241; x=1690490041;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M/Xw6Mow1vHQU1D1ZE9oEbqvJJHgPIbPkK0wifhkHk8=;
        b=d6cd2p7cNwE+FZKonE6Fv6lNIwQkxveMbQAYFIHscGfX7RTdEPNWIYS1kO+hakM95e
         q6/QzyPHqx54IEiK7LJvIZ5BT8wSvrbHVQaBMRp3GbY4JjqwIAKWRNz0sbJbx1C3wGcM
         pXg7LxObwcNLGiKv9sCqCpG8K4CRpzd/JGuX8TP/1kcNOTp/mRFCX6IV8e0e3bQT/C5V
         LWe7TdTE5ZECMFPRLKk78RB9zCrIx6klzclVLAJtN+m38n2I8mxNzdVi4d+/tclz5ljG
         lDHb5I84csUBDTuqzgVkg457dVOOYCbjkk1v9jBBLFvEeu/QqNiTpEnhIvO/ZXOvcGFK
         mUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689885241; x=1690490041;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/Xw6Mow1vHQU1D1ZE9oEbqvJJHgPIbPkK0wifhkHk8=;
        b=ECljWZZrqRHfLMssxQLPhnGi8yWgEPHOZHyMGdHgNS3T5sMgZJzhtvzq4aKebtpdqm
         kc2pHT/V2sEJ9caH6TIcvX28d0QSAI88361slYnVHcUCP3BxGYPAuADVgsiKdVBW+tME
         Ya+nKNvOk7Pc1CkNiN6UF60oOpUi1UQMQVk9TQs5ZLZGpQepMt1s6cm4uAbaq76bFLSL
         8LWTPGHoIsPqPHw1WtDCKRruESeNbSOEIbVy4LdezSfc+fouBpYFWZZspE4uqM+Bfzib
         bpjUQgKfsIyLngQaDQYoePGrT5FQHFPEn8nOPJU9286pZtsTPxxgyfsVh/Xvz6oW8xap
         e8xQ==
X-Gm-Message-State: ABy/qLbyTno1Z2sk2T5Y9YNTzXA561sBPqTZV0Y/StrHyOn3vokjF5tj
        xMWKqgVMgfSbfRxMnm7TV2Ug1v6WA6M=
X-Google-Smtp-Source: APBJJlEbWMOFKhgICiUOad9Of1PyBeF+XPXCMxQNr32eo+U2hJN2cyXwcSYuqGjIBwfg8JPXDCETjA==
X-Received: by 2002:a05:6358:5286:b0:134:c859:d32a with SMTP id g6-20020a056358528600b00134c859d32amr25198464rwa.25.1689885240972;
        Thu, 20 Jul 2023 13:34:00 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.166.8])
        by smtp.gmail.com with ESMTPSA id y4-20020a63ad44000000b0055fd10306a2sm1628834pgo.75.2023.07.20.13.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:34:00 -0700 (PDT)
Message-ID: <64b99a38.630a0220.88068.30fd@mx.google.com>
Date:   Thu, 20 Jul 2023 13:34:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5417203488835723242=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v5,1/3] btmgmt: Add man page
In-Reply-To: <20230720190228.446570-1-luiz.dentz@gmail.com>
References: <20230720190228.446570-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5417203488835723242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=767959

---Test result---

Test Summary:
CheckPatch                    PASS      0.85 seconds
GitLint                       PASS      0.63 seconds
BuildEll                      PASS      27.34 seconds
BluezMake                     PASS      869.18 seconds
MakeCheck                     PASS      12.10 seconds
MakeDistcheck                 PASS      155.09 seconds
CheckValgrind                 PASS      255.49 seconds
CheckSmatch                   PASS      341.65 seconds
bluezmakeextell               PASS      103.62 seconds
IncrementalBuild              PASS      2135.20 seconds
ScanBuild                     PASS      1040.36 seconds



---
Regards,
Linux Bluetooth


--===============5417203488835723242==--
