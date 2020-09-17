Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93725C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566B721974
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owCBqehQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIQGbn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 02:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIQGbn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 02:31:43 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15302C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:31:43 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id w186so1204933qkd.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=M9HsWmGaYc362hnOhx8k59DhoQP5scWZuWggFfKUr7U=;
        b=owCBqehQkZ70rYhdafb0oO6XevkSPUwfWh7c+RfcVXMeIx3zlVGdvS0aZGX7QmL33B
         Ib3CZX0AdletXm5JdblJDTGGY5N4+p8u2LT9Y+kz3ZBjUiLyP81GmckF7NRt4PS7ZBMp
         ys3ooi5HroqQd2Xi4U9RfVXizOX76h6Bs/Mtkt13KPdcsEf41KrVZQ4U2BiarNElQ+rl
         FT8N0SAKQFe09MgLVM+mmopoh8cH6JCHLAGeD08Ogl1Z87I86bZB/AjVFJvli4uTKB9a
         xXu1Fm+KikN5m0DgtMTNVJXGTqY1NfQOZbglJdu01nefjeyQf/vXkWGtVMM+umpaUtWi
         vRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=M9HsWmGaYc362hnOhx8k59DhoQP5scWZuWggFfKUr7U=;
        b=EH+Ia1BmjL1SbNQqTzFkLt6nqBK6/BM35YiNjZ8omUXDX3GJuxmhBD795Ul9U4BqRO
         VMz7yVukFmRoIrKw/FsWO1aXJHOHzTUWWOoRzAGA0uUvPcVt3/poEXkcXdjbRI0EMEee
         u/nfEUjlYLh56nOqsohELtFI93EAxYt3C50PevgDcEc33hW6oKAm3LAfGa38cJweOrrF
         Q0APve3sgrf24nehJB21zRbEQI6npZM0OpTyjLCJobeUCMWMZf7YheRAyvmwXagt5rsc
         hJpDYag/INUOL5zmkROnzLEMWRIwRq6Fg9d80iicMDkD3i1Szga++qrX8lXLnLIIeVEL
         JUdg==
X-Gm-Message-State: AOAM531rSgnyNpErftFFB8oO3miaXecBtLCr0XPOd0soQ7Sl+I4TOJ/c
        0JJW+WRX2AiqUoffRa1UJqDZ8CeFNfOKJg==
X-Google-Smtp-Source: ABdhPJw4O/T+qIYoTCmXupd5p11YxERo++uMatYPWLoGuqULNSJNmZaUtPJFy0qkAhO8Nvz0QnSyow==
X-Received: by 2002:a05:620a:1266:: with SMTP id b6mr26896996qkl.371.1600324302217;
        Wed, 16 Sep 2020 23:31:42 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.42.1])
        by smtp.gmail.com with ESMTPSA id w2sm20215859qki.115.2020.09.16.23.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 23:31:41 -0700 (PDT)
Message-ID: <5f6302cd.1c69fb81.3aaf4.fba0@mx.google.com>
Date:   Wed, 16 Sep 2020 23:31:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0070315470866689327=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v2,2/8] adv_monitor: Implement unit tests for RSSI Filter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200916231935.BlueZ.v2.2.I5ae05701b2b792a3ea2ca98f4a5d977645b1afc2@changeid>
References: <20200916231935.BlueZ.v2.2.I5ae05701b2b792a3ea2ca98f4a5d977645b1afc2@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0070315470866689327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#163: FILE: unit/test-adv-monitor.c:1:
+/*

- total: 0 errors, 1 warnings, 512 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============0070315470866689327==--
