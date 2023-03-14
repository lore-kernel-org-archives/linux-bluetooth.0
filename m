Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F592C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 00:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCNAtD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 20:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCNAtA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 20:49:00 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C8B5D249
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 17:48:45 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r16so15202326qtx.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 17:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678754925;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=34UTjE1VUixFaNDmYjJFcrN66ELET5rwNQwjvqDR6wk=;
        b=ivRuLKIDx7BXYfA2y1A3PzGAsPXzbWw5rmut42s9aysOiOOL6EV3En1CR8yLcycqRF
         ldI+h8cnOQcBfD/XzSsP0yACI9/NYJ+b91vbjWk5OKD6riio2AZvu4ZyzJCbFj6y1QYc
         kAZxedP4nOuCzUiC3qJ8yuMhDXoc6gwPEreQBB9d8t2pCq32zikRCOxPPGh4dKu2y+NG
         8LO2yXb/fs1cCWLFI30cvHqpK8s/iSqo7+xmJmrmMDXaZJnYewNmA0f7WXyhmLCP7y+n
         ZYQ4+yB/nbGKSpzqObYK4/z/vbKjDzborTH8LvyXfLU9tq4aDoxxxRHVXmvDEP8I/nWG
         UVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678754925;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34UTjE1VUixFaNDmYjJFcrN66ELET5rwNQwjvqDR6wk=;
        b=tK28IuvmKtNsiykk0YJKaZJUAyuakis0VpBdWd/lhMKPeIj20XX2PkIeyEhwYKwZyr
         n8E3caOScbQQY7PEXxgygR+1ZZIM0i3xz6n9yCoNBewlS8XQYfZZJxStBBxWtFKd32vy
         BaSz3hqagNKaQRhwD8sIu7W2ktQC40Q8oNdoceZr325MJrXpvbhu9oIQ/KWaCfGP1+JO
         jsYbS0YnHgPiVZpbXT5HDucSVM+H5FvojJkq39dtlYchOrv6p5z01Og+XM23bRAU4vjn
         +Mnw1Uk4WPy+icIMNwnOAaNd96pN6mMQ6fDaULIokORdNRoHgmi3/Gswmg8NL1olOmyf
         MDaA==
X-Gm-Message-State: AO0yUKXB16eNiaAuTmDn8eo5mt9Jc1WleHq851jF4+1E36fF37qlUN0H
        X0AigpDBbenC6vnM0CTFZo1pBP0vWno=
X-Google-Smtp-Source: AK7set8i5+/SZmuUq4AR4IW0EunXHlZTdmcX+Dhgt7HunAd5wa0r8DV0jOEqtOvZDYTDTUuG2wTpfw==
X-Received: by 2002:a05:622a:5d2:b0:3b9:a5d8:2c50 with SMTP id d18-20020a05622a05d200b003b9a5d82c50mr25051690qtb.38.1678754924902;
        Mon, 13 Mar 2023 17:48:44 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.200.40])
        by smtp.gmail.com with ESMTPSA id z18-20020ac83e12000000b003bfbf16ad08sm796851qtf.74.2023.03.13.17.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 17:48:44 -0700 (PDT)
Message-ID: <640fc46c.c80a0220.261e3.4889@mx.google.com>
Date:   Mon, 13 Mar 2023 17:48:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0902888453141970176=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/bap: Fix not unregistering idle callback on detach
In-Reply-To: <20230313225150.267896-1-luiz.dentz@gmail.com>
References: <20230313225150.267896-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0902888453141970176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=729652

---Test result---

Test Summary:
CheckPatch                    FAIL      2.24 seconds
GitLint                       PASS      1.38 seconds
BuildEll                      PASS      27.19 seconds
BluezMake                     PASS      847.95 seconds
MakeCheck                     PASS      11.14 seconds
MakeDistcheck                 PASS      149.61 seconds
CheckValgrind                 PASS      244.58 seconds
CheckSmatch                   PASS      328.42 seconds
bluezmakeextell               PASS      99.01 seconds
IncrementalBuild              PASS      2848.45 seconds
ScanBuild                     WARNING   1027.16 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,4/4] shared/csip: Fix crash on bt_csip_get_sirk
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#100: 
   by 0x48BBC7E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.7400.6)

/github/workspace/src/src/13173430.patch total: 0 errors, 1 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13173430.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/gatt-client.c:179:18: warning: Access to field 'ref_count' results in a dereference of a null pointer (loaded from variable 'client')
        if (!client && !client->ref_count)
                        ^~~~~~~~~~~~~~~~~
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
src/shared/gatt-client.c:2142:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2150:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3238:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3260:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
13 warnings generated.



---
Regards,
Linux Bluetooth


--===============0902888453141970176==--
