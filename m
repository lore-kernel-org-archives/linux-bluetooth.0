Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46330C77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 May 2023 21:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjEEVTy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 May 2023 17:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjEEVTk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 May 2023 17:19:40 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FBF525D
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 14:19:39 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-18f4a6d2822so20116635fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 May 2023 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683321579; x=1685913579;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jgd1X+Gu5xjFnPIfNtY90lsd8GnVU1hNOYE8UcegVDk=;
        b=TqQDmxY170Lfgd8MFzVeKhPFf8MLepptV1VDjBxoIVo5g9/yPzWRom9n+vA9+M+Ytt
         exLlJ9FBU5Gz0HKw5H5AeXst7XuidkQolbDDSfHLZiLDl1AocJeoKuTO51M3iF9rG0nP
         L8W/XnwmL7NNz9Zj+exaYnQuVT3qD+20KPAKlHSKmREEQmgU7XP0u29ZFcp+9neLa5YH
         FrLk2kLbycNIMkYlbGdEW4kF7KPvUiAdaw21SaFRGM8LFEr3u87RXpoG6Og/w4K9aZe1
         1QD2YpqxwTvhTJG8m8fYxLVkcAi0fC3+Tna88mC/w8Yz2KOjj+yISfj2bzuSb5+xsl8C
         QWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683321579; x=1685913579;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jgd1X+Gu5xjFnPIfNtY90lsd8GnVU1hNOYE8UcegVDk=;
        b=agY6DGEKlFLWhjLX2lquucCyQDFNrXJRzS1npsXj+BC6REuU6Af0BCt3cfmVYX7n/u
         G6xP596IyL8erom22D60/O0MJ90geP38YuyKehKMumuBfgAd4UULg4TjWXnQM1sG5W26
         +k5zObwlPYhFqTB7OUklkNzKtgz22ayJav7+e88FOj1HUk4sAx+ZYbNcSFfKP3N/ib3H
         Tgw/8u9sl1/acJsP0cUN1yXt2ltI+k5ajddjryNuCcVIzs9mmkbCgGWFkp+obChy4Aho
         mtSG4t0a3ZvB/zHZwAJf5cX247eNzzIeXE+ut9X/tYbUDsb/98jn3OWZyBGp8fzby4xb
         jFaQ==
X-Gm-Message-State: AC+VfDyou8G4IAHJMFnJ8I2lJ2Djet7QLx7F8wFda2i1KaZYj66N0sCS
        Z2hZAIQuFOKFXDYUv6bjN2CAwn5wfps=
X-Google-Smtp-Source: ACHHUZ4uBZFEmom8GdytrR722Txe1P/VvZcdd4VthgvDWtehUEv+VYvIflOwNe3ruy3ELAlM688fPQ==
X-Received: by 2002:a4a:c905:0:b0:547:62e8:c5bc with SMTP id v5-20020a4ac905000000b0054762e8c5bcmr2070247ooq.0.1683321578612;
        Fri, 05 May 2023 14:19:38 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.219.151])
        by smtp.gmail.com with ESMTPSA id j16-20020a9d7690000000b006a6558ef17fsm1336652otl.30.2023.05.05.14.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:19:38 -0700 (PDT)
Message-ID: <645572ea.9d0a0220.a907c.75e7@mx.google.com>
Date:   Fri, 05 May 2023 14:19:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8000969334449018789=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@gmail.com
Subject: RE: [BlueZ] mesh: Update the behavior of --io option
In-Reply-To: <20230505193931.106760-1-inga.stotland@gmail.com>
References: <20230505193931.106760-1-inga.stotland@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8000969334449018789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=745379

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      31.27 seconds
BluezMake                     PASS      953.63 seconds
MakeCheck                     PASS      12.38 seconds
MakeDistcheck                 PASS      179.73 seconds
CheckValgrind                 PASS      291.13 seconds
CheckSmatch                   PASS      381.59 seconds
bluezmakeextell               PASS      113.70 seconds
IncrementalBuild              PASS      758.30 seconds
ScanBuild                     WARNING   1182.91 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
mesh/main.c:161:3: warning: Value stored to 'optarg' is never read
                optarg += strlen("auto");
                ^         ~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============8000969334449018789==--
