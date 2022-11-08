Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Nov 2022 03:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiKHDGv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Nov 2022 22:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiKHDGm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Nov 2022 22:06:42 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6375C2FFC5
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Nov 2022 19:06:40 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p21so12983878plr.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Nov 2022 19:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T3HTYm54AJfQUwkPtmtj4O3o5uJAZPoU1VzfBv3qIc0=;
        b=KffO3DGDEouaJDzAGqllUkSvAqBK/V0W2TmzGVGWrYSUPEXQPsLL03TKus68N0rPZb
         8YBomr0HPLdF1odg7updh0OVdrLojzDhk0xfCqwWxnQrF0EVXyFOJs0F+lLGCeRzUmC0
         FqaVMArQsXBDy0kGQW9Kch/gTR5xXw2+JKhOVQ3F1xJE3mrAwQYP2fhtdu0o8ypZGFTE
         HqvMJsrxTlxslCVXBd9UTFHi3rUmjFsFrVVB2XjXWe/zJx0giDmc6PDWuap3QlD+/JqL
         1E4ulGHgpVaRd9HZ43ZJyln8/V0VIuaKMbPpbjC7Ecr6rIdoBedcklmEGX62sLIGu1D5
         WjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3HTYm54AJfQUwkPtmtj4O3o5uJAZPoU1VzfBv3qIc0=;
        b=Ccs+HhYAfRdEHSXj+Wokb9ZqwnGy7HM6F/WYRp0/H5idekiItrHVNAMu2EFUYhhd1S
         57MZ3yvPcSVUqu5caKFDnAymFCA749uN+W2IorpfmrtFOSQkgN+BDSb/Euzmb27RqrWY
         /2cCOXA6gCLrYP0CU9aqcICmnx22lwwiYyLmIpugCrfMuwvj7M9t4mCQ7259efiYcXWq
         DpjHWr+MTrQWMRJBn+MidmwXz7MYjSLlr/fj2rD2HjtCdGBkNZHy7w6X8C9wAfTD0dJr
         kHkina1tstJX5N9Jt5l1zGrLn2wW0uXkUtuZGRAl3lCzFLFxTfDMGWoqZ8HgJhK3wNba
         Xn8g==
X-Gm-Message-State: ACrzQf0p0xK9NSsCEarToS4iT1k7tnMX76hKfFL8Km/SmmCifpTp2A9b
        7qTiB8JcUgdKXgUQLZNT+AYL1HomETk=
X-Google-Smtp-Source: AMsMyM6dmsd1LSIzwP+VSvr8kMy1uSRuOmGiTAIAlizys9RLy0uFkziDBvKin5QPzyiJ7yhjaIp1cA==
X-Received: by 2002:a17:902:f54f:b0:186:a437:f4d1 with SMTP id h15-20020a170902f54f00b00186a437f4d1mr51393896plf.168.1667876799681;
        Mon, 07 Nov 2022 19:06:39 -0800 (PST)
Received: from [172.17.0.2] ([20.237.218.133])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090aab8900b00217ce8a9178sm2544470pjq.57.2022.11.07.19.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:06:39 -0800 (PST)
Message-ID: <6369c7bf.170a0220.14c1c.49cb@mx.google.com>
Date:   Mon, 07 Nov 2022 19:06:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2912898311073867379=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ] unit: Introduce test-bap
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221108004348.582197-1-luiz.dentz@gmail.com>
References: <20221108004348.582197-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2912898311073867379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=692997

---Test result---

Test Summary:
CheckPatch                    FAIL      0.98 seconds
GitLint                       FAIL      0.49 seconds
Prep - Setup ELL              PASS      34.15 seconds
Build - Prep                  PASS      0.87 seconds
Build - Configure             PASS      10.58 seconds
Build - Make                  PASS      1205.85 seconds
Make Check                    PASS      13.07 seconds
Make Check w/Valgrind         PASS      366.10 seconds
Make Distcheck                PASS      309.40 seconds
Build w/ext ELL - Configure   PASS      11.03 seconds
Build w/ext ELL - Make        PASS      111.42 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      775.27 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[RFC,BlueZ] unit: Introduce test-bap
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#83: 
  bt_gatt_client:src/shared/gatt-client.c:exchange_mtu_cb() MTU exchange complete, with MTU: 64

/github/workspace/src/13035576.patch total: 0 errors, 1 warnings, 311 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13035576.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[RFC,BlueZ] unit: Introduce test-bap
7: B1 Line exceeds max length (95>80): "  bt_gatt_client:src/shared/gatt-client.c:exchange_mtu_cb() MTU exchange complete, with MTU: 64"
8: B1 Line exceeds max length (89>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_primary_cb() Primary services found: 2"
9: B1 Line exceeds max length (139>80): "  bt_gatt_client:src/shared/gatt-client.c:discovery_parse_services() start: 0x0001, end: 0x0013, uuid: 00001850-0000-1000-8000-00805f9b34fb"
10: B1 Line exceeds max length (139>80): "  bt_gatt_client:src/shared/gatt-client.c:discovery_parse_services() start: 0x0014, end: 0x0023, uuid: 0000184e-0000-1000-8000-00805f9b34fb"
11: B1 Line exceeds max length (87>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() Characteristics found: 11"
12: B1 Line exceeds max length (143>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0002, end: 0x0004, value: 0x0003, props: 0x12, uuid: 00002bc9-0000-1000b"
13: B1 Line exceeds max length (143>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0005, end: 0x0007, value: 0x0006, props: 0x12, uuid: 00002bca-0000-1000b"
14: B1 Line exceeds max length (143>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0008, end: 0x000a, value: 0x0009, props: 0x12, uuid: 00002bcb-0000-1000b"
15: B1 Line exceeds max length (143>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x000b, end: 0x000d, value: 0x000c, props: 0x12, uuid: 00002bcc-0000-1000b"
16: B1 Line exceeds max length (143>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x000e, end: 0x0010, value: 0x000f, props: 0x12, uuid: 00002bcd-0000-1000b"
17: B1 Line exceeds max length (143>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0011, end: 0x0014, value: 0x0012, props: 0x12, uuid: 00002bce-0000-1000b"
18: B1 Line exceeds max length (143>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0015, end: 0x0017, value: 0x0016, props: 0x12, uuid: 00002bc4-0000-1000b"
19: B1 Line exceeds max length (143>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0018, end: 0x001a, value: 0x0019, props: 0x12, uuid: 00002bc4-0000-1000b"
20: B1 Line exceeds max length (143>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x001b, end: 0x001d, value: 0x001c, props: 0x12, uuid: 00002bc5-0000-1000b"
21: B1 Line exceeds max length (143>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x001e, end: 0x0020, value: 0x001f, props: 0x12, uuid: 00002bc5-0000-1000b"
22: B1 Line exceeds max length (143>80): "  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0021, end: 0x0023, value: 0x0022, props: 0x18, uuid: 00002bc6-0000-1000b"




---
Regards,
Linux Bluetooth


--===============2912898311073867379==--
