Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726FDC001DE
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Aug 2023 09:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjHFJvu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFJvt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 05:51:49 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92190199A
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 02:51:48 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1bfce114ef9so368364fac.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Aug 2023 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691315507; x=1691920307;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/VUDCWHTrUSC45aF8XFs/czgBHd5Q1+rA+0ftuIR4sc=;
        b=ItwN+sGqDJnn3tcS94i5MCZVGGeY6U8hv6gxLM2XRKsMkAnR0sR3F4ur4ew2IWLysN
         /bMe1VzMHgNugSvGHH1oa8ZplX2+p69JiHFkqfEi+/tmKN5SXmg18h1psaYnrFMhuhkY
         MHFCq8mq7UMruynqW9W8rPo+vGbLhGbbv6s3jw2UK0uOSixAtdpigUZLbhLZ1EYekbEm
         q5TyMPaP75sAItljy58dLEI2j10dbxeSHSpkKQWrfys++6vSt97M+BUxseDn4luV+0PP
         3XtGgLwGTZvRr/eKgE4HmfJl+eJMQuWlZXVN7qJowbiZCOVKrnhScvXTM02UzQgBkf8v
         4nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691315507; x=1691920307;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VUDCWHTrUSC45aF8XFs/czgBHd5Q1+rA+0ftuIR4sc=;
        b=CX/l00ovdDaMzYg+l0n3vC+43JJJEqx+XDf2TmkmRRl7xeSpJBCZWl1CmsqNv9IXZO
         1teh++pwZW0lK35Wvt+Qp2/7OM+lvVESwOq1+CLLHfncFXh+Pl7ofcdHPTrs93h64G8B
         nZxqnYMQ1vBTFTQt7YwoYQciK9uyr6oaMyS3CQxhaT1mVC1gIxi6VZ81XD0lf89l430A
         QUgdYvq3VnXfs+0SB3g4DR1Po6Ulw3KOZD0PkcShNq8YfvfjJLsA3bXwk7XwABWiMutv
         JRdTbF+pwoWBp40dIIMsXKfjxlKJ629Yw9LjzOPZoEPiXADjhvLwREO7mIf4lSzMbU08
         LDrQ==
X-Gm-Message-State: AOJu0YyLJjFiZ7H7Tfr+8X7/pxuRO1plb+56RRRVE6WAqom3qOKF+Qem
        zEgq/3c7Wfc3AdgDtu/Ay2GgUaOCj2Y=
X-Google-Smtp-Source: AGHT+IG9l64vKd63pk9S8huP6ZkLhFrtRDgIj5w/dZK+atOMSyUaKVX3EmZsdZzfKuMafSu+JRn3uw==
X-Received: by 2002:a9d:61c8:0:b0:6b7:507a:e13 with SMTP id h8-20020a9d61c8000000b006b7507a0e13mr6416049otk.19.1691315507366;
        Sun, 06 Aug 2023 02:51:47 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.104])
        by smtp.gmail.com with ESMTPSA id y18-20020a056830209200b006b71deb7809sm3617192otq.14.2023.08.06.02.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 02:51:47 -0700 (PDT)
Message-ID: <64cf6d33.050a0220.3ed28.0362@mx.google.com>
Date:   Sun, 06 Aug 2023 02:51:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1889080970492991458=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Report proper error on connect
In-Reply-To: <20230806080109.1639693-2-simon.mikuda@streamunlimited.com>
References: <20230806080109.1639693-2-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1889080970492991458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773409

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.63 seconds
BuildEll                      PASS      32.96 seconds
BluezMake                     PASS      1188.84 seconds
MakeCheck                     PASS      13.56 seconds
MakeDistcheck                 PASS      193.65 seconds
CheckValgrind                 PASS      317.85 seconds
CheckSmatch                   PASS      443.22 seconds
bluezmakeextell               PASS      132.21 seconds
IncrementalBuild              PASS      2073.05 seconds
ScanBuild                     WARNING   1396.94 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/a2dp.c:352:8: warning: Use of memory after it is freed
                if (!cb->resume_cb)
                     ^~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============1889080970492991458==--
