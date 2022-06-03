Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F89C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 22:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348633AbiFCWfD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 18:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344402AbiFCWfA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 18:35:00 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974A12FE53
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jun 2022 15:34:59 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id j2so6533282qvp.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jun 2022 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=o0GwiWM35Mt5fKDg7cifjC9fy0VPJsEdGBnDhFom2J0=;
        b=kEfoQ+Kfl9x3jvyA3ztYS53T/BHhs9OO8QPVRVrExC+UwGhf5mRjCpDxXtRsgsR+NJ
         zClQgxkJeuWuIPSXIFBbfDuijqym0N3KFA0mRQN/Fabbf+rvQZDwG/JCP66B94MFLJ6h
         8iz7PmUNOn0LWW3B+Ex1fOqoLzm83YP1dShoXR1oBGvKN5cchWfpxzLW74jDp0245pVU
         1MuEiO7SMxtAwh5vQ/L9SDOe8+vYZxmea83SW2z37FTqQzrBaGpxTJQl4R3PaLY2W3s+
         5LqOo9w1CJIqoiWp1FT3bZuump8Ms5453k9p0WdppMvG41D7QprbzTXzC2EnSQeOpoOJ
         +YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=o0GwiWM35Mt5fKDg7cifjC9fy0VPJsEdGBnDhFom2J0=;
        b=I4IhmTPovS4vK4eZHCxS/aXQVh63nqrVl2MgjCilRgcGubmpfLWdQ3HLvgma9A0wKm
         +0NRQ/fu3xTuO7wc+DKUKLLocdhXdoGC/lxOYo73wDhCIWbvI9Z0p22HUJ17wkOs/ilh
         rlvtgRGSXDxLSc2RYv4GdcFQ4kL5yHDDT2NkA0Vih4vQPdc1FNqDgw1thZoBn58iQKmB
         jNZ+oqN/EM0CYpGVjyNI0xoB0sIqYpXP4mFIf8YKk8J0v138kTRYbyHRNf8UjKKaZF+J
         QnH/u4dgtKMbEWqxYlLOO5invm/0ITfmQsKC0g62cM1Ko2/Vv1IUX3Y3DyUfBfZByIHs
         XzcQ==
X-Gm-Message-State: AOAM533e/ei8f3hANYVDY3gffV/jQp8iRiIdlgSU3X2xWp5wAbAbR1RL
        oC0jve4lyxuzkITNoZLCYCxEF33fy1NMCg==
X-Google-Smtp-Source: ABdhPJzVY7jH1tdu6JO8yqs4OVigPa2+DY6drYJhWK1F/S6TC9tEHHLJ8+ADkhaEaYU7DAx2Q0gGjw==
X-Received: by 2002:a05:6214:20ac:b0:464:66c0:bbe6 with SMTP id 12-20020a05621420ac00b0046466c0bbe6mr14734894qvd.127.1654295698553;
        Fri, 03 Jun 2022 15:34:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.94.205])
        by smtp.gmail.com with ESMTPSA id az37-20020a05620a172500b006a690e3a0e0sm2910868qkb.98.2022.06.03.15.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 15:34:58 -0700 (PDT)
Message-ID: <629a8c92.1c69fb81.37f6b.cfd2@mx.google.com>
Date:   Fri, 03 Jun 2022 15:34:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0763293817903988246=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, puffy.taco@gmail.com
Subject: RE: doc/coding-style: Update URL to kernel coding style
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220603212604.13758-1-puffy.taco@gmail.com>
References: <20220603212604.13758-1-puffy.taco@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0763293817903988246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=647329

---Test result---

Test Summary:
CheckPatch                    FAIL      1.41 seconds
GitLint                       PASS      0.96 seconds
Prep - Setup ELL              PASS      40.26 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      7.98 seconds
Build - Make                  PASS      1210.43 seconds
Make Check                    PASS      11.64 seconds
Make Check w/Valgrind         PASS      405.55 seconds
Make Distcheck                PASS      222.88 seconds
Build w/ext ELL - Configure   PASS      8.39 seconds
Build w/ext ELL - Make        PASS      1183.08 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
doc/coding-style: Update URL to kernel coding style
WARNING:BAD_SIGN_OFF: '-signed-off-by:' is the preferred signature form
#95: FILE: doc/coding-style.txt:9:
-Signed-off-by: line(s)". BlueZ does not used Signed-Off lines, so including

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'line(s)". BlueZ does not used Signed-Off lines, so including'
#95: FILE: doc/coding-style.txt:9:
-Signed-off-by: line(s)". BlueZ does not used Signed-Off lines, so including

/github/workspace/src/12869423.patch total: 1 errors, 1 warnings, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12869423.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0763293817903988246==--
