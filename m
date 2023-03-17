Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E21C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Mar 2023 22:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCQWGW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Mar 2023 18:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCQWGV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Mar 2023 18:06:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F035EF0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 15:06:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o11so6765337ple.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 15:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679090779;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VyyxF3qd7P+7xH+chlpS9OwF+Po8SUKENrLFc8SUn1U=;
        b=n00tijxFVyqd9ye6eUDdrHD/8kDzYnZuJmIntBz4KOPNATbsRvD3lJkhLsYr6b7Mid
         n9VqFHMUjUiSx46gHxYvBKQiWULHf468Uw0FKC7HJerhui1ICFsQguw0/FPTbAdHdCR4
         cphAtxyVgV/2QN5/0ugbxODMIKA5SIxSbLJ34wu5jHNT4ll9oLsKZzGgbsfGSh1nesZK
         D/5w4FZiAneLBWMMfZc5aLXnfr/jAyxSPPcwQSu9akTtThz941zBQwHI82BkkZWRDT/J
         Pk5uh/vNVz/wcbUrZcKrvFD24+DgDkCGnPkUmJm6MqD5T6UwY0Y+D2VMza+oD/wyiDiz
         MDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679090779;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyyxF3qd7P+7xH+chlpS9OwF+Po8SUKENrLFc8SUn1U=;
        b=yQYCDWQcweBZeBWjyaOSr9M5gmV3wwUmURkB8K+OGB/uaCoDMWxFOAh5v/dLo2h0qk
         QjnR/XLpTNE1meNeHURl0yBUwa/nLJxsuB7nA7QOA2tXcuLUGWd/QZHDAEOw5xIRmrad
         /DKbZ4xHLbvD/NBwwsrkhcANo6foy4nxdaHs7SJ7LAyIrLttmeC4SE3t1HNifk/Z0Jcw
         Yg+ZXydV5TOjt+qKFZGxLSCoFU8oEGWP6S8LlembO1Rr/tOuJH5lADb8hrCAN+3Un8KK
         XRP1CgCN/YV4Wj4aHP46rfMLhxFsvbEPbONyYmm4vOyGSKF2OX8DRffwC0PNKreskANA
         zrcw==
X-Gm-Message-State: AO0yUKUHsUYn9bPUAMiLM6ysJp7e3+pHqbxAPXpnom+7FGKSGAWyNKg2
        emaC90vGXXK9zzgdrbeuiegVu4uo3JY=
X-Google-Smtp-Source: AK7set8Nwvtsft6pwe60tChapgRzKfxwsGt/kzOpmyd8UhpaZWXsedlZqGbNMmIjus5f3xA5qKlV+Q==
X-Received: by 2002:a17:90a:342:b0:237:e1d2:c65e with SMTP id 2-20020a17090a034200b00237e1d2c65emr9970893pjf.4.1679090779476;
        Fri, 17 Mar 2023 15:06:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.48.2])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090a4d0300b00219752c8ea5sm1822345pjg.37.2023.03.17.15.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 15:06:19 -0700 (PDT)
Message-ID: <6414e45b.170a0220.dac04.3c26@mx.google.com>
Date:   Fri, 17 Mar 2023 15:06:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4472320833735839097=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@gmail.com
Subject: RE: [BlueZ] mesh: Tighten IO and fix out-of-bounds array access
In-Reply-To: <20230317201741.203098-1-inga.stotland@gmail.com>
References: <20230317201741.203098-1-inga.stotland@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4472320833735839097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=731303

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      26.20 seconds
BluezMake                     PASS      746.54 seconds
MakeCheck                     PASS      11.33 seconds
MakeDistcheck                 PASS      147.81 seconds
CheckValgrind                 PASS      240.02 seconds
CheckSmatch                   WARNING   319.77 seconds
bluezmakeextell               PASS      96.35 seconds
IncrementalBuild              PASS      602.64 seconds
ScanBuild                     PASS      958.13 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
mesh/mesh-io-mgmt.c:519:67: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============4472320833735839097==--
