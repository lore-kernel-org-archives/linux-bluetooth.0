Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FF5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 18:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJGSWD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 14:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJGSWC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 14:22:02 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D87BC61B
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 11:22:01 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id a2so2892237iln.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu6emep6OtsncTAzwUnSylFhKX2Qn4L6W27XEnM1n6Y=;
        b=M3wwQylEbSeYOQfnhXhas+FFyu2Pz3u1u5Jzbv3tdR5gGo6+yXI4gygIJPFYVL3ht9
         6b1i5jnOoqnHtMey/m8NR6XT5++h+k59UkK3BgWnmfVlq92Qko/q1D6Ut+rXCsmQzrDD
         d8MmpLgFcdw7151ID6aK5iMjQr+jjYEa2wUh0duXWDJac+E5U79NeH9MvekdpqiVcxkb
         aiT70PsjaRrcLO9zZVjtbq6YTz3TPX6Pm3Xn7am5BeHoct1JkG5ZsjKGY5X1RQ7+BpRP
         pdLsFUR6lHGPNJ4QVpM7I2EMVirbmpBBbM4Sa8kzVioEeI9+y0uWTMIyI72MsDYcJVOx
         Bz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vu6emep6OtsncTAzwUnSylFhKX2Qn4L6W27XEnM1n6Y=;
        b=FB/zNwJXvZ4OoSF1sR3r0eNqlLUapupkjlk3m4hgiqNVHKSP2OcCMjJUhsU1PO8eMB
         gYBbJ6gT/WgmCU2FrYs+7RCsPx55M+ZjjlW13rxnJbKwgCQ91lEjAfB0nTT6Peih7DfE
         EzgL8xds3oj21s2CYL3LkEzfGhxDCGynERh3d0NcMjH9pbqSSlGJU9tFoA/GIotEzIv/
         NYcqBGgzY309YnfnsdUohDYOv2ukmBBdyPSyHmwxi2tw6cPr0WVoyXC5xMTFlLg/2ADL
         1Nm9IySYT02LUyueZsGeik8vTORtQlg9iGrDSOxLTbSoT1FsehrpdjxOkxfh1zCjrbfw
         7MCg==
X-Gm-Message-State: ACrzQf1VBF1c5ulg6cY9UfsSxsG7/s6Jibwg9ncEkcWTGSZSm06BETW3
        be37RTSajVQUQ5jKaWvuz1n9/N9NY4Q=
X-Google-Smtp-Source: AMsMyM5zw1k52Od5ho/bU5x6w0iIYZ0sGjpEQ1/+yVZvkjJPx/ZnT0JLDxmiqrLHnjJzp9UElnNDig==
X-Received: by 2002:a05:6e02:1c2b:b0:2fa:569c:ccb6 with SMTP id m11-20020a056e021c2b00b002fa569cccb6mr3002317ilh.291.1665166920928;
        Fri, 07 Oct 2022 11:22:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.0.84])
        by smtp.gmail.com with ESMTPSA id q11-20020a02cf0b000000b00349d33a92a2sm1102664jar.140.2022.10.07.11.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 11:22:00 -0700 (PDT)
Message-ID: <63406e48.020a0220.22cac.1600@mx.google.com>
Date:   Fri, 07 Oct 2022 11:22:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8758378503931527903=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhay.maheshbhai.maheta@intel.com
Subject: RE: Bug Fix for Memory overwrite
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221007174516.22335-2-abhay.maheshbhai.maheta@intel.com>
References: <20221007174516.22335-2-abhay.maheshbhai.maheta@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8758378503931527903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683768

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       FAIL      0.79 seconds
Prep - Setup ELL              PASS      26.37 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.23 seconds
Build - Make                  PASS      738.27 seconds
Make Check                    PASS      11.82 seconds
Make Check w/Valgrind         PASS      288.32 seconds
Make Distcheck                PASS      235.30 seconds
Build w/ext ELL - Configure   PASS      8.28 seconds
Build w/ext ELL - Make        PASS      83.71 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      511.94 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,1/1] shared/bap: Fix handling memory overwrite during ASE Enable Operation
1: T1 Title exceeds max length (81>80): "[BlueZ,1/1] shared/bap: Fix handling memory overwrite during ASE Enable Operation"




---
Regards,
Linux Bluetooth


--===============8758378503931527903==--
