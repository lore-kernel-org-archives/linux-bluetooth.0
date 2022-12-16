Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5FFC4167B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 22:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiLPWCO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiLPWBX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 17:01:23 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2D227907
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 14:01:16 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id i83so1925382ioa.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 14:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rAPQDFwYZkGGtSknezcp77j3YQjW2aNVo8RI03iF7JA=;
        b=j85Cav1ts3OTpvpTEC59ptKYlf49VGNCWzKjCeKRLUV1I3ALe1yOWGpzA++ziWrkhW
         JMzwqbjJhI7vCVJGT3nif/aT8Pp5U57UrxcBPHjK307GIxFGvB3G2AueGO6VeFmog/xV
         p9Tm3tmGAXjFGkhLK9V2tRP2SPNePE7hTzWsMDwib8XmsCSMndGu3hXzdId6oJhznkWo
         OJEwnMnVSWSNtIdBpz/uWK2PtlA8txJ8ZinKqt6yBVjGdoMEuA/Vs73Z2zQxpSUIB6bs
         WfHLluwirWdOi62fWRLpmu7N5g6JtyHAWa6ykwvHJZC1YuHdDJlbJCqnAmSRWx3DY0wn
         i8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAPQDFwYZkGGtSknezcp77j3YQjW2aNVo8RI03iF7JA=;
        b=kENkIsmtb9Uyq4V/XCnZgu7pnlhE4/wgGnOs8SbgHIQgXouWYusBqmoliyrLp41XZl
         sa31r7GaEU1zx8JY3gUIS1ka+cAwNME2+LXDN+nNowl7V/bHSyxYqObmndsUK4Hxg6oL
         oVVZUKs9tlSBHwxftmk2rnjJg81VJUDPIDtXIBS1n+KmD5donPAevmJz6hXZ9iUQ2lpW
         zqhik+gwm9vKmmdjbdFDmabaWofufEfg4+gJ3XxyN82PLO4yh6zr7rtltr80KD10wKwD
         s8yghCMHWGMZvpbNFOkjka5CjF3WSp5UcigyRDVH2zKvF3pynR63I1woNERA++3xY+IO
         8E2g==
X-Gm-Message-State: ANoB5plPt93HvVjIxjEkASwyXggObNC15h6Ez+Mkt7ngxsaqiQinI2n2
        Mr/i4LmZFwfL/TafxP82oWrDCIZ1OUw=
X-Google-Smtp-Source: AA0mqf4x3w/ZerfzYZ26Va7jeADbYfpGtLmwvZeHpwWQbNz7nOsivN5f7hLuH350JE4Fq1PB6KPbbg==
X-Received: by 2002:a5e:dc46:0:b0:6e4:eab7:8c67 with SMTP id s6-20020a5edc46000000b006e4eab78c67mr4494115iop.14.1671228075800;
        Fri, 16 Dec 2022 14:01:15 -0800 (PST)
Received: from [172.17.0.2] ([40.77.45.145])
        by smtp.gmail.com with ESMTPSA id a90-20020a029463000000b00363d6918540sm1048169jai.171.2022.12.16.14.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 14:01:15 -0800 (PST)
Message-ID: <639ceaab.020a0220.8afdd.1d47@mx.google.com>
Date:   Fri, 16 Dec 2022 14:01:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3868226378828925979=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] shared/gatt-client: Fix not marking service as active
In-Reply-To: <20221216210611.2990552-1-luiz.dentz@gmail.com>
References: <20221216210611.2990552-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3868226378828925979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=705220

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      26.35 seconds
BluezMake                     PASS      766.01 seconds
MakeCheck                     PASS      11.24 seconds
MakeDistcheck                 PASS      147.97 seconds
CheckValgrind                 PASS      239.23 seconds
bluezmakeextell               PASS      93.67 seconds
IncrementalBuild              PASS      615.21 seconds
ScanBuild                     WARNING   949.04 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/gatt-client.c:387:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:616:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:919:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1028:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1220:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1285:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1556:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1561:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2063:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2071:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3154:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3176:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============3868226378828925979==--
