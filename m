Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1493C76195
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Mar 2023 17:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjC0RJ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 13:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjC0RJa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 13:09:30 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14535A9
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 10:08:51 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id s1so4947810ild.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679936931;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VU3eQogz9e50c98trN0g0Z7+ypk8xQ+S9FN+5AS9PPQ=;
        b=lrOEJha5JfJ2pnjzi+ICQ4imjgG9Zrs71E05r2Xgz99ih3pQyyjsjGeOJBUVjBMHMS
         MiUiXzzmpRGnRRB8UWphSB6ekVA7Rq1EEHsdBZUB4klN2xRSLj9L1YZBtUEIwhjjgyH0
         H3sc85ymdtyZm/YGQGoF9abAkqXk55ryXfa+DWfaDaKuy+QPPlO7KflZkva2zuMzkgv3
         Fm54VwMWRmYqlq0AD0/5TiSodzr4Cw3Ix4UmCmU+7Lk6bDewe46COkImws6R91CVXttG
         P6bry5NDsGwC3u8DBthCeVDIw+yT3uOxiEvzBM+hf8qRDrd+M37HpZwQTwECYM5k6W7e
         TnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936931;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VU3eQogz9e50c98trN0g0Z7+ypk8xQ+S9FN+5AS9PPQ=;
        b=QTxV8IvImsKMMHQ4myyPNDCHNHG58VXOvjLbMAsKjzv7aUuB9TSP4xECfUS53TliG2
         NtNyP+lU+f14x/xUDx6gpboQ2wsTIWmtICKX6e+A2RxrEOgpm0RIzkqWUEsq1Gl2Ts2u
         tz2iMK0BKacww+s6WhD4BzFQ7nkAnS09EzYUbBmpoGUvoUdVLcgdeoPMYMNYUlBM32fM
         yoy0wwZU+HQKlI7gOvS1jfSE09/ErMKwH7dUVlZXtCXIlwYPl1Yhho0kL5lPtEG6ggu0
         8BIHoU+fA6kQCkJshXuhaq7Dqk8DiTGlqOj/g1+KhaIB24H3RMK0Fhl1ct9YUVK7dHll
         EAoQ==
X-Gm-Message-State: AAQBX9cp2rMAPu1clg6JlYooQEiu9GZdVonQX66ggJEjN4A1EaXI/ptG
        AKd3czQkFLORGQdz63rvOIr/XxrKHF8=
X-Google-Smtp-Source: AKy350ZKoW9FupNMRJ3JC+AlfAnJhOBKgMeeeLcv2LoALB/Kr3gLxXFWKjiSs8ERBHmSbBPASlr9iA==
X-Received: by 2002:a92:d30e:0:b0:317:9d52:23c7 with SMTP id x14-20020a92d30e000000b003179d5223c7mr10044004ila.16.1679936930943;
        Mon, 27 Mar 2023 10:08:50 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.28.133])
        by smtp.gmail.com with ESMTPSA id y4-20020a92d804000000b003231396e317sm7915646ilm.88.2023.03.27.10.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:08:50 -0700 (PDT)
Message-ID: <6421cda2.920a0220.6f19d.ead9@mx.google.com>
Date:   Mon, 27 Mar 2023 10:08:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7367377807165753455=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: NXP: Add support to download helper FW file for w8997
In-Reply-To: <20230327161424.727785-1-neeraj.sanjaykale@nxp.com>
References: <20230327161424.727785-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7367377807165753455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=734230

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      42.20 seconds
CheckAllWarning               PASS      45.77 seconds
CheckSparse                   PASS      50.86 seconds
CheckSmatch                   PASS      138.38 seconds
BuildKernel32                 PASS      40.35 seconds
TestRunnerSetup               PASS      585.06 seconds
TestRunner_l2cap-tester       PASS      19.93 seconds
TestRunner_iso-tester         PASS      21.10 seconds
TestRunner_bnep-tester        PASS      6.83 seconds
TestRunner_mgmt-tester        PASS      131.14 seconds
TestRunner_rfcomm-tester      PASS      10.73 seconds
TestRunner_sco-tester         PASS      10.21 seconds
TestRunner_ioctl-tester       PASS      12.70 seconds
TestRunner_mesh-tester        PASS      8.96 seconds
TestRunner_smp-tester         PASS      10.04 seconds
TestRunner_userchan-tester    PASS      7.53 seconds
IncrementalBuild              PASS      39.36 seconds



---
Regards,
Linux Bluetooth


--===============7367377807165753455==--
