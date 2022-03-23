Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E22C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 04:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiCWEzw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 00:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiCWEzu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 00:55:50 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0886E8EA
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 21:54:20 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b189so273639qkf.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 21:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=oCVHGt+hQWekyhMB8mfcE5g8zSoImpp8gtI0wK51bh4=;
        b=L5sD54P11OSDJ5S7mP/q4RUQ55EeseTwHO90gsHHA4+lpPax8y5WRJGpYoiN1cejFx
         MzP3t88MsMNJBF467iI3bQdN+pmqhJObsQ54kYo0QnaESX7VQj6feCAUu25DnkWuUdMP
         TrmZQI3Qn16XXszSrGHsTpeuHFPeGolv4GBG6poFlWB4OK0FF74skhEmNUKMTpaHKz03
         yA02ybBSRRzRQoDNQo5wc8yCBQESOsOavqlFViUW+EM9fCzGyt5nh7zNYA4fsN5NqkLi
         9pqcXlxNN/YqcQd8F8n9llKOYNzuGhjj/ucxIrD/c2CDs+ms8E1XtZiUQCW78i5icARS
         5Pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=oCVHGt+hQWekyhMB8mfcE5g8zSoImpp8gtI0wK51bh4=;
        b=rPYso9cbSIrZ0/bIHdkEAag0OK4bs8gVaeBkUNvDWRtzuID5m+Y1UwklExS2yHnU4x
         pySXyP+0+40HQfFqsv3GzH6HnQYkGInM7EYRTeleiQXpamMlqCqMmJOM6fjOMT8181wV
         DbstU6XDTCca77VT3RAoaWQvC5CCT+tz2fWNbkr0wsw7gsUqOk+pRiUmgJ0bOUQtb/IJ
         JeFMD8O27AFysqIkm76sbyWFraAK4BOuM3cIq8xG/0u+ExiC6TggBr97y2QouLvUtQ2a
         AK7N12bpoH8IJkxsZ4+D8hr7DT93WxSXhUh+HwQrAEcT5WAmdJGnvtYa73uWFIXT1JAj
         wfrg==
X-Gm-Message-State: AOAM531grd5/r0hfcvfg/ldxKPs13TuK8QeXDUxnzZLy7Q/vmppqqJHO
        c0ySgZlD7/vFUtjIN6LdR9OrtqxKOEI=
X-Google-Smtp-Source: ABdhPJyohHij5ZDcUuyXKjfVsEgXM22Dz5qemlhXo5/9EZ0GSmLiBQEnyra8QMsbzm7mNc8kgtzzcw==
X-Received: by 2002:ae9:f119:0:b0:67e:8e4c:604a with SMTP id k25-20020ae9f119000000b0067e8e4c604amr7951495qkg.642.1648011259633;
        Tue, 22 Mar 2022 21:54:19 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.57.162])
        by smtp.gmail.com with ESMTPSA id h206-20020a379ed7000000b0067b5192da4csm10037187qke.12.2022.03.22.21.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 21:54:19 -0700 (PDT)
Message-ID: <623aa7fb.1c69fb81.8a69c.5cea@mx.google.com>
Date:   Tue, 22 Mar 2022 21:54:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6003579533289142179=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangxinpeng@uniontech.com
Subject: RE: obexd: Fix cann't receive small files sent by windows
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220323033612.12132-1-wangxinpeng@uniontech.com>
References: <20220323033612.12132-1-wangxinpeng@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6003579533289142179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625634

---Test result---

Test Summary:
CheckPatch                    FAIL      1.52 seconds
GitLint                       PASS      0.98 seconds
Prep - Setup ELL              PASS      49.12 seconds
Build - Prep                  PASS      0.76 seconds
Build - Configure             PASS      10.06 seconds
Build - Make                  PASS      1429.67 seconds
Make Check                    PASS      12.33 seconds
Make Check w/Valgrind         PASS      512.41 seconds
Make Distcheck                PASS      268.26 seconds
Build w/ext ELL - Configure   PASS      9.93 seconds
Build w/ext ELL - Make        PASS      1390.18 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
obexd: Fix cann't receive small files sent by windows
WARNING:TYPO_SPELLING: 'cann't' may be misspelled - perhaps 'can't'?
#42: 
Subject: [PATCH] obexd: Fix cann't receive small files sent by windows
                            ^^^^^^

WARNING:LONG_LINE: line length of 105 exceeds 80 columns
#83: FILE: obexd/src/manager.c:540:
+					TRANSFER_INTERFACE, "Status",G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);

ERROR:SPACING: space required after that ',' (ctx:VxV)
#83: FILE: obexd/src/manager.c:540:
+					TRANSFER_INTERFACE, "Status",G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
 					                            ^

/github/workspace/src/12789421.patch total: 1 errors, 2 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12789421.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6003579533289142179==--
