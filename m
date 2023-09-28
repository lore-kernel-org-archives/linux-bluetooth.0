Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D21E810D5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 02:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjI1COR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 22:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1COQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 22:14:16 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09BAAC
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 19:14:14 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-65af7d102b3so58145956d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 19:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695867254; x=1696472054; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VCnU4friet94zHXNfFv6djWkmcpdYy0QrD6ptr4JN7A=;
        b=fn2Ye6mihBfOUOFnhTeq2o3FcQQHNc4nboDhPkm5vt+qNU5rKG3bqEg0wptZyhwi+u
         jo+aJyuItRWG6JvcY2eNITIB0mF9cK4DrU/pded1cU1YoVDUK45xOD5qa6rUtaSXlcs/
         YEFJiDytDzMxQru0zTklVW2LCthimgsPzvd2XDC76Crux8fGFWTMR8U3Ip8rKh0wQTsP
         G6gl4N+rSW0WGhwX1tgdnKx7xdIFT+W4XmvohFWWFQIYSHl1Bl6/UT79Q8bCZw5Av2mI
         Xy7GcyuAomcl7Ql/PsJ/WJUZ/0Ymqn2muutmKTT7ae3n0QzIIPUGTaKZDbGx72KLIhVE
         SVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695867254; x=1696472054;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCnU4friet94zHXNfFv6djWkmcpdYy0QrD6ptr4JN7A=;
        b=WrUPoRdp6QiTBJiZz7vM29/46W4ZLfbn8DwPZ1MOMz5Q2SU3ZO43dbSFemlTm1iyGV
         EMDFk1iznlGtkbDlYqWKQMsUMEzCXhnR3VNuo6RKBmrnlS7dp0RHs1hf1l0zxvsd9ZRo
         zJVeYWBfOgmePjPM0g/QUv8weRrxnxs8eMwNMUEDDRFa9h+j6VGiMCJiwfp6kEYexcnb
         /v4ZMqGLck5tyeHO/3gkfz0EUOOUFfUTpnqjq8aSlR+qXl0JQcYfaAtHuyKKaUQYjZzI
         OH3mNJMcv9smhri3sSPxiVcO1tKhMsF2oL/xNaTIkivLEWw1M513ze1FYFL8SmKr5Irj
         4+1Q==
X-Gm-Message-State: AOJu0Yx5ef+b3CDTSjLoImHDXEUJx3UWXAdb6KiglAYh0KphxPHtJPcr
        nfmSscDvNuqvLW4uQnuNaF9bxOpKQg8=
X-Google-Smtp-Source: AGHT+IGGu2cNx7hWbWUbG4rh1Dg83s+oBzocaTrHQ6BOdlmzX4c2ClH0Ar3tHok/WPZHpNXweOm01g==
X-Received: by 2002:a0c:e1d4:0:b0:65b:2660:f58b with SMTP id v20-20020a0ce1d4000000b0065b2660f58bmr3941737qvl.12.1695867253812;
        Wed, 27 Sep 2023 19:14:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.69.216])
        by smtp.gmail.com with ESMTPSA id oo25-20020a05620a531900b0076cc0a6e127sm3665717qkn.116.2023.09.27.19.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 19:14:13 -0700 (PDT)
Message-ID: <6514e175.050a0220.177d7.f1ac@mx.google.com>
Date:   Wed, 27 Sep 2023 19:14:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2879654825851461336=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,01/12] media-api: Update to reflect the last code changes
In-Reply-To: <20230927215354.1874835-1-luiz.dentz@gmail.com>
References: <20230927215354.1874835-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2879654825851461336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788267

---Test result---

Test Summary:
CheckPatch                    FAIL      8.55 seconds
GitLint                       FAIL      4.65 seconds
BuildEll                      PASS      31.88 seconds
BluezMake                     PASS      1162.52 seconds
MakeCheck                     PASS      13.58 seconds
MakeDistcheck                 PASS      206.98 seconds
CheckValgrind                 PASS      325.92 seconds
CheckSmatch                   PASS      439.84 seconds
bluezmakeextell               PASS      129.00 seconds
IncrementalBuild              PASS      10914.56 seconds
ScanBuild                     PASS      1216.72 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,10/12] bap: Add support for missing MediaEndpoint properties
ERROR:SPACING: space prohibited before that close parenthesis ')'
#561: FILE: profiles/audio/bap.c:991:
+						{ "Configuration", "a{sv}" } ),

/github/workspace/src/src/13401723.patch total: 1 errors, 0 warnings, 476 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13401723.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,03/12] client: Make transport.show to print QoS configuration

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	UUID: 00002bcb-0000-1000-8000-00805f9b34fb"
11: B3 Line contains hard tab characters (\t): "	Codec: 0x06 (6)"
12: B3 Line contains hard tab characters (\t): "	Configuration:"
14: B3 Line contains hard tab characters (\t): "	Device: /org/bluez/hci0/dev_00_AA_01_01_00_03"
15: B3 Line contains hard tab characters (\t): "	State: idle"
16: B3 Line contains hard tab characters (\t): "	Endpoint: /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_sink0"
17: B3 Line contains hard tab characters (\t): "	QoS Key: CIG"
18: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00 (0)"
19: B3 Line contains hard tab characters (\t): "	QoS Key: CIS"
20: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00 (0)"
21: B3 Line contains hard tab characters (\t): "	QoS Key: Framing"
22: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00 (0)"
23: B3 Line contains hard tab characters (\t): "	QoS Key: PresentationDelay"
24: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00009c40 (40000)"
25: B3 Line contains hard tab characters (\t): "	QoS Key: Interval"
26: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00002710 (10000)"
27: B3 Line contains hard tab characters (\t): "	QoS Key: Latency"
28: B3 Line contains hard tab characters (\t): "	QoS Value: 0x000a (10)"
29: B3 Line contains hard tab characters (\t): "	QoS Key: SDU"
30: B3 Line contains hard tab characters (\t): "	QoS Value: 0x0028 (40)"
31: B3 Line contains hard tab characters (\t): "	QoS Key: PHY"
32: B3 Line contains hard tab characters (\t): "	QoS Value: 0x02 (2)"
33: B3 Line contains hard tab characters (\t): "	QoS Key: Retransmissions"
34: B3 Line contains hard tab characters (\t): "	QoS Value: 0x02 (2)"
35: B3 Line contains hard tab characters (\t): "	Location: 0x00000003 (3)"
36: B3 Line contains hard tab characters (\t): "	Links: /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_source0/fd0"


---
Regards,
Linux Bluetooth


--===============2879654825851461336==--
