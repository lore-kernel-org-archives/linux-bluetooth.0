Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D53C32771
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 09:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiHPJHC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 05:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiHPJGT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 05:06:19 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFC0B942D
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 00:22:54 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l64so8569670pge.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 00:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=lk5AEJoWR9Bc4Vw8lp0svXaxZfxDjOYFGj5e5f6qc3k=;
        b=aJdkXX9keCmi5nu059TcfE2qjF9n0A3/DnAEPBEa/nd3jeE1/xVfAqlrkXYj2oVSae
         70xOgJz+8fQmu/ROp+4PqtJOmBfdM/PWXJXo/+XMAEDSxkjNxUeW7cEJTU2hCcCNQKPv
         WlQdhCFGpDODEz0JSbVFl2ufcOxI0flztY/xk8d/Jqa7Y6J9SFfgSCJIPRumAXmosI/T
         0d45a/LRuLJ8C9gY6LT9qCIwbIv8J2Yyru47iMHGDRuoHgxOyyMnX1il1m00POeYJO56
         Up7Ox8K0OAIhi+VQKpIM8A2D7D162SoIMN3cnIzGLEbR2bMjgZnJ9Ydra2dfzO9urMJ5
         PHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=lk5AEJoWR9Bc4Vw8lp0svXaxZfxDjOYFGj5e5f6qc3k=;
        b=tIP45Q4timZZ/w6+6OB6x7Roe1QKQlRQriM6COdmlvr31SDe5xrRTrhCpG3Xd/SDd0
         WKzMNsKwK+sbxNjjhizGb6S6Pi5P68MAPN1iO0d9k/2Pe8wznt/4b4IN8N66nxaXHndm
         Mk8i0TK3CQMdiWwnaSBtd6UDNibYdrf/vcXjtJU+jiTGIGcNjpFM7pGFZasZZ2GdRSIN
         IBRKZGnfigqf9X6AARzE7aXl23fV3wILJVOGI5dGImWbxp7vM2vKm3y+i0L/SUNygxmZ
         8zBDUuqXKEr91if2hhx+32+PYbTrhNBQTKuo1Xc4UcSAeYX/6aRPe5vyrdrqgMSKZQRf
         mc9A==
X-Gm-Message-State: ACgBeo1qN60nYyb4Jt5dc0kdsGkzXSmztuxAEFqUFOS/0JziyES3nTTI
        EGmNa5QMzNvWM+iFSlE0uuwInhxBp2DMrg==
X-Google-Smtp-Source: AA6agR5dEJkvwjII4iWeMMuz/Eq/Gfhe+efvOnn4OWquGWbe3HvTSw/C10Y2HD3Oi1uwHUUGtbeLsA==
X-Received: by 2002:a05:6a00:2195:b0:52e:6157:904d with SMTP id h21-20020a056a00219500b0052e6157904dmr19833403pfi.44.1660634573587;
        Tue, 16 Aug 2022 00:22:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.242.57])
        by smtp.gmail.com with ESMTPSA id w1-20020aa79541000000b0052d96fb3366sm7699380pfq.207.2022.08.16.00.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 00:22:53 -0700 (PDT)
Message-ID: <62fb45cd.a70a0220.f9818.d19e@mx.google.com>
Date:   Tue, 16 Aug 2022 00:22:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2693072772912921774=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] client: Move admin submenu
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220815232631.1275861-1-luiz.dentz@gmail.com>
References: <20220815232631.1275861-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2693072772912921774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667869

---Test result---

Test Summary:
CheckPatch                    FAIL      1.49 seconds
GitLint                       PASS      0.91 seconds
Prep - Setup ELL              PASS      32.40 seconds
Build - Prep                  PASS      0.89 seconds
Build - Configure             PASS      10.00 seconds
Build - Make                  PASS      1134.24 seconds
Make Check                    PASS      13.10 seconds
Make Check w/Valgrind         PASS      343.48 seconds
Make Distcheck                PASS      300.03 seconds
Build w/ext ELL - Configure   PASS      10.97 seconds
Build w/ext ELL - Make        PASS      108.11 seconds
Incremental Build w/ patches  PASS      256.87 seconds
Scan Build                    PASS      673.96 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/2] client: Move admin submenu
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#192: FILE: client/admin.c:194:
+static GDBusClient *client;
                    ^

/github/workspace/src/12944326.patch total: 1 errors, 0 warnings, 290 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12944326.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2693072772912921774==--
