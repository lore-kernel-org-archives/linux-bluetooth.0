Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A41C388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E91120684
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvhcbo1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390651AbgJ1XyB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389984AbgJ1XyB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 19:54:01 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B095C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:53:59 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u19so1458614ion.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=V6rlFkQf5dOMs+c+D1tMpcfSOd5ukJkB9+4ErZPUDjI=;
        b=Mvhcbo1RAcN4ZxWCY2z7ThDWkRTewUFW2SbQlVhwgA4l2kt/1nOrvcvU12lNe4DU3X
         FAENsKcAiA0YRhtN4tjgm7F2R4RJ0gqEuWHKjsa3nw5kW7Vzx8XiTpHRratMGNyjZVeu
         c/JlbRS5gmkCyYa9MwwgA3nbS6cqh1jX7EnnMOE41bBKqn5m3fC57WZLOiaaFwtkZ+YJ
         k72mulaMeKhI2l92hIkCMmeIdJQqDvK7gJU9hGrOnvpcqJ1ScDcUNjeIBs1KRdSF5dRC
         bHfHrXSqsgWUh/nGdmjBkd46+K+Lw7tgqQ+keOxN+H5ILEfKw8DFdkY2sWmdnrb5ndw6
         KksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=V6rlFkQf5dOMs+c+D1tMpcfSOd5ukJkB9+4ErZPUDjI=;
        b=O6RgT7S9+LlKNrEm7BRDDLNFCSiINV0u1jKD5zPS4O2csOtrLnTMRZnCGONbq2lyfF
         Ed2JkxP8iagx41CSqTkPYsfbAkH9MvUGKEe1x9FHB/rZUMpztliTyW8TwHxMUuj1ZQ6j
         S5+j1V3zjLFHUUOIGGHm3iQtcOelK4QdEndAqhjoy6QzLPxDjEbfzmOwIlFmhpjiL8j0
         YKfcYmM82anCzCtMrqoaHlZCtRdm0YU9Vr0hYRdYdFudf+1EwyrvA/Yl38vQ4BWXb9v4
         VS+0w50dXzIkPBmCjMxrRhaHeP+0WC3Cg+SZ7FSx1H022wLCWbnL6TMAFBSmHDwe0F2J
         nqww==
X-Gm-Message-State: AOAM530CGNMwUKq+n2ihfZdqOjBriRHVC3L4/nCI4u9PyO1KnsSJ1ELs
        jyI4LwShoqRIl2YVYqjVB8XwDz32ESk=
X-Google-Smtp-Source: ABdhPJzzS5prwPopxDZGh8QKA2X/Nwi0jowjlDLkfe6a+GnS8wZ8LH3vzMXNWkIRienWaEd/cQn5ig==
X-Received: by 2002:a02:6342:: with SMTP id j63mr1325937jac.41.1603929238680;
        Wed, 28 Oct 2020 16:53:58 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.201.112])
        by smtp.gmail.com with ESMTPSA id v15sm844976ile.37.2020.10.28.16.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 16:53:58 -0700 (PDT)
Message-ID: <5f9a0496.1c69fb81.ca4e.493d@mx.google.com>
Date:   Wed, 28 Oct 2020 16:53:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7979117838570326410=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [BlueZ,v5,1/2] mgmt: Add support of mgmt TLV API
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201028195132.BlueZ.v5.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
References: <20201028195132.BlueZ.v5.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7979117838570326410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=372511

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
core: Add support of variable length params in mgmt_config
WARNING:LONG_LINE: line over 80 characters
#115: FILE: src/adapter.c:4215:
+			sizeof(main_opts.default_params.br_link_supervision_timeout),

WARNING:LONG_LINE: line over 80 characters
#182: FILE: src/adapter.c:4251:
+			sizeof(main_opts.default_params.le_multi_adv_rotation_interval),

WARNING:LONG_LINE: line over 80 characters
#183: FILE: src/adapter.c:4252:
+			&main_opts.default_params.le_multi_adv_rotation_interval);

WARNING:LONG_LINE: line over 80 characters
#194: FILE: src/adapter.c:4257:
+			sizeof(main_opts.default_params.le_scan_interval_autoconnect),

WARNING:LONG_LINE: line over 80 characters
#206: FILE: src/adapter.c:4263:
+			sizeof(main_opts.default_params.le_scan_win_autoconnect),

WARNING:LONG_LINE: line over 80 characters
#218: FILE: src/adapter.c:4269:
+			sizeof(main_opts.default_params.le_scan_interval_suspend),

WARNING:LONG_LINE: line over 80 characters
#241: FILE: src/adapter.c:4281:
+			sizeof(main_opts.default_params.le_scan_interval_discovery),

WARNING:LONG_LINE: line over 80 characters
#265: FILE: src/adapter.c:4293:
+			sizeof(main_opts.default_params.le_scan_interval_adv_monitor),

WARNING:LONG_LINE: line over 80 characters
#277: FILE: src/adapter.c:4299:
+			sizeof(main_opts.default_params.le_scan_win_adv_monitor),

WARNING:LONG_LINE: line over 80 characters
#289: FILE: src/adapter.c:4305:
+			sizeof(main_opts.default_params.le_scan_interval_connect),

WARNING:LONG_LINE: line over 80 characters
#456: FILE: src/main.c:375:
+		  sizeof(main_opts.default_params.le_multi_adv_rotation_interval),

- total: 0 errors, 11 warnings, 524 lines checked

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


--===============7979117838570326410==--
