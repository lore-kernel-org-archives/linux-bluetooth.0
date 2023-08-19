Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CFAEE4993
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Aug 2023 15:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjHSP4Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Aug 2023 11:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjHSP4Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Aug 2023 11:56:25 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DC61D755
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Aug 2023 08:56:23 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76d77d2ee36so127404085a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Aug 2023 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692460582; x=1693065382;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dnPjw+D1i+ZWBYACttyIfmea+/R1PEQJ9gDeztdLpKk=;
        b=ULanuiH2Hmwv3lA9nuswih2aXjgJEiJPvVCVhZUa249VK0rm4bEtjmJZ/Jkyc38l0s
         AH9p/qurCXuz+LiwHXdQqQeeAUGpBob41VKq58e9Wi/N6lFwrcWhVT4tAV5CfiyrZC3x
         GMneprJoJN8ox3ze4JC9LZRRSnm0dsYP8eh2TwLoYNw9dB+WiI6goZKE8rxs5kUIrzok
         PE/P6Tz3o4sazpVWe3j/7xr2Z8thhjXqC5eevMBHb7EyVBVjLt/CAEBSGQvzHyr96GEm
         jBHBlgEbnemKZAhA4pvo11wO1Nf6kbkAIZuF0h5k44MZqBch4sRvZ+AXz9m93BJBCg/T
         BfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692460582; x=1693065382;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnPjw+D1i+ZWBYACttyIfmea+/R1PEQJ9gDeztdLpKk=;
        b=DkRfpThXN12t0mp9kbMhwjBFYDGtGTvvGz1/br2VbrsRgwIfejYUJTh2hw/WZtWYkm
         ynV2vHY+fPZh1cMLH7RkQsT/nv/0a8xPHbVL9src9jWBetHsFdTKX+47UipKAhdsOM+g
         3xSnM/MgYya9jtcVY2WtHb/PV+ziP/PDnJ8cBKNPvguskRSivCA+//WNBAJoaNoM8sLK
         pWVzuE65GVQ8WnB8URG0dMDJD0ldgWpejlhzOTeS0bECcQrdtRRe7wP1yYxgQqC3ndi1
         tR5IBNuXAibzunE+uRvHAr0gG4AcTiyZDI1x1v3UGUr9WKifYhodC4G8WwOFqHTeP1J/
         mBow==
X-Gm-Message-State: AOJu0YzEGQ2ax+sXSJguQlIrErvYFSTlzT76NWPdblelATZMtaANJh5f
        1QIorCEQHlgrPh5Mtne86VDkqWa5c1HVrg==
X-Google-Smtp-Source: AGHT+IHG4fitZfD1umRBncYXvdzKD4HvWjUWE9LKxPIbVJjvihpxOQQ2WF+QqnuZ9Hi+w94RfFoZmg==
X-Received: by 2002:a05:620a:4084:b0:76c:bfeb:97d0 with SMTP id f4-20020a05620a408400b0076cbfeb97d0mr3198480qko.58.1692460582213;
        Sat, 19 Aug 2023 08:56:22 -0700 (PDT)
Received: from [172.17.0.2] ([52.240.53.67])
        by smtp.gmail.com with ESMTPSA id u21-20020a05620a121500b0076da0f81baesm67922qkj.35.2023.08.19.08.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 08:56:21 -0700 (PDT)
Message-ID: <64e0e625.050a0220.a8640.03e8@mx.google.com>
Date:   Sat, 19 Aug 2023 08:56:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1821578002973934830=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/4] vhci: Add function to pause processing input from vhci
In-Reply-To: <feaee15ebafa76155f6c1a91755d6d5ba054d451.1692451184.git.pav@iki.fi>
References: <feaee15ebafa76155f6c1a91755d6d5ba054d451.1692451184.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1821578002973934830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777635

---Test result---

Test Summary:
CheckPatch                    PASS      2.53 seconds
GitLint                       FAIL      1.59 seconds
BuildEll                      PASS      27.66 seconds
BluezMake                     PASS      992.12 seconds
MakeCheck                     PASS      12.10 seconds
MakeDistcheck                 PASS      158.27 seconds
CheckValgrind                 PASS      258.93 seconds
CheckSmatch                   WARNING   345.63 seconds
bluezmakeextell               PASS      104.86 seconds
IncrementalBuild              PASS      3340.97 seconds
ScanBuild                     PASS      1062.42 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,3/4] sco-tester: add test for ACL disconnect before SCO established

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (86>80): "Link: https://lore.kernel.org/linux-bluetooth/00000000000013b93805fbbadc50@google.com/"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth.h:216:15: warning: array of flexible structures./lib/bluetooth.h:221:31: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1821578002973934830==--
