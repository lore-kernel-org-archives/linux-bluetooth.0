Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0EFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 21:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6408A64F58
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 21:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBDVaj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBDVai (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Feb 2021 16:30:38 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10257C0613D6
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Feb 2021 13:29:58 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id r13so2458190qvm.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Feb 2021 13:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=i6fWql2D4Bz/JGSMkuXstuh1L4YFCNcQi2R+5G2d5iU=;
        b=qd6jqqCAN2jWp8o9fnXdHQRrYzv5S4h5X++1IIOZOeWsByL7HKICJb89cFhc7OVNmM
         WMQBAeE+4+40fSsQTiGakogOKKhW/gUJ9ZdQ0M3ROPZHt0jPs1eaXPUDMmAEzp3Q71qg
         +YUk51hV2fD2XRSJsrfm1ibsFBCwRUKA934Jh/LeXujWnG+eATindb46Q6zAGH1iq6Be
         +1fS5muhMs7ci1K5pafpY4gLceltmJ0CBPaXMubSISS4ETS7lFHNKdVmdYAkKniEF+Oe
         E4dIOa7vXCUOxVN8hzWczqf2nTzneyReKO460sJlU6pn2UNvMzKNb3Otz+gVFIw+qa6r
         Ns5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=i6fWql2D4Bz/JGSMkuXstuh1L4YFCNcQi2R+5G2d5iU=;
        b=oIY2FpgwzZhlAFMbW0R5VKJwq3JIgNysZ3NRqIbUEXzkiMZYy1I9YorFljdr4UMzMz
         CBVIj61cReRYZPQDQmuZyDC/sXMXB8OhNZpPpxAFZT7TTuznt13Gt690UQasRgyYOSCa
         q/nlww/lba2GLbHpTtdnt2Omo5E+SsWgcQN53CtVH4S1bF2xC+qy2wJwe9nTeNXfORBm
         t+M3TwExqs2HGcSKBzbt7qr6Oz3yC0321vwHpPPQLT7bRTJDUJnIjc4ZdRiKI6TpgZeG
         MiqqyM8z/gAGRFfkBpTBBPLIYg/z96FMKEoonnOP8nmkLy8LTCZjogkxGKbKiH/v5zEC
         NSew==
X-Gm-Message-State: AOAM5330DFhRVbQccaBdU7DIdqhm4/qAUNvRzZUFw8NQn+qbMKMcm75R
        bBrEPAsS+eHk07TmLKpsBXPUYDxLXBORFQ==
X-Google-Smtp-Source: ABdhPJwZpWg/twL0RWQ2Pr8j7pj0dPaXZf7K9JiJyhOPqYGcNsROPo/+NxDMerHBDzGWKHpF8Z9llQ==
X-Received: by 2002:a0c:ee2b:: with SMTP id l11mr1518940qvs.7.1612474197195;
        Thu, 04 Feb 2021 13:29:57 -0800 (PST)
Received: from [172.17.0.2] ([40.75.25.52])
        by smtp.gmail.com with ESMTPSA id l35sm5518668qtd.90.2021.02.04.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:29:56 -0800 (PST)
Message-ID: <601c6754.1c69fb81.99438.a783@mx.google.com>
Date:   Thu, 04 Feb 2021 13:29:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4475494085123615121=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, cdwhite13@gmail.com
Subject: RE: emulator: Periodic Advertising and Create BIG Command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210204210222.69767-1-cdwhite13@gmail.com>
References: <20210204210222.69767-1-cdwhite13@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4475494085123615121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=428267

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
emulator: Periodic Advertising and Create BIG Command
ERROR:CODE_INDENT: code indent should use tabs where possible
#18: FILE: emulator/btdev.c:144:
+        uint8_t  le_periodic_adv_enable;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#18: FILE: emulator/btdev.c:144:
+        uint8_t  le_periodic_adv_enable;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#19: FILE: emulator/btdev.c:145:
+        uint16_t le_periodic_adv_properties;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#19: FILE: emulator/btdev.c:145:
+        uint16_t le_periodic_adv_properties;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#20: FILE: emulator/btdev.c:146:
+        uint16_t le_periodic_min_interval;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#20: FILE: emulator/btdev.c:146:
+        uint16_t le_periodic_min_interval;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#21: FILE: emulator/btdev.c:147:
+        uint16_t le_periodic_max_interval;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#21: FILE: emulator/btdev.c:147:
+        uint16_t le_periodic_max_interval;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#22: FILE: emulator/btdev.c:148:
+        uint8_t  le_periodic_data_len;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#22: FILE: emulator/btdev.c:148:
+        uint8_t  le_periodic_data_len;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#23: FILE: emulator/btdev.c:149:
+        uint8_t  le_periodic_data[31];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#23: FILE: emulator/btdev.c:149:
+        uint8_t  le_periodic_data[31];$

ERROR:ELSE_AFTER_BRACE: else should follow close brace '}'
#47: FILE: emulator/btdev.c:3948:
+	}
+	else {

ERROR:ELSE_AFTER_BRACE: else should follow close brace '}'
#87: FILE: emulator/btdev.c:3984:
+	}
+	else {

- total: 8 errors, 6 warnings, 124 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

"[PATCH] emulator: Periodic Advertising and Create BIG Command" has style problems, please review.

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


--===============4475494085123615121==--
