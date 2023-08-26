Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50954C83F11
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Aug 2023 21:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjHZVhG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Aug 2023 17:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjHZVgi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Aug 2023 17:36:38 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AB1CD1
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Aug 2023 14:36:34 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-792388ea4b3so76974739f.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Aug 2023 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693085793; x=1693690593;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MXrivRLe33wkdBjKFQJosdpYnUF+Zp4T415MujSJShk=;
        b=UJjR7ckjgu50IjtjpTe8DfWOanXbguIAGAodm9exzeSRbODdbNKxIeVT0svSYHNCgK
         grkPdPRe7j8mgtIq2fq71uWMc8nnU7y44ZBx83c8/488fyQwVYyXrGVlcLrnVv+WoZzr
         xMJh9Da7+Abs8drFp3zaInGmVnaHtSYE+1taoXyUOuoi4wSkAaePcBigOqaeaVdgIFSJ
         UaWeQNMdC+JFyBkwOmTze5AXc+knDFeQyekDJan7xIIaOlkvzsPMJ1kZwlHthZow+bHp
         6/fkuk6Jws1x2RyANHT73bJWI6M8nnc3y30ugj4UI0i6Tlp5OpV5ckgvpWuNIxM6Y7Eh
         9vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693085793; x=1693690593;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXrivRLe33wkdBjKFQJosdpYnUF+Zp4T415MujSJShk=;
        b=fTzAjvJ90VSJwKXJcxUITJu8G0HndYkuI+UInsYCcONlprHpfvYeInFw+Qa0OgD7Uv
         Mlg2FRl3dDafhb50QWgjeb+l3a0oZEBLwOU/Pxm/eGwzTjIw3PZTTlofaFzKeQbOkmPw
         l7I0wEBcIxjqUThTqFylrRvBzYYw5v+GI1GyR4Fn5B/N5UftImJEraq5GtmrgkTRtIY5
         yxLOOXE21T/syzd5ry2m1DKNJzNfO7I8v05lwz3ncCFHgFoOT4WJI4Tj7LMkMF+gw6H4
         MZ92L2galR+Ifk3dlZ0Q/PcSCEHJ05D8CWuCrZHoPLcVWE6hBKhGY/fi4E9GCKiGGlYE
         UAcg==
X-Gm-Message-State: AOJu0YyKwuGNnbRFgBBcenC5rfTBZS6K4z3uTRTv+GlH2ViYWnTAkEX9
        C2e3ynhuy3FAq0ltrKZYw4LcnKvi7FU=
X-Google-Smtp-Source: AGHT+IHFF/AtoVbr4NYtVliUSOBa4EgpXjy3JRAYH8osd6L1AXYNtkBnDXgLS/duLxFT25eecLNomg==
X-Received: by 2002:a4a:6211:0:b0:56e:a1d3:747e with SMTP id x17-20020a4a6211000000b0056ea1d3747emr7859740ooc.6.1693085375344;
        Sat, 26 Aug 2023 14:29:35 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.79.113])
        by smtp.gmail.com with ESMTPSA id h187-20020a4a5ec4000000b0056d2dde4cb7sm2393860oob.0.2023.08.26.14.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 14:29:34 -0700 (PDT)
Message-ID: <64ea6ebe.4a0a0220.11b96.ca95@mx.google.com>
Date:   Sat, 26 Aug 2023 14:29:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8998942012055553725=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dev.git@javispedro.com
Subject: RE: [BlueZ] shared/gatt-client: always send ATT confirmations
In-Reply-To: <20230826192421.7032-1-dev.git@javispedro.com>
References: <20230826192421.7032-1-dev.git@javispedro.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8998942012055553725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=779641

---Test result---

Test Summary:
CheckPatch                    FAIL      0.73 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      34.95 seconds
BluezMake                     PASS      1115.34 seconds
MakeCheck                     PASS      13.08 seconds
MakeDistcheck                 PASS      190.30 seconds
CheckValgrind                 PASS      306.89 seconds
CheckSmatch                   PASS      429.57 seconds
bluezmakeextell               PASS      127.14 seconds
IncrementalBuild              PASS      987.75 seconds
ScanBuild                     WARNING   1349.03 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] shared/gatt-client: always send ATT confirmations
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'fde32ff9c9c0', maybe rebased or not pulled?
#51: 
Commit fde32ff9c9c0 ("shared/gatt-client: Allow registering with NULL

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'fde32ff9c9c0', maybe rebased or not pulled?
#66: 
Fixes: fde32ff9c9c0 ("shared/gatt-client: Allow registering with NULL callback")

/github/workspace/src/src/13366653.patch total: 0 errors, 2 warnings, 74 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13366653.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/gatt-client.c:451:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:696:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:993:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1099:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1291:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1356:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1631:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1636:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2140:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2148:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3237:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3259:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============8998942012055553725==--
