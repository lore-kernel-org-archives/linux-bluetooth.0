Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339C2C48BE0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 08:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C73F60C40
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 08:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhFKIoV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jun 2021 04:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFKIoV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jun 2021 04:44:21 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72898C0617AF
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jun 2021 01:42:07 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j62so16385105qke.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jun 2021 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zS9dLFOrInQEtUAsIwWOrWbG2bDhRiYC18ieXt1t7AI=;
        b=MEzqUuM28HfnT6q83cz7NKMZt2CrMZIOamScBZTxgX2ElzZGWzhejDzBB97PsPFUQ7
         W/j/49ZMK1I5n6dMTyo4gvKpWkVLCYKsVIs1d4gyv2igoRDMkY+QNZwP2w5YNMt1u6wM
         6BX6EeBM3Vb02H1x984/RFuSzos0d20gDY6PH4dexiY8CLAeQAPBC4/wlxmtCHF6/Mn/
         jycqy6eaOZLmSy1JkdY1/73p9j0kYL0Tyd7AgiWwOv8fAwO87umryqU/Elkhv02w/JsT
         4VtyAr+13tPobS5wXTMO6LUvcxokzJQss1hp36g3rOXzarQ0ceGcjk2pRDWR+FyA3fgz
         4X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zS9dLFOrInQEtUAsIwWOrWbG2bDhRiYC18ieXt1t7AI=;
        b=hQ4+IvRd23O+md1Zc6nqoJkABn4PV8nb5p5ahTrdTawKvXEGKa9lhE2EqrILSOx8/Z
         m/kTRRJZfdt8VpR/3a/8rqt7vNC1TDK05x2r0AAbn3oHuiCMFA9vV04t+rX5T1PTO/Ip
         64ufFR3Dm7IdeZl8X8PHCIw/5qAJWaJk2Z5JidVNoeBkiaageaeVcSXXAhg9cDX3pHL/
         SaiArBr/92vpy5cfSvofh8yMVz26qpq9fMHTwL8E5maAMCrOQhz6fQXyoPpEORpm3AR7
         Dm7O4mq6iByTYuc5gcJzBRSG6YJ+Kj+C+VxqztOD7yj2yQUEBUSXkXzDiDALuTsEXzPk
         zRQg==
X-Gm-Message-State: AOAM5331zKqVI2ZJ/BJv+RSVkJY2x0onoSRP2t8w7TN7U20xwTF3jk2a
        TT/Qp7bCf3qNQ4Npwrt9Rs44POSEUdOPcw==
X-Google-Smtp-Source: ABdhPJxxVQCOyyk4fbWHmao7AOGj9st4sgpP12PXW+fhiwfMsEXpXn4A+xt/Xebm1jLlyXom7MqbLg==
X-Received: by 2002:a37:310:: with SMTP id 16mr2623138qkd.437.1623400926433;
        Fri, 11 Jun 2021 01:42:06 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.155.82])
        by smtp.gmail.com with ESMTPSA id z3sm4002022qkj.40.2021.06.11.01.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 01:42:06 -0700 (PDT)
Message-ID: <60c321de.1c69fb81.635b0.db01@mx.google.com>
Date:   Fri, 11 Jun 2021 01:42:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2141040615552163025=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [BlueZ] gatt-server: Flush notify multiple buffer when full and fix overflow
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210611081932.4279-1-surban@surban.net>
References: <20210611081932.4279-1-surban@surban.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2141040615552163025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=498667

---Test result---

Test Summary:
CheckPatch                    FAIL      0.31 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      44.15 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.14 seconds
Build - Make                  PASS      189.01 seconds
Make Check                    PASS      9.48 seconds
Make Distcheck                PASS      207.31 seconds
Build w/ext ELL - Configure   PASS      6.78 seconds
Build w/ext ELL - Make        PASS      157.09 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
gatt-server: Flush notify multiple buffer when full and fix overflow
WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
#28: FILE: src/shared/gatt-server.c:1706:
+		/* Flush buffered data, if this request hits buffer size limit */

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#29: FILE: src/shared/gatt-server.c:1707:
+		if (data && data->offset > 0 && data->len - data->offset < 4 + length) {

- total: 0 errors, 2 warnings, 38 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] gatt-server: Flush notify multiple buffer when full and fix" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============2141040615552163025==--
