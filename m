Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC82ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 03:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiIBDnk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiIBDni (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 23:43:38 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D87B08A8
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 20:43:37 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so645269otq.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Sep 2022 20:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=gMnUfGhZut29hwu0BG/R/OVhE2fWLz4RP0qcU764INY=;
        b=I+CYVFTKtM4X48OMDU6kAkMJ2wMRjfdbTJcJEUGRFCRW3abwU1GzRlODBPXPTEFdKq
         PJ3yu9MRlahvZccft4N0Rl5QfmKWCdgjOrt+EoCNFY+JD6+CSIwV8XTXavvxYESMRt30
         ycCWG3sieKoGTQTi0PLimuHg/EMyNYM5HUnTzAHBGE3ArEkrhp1qDBTy38ntW1No+AN/
         5vctOqDdTTtRYPhMsJFovGTTkRMk5oO+it2NcDwzcwbvoMjxX4YgEtUkzsBaCUcR//+G
         O+KFjUwC33WyHTbW8xqVsEkUMWFERHCtvyJwl0f8N2vFKcTfHTVRcJJK7YJcDzdqLqH2
         KMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=gMnUfGhZut29hwu0BG/R/OVhE2fWLz4RP0qcU764INY=;
        b=XwP08QTG9aK/oxi7hj7Swax7fCP/nkK8rQYbm5Ykwi/mIEvHkMgPVLc7CjPS6cC8wN
         DsmvX1GCorqOuBsDiLYQYZMrHkCktYZVgnDmnmtS2LhUKHgk1jIhUttQAz9XqqcHO67t
         8CySeoxU+Lmw8dd9W+9B78K1FrBlcFnhlfM6DmyrwPRRhGBAUntIhOthhBDYDyaCwCLn
         F9Kvkq8Ihu9+iRYlwZEIraqrf7N8r8Bizkyhz0p0Z9qnoWPeAPJw4Ra53LQDkxqDrq0Y
         SWZMJwvSOJsJdINuJrBy6kb1e6mhjk+3PsY77IThRBiZFyQBiEIJAHhtnSV1FBUYmNdx
         fWPA==
X-Gm-Message-State: ACgBeo2MBF7ci6Adi7K6PVFtzBJhcjRYsKmqfpVPWQuRTraELtSgr6KP
        57K4MOu98iMvr59xCf/opJJLRrLld/g=
X-Google-Smtp-Source: AA6agR7AzRExEezUGx6soCqA1OE0Ecx2Sz31kOOhRwXSghc7FWyBwjOjgqqgzTYVzrUBnBVsk9WK7w==
X-Received: by 2002:a05:6830:9cb:b0:616:a9b5:df50 with SMTP id y11-20020a05683009cb00b00616a9b5df50mr13660022ott.306.1662090216616;
        Thu, 01 Sep 2022 20:43:36 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.137.18])
        by smtp.gmail.com with ESMTPSA id 79-20020a9d0ed5000000b00616e2d2204csm514232otj.21.2022.09.01.20.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:43:36 -0700 (PDT)
Message-ID: <63117be8.9d0a0220.7ad1d.2303@mx.google.com>
Date:   Thu, 01 Sep 2022 20:43:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2746611659426952030=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix hci_read_buffer_size_sync
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220902002717.1823748-1-luiz.dentz@gmail.com>
References: <20220902002717.1823748-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2746611659426952030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=673423

---Test result---

Test Summary:
CheckPatch                    PASS      1.35 seconds
GitLint                       PASS      0.75 seconds
SubjectPrefix                 PASS      0.60 seconds
BuildKernel                   PASS      46.55 seconds
BuildKernel32                 PASS      41.29 seconds
Incremental Build with patchesPASS      59.54 seconds
TestRunner: Setup             PASS      679.00 seconds
TestRunner: l2cap-tester      PASS      21.10 seconds
TestRunner: iso-tester        PASS      21.79 seconds
TestRunner: bnep-tester       PASS      8.44 seconds
TestRunner: mgmt-tester       PASS      131.39 seconds
TestRunner: rfcomm-tester     PASS      12.32 seconds
TestRunner: sco-tester        PASS      12.28 seconds
TestRunner: smp-tester        PASS      12.15 seconds
TestRunner: userchan-tester   PASS      8.71 seconds



---
Regards,
Linux Bluetooth


--===============2746611659426952030==--
