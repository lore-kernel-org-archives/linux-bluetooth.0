Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A24EC875D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 21:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjIGVUy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 17:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjIGVUy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 17:20:54 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949BEB4
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 14:20:50 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76da121478dso76890185a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Sep 2023 14:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694121649; x=1694726449; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/5wiyXik1w6gRRecdR/HWw7EvTIzSL9NcgUGbGKPiQ0=;
        b=BKWIJaA6jonFd1kzhjzsuaqzbeP4n5SX2fYJW0B1H9FCCFbsdFlMUHh5q3QAEjwH9X
         2gqWzEwcfGwcgTuGCjkUU4pCbGhPO9zYD8rnop/lS4zwDAapKq5aLmH08L2pCn47jFU6
         s7qXIKE5TCT/j9UbCcoTsoPuIbOpJ5EdNOBdq7XEY2hEpbQhLjr4agi4mwAvVywTI4Xm
         wbTSfrdALsKlE6Z34aIVswr8ABXJzpu4e2jSWrPi7h59UlwRmtofQh3J+EgW6+qEEjl4
         E9CD1/T/cTUOR0h5onuC/q1T3E4OfkL3kIBUXRI5bRFLnvVldJnlVLMBE+YaNUrGSAKH
         gleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694121649; x=1694726449;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5wiyXik1w6gRRecdR/HWw7EvTIzSL9NcgUGbGKPiQ0=;
        b=qRAogMCSccbSufYtpx1mfWHHaOldn71pNPsQPD2C8w4pE0hsJz7deXL8VFkIpVQuId
         s++/8U65xgQxga6qqYpk0coPm4of9SCVxHxOSBEIbF2cmWly5RhFDajZ2kGHsogLYyn1
         tAf9Tof76fPasVbcpZHWN0XRS7CEj3aJFzKNzWxkG6RGNCrub7m+RJll9VgEKs7/P/nl
         MaKuJHPpFzGLhrxAevS6EZveZguEqKr366ocO0XxJIzi5j7qIxrGlBP2p6IF/5XiYV4w
         Y+aOBTnmcaY/K7bbXQA5qaU38pM57i4TkqC+/1uTeHLSYj9yfvXXGyxzxx6TTuXl687W
         DwsA==
X-Gm-Message-State: AOJu0YzUrkH+Mu43/Idb659V4XUDpl/ywQ8h12La5JF6qyabZ+Wv5edz
        vYffhuwSoEUW9v0yov1sLssRX15MTOg=
X-Google-Smtp-Source: AGHT+IGTZXpQ+jcGDeUHqRFJyzEB6EqgkDxzI+qo3An302RpGjBNqyhagMJTU1oP+rVB8uhCvGr1/Q==
X-Received: by 2002:a05:620a:40ca:b0:76f:135d:ce08 with SMTP id g10-20020a05620a40ca00b0076f135dce08mr756084qko.57.1694121649377;
        Thu, 07 Sep 2023 14:20:49 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.6.19])
        by smtp.gmail.com with ESMTPSA id p18-20020a05620a133200b0076e672f535asm75609qkj.57.2023.09.07.14.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 14:20:49 -0700 (PDT)
Message-ID: <64fa3eb1.050a0220.c6752.0503@mx.google.com>
Date:   Thu, 07 Sep 2023 14:20:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6929028091161248338=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] main.conf: Fix printing errors for valid options
In-Reply-To: <20230907194134.2242634-1-luiz.dentz@gmail.com>
References: <20230907194134.2242634-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6929028091161248338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782332

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.71 seconds
BuildEll                      PASS      26.76 seconds
BluezMake                     PASS      775.48 seconds
MakeCheck                     PASS      11.57 seconds
MakeDistcheck                 PASS      155.78 seconds
CheckValgrind                 PASS      251.36 seconds
CheckSmatch                   PASS      340.71 seconds
bluezmakeextell               PASS      103.04 seconds
IncrementalBuild              PASS      1309.56 seconds
ScanBuild                     PASS      1018.30 seconds



---
Regards,
Linux Bluetooth


--===============6929028091161248338==--
