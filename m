Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CC5C64EC7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 04:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCAE63 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 23:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCAE62 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 23:58:28 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CFB20D3D
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 20:58:26 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id k21-20020a17090aaa1500b002376652e160so11867289pjq.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 20:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677646705;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SbwVFttI0OfhT2Noqe0wm2P+ZMZUhfY4u7RDb6BIdfs=;
        b=j/zSRmPrWu41pDVxacQzw7av3lgROU5MOqUApUUE0N9qXmWwCCfqP6yUGBu9+LgbfH
         kmKV8nycqynMHlt2WKKVfHei7pzm2EwqEXFjlObDqFdL2qleUb4RLSvdcRx3jDF23Kz5
         UMpBXGYE9kYd37+PHMtcvylIc8ChsBpSYEC8D1mIoDYNUgYzpWbos27LrB6sLYrC97kt
         +/2+fFQjFk5EvyI0iG5tVW8tiGeYycNTblfiAOHWj0aOuqilssjLoOLS2dAAdCTuiUQj
         WiDRlIgagoTEtkBeUn/E/oSr0MgjoOHm1X8TSiaZUBGLgkvRP+nTGcaE3AlIsj5vZaJP
         y+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677646705;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbwVFttI0OfhT2Noqe0wm2P+ZMZUhfY4u7RDb6BIdfs=;
        b=6rfx3zlD+SQkYCI12AMNlG7X+rzQLcwKnajSjLBWfESjTdjsdsYnZf11XyAGPjRdFN
         1hsSekft8n0D2pBeJooV2gce+CV59mMlPN9V2ay+kwX31527KUx0Nq7wD2wM7OSlA1jU
         JvkTeWS+MMTz5vj4i06Ek7whSgZkOEeAEYX0vlyMK1ePMkqWiaXas/HR39e2iffLrtCd
         X1zZ+VC2muSSDNHHgPZlOlsWA0VcahNVlf9ZWMJC7zyyu6wBFk8qK4T10r0DZjnMG6Bj
         3mt8T2qFyxTGEeLbkEbyr19Ct2gXU7dXQvRURpmtZptQ7mkt83pHRBGZ/MPFrRqSMZ6G
         mdOw==
X-Gm-Message-State: AO0yUKXPTGF8NUL0zHk4XKrRjs7bXy4UD6P0tW+S8XQ5Dx0KL9KCb+hw
        /4ORSkN6lZP1aTGyGnZrQG07uXBekts=
X-Google-Smtp-Source: AK7set8OisIMIC5vzBasRIurS1L96W9FKE9qijUHm+MiOGosrB/Q0nXw/ZJ4o3kqOQiJXglvYaY8pQ==
X-Received: by 2002:a05:6a20:a110:b0:cd:47dc:829e with SMTP id q16-20020a056a20a11000b000cd47dc829emr5578251pzk.12.1677646705230;
        Tue, 28 Feb 2023 20:58:25 -0800 (PST)
Received: from [172.17.0.2] ([13.87.244.196])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7810b000000b005dd98927cc5sm6880085pfi.76.2023.02.28.20.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 20:58:24 -0800 (PST)
Message-ID: <63fedb70.a70a0220.95fec.d072@mx.google.com>
Date:   Tue, 28 Feb 2023 20:58:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2731562551234987898=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] device: Don't attempt to connect LE if ATT is already connected
In-Reply-To: <20230301013842.718438-1-luiz.dentz@gmail.com>
References: <20230301013842.718438-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2731562551234987898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=725670

---Test result---

Test Summary:
CheckPatch                    PASS      1.85 seconds
GitLint                       FAIL      1.79 seconds
BuildEll                      PASS      30.84 seconds
BluezMake                     PASS      1036.66 seconds
MakeCheck                     PASS      11.64 seconds
MakeDistcheck                 PASS      170.69 seconds
CheckValgrind                 PASS      280.89 seconds
CheckSmatch                   PASS      382.89 seconds
bluezmakeextell               PASS      112.89 seconds
IncrementalBuild              PASS      4390.29 seconds
ScanBuild                     WARNING   1224.48 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/5] client: Allow transport.send command to work with multiple transports

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,2/5] client: Allow transport.send command to work with multiple transports"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/gatt-client.c:440:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:685:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:982:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1088:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1280:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1345:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1616:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1621:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2127:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2135:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3223:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3245:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============2731562551234987898==--
