Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F426C4741F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1709D206FA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8HJy0Ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgKDTWS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKDTWS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 14:22:18 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA4BC0613D3
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 11:22:18 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 11so832138qkd.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 11:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hjZEtv8TVYyZU/yBQLQhbU7MJtRTIwqTvjsi0ESOl3Q=;
        b=k8HJy0EcTVJG6I3aTV32A+l45QIkxI7nTX1u23Ytw7lLmwLOp+xjBC1+H4V++JUb5y
         DO9GahHXYUGKdFsEPrFQ8p9HivJtOcr3/GAekRC7W1qnofsh4ZrS6p3Rz2Sh8Gog2Iod
         G1Ni+tB09u75spi6TndTuuytBKc2kJ7yqd0RniVLIKI4OIWqQEaFFLPG/OJHGrZ94h3S
         1lSmvSURLD/dwjBBQKmbmqG+jmTs10KHKf5aSfLVO7pTx76CQl1+e0yRwj8nHqrm6sbg
         7lr8q20yFmm+TmSX80spyYSfEtoealDry2tni+qwJawbNNk5LNn3WlNlpVOUY2PhNu43
         +ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hjZEtv8TVYyZU/yBQLQhbU7MJtRTIwqTvjsi0ESOl3Q=;
        b=B6W0okecexlTS9jyQTUWdFXWSTkkGZJ87t8iSSXBlswVQIBBJTidhAGIiLzY91o0/U
         JnL3SJttJkLbznVv2TneJUbfvtJPmx8qh7/LnLc9DEO2uaZ8kJw2ODMmstHbkWkYveSc
         Tt3XqLxmIGy/aeVxQrLIMML6LVmIbDVPuY/NhAYh0luvzQ8yupBjYO9r3dx/EY9MqIH4
         CTdtX0uSWODkll1ubjyF0vp7F6Y8N61uukD7PrP2riunYopSTXuoOo2Ygx24wRL8iciH
         YSh8qALZn6yun0mlQuTIaWO2e9XkpZ1zS0O3tBNEY6xRlHnUT3y2V99DIkCCj/dlj0oJ
         5fsQ==
X-Gm-Message-State: AOAM531R9mFYCNu+4ku/Zac58LnEt04MBD8PU4Mm+motxu/ucGO4I5Yo
        YMabeH28jOLKBjI5OxW0KjIOoTVeirItVA==
X-Google-Smtp-Source: ABdhPJz9FmTbyHTtnIcGa2AFw0AovZJ3xLBlGAS/asMW3hisen4RA2fXDouSHArA5a7Ksk34dvwz4g==
X-Received: by 2002:a37:7d43:: with SMTP id y64mr25477078qkc.225.1604517737480;
        Wed, 04 Nov 2020 11:22:17 -0800 (PST)
Received: from [172.17.0.2] ([104.210.9.26])
        by smtp.gmail.com with ESMTPSA id o2sm3288260qkd.12.2020.11.04.11.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:22:17 -0800 (PST)
Message-ID: <5fa2ff69.1c69fb81.eeebd.14a7@mx.google.com>
Date:   Wed, 04 Nov 2020 11:22:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6627555207724036700=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Subject: RE: [Bluez] profile: GOEP Set IMTU to 32k
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201103073032.4532-1-sathish.narasimman@intel.com>
References: <20201103073032.4532-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6627555207724036700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=376113

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
profile: GOEP Set IMTU to 32k
WARNING:LONG_LINE: line over 80 characters
#29: FILE: src/profile.c:1364:
+				if (!bt_io_set(io, NULL, BT_IO_OPT_IMTU, BTRX_MTU,

WARNING:LONG_LINE_STRING: line over 80 characters
#31: FILE: src/profile.c:1366:
+					DBG("ERROR bt_io_set Unable to set MTU");

- total: 0 errors, 2 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============6627555207724036700==--
