Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B127BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jan 2022 03:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiAKDZ4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jan 2022 22:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346769AbiAKDZD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jan 2022 22:25:03 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069BCC06173F
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 19:25:03 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b127so7184669qkd.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 19:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=co5nSC9ZV3Yq3TRatZNKM2pupxH1TpM56jsk63MwL/Q=;
        b=fkMqYKbwRJHEybEDYX+x7ggcXUnTZhPJ9hU9S/PCgJgGd8ThrgzK+yvIas6TeSKmJy
         AIQC92YuEZCrl38esP5l2mnQoNcxINjnO1RTeH1j6m14XjidrJzUTUii73jiCAmsthnA
         jL5ZutMDWydxoq6+bz21X/t0NfPyFtSCLWg4aB5lrGHfG8W3GUJCIG9jjy592grCSHo8
         aG4odRMEZZlbVzUbGZeaXEw/HCywweSkctKuvjgUtRFdV/vV+dMmGo8WSpmufNsgBNQO
         WC/tZ4J+YZCwIIfnvxnrP4/v71I8CliS0aTffQxkvIgrQpxyeT0fOOW7NLWCcZE1zg+s
         xXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=co5nSC9ZV3Yq3TRatZNKM2pupxH1TpM56jsk63MwL/Q=;
        b=KS1QFZOXfal6j9NNEGuXK4li05zdmVDhZ2OtWPhcAJwxsJaCAyn12/sbmAQUKS57kw
         bRBp150yFcjMeCib25sDKNWN1SppbMl3P2OHvYqKQ+fzEJmZSw8zMjDi04pl7NoymqjA
         Il09DyErqXJt7bNDgFcZwp34/D3aX3vlfBERr1CVmlVZcFz0CPR1xz3yuvkWCRjjECpm
         4wBGx018KpZBwDhpRbqMs8hKqz0wpmTQP/R/I/egDDelx0GPJadcb1CbxR1o6TV6QRFj
         lAPxMU/XpVscnudv19IihDREStJcXKnklkxLr84TxqbwTRdoSJIelnPP5MK05tLNdBJz
         GLcw==
X-Gm-Message-State: AOAM530ECOEMP+uDlVpcCDkdeO+U9B5QlWH1DNPt9EkLr6rH5nv9r1ii
        MQr/iGyU0XjpnB9+1ochddm51lt8rrggEQ==
X-Google-Smtp-Source: ABdhPJzP9FPiPsVaBiK9iw4K7D/uFKmEazF/ynOaSSZmAzjdhfoskN4DorC+uG13fo+NsLJFvM7a1Q==
X-Received: by 2002:a05:620a:1a24:: with SMTP id bk36mr1935828qkb.513.1641871502005;
        Mon, 10 Jan 2022 19:25:02 -0800 (PST)
Received: from [172.17.0.2] ([23.102.104.241])
        by smtp.gmail.com with ESMTPSA id p67sm5491651qkf.49.2022.01.10.19.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 19:25:01 -0800 (PST)
Message-ID: <61dcf88d.1c69fb81.b6365.8aa9@mx.google.com>
Date:   Mon, 10 Jan 2022 19:25:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1073856314173231272=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] hog: Fix read order of attributes
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220111014134.128632-1-luiz.dentz@gmail.com>
References: <20220111014134.128632-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1073856314173231272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=604337

---Test result---

Test Summary:
CheckPatch                    FAIL      5.70 seconds
GitLint                       PASS      0.98 seconds
Prep - Setup ELL              PASS      42.22 seconds
Build - Prep                  PASS      0.73 seconds
Build - Configure             PASS      8.38 seconds
Build - Make                  PASS      1357.51 seconds
Make Check                    PASS      11.76 seconds
Make Check w/Valgrind         PASS      438.80 seconds
Make Distcheck                PASS      225.56 seconds
Build w/ext ELL - Configure   PASS      8.77 seconds
Build w/ext ELL - Make        PASS      1328.88 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] hog: Fix read order of attributes
WARNING:LINE_SPACING: Missing a blank line after declarations
#141: FILE: profiles/input/hog-lib.c:1404:
+		struct report *report = report_add(hog, attr);
+		gatt_db_service_foreach_desc(attr, foreach_hog_report, report);

/github/workspace/src/12709406.patch total: 0 errors, 1 warnings, 71 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12709406.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1073856314173231272==--
