Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B33C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 08:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346977AbiETIY7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 04:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346965AbiETIYx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 04:24:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B1D14084B
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 01:24:51 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y15so2180145qtx.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/LumJPWgC6JjcVGqiDkof7XuByE8Gd+If15yk15XfjY=;
        b=E1mQ+mbYPMZorU1FAlj5IIw9mg2rPxQdKpgRQDYIChYnhQggt7Mn5sjUc13k/9/FF4
         oS+5OM69fq8p7D+sAtOIL1RUZFRfPE75tge6V+W7HgZrSdWfvQAZTDWDlYaVgmkKBzWP
         4T5I1WYg7aOgah6yMOBcGI+D51oNiaJipY66iagWcORZmu+ML/g7qTRq5csnI2o11Vz5
         2P2yHbM4vhmObf2VbP4tZ/sCzREPDQsgc5q8V6+5GU9RJ8uVyo6Gu7I4sErUZhyZY9jE
         kj9wqhAwjPSVT1tZGL/VSGw479/RwU0vELV7Dtfw2qff98DMAge3QDfZCqSBQ23d4xPY
         g+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/LumJPWgC6JjcVGqiDkof7XuByE8Gd+If15yk15XfjY=;
        b=Ox1lTsh1tkdIybUCxPm2TIntsDFJTB6E27LLlR4QBD+GJtynYmT4KM7PJiqpvJNnZy
         1GR7J5zyKFmpM7jGyzUSRkI6qNRpD0fsPVZ1F6AD7AvkKX0eD6BuebJG/ASHnXkbqZ2v
         ipNiPiEzqwGWosSKg5/9SKNFbtRYFRm2C2nDqYM0WafdZdEpKwMRnXslksXLphf16zpm
         gBSWc4htFuEBjOERb6hohoiG0jMUkdZ+z6wSzKGPJU1D9YmvTz4FaFxIWNqiMoM3pnBV
         WOdRkDFBiHeF2D/RXFWjBOdNpPg4xIg3QOImlRppPc24RwZ/1ER+6pzFZprK4/ufG3yX
         1EXw==
X-Gm-Message-State: AOAM5307TBb1YYopyQUIlEUSIp2z1uOsqfGg9RzEkUvBDrnep07Gd/Bo
        NTQcvTHCq+0TogmNqzZfdTFwzpYpfTpZmQ==
X-Google-Smtp-Source: ABdhPJyDCgIzHp+c72E6NLgO/YToU9aSpEVDUWPSvj9H3MjuYsaLHLyKu8ZrFn6IXdpPGPDzQQ5Qsg==
X-Received: by 2002:a05:622a:1787:b0:2f3:f7cd:f59d with SMTP id s7-20020a05622a178700b002f3f7cdf59dmr6665216qtk.594.1653035090537;
        Fri, 20 May 2022 01:24:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.119.162])
        by smtp.gmail.com with ESMTPSA id a3-20020ac844a3000000b002f39b99f6b3sm2655911qto.77.2022.05.20.01.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 01:24:50 -0700 (PDT)
Message-ID: <62875052.1c69fb81.1b833.e4e7@mx.google.com>
Date:   Fri, 20 May 2022 01:24:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6171580576428615639=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/7] settings: Add btd_settings_gatt_db_{store,load}
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220520041701.2572197-1-luiz.dentz@gmail.com>
References: <20220520041701.2572197-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6171580576428615639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=643418

---Test result---

Test Summary:
CheckPatch                    FAIL      14.34 seconds
GitLint                       PASS      7.50 seconds
Prep - Setup ELL              PASS      46.58 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      9.56 seconds
Build - Make                  PASS      1349.39 seconds
Make Check                    PASS      11.92 seconds
Make Check w/Valgrind         PASS      475.43 seconds
Make Distcheck                PASS      249.97 seconds
Build w/ext ELL - Configure   PASS      9.27 seconds
Build w/ext ELL - Make        PASS      1329.54 seconds
Incremental Build with patchesPASS      9974.05 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v2,4/7] monitor: Move ATT decoding function into its own file
WARNING:SPACING: Unnecessary space before function pointer arguments
#618: FILE: monitor/att.c:501:
+	void (*func) (const struct l2cap_frame *frame);

ERROR:SPACING: space prohibited before that ',' (ctx:WxE)
#657: FILE: monitor/att.c:540:
+	{ 0x12, "Write Request"	,
 	                       	^

/github/workspace/src/12856291.patch total: 1 errors, 1 warnings, 1316 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12856291.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v2,5/7] monitor: Cache connection information
WARNING:TYPO_SPELLING: 'addres' may be misspelled - perhaps 'address'?
#83: 
This caches connection information including the device addres so it can
                                                        ^^^^^^

WARNING:SPACING: Unnecessary space before function pointer arguments
#3959: FILE: monitor/packet.c:8833:
+	void (*cmd_func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#3963: FILE: monitor/packet.c:8836:
+	void (*rsp_func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#4944: FILE: monitor/packet.c:11433:
+	void (*func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#5002: FILE: monitor/packet.c:11617:
+	void (*func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#5056: FILE: monitor/vendor.h:17:
+	void (*cmd_func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#5060: FILE: monitor/vendor.h:20:
+	void (*rsp_func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#5069: FILE: monitor/vendor.h:28:
+	void (*evt_func) (uint16_t index, const void *data, uint8_t size);

/github/workspace/src/12856290.patch total: 0 errors, 8 warnings, 4552 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12856290.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6171580576428615639==--
