Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6038C43461
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 07:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0FF21D40
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 07:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sxj0db2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgILH3W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 03:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgILH3U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 03:29:20 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2088EC061573
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2020 00:29:20 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o5so12151511qke.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2020 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=i/o0X33HGBCzKetBjXz7CGLqnszwCjMaz1oe3js2hn0=;
        b=Sxj0db2l/AWxUFfGuK6FVaLnbO97WsOn1XKNKRXzwmXVKbqBwqGtN455Ft67ZrqOYy
         SUmNTAy1xy2z6yBPaONYgnSW45CFV0tlpAlY5O3qP6lhHDF+6HZrlU8Al9cbvp1VJIxm
         2TyjHwn+FNYd8fQRtbeZguzbF79OzsZRB6bteKQCtVdKMJygoV8wTOQFfZuDqAmIcaOj
         mN7JLtdPYyxSnhUJftpm2geLI0JROoGKIqzPtroMOecRx2VwQFkeVXgKwKBlHPeoeQHV
         wEbaRaVd6qVLdwHPOEWtue3qxJumbvItOZOj8nW8IJvHuvGQnnkdu+TDNgxSCXVbsbEC
         fdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=i/o0X33HGBCzKetBjXz7CGLqnszwCjMaz1oe3js2hn0=;
        b=AicSIZbgKB2kjOHcQ8QvTaXT46NcULtY2zf1snyPZbjavHTUthFmLSN2UKNLFfstHN
         ZC909v7fHNIfm2hafSum1+3Q8zyh0BqadQTikkBz+XBitUDX9uNN3zl+7pskxxwy+7+M
         2O2McezyT9G9/E4t+0v5wb0E8gtw9RoInkUDnU07dOWLmuBLGZw839/EeGewNT4bL4Rs
         ALfVGP+Dt/rgqY0zQeJTx114gFXcRdGUW0hVdFTQUD7j5Pdwz7CyPdZO2fSHkW7HPjuW
         2XW21ghYXjFhLwI+OQKv7UsknMCYcUr/98ncJ5TRwn+2XE3ZRpTOcrSGvuHXkE5ias37
         L+ag==
X-Gm-Message-State: AOAM531KHuY00ZzYsT3v6OXhGQOTT6xe5kkoqHRbOHZh2waY6KrVmv0O
        vZKJdWajV2qonLR2MRipLuSztjfL+duemQ==
X-Google-Smtp-Source: ABdhPJwPKcwIxpe+22zSjyUBTCDgJ/RYP7M4p+1HMZXwwD09I9JByUpUVQcffPWt9VVhs2HEiwsSLw==
X-Received: by 2002:a05:620a:222:: with SMTP id u2mr4706940qkm.218.1599895757867;
        Sat, 12 Sep 2020 00:29:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.204.96])
        by smtp.gmail.com with ESMTPSA id x197sm5635873qkb.17.2020.09.12.00.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 00:29:17 -0700 (PDT)
Message-ID: <5f5c78cd.1c69fb81.72417.e857@mx.google.com>
Date:   Sat, 12 Sep 2020 00:29:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5872809771856964816=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v5,2/8] adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1 interface
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200911235104.BlueZ.v5.2.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200911235104.BlueZ.v5.2.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5872809771856964816==
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
#94: FILE: src/adv_monitor.c:1:
+/*

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#247: FILE: src/adv_monitor.h:1:
+/*

- total: 0 errors, 2 warnings, 235 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============5872809771856964816==--
