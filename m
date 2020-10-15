Return-Path: <SRS0=NBlN=DW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91199C433E7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 04:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B5C22226
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 04:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/ycUahF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgJOEfB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Oct 2020 00:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgJOEfB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Oct 2020 00:35:01 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C33EC061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 21:35:01 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k25so2678945ioh.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 21:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Dl0Ek3JMwcmVefI0qFNk1l7I4E8yz8tWXosH1uy4KUU=;
        b=u/ycUahFs24zBSnTHRZ6LOfZU9yuyB8q3mKbymXq/bjsfwpfykV3CW5fvhBC0oyUov
         KFDE3RXn3FI05kWT4SBlHveH4GgOom6/kFsNQQCwg2VLIkM9AtIzLnvKniKmBxyJRHXt
         nSkwsdPtDMxTaz1wENuFi1fNSCeEC+1O15pjS9vxPcnfdX11wDL3JJJ1alHZY7u2de85
         pP5aittpGoz6td1iMTPacluGOLiiA56F/Wa7DJSau8vH+p+Ln9OzyWixIowoOfDyEe/m
         CRmqlBRG8FDKiIW5atqwd6zoR4zrgG1ASJlQHInkXqoqNEU7s5vJV5JTLjWoKQE6cxuQ
         gd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Dl0Ek3JMwcmVefI0qFNk1l7I4E8yz8tWXosH1uy4KUU=;
        b=SGtROrh/gOkZCuLcoly21ItFMoCFR49oN7nnIarmHmQOBVfR3jJgvASKgqVkdXwf9j
         VfgsDYWeesAs0kfbnFjXXpzhe+37+c7YHDy3gtAk3X26NVFfoNvGaYCYrctpNvnYpQBh
         gzHdFiacPwAogZKJTgKYCmhi92l+DL0JMt2p+55kPEfAK1ny1c6eF93wXGzFIZbaVydJ
         g4vj9aafjTNiMmik4VfJ1yiNIoaAExJoz2/shL3BE0zXR8QsSdpHM2jNKFvlOBKMKbwX
         65t8Lm+5YTLEq+VrR6MAo6D/ycWwh0+lyAd6py7FDGxiHV+P00lwuWKB1MU4mdHlV3S6
         KDDw==
X-Gm-Message-State: AOAM530ZGl501VdueXCsiyxiVBm4Nbx3fHv4NgIJsgDi+Lh9xTm9dp1I
        WRNy/D7SuBEQ581rzsVdclAAerDOuT4=
X-Google-Smtp-Source: ABdhPJzdJhvNJUQVJrysg8ObV22KRWPQTgnYodyVU0K1kcvwr2G5YXaVG8oSAHlDiJ7DusWF+AIXtA==
X-Received: by 2002:a05:6602:224a:: with SMTP id o10mr1901705ioo.168.1602736500592;
        Wed, 14 Oct 2020 21:35:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.52.83])
        by smtp.gmail.com with ESMTPSA id s17sm1629837ioa.38.2020.10.14.21.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 21:35:00 -0700 (PDT)
Message-ID: <5f87d174.1c69fb81.709d1.bde8@mx.google.com>
Date:   Wed, 14 Oct 2020 21:35:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2108639430148347613=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [BlueZ,v2] core: Add support of variable length params in mgmt_config
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201015120151.BlueZ.v2.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
References: <20201015120151.BlueZ.v2.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2108639430148347613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=364849

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
core: Add support of variable length params in mgmt_config
WARNING:LONG_LINE: line over 80 characters
#131: FILE: src/adapter.c:4230:
+			sizeof(main_opts.default_params.br_link_supervision_timeout),

WARNING:LONG_LINE: line over 80 characters
#198: FILE: src/adapter.c:4266:
+			sizeof(main_opts.default_params.le_multi_adv_rotation_interval),

WARNING:LONG_LINE: line over 80 characters
#199: FILE: src/adapter.c:4267:
+			&main_opts.default_params.le_multi_adv_rotation_interval);

WARNING:LONG_LINE: line over 80 characters
#210: FILE: src/adapter.c:4272:
+			sizeof(main_opts.default_params.le_scan_interval_autoconnect),

WARNING:LONG_LINE: line over 80 characters
#222: FILE: src/adapter.c:4278:
+			sizeof(main_opts.default_params.le_scan_win_autoconnect),

WARNING:LONG_LINE: line over 80 characters
#234: FILE: src/adapter.c:4284:
+			sizeof(main_opts.default_params.le_scan_interval_suspend),

WARNING:LONG_LINE: line over 80 characters
#257: FILE: src/adapter.c:4296:
+			sizeof(main_opts.default_params.le_scan_interval_discovery),

WARNING:LONG_LINE: line over 80 characters
#281: FILE: src/adapter.c:4308:
+			sizeof(main_opts.default_params.le_scan_interval_adv_monitor),

WARNING:LONG_LINE: line over 80 characters
#293: FILE: src/adapter.c:4314:
+			sizeof(main_opts.default_params.le_scan_win_adv_monitor),

WARNING:LONG_LINE: line over 80 characters
#305: FILE: src/adapter.c:4320:
+			sizeof(main_opts.default_params.le_scan_interval_connect),

WARNING:LONG_LINE: line over 80 characters
#476: FILE: src/main.c:375:
+		  sizeof(main_opts.default_params.le_multi_adv_rotation_interval),

- total: 0 errors, 11 warnings, 540 lines checked

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


--===============2108639430148347613==--
