Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1CDC7618A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 19:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjCPTbP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 15:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCPTbN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 15:31:13 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D9900A9
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 12:31:12 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17997ccf711so3417532fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678995071;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xCVNUjJIK/pE64KiNIzWQcSRcZjiAFclkZLdtLeDI18=;
        b=fkNC2293K0H2xSEl4eA/83geVkoKRBhKmmMmqNGiNwo1wRbV4ge8JpEKTJxXEw65Ze
         Outvqldg13T7lXMYw8+OzwMOZoT7tRVGWNIaMU4pvKuL6H+Q+zjcbremq6v+JX26+Uxk
         XXmlHJ/+0O1b+9bnUL7NyxW0KotrMM0esgWASkcqCayk4G0fZHuo0Yz/ceOVWo09tyHw
         r/tkjR+UVaClv9CCZEWYivJooMUk7n2CRqwLEUeh0kRxPttnXvaKcOMscj7wQgNj5mx1
         f6oKetPj6bjRtCW/hln7CJ9tipbNw6lPOAUwX1CMsC/bUjhZ84xtkedmTo4xPdTiuemT
         87qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678995071;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCVNUjJIK/pE64KiNIzWQcSRcZjiAFclkZLdtLeDI18=;
        b=pekJifcxcGdgzb/QEArdRMNN3uiYnw4eLH676lmvb5rPyvWvqiJVGPFqbeWM3sOic2
         MAQVLoGNi+g14HC1lq91twwFKqbh6UJCB1i3SWrwqrfAogI+YEBkWTWb9qw1zIsvUADg
         bJbVz2YtcT5aVlDaamFUZJFSq+gs3WHSZdEF0bRFq4NBInpr+ycl/LovkOHHS9uwk24A
         OHEAbYMwd6d1D/alBy9OwJJri4d8OcFMGxBBMrkw456mj/UQxDRjONfjtJ0U1tN8Mj25
         REaiGHCHBm9PE3QoXfrzpZyQ4hWp/QOxqGgUEnUZgEWOn0v/KLzeIr3egqLTAGN6GBDD
         IfnQ==
X-Gm-Message-State: AO0yUKWBbfrZnNE4znRCiZhB9j57h3janb9N+kA57deTTygZowOKP8ok
        ZjM+HW2PWYGcoW6oLQmWutb31cy1jeQ=
X-Google-Smtp-Source: AK7set9XTIs9NQKQlpVM1Pp77mCV4LWUsWIUPLNRH4tEiGVkz6DRptH4Ah6Q1U8gM4PposeHgAHZDg==
X-Received: by 2002:a05:6870:41cc:b0:177:dfdb:76 with SMTP id z12-20020a05687041cc00b00177dfdb0076mr8989390oac.49.1678995071527;
        Thu, 16 Mar 2023 12:31:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.248.87.131])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d4803000000b0069dc250cb24sm206161otf.3.2023.03.16.12.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:31:10 -0700 (PDT)
Message-ID: <64136e7e.9d0a0220.91df2.19dc@mx.google.com>
Date:   Thu, 16 Mar 2023 12:31:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1164611547127931313=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@gmail.com
Subject: RE: [BlueZ,1/2] tools/mesh-cfgclient: Prevent storing duplicate models
In-Reply-To: <20230316180759.147486-1-inga.stotland@gmail.com>
References: <20230316180759.147486-1-inga.stotland@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1164611547127931313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730934

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
GitLint                       PASS      0.57 seconds
BuildEll                      PASS      28.31 seconds
BluezMake                     PASS      886.31 seconds
MakeCheck                     PASS      11.37 seconds
MakeDistcheck                 PASS      155.54 seconds
CheckValgrind                 PASS      263.36 seconds
CheckSmatch                   PASS      336.69 seconds
bluezmakeextell               PASS      100.41 seconds
IncrementalBuild              PASS      1489.30 seconds
ScanBuild                     PASS      1054.85 seconds



---
Regards,
Linux Bluetooth


--===============1164611547127931313==--
