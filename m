Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1686EC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jun 2023 00:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjFBAsq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jun 2023 20:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFBAsp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jun 2023 20:48:45 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7574FE4
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jun 2023 17:48:44 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75b050b75a1so139183485a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Jun 2023 17:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685666923; x=1688258923;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3TgFGs3l46uMOecvAJZ3ZqBAqzouNcEsvBBH9nP8/BE=;
        b=KaaaKPTz67VAoEt82Y9cnsCsgiWTo0PtH+NQcX6SSOHTmkg1/PilVTQekYEl2kvqMq
         N2u5pkyzM04WV3y0OhXUWwIKMpPNF0z+5DKqCz31y346X7T/wx3zsDspbwYjXjkQPXUU
         FVBPy1FFXvu4CxCEFHM09PgJZpxMIXxmbf9aCLBjYsWRc6JyiLYPViUbjnsoewFlTJnv
         pZTaWjBj66+o9kdY6SFGztykcMwoFRuQ6J8DJCoccMoUmYYUbzvXBSwFSx36wD52cd0C
         fQ2JvKP1CrVEdeKInulcrO0Q1kF9cIXFt0FMM/kolSyBkjXirT6criCpDRNOSQxWGSV8
         Jfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685666923; x=1688258923;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TgFGs3l46uMOecvAJZ3ZqBAqzouNcEsvBBH9nP8/BE=;
        b=jMWBD3oqFzR/b99oMRWe4O80Yojt3l6KP6SmHB/+OGDHssTpuAjC48HwxtXNPzMBHq
         w996Ao2oUOrvnuVAaWGf4MqOiwNd+hrucyKRPdna9C+zI/bFqvTw+0zhXkdYFyRQbmQV
         cTpCnu6RyhGEUdrqfTVKfw5FBtYRTXipS8BTRVDaCDsGZidJ+s5I1Nx6QaAAEtQs9lko
         AiHEQX3kb6j35971WPalG+8214JlxjFL8odSgHVzlH+M3eW5q6zr8L4cAkJOTm6X2uZh
         aHNtmzOGGlmG7uQRWo1aEh+QVL4fr8OC4m1xHNJcjPEDs+dBgzwtn6jay8M2uPT//sjh
         +ZSQ==
X-Gm-Message-State: AC+VfDyhfMVcxBNKucYFbyiXcfPUM2iGcVivgI1CQcxUfZtiHTCj0pZf
        ANO1nYSNZVHj0i2IQTuVQzh47I2m53A=
X-Google-Smtp-Source: ACHHUZ44pzKHrIO+FJpis9aIWlf9mnqhP3iYBT/nrnaBQ1c8OGy+Lc6Oj9V4urPyHfG2IFpUfNWTlg==
X-Received: by 2002:a05:620a:4108:b0:75b:23a1:417 with SMTP id j8-20020a05620a410800b0075b23a10417mr12283782qko.45.1685666923360;
        Thu, 01 Jun 2023 17:48:43 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.96.41])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a124400b0075b1c6f9628sm7292971qkl.71.2023.06.01.17.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 17:48:43 -0700 (PDT)
Message-ID: <64793c6b.050a0220.ba97d.a8ee@mx.google.com>
Date:   Thu, 01 Jun 2023 17:48:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4074723366658734563=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] monitor: Only print credentials if PID is set
In-Reply-To: <20230601233317.1419030-1-luiz.dentz@gmail.com>
References: <20230601233317.1419030-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4074723366658734563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=753319

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.74 seconds
BuildEll                      PASS      27.23 seconds
BluezMake                     PASS      889.25 seconds
MakeCheck                     PASS      12.26 seconds
MakeDistcheck                 PASS      155.68 seconds
CheckValgrind                 PASS      252.09 seconds
CheckSmatch                   WARNING   341.89 seconds
bluezmakeextell               PASS      103.28 seconds
IncrementalBuild              PASS      1456.56 seconds
ScanBuild                     PASS      1036.99 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============4074723366658734563==--
