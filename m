Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F680C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 06:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiFWGWe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jun 2022 02:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWGWd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jun 2022 02:22:33 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB927B4AF
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 23:22:31 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 59so5864093qvb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 23:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=q/v9ZNZMCUOBR3VX6zkj6LA42HSbiSiZ6LFmBXEeFOs=;
        b=maiANHx3M5bPCnZ7cSJVcIde7D7w363QQ3isBvluSH0CDSkGv3GlB5mzfqi89QMYbs
         WiysKagZBzai4DSy1ElzX701+kfPlo67+uxYyvYlffDcL4ApcDLmqDYKZbOvxUTgazz2
         YBycmvqI5w5sZEpupU/kZMIYBj5Co74LYZtV1BmKnlHtoqQgWRUs/ddA0e5Hotvn22jd
         vWlJBvrrKsfkUloc9yXxWf758s9/DV19SLAa6Te7pNcpcsh8omjRE8eYOu8zZP1fXop1
         SYQR+vMtAbV08h9snMxx8wI/PKksraRh2P/rtJoWP5tMfQdcNSJh5WrQmFdQwCRdN4d9
         mtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=q/v9ZNZMCUOBR3VX6zkj6LA42HSbiSiZ6LFmBXEeFOs=;
        b=CvDP/kXRSxbLXdyotHtEdh6+ObrvZsRpHQGDz2tA70p6ojZMHFnpixXT9fQP1sMS53
         M+0d1h9DELJAeBeq4conRrQtC8D6HuZRixBwmFjciNu3jyIcTlbLz7jrLw4i27vQOxaO
         LrrL0Q57xb3MObOQxq+i8GZWU/KHbq+E5xjfPFSbnOn0A5ShTz44qfTkL2ZpqDeYQZKw
         5Agol+GQNQD/+6KuGP1BgvbwkvlODnk+HeppEO/GrU1bRC2DJry3pIMQBjUSVyrMQT8C
         awAhIR58pHgqvFTCL0X/fgw8dk2ymBLamaNc3T5kaDSmYbsYAXo7DlgYAhE80JAcAU/X
         lLYA==
X-Gm-Message-State: AJIora8AunhCgc3/RaaSJEW3Cdif9j8ZsF7iSUzAZiwJJg2Y5ZqWIXDm
        AOV/7GNGpUWpx25wnS2EcIEb310uuF8cHA==
X-Google-Smtp-Source: AGRyM1vaFtsaSCvONXdUzG9CF4e6/3YNNEtDEJKMv9VejDWUjmQGcCcT9D7lqjHRDKL/tk/7T9Xdxw==
X-Received: by 2002:a0c:ac45:0:b0:470:84e1:10d6 with SMTP id m5-20020a0cac45000000b0047084e110d6mr187845qvb.131.1655965350923;
        Wed, 22 Jun 2022 23:22:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.33.97])
        by smtp.gmail.com with ESMTPSA id l16-20020a05620a28d000b006a6cadd89efsm19420221qkp.82.2022.06.22.23.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 23:22:30 -0700 (PDT)
Message-ID: <62b406a6.1c69fb81.d81f0.813b@mx.google.com>
Date:   Wed, 22 Jun 2022 23:22:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4118514912692321773=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: device: Fix not removing connected device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220623031300.11581-1-wangyouwan@uniontech.com>
References: <20220623031300.11581-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4118514912692321773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=653025

---Test result---

Test Summary:
CheckPatch                    FAIL      1.49 seconds
GitLint                       PASS      0.95 seconds
Prep - Setup ELL              PASS      41.48 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.06 seconds
Build - Make                  PASS      1196.70 seconds
Make Check                    PASS      11.80 seconds
Make Check w/Valgrind         PASS      439.72 seconds
Make Distcheck                PASS      228.36 seconds
Build w/ext ELL - Configure   PASS      8.08 seconds
Build w/ext ELL - Make        PASS      1187.94 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
device: Fix not removing connected device
WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#131: FILE: src/device.c:3076:
+void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type, bool *remove)

/github/workspace/src/12891800.patch total: 0 errors, 1 warnings, 54 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12891800.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4118514912692321773==--
