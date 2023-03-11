Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE668C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 02:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCKCUa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 21:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCKCU1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 21:20:27 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B6FFBC4
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 18:20:26 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id a2so7550760plm.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 18:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678501225;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mV3jZdrLVmfnyl9URb0aYcIAE9u+tcApi+XzWiv9KAM=;
        b=ZC6KtTACkDF38xUnWhrKBAdyvoPuzja+eNoMWmhSgQSeTmeQoezNYrVJEDknzxAgO+
         +7GiHyQWfQ8xy0k0njRq08iYahpq2tT9l5O1bMbyLc2P8xdkL+n/rx/9grYhHNVQSnIR
         No64Yy/Y86FpfBk+a/1V/+8VSrbp3yVIiRIddfFfv/YcQsYmidiujpgmxG7x0QowCo/F
         mMx1+6p0TIFt818HCovzh9+5HYeK+ETrPy3aIxQpIUDblZKxfwNug5d4ZROVE7isQImZ
         Vw1GzfPtyXagvtrGGO+Z2AF4TzqZq9vZLWqjjXPQb4+fexlnS+ZBSIVoNVvqH81YsC0K
         cWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678501225;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mV3jZdrLVmfnyl9URb0aYcIAE9u+tcApi+XzWiv9KAM=;
        b=NJQtKdOihR+XXbF9875XFvFn4r1E7TJx1vIJ93sTR9CtmUNT0FtL9B/wJwtzIOcGDS
         pnWWk8B1g/ivQvd8gCgyVBXc6yp01PKTMKqTsLYsSPU8vQlw2L+jHCkOYd1VbvwWX9wa
         vDrcgPhNThM4YYUdAZvTPnbDI7szCyKRIrBoyArh4tXWFB88vKXVQbTz6R4J/IlIy2OA
         rTIOjGgJ+HahUEGI9ZLcuGSJKJQrxhZTFCpiX67z7QmSqbcyHvErreuvZ6mMkXc11kEd
         D4afwU7wqGC1FLkUtymZp5HO+z+Ter9fEJklyFuoVUOBrDSpc2n8IPmCo2PLU7b4heET
         ckhQ==
X-Gm-Message-State: AO0yUKX5SBwnwuTzHKyueL5q07dBDUFG/0NjAE5JjSaVJPtOEbtoPaER
        eE4Yq93LsRhGkyDhqlZGe4Mw4U3hpKE=
X-Google-Smtp-Source: AK7set+cgb45V/GqpuvR3JNAeGFqIlOWivHpSO9iyMhQ8m+tLMfGlu3QxUPlZ0reGEOxRIz2bxAtxA==
X-Received: by 2002:a05:6a20:8c0f:b0:bc:f336:98ed with SMTP id j15-20020a056a208c0f00b000bcf33698edmr22799699pzh.45.1678501225501;
        Fri, 10 Mar 2023 18:20:25 -0800 (PST)
Received: from [172.17.0.2] ([138.91.87.25])
        by smtp.gmail.com with ESMTPSA id b4-20020aa78104000000b005abbfa874d9sm423161pfi.88.2023.03.10.18.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 18:20:25 -0800 (PST)
Message-ID: <640be569.a70a0220.68aff.17b5@mx.google.com>
Date:   Fri, 10 Mar 2023 18:20:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6263770465519795957=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/att: Use a short timeout for EATT bearer
In-Reply-To: <20230311004720.4017529-1-luiz.dentz@gmail.com>
References: <20230311004720.4017529-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6263770465519795957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728985

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      33.71 seconds
BluezMake                     PASS      1133.27 seconds
MakeCheck                     PASS      13.21 seconds
MakeDistcheck                 PASS      194.10 seconds
CheckValgrind                 PASS      318.11 seconds
CheckSmatch                   PASS      423.77 seconds
bluezmakeextell               PASS      125.30 seconds
IncrementalBuild              PASS      954.53 seconds
ScanBuild                     PASS      1395.38 seconds



---
Regards,
Linux Bluetooth


--===============6263770465519795957==--
