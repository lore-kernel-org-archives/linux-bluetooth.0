Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B789C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 03:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKSD7O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiKSD66 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 22:58:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489E8C4C0B
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:55:25 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s196so6636054pgs.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GUlgd8NHEeio7a7AMGqV27gUULaxaSgrZpKen+WR2F4=;
        b=KCgaVIGqGrKhqmdWlN1oLsbaLFEMSVJW8BBpensO70LQji1oXsShr5c3ho3OewhhT/
         9DTfb9BKtuNAAdx9IizM1gMDB6qN8nDRIUOWClweJ/dMsoXv5zSdML9lsM5uv5I89lmW
         2sU/jsyQ73akSLsBnvMAKyZMf6+zDjUq16lBcTt9wcVmxBjyaokBbKynnpGKVdi2dRp2
         gn1wX6c0PXNlsk12P5JoI9/B0F0sKw41Bnnc0nmhQFd4DB0Ux1WPOVltTDn4Wq3Hh2Rl
         vSUPRQJ+aywsHWu9j0vkyLD0MReaO0u0APjHSxgW5KKxfZOyYPb6RU65cq7EQ3CfvR0N
         DsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUlgd8NHEeio7a7AMGqV27gUULaxaSgrZpKen+WR2F4=;
        b=zfph+Krk09+P2UMBXh5dNbkDPZ30KMV7ChNkR3cfXve1tFZ/oLpoJvuY7DrNiJJwAp
         ucbonRZg02z4BISO2HPvbOPtiWEaKuUQcFQRDQLZ45FmpFDD8J9Uumuq/KmmfmLRW5tE
         MGjp9UvSrb1Rhp0RVAI2/6dDl1/+2CmGZ+ecZGgZlmCoRXpWIIs+oUcJwK4aY8K0RCUq
         7ZcJUPuVUUVE8cc2sKe2hoQYMp6fXCri/ya3sx1vjIyn0Jyk8z1EXDOq49fsi6Wo4kwk
         XOvDT8sVm6uLl7ft9xgqm2UU3iXfk+t3Pvu6Lco4h3/540pPQ9lA9mlZCJENHVbHcJ+n
         K8Zw==
X-Gm-Message-State: ANoB5pnR+TkeNjiBpAJ8B6GBNGbtHHd3VhgoXHJabmP+8XGLl3fECcBK
        +ynCAfQV+Plh6Hi0Kr1J2jHEjkPUSCQ=
X-Google-Smtp-Source: AA0mqf4UfXfHJEiPqCxsaze3tuLRMMAjinW4XS/L4CkSAqMTEjfDpvf3Xcv/HYxgo2wID0SDAWhv9Q==
X-Received: by 2002:a62:648a:0:b0:572:76dd:3756 with SMTP id y132-20020a62648a000000b0057276dd3756mr10998096pfb.9.1668830124428;
        Fri, 18 Nov 2022 19:55:24 -0800 (PST)
Received: from [172.17.0.2] ([40.112.131.123])
        by smtp.gmail.com with ESMTPSA id y65-20020a626444000000b0056ee0d0985asm3980642pfb.82.2022.11.18.19.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:55:24 -0800 (PST)
Message-ID: <637853ac.620a0220.4f87f.68f0@mx.google.com>
Date:   Fri, 18 Nov 2022 19:55:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2705517297403248933=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] main.conf: Add SecureConnections option
In-Reply-To: <20221118052610.36133-1-simon.mikuda@streamunlimited.com>
References: <20221118052610.36133-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2705517297403248933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696767

---Test result---

Test Summary:
CheckPatch                    FAIL      0.64 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      25.78 seconds
BluezMake                     PASS      966.32 seconds
MakeCheck                     PASS      10.74 seconds
MakeDistcheck                 PASS      139.32 seconds
CheckValgrind                 PASS      230.10 seconds
bluezmakeextell               PASS      93.31 seconds
IncrementalBuild              PASS      824.68 seconds
ScanBuild                     PASS      995.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] main.conf: Add SecureConnections option
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#98: FILE: src/adapter.c:10149:
+		set_mode(adapter, MGMT_OP_SET_SECURE_CONN, btd_opts.secure_conn);

/github/workspace/src/src/13047733.patch total: 0 errors, 1 warnings, 77 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13047733.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2705517297403248933==--
