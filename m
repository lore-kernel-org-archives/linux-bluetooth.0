Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1033DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 04:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiFWEm1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jun 2022 00:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiFWDOY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 23:14:24 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FA733342
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 20:14:24 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-101d96fe0a5so15501090fac.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 20:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tiKJaoIhN0p3hwg/b01JHmIFp0L41nkn18acwt2llnA=;
        b=Adpfve2B6cRfalQiTb2movf3pmWXYTfuu5FH/VW5FLbTtYL23L8q0maqkhdZ0ydx5r
         T7DDCeJ1Q0vrV9XTvbRD3t9KXKza6BNGMzCX4YhwSRxuptAgOAiQPwtkWpDtg0vdmlpL
         ib50uyrmDbVDUJ2gDC1/XslA45lPvhroKqidYYuTw0b7ec2T92FUzzAfrPxPfin9vdH8
         Pko5YGYI1b8lS/ddzxyJ2VL94eAeYDkt3xAzlm8PjcD6cq028NQli5DKEvWHMVwyjdVf
         X1VKJ1E7cV9+IfatuA4DU9QwPGYYIIGNL9y3L2HhsyBfbcxeuybVQN9A9dqvHo84KoD2
         ckHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tiKJaoIhN0p3hwg/b01JHmIFp0L41nkn18acwt2llnA=;
        b=8KFVcaY8XeKDUUUUtA/Pp0axSF2Uzz3x/lJ0fEqSDT/bJgmkhZN2U0goaYTX7bH6Qi
         12ybXp5tW4ysu8uV4r6kKiHw8TMMSHkBY33yFuKhc3e+dQllP5HU8RPvrguNIqDqPcad
         dXoByeE/D3VaS1uONnG1f1q8mYDbMeZrwYCwc8sjd87kc0EXaJRJTzJjuukfbnwEZnT+
         Tn5Ut8y23RBGEIGdBqBJhceCHA4LddA5ZB8rIfe9jm4cmvBTsMQ/iwCXJwatrCx+a2M8
         K8TlcjeFBncPV671XC/TesDeX/yVTXVTORETOaYxQ0E47UX6WgeYFLGakLalf91/7Vxh
         tDBg==
X-Gm-Message-State: AJIora/1QcqyIH7/z5KoXkgoyqEtOx7/2Z7TYNTf3i95dg7j1I9u6OTC
        bEHTI9lyeCH3WUr5kiAp7nvp28dGu9E=
X-Google-Smtp-Source: AGRyM1sDmdPDAl6w5ua+ICjqIiwjbHO3ifDKpUjSWBgJGKRziMp8xppgYgQrF4k2SZ73Pd1soP/+gQ==
X-Received: by 2002:a05:6870:14c7:b0:fe:4131:6db9 with SMTP id l7-20020a05687014c700b000fe41316db9mr1070824oab.75.1655954063239;
        Wed, 22 Jun 2022 20:14:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.67.209])
        by smtp.gmail.com with ESMTPSA id el40-20020a056870f6a800b000f32c6b6871sm12544275oab.10.2022.06.22.20.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 20:14:22 -0700 (PDT)
Message-ID: <62b3da8e.1c69fb81.d5091.c19c@mx.google.com>
Date:   Wed, 22 Jun 2022 20:14:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7676444347044109128=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: device: Fix not removing connected device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220623014403.22360-1-wangyouwan@uniontech.com>
References: <20220623014403.22360-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7676444347044109128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=652986

---Test result---

Test Summary:
CheckPatch                    FAIL      1.08 seconds
GitLint                       PASS      0.70 seconds
Prep - Setup ELL              PASS      41.48 seconds
Build - Prep                  PASS      0.56 seconds
Build - Configure             PASS      8.20 seconds
Build - Make                  PASS      1255.26 seconds
Make Check                    PASS      11.29 seconds
Make Check w/Valgrind         PASS      422.87 seconds
Make Distcheck                PASS      222.72 seconds
Build w/ext ELL - Configure   PASS      8.27 seconds
Build w/ext ELL - Make        PASS      1244.67 seconds
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

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#153: FILE: src/device.h:126:
+void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type, bool *remove);

/github/workspace/src/12891622.patch total: 0 errors, 2 warnings, 53 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12891622.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7676444347044109128==--
