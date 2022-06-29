Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5162C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 20:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiF2UP5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiF2UP5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 16:15:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216E52E6A1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 13:15:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i64so16106187pfc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/R9AKFwQBDwqpt0QWjfJNZpi/8XJxjFOPf5R7hVJpkg=;
        b=UZymtQVuJlGinFuNXUwPAbwS0LiPD9s7vqgWAmuOhEVacAOeORK8aJZWUIWvZxgQng
         IRjyvYThfWEsohKnv7JkC3vsor29Zf1ICm7ylJbM9lX3zhGj/fNsSBp9G3sEiy6oNJ5j
         mqL81Wo0UR+8PUqi3+eyoEl1xv2DM1WVUR5rh6NXn1pQPtbdwwVqbNcnTiDcZd3Mm6wQ
         AaWU7hHNfRBZcVaxgudKtqKVRQnOwWOipdTP7jHJdGgxcubQPfZVIC+Lv4jKTXPtJdmj
         ipaWVxO3BF1W37tJGFUDNNx0IA90E1GLHaG3ZaJjDWt8ThjRIQabq3pbb8bPpq/tQOhp
         UIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/R9AKFwQBDwqpt0QWjfJNZpi/8XJxjFOPf5R7hVJpkg=;
        b=LDTjYTQHlUfTHGyt5WBvbyDC+lsG+Elz7pJPzz59gkrWfXAFc27tRFb1RRkt/OTEWV
         0lyLdA9dzj3x9+VH7EWDnjfPC71QxbgOGh6GCyup65SJp5SnqtLxrXgns9ct6jJ0BAQP
         HmJ5kQv8ZA/gPrEf1t1qlGupJwGNr+Y985LW3jBs03k+4x6i5UE1RSmGIW00IKr20IXR
         JqK4n6JgSCq3bExESpw0ps4QjH+UXhD7qQbSqS1UkZ9ieWjXq1BoHM+iCMQThmUQpBmh
         wdxqIKHQIiF/sTrCV/23hXMY4Bz+oeSBrDnmfLPszFKEPJdDP/lgfqxn9tebTfitGTCq
         8MYQ==
X-Gm-Message-State: AJIora/BiPX/ekemfdz0mlSoWQ4MM9re+7xWL0Rocj1X3vPjcaPQR6zv
        keBeuCKLBi6o0j9BGqTWDmdswBbIhAU=
X-Google-Smtp-Source: AGRyM1vGhasusO8SV2bB7qpxqGfvSFsGTL0oOLYwl94tq6XTFMtBbObJgSQGtfaEaHYq/b/6cBvT4Q==
X-Received: by 2002:a63:854a:0:b0:40d:1d04:769 with SMTP id u71-20020a63854a000000b0040d1d040769mr4406534pgd.151.1656533755205;
        Wed, 29 Jun 2022 13:15:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.165.54])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090a1f0300b001ecfea03d85sm66418pja.37.2022.06.29.13.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:15:54 -0700 (PDT)
Message-ID: <62bcb2fa.1c69fb81.4ffd.029b@mx.google.com>
Date:   Wed, 29 Jun 2022 13:15:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5668549091075857746=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] mesh: Fix snprintf return values not being checked
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220629190046.14198-1-brian.gix@intel.com>
References: <20220629190046.14198-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5668549091075857746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655140

---Test result---

Test Summary:
CheckPatch                    FAIL      0.82 seconds
GitLint                       PASS      0.54 seconds
Prep - Setup ELL              PASS      41.91 seconds
Build - Prep                  PASS      0.45 seconds
Build - Configure             PASS      8.07 seconds
Build - Make                  PASS      1222.12 seconds
Make Check                    PASS      11.65 seconds
Make Check w/Valgrind         PASS      441.75 seconds
Make Distcheck                PASS      230.08 seconds
Build w/ext ELL - Configure   PASS      8.10 seconds
Build w/ext ELL - Make        PASS      1197.84 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] mesh: Fix snprintf return values not being checked
WARNING:UNNECESSARY_ELSE: else is not generally useful after a break or return
#101: FILE: mesh/mesh-config-json.c:184:
+		return NULL;
+	else

/github/workspace/src/12900623.patch total: 0 errors, 1 warnings, 220 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12900623.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5668549091075857746==--
