Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D60C001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 08:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjGEIiD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjGEIhv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 04:37:51 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8AA1720
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 01:37:46 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-635857af3beso32110596d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jul 2023 01:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688546265; x=1691138265;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0/beK9mfnvZ2t9XFwq0dxalTBYoL6AdkeP2tOZErAms=;
        b=Z6ItINJC3D8BWo4TDDks1m2pzFeOnY7wQQA2ZQxkotK10QfF3Fg5fmzTNV1dMUoyOf
         2SS/5dsXHcqax1vmdkez+kGtkdmvY5B2IOAA9Q4ZvHyvRoxCUjU1NGUXTZau89i/lOiS
         udRrMw8ej3vSTi2qOC+ooD71SzFYWrzAVR1aZYemSiL2CNtx+k/isT0664/KyR+XIqqn
         c0ICJi7IM8kAU9ECA64SU+TGkv6zN4X/jBq+alo19rOtytaNcShrRnJduGIeCwnin8CD
         8kqmwbJfAxC82BTwUk/IYKF6NGPjQTuhq7tX9MLeX0Xtf135X4lBZkbR6u3x3m/Sh1CG
         DvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688546265; x=1691138265;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/beK9mfnvZ2t9XFwq0dxalTBYoL6AdkeP2tOZErAms=;
        b=Nb7i2hcuX6DvGvJPgl7F99sppraxRmUk4iOpBvqjizv34ePb0r4HKGp8sud1AulFhO
         LotyUFtrWUscnSVmK91sN7ThRgvSByuhhA+xvsWivxFvNPuzzeFL9tgfNDBcFQfdxOLl
         XoUeW4Co8nAKvj6WGqYe5uFKsgl/qaYORtqqrkZdcFC6ZpXB7IRnQVNrU/RWa9OEcUMH
         Bq3LmCzyDUoy4dRoupQzsoEov0GyChyn3aXiMM4c2Ya7crVohUC3iD+YtPVhfYg9+hoJ
         jwyFoxtdd2xgoZsWlNats2cmgOpIO/KC+XlcsIO+Zsqudr2cmcr+RwlDxDpKjE/YdQzL
         mKlQ==
X-Gm-Message-State: ABy/qLZl7Ya/tgRRmYSVYVFCshSKKXI29gu6uwZvUwD8IazlLEZNSiVe
        DqdlYdYJY9zLF94HkDXoeIQnPqVkQ60=
X-Google-Smtp-Source: APBJJlEnAz/KeKA69zlQsm/tkdlIM3YoXHUMXSzkWDmnRH5Fna1pD84VwP8uGASEtgChdgYs5HOZkA==
X-Received: by 2002:a0c:efc6:0:b0:636:9b4:c7fb with SMTP id a6-20020a0cefc6000000b0063609b4c7fbmr12433857qvt.42.1688546265234;
        Wed, 05 Jul 2023 01:37:45 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.203.193])
        by smtp.gmail.com with ESMTPSA id i8-20020ad44ba8000000b006364a0caaadsm6255853qvw.78.2023.07.05.01.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 01:37:44 -0700 (PDT)
Message-ID: <64a52bd8.d40a0220.87fd7.e94f@mx.google.com>
Date:   Wed, 05 Jul 2023 01:37:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1514209672171803239=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: adapter: Allow broadcaster to be passed up to application
In-Reply-To: <20230705073219.5357-2-claudia.rosu@nxp.com>
References: <20230705073219.5357-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1514209672171803239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=762556

---Test result---

Test Summary:
CheckPatch                    FAIL      1.00 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      27.23 seconds
BluezMake                     PASS      883.04 seconds
MakeCheck                     PASS      11.99 seconds
MakeDistcheck                 PASS      155.56 seconds
CheckValgrind                 PASS      256.02 seconds
CheckSmatch                   PASS      342.58 seconds
bluezmakeextell               PASS      103.66 seconds
IncrementalBuild              PASS      721.95 seconds
ScanBuild                     PASS      1060.26 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] adapter: Allow broadcaster to be passed up to application
WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#113: FILE: src/adapter.c:7035:
+								struct eir_data *eir_data)

/github/workspace/src/src/13301782.patch total: 0 errors, 1 warnings, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13301782.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1514209672171803239==--
