Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7829C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 02:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiESCdQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 May 2022 22:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiESCdP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 May 2022 22:33:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F5EC6E74
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 19:33:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m1so3549229plx.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 19:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=PTH1YmocH2C51FiMcRD13JVE4jYTaiASnFXahGmQ0GA=;
        b=J7hxnEoo2nONWsrwNzZEQY1PEsA5dJD4bha/PJk3yQ5AeBvIvCzkduttWg40r0r8Zo
         9itvb/XhUQoRZSPEwwVBnmNwELf51FWaDllIexXD2k5gf3531GCaXLx1DXdYYZa+vWCs
         hvAfDS+FQWN5aetF8lvOUx1hqRs9edqpNw84CCq2SAiL1GY9ebR+oY1csFvlCPvITGYm
         qB2WpTxrSVCxfM/DCU7svfDFJV1PZ5FlDnUEmSHwp4DEG5RP9LJUgPNk4lDWDC27fTVN
         xaftlM7cKPdc54EcIpnVVymaVLkooz7Avlp+JycJ2tYLH7oN87qaEoIx5sbFK4+kqM7v
         yHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=PTH1YmocH2C51FiMcRD13JVE4jYTaiASnFXahGmQ0GA=;
        b=rabqEax5D8ivkhgo+5jt6FHA6qFGiKXGJBDPfibmvS7llMwuyh0jO57J2ZHo6OJUJ2
         ekDhyWXg1xyX3Y3STm0lcXD8zDhR7qRndOQcnAhmiEpY8vlhLM/Vh0eIJdDQH12byDWS
         GhRyAwPsNlcpKmlLWDCrN/pDwz7xV6r7+ZJdrbdtA5zZbcTC7rWmTdj8/bgLWDyX02Kq
         7oioh+iaNK0DPi8cT0utXOfM9Zvw6cSTtGkb+/cMCwrys9obJWe9EuC+Ps8kjeh44VhF
         gFHE3Ur9ZbBdNisY4RMyTQT/P4xRaTPKZFi/NvfcfJE4zdBohJCbuwA2FPILqYBtBmcK
         tsTg==
X-Gm-Message-State: AOAM531PTmRjPLkO6CK8Gj6PgVa1zwVG17B0Cogv4/WyveV9u+yzddjD
        lx/XgUt2jPHO6veGbCb4h8ZkHQa8JWY=
X-Google-Smtp-Source: ABdhPJwdQfXkPikzG8znBf2vfdcVabQQ8F9uxzDhAPaNyT7jYohU02DLD/wuw+eT+s/TxOzxDz0lCA==
X-Received: by 2002:a17:903:481:b0:161:6392:c350 with SMTP id jj1-20020a170903048100b001616392c350mr2560202plb.17.1652927593824;
        Wed, 18 May 2022 19:33:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.132.62])
        by smtp.gmail.com with ESMTPSA id f63-20020a62db42000000b0050dc7628136sm2789490pfg.16.2022.05.18.19.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 19:33:13 -0700 (PDT)
Message-ID: <6285ac69.1c69fb81.597fc.7653@mx.google.com>
Date:   Wed, 18 May 2022 19:33:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2062326113133968543=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/6] settings: Add btd_settings_gatt_db_{store,load}
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220518221701.2220062-1-luiz.dentz@gmail.com>
References: <20220518221701.2220062-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2062326113133968543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=642899

---Test result---

Test Summary:
CheckPatch                    FAIL      7.67 seconds
GitLint                       PASS      2.82 seconds
Prep - Setup ELL              PASS      51.73 seconds
Build - Prep                  PASS      0.64 seconds
Build - Configure             PASS      10.19 seconds
Build - Make                  PASS      1707.88 seconds
Make Check                    PASS      12.58 seconds
Make Check w/Valgrind         PASS      528.47 seconds
Make Distcheck                PASS      288.81 seconds
Build w/ext ELL - Configure   PASS      10.30 seconds
Build w/ext ELL - Make        PASS      1702.73 seconds
Incremental Build with patchesPASS      10363.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,4/6] monitor: Move ATT decoding function into its own file
WARNING:SPACING: Unnecessary space before function pointer arguments
#618: FILE: monitor/att.c:501:
+	void (*func) (const struct l2cap_frame *frame);

ERROR:SPACING: space prohibited before that ',' (ctx:WxE)
#657: FILE: monitor/att.c:540:
+	{ 0x12, "Write Request"	,
 	                       	^

/github/workspace/src/12854194.patch total: 1 errors, 1 warnings, 1316 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12854194.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,5/6] monitor: Cache connection information
WARNING:TYPO_SPELLING: 'addres' may be misspelled - perhaps 'address'?
#82: 
This caches connection information including the device addres so it can
                                                        ^^^^^^

WARNING:SPACING: Unnecessary space before function pointer arguments
#3958: FILE: monitor/packet.c:8833:
+	void (*cmd_func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#3962: FILE: monitor/packet.c:8836:
+	void (*rsp_func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#4943: FILE: monitor/packet.c:11433:
+	void (*func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#5001: FILE: monitor/packet.c:11617:
+	void (*func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#5055: FILE: monitor/vendor.h:17:
+	void (*cmd_func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#5059: FILE: monitor/vendor.h:20:
+	void (*rsp_func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#5068: FILE: monitor/vendor.h:28:
+	void (*evt_func) (uint16_t index, const void *data, uint8_t size);

/github/workspace/src/12854196.patch total: 0 errors, 8 warnings, 4552 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12854196.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2062326113133968543==--
