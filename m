Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC1C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE9F206E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIYPQ4Gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgC3IEG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:04:06 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52661 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbgC3IEG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 04:04:06 -0400
Received: by mail-pg1-f201.google.com with SMTP id j20so14243894pgm.19
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 01:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zdF8QPHkA9ihoMoJCk2M25Nui0V6Vk7lFhaw267WavE=;
        b=iIYPQ4GwX7V/Mg/35Qk0xfAWzeDFxo+MBsbbJWHKtTSQt32U14PGJkbD9cQTIOHgpn
         lejbn83EUSAzJUKt4hZlnKKIoR4tkd/CU0uUvB+PCiEvYBrQ3vSxDLne8nlx/JS286If
         ibvLVvAPQ65qb8VOzbuf935YjZhtyF2/yjhy066HuigxZwTnjsxqONauFGIezsqvUohV
         eq9mLlrXqTrVXqDvwo2Y4pJTKK1+M9ZOUWVzL81PHUNQRaGqNZokX+Vlo+uagks25qrj
         A+xg5Xj5UpOIIr5slk7aQaic3apT7swBR4YHbsuQ/+iwoAr4zmF2DsykLk1SY/lgYP9Q
         3zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zdF8QPHkA9ihoMoJCk2M25Nui0V6Vk7lFhaw267WavE=;
        b=EiljpTlrSypbkew9isOz+31G/d4nzkfV38K4IL2vaE9b/e3YBu2HdFh06EHQVxhB9a
         KlZjE9twFLIpENLpZwfb3HDnLJCNwhUyQ0jxFTYzIm0NBrnfPxDM4bBMU+VpbCYsEQBb
         GpjvsQEbSlz/RgTJ+wfafvn82Rr4QVGhqywmjARRyqnz+1YfzehJUvRCW0vToYeAzzpq
         k1khXAKzBUKBswnWhpcL/PwG5Ms1Oz34l7oa0sTqRaxNna3CKLbLbcbZPN5NZN2PVkRm
         x1J2L9hret+goro9Er0WK/FS0Ro6HEAHeqVB0JJtqOg6ChR88kNcgpfmjgjwenoWAd3A
         kV9Q==
X-Gm-Message-State: ANhLgQ0jtLq3tSGBLBIbYhudqfdEPAxYfyKFpS6yDAAujXlwDv8A/JFn
        NXhE9cFMU7iN7WNe5UjFpVnEbTcf8/icLT0r2yRhDELbgUAp15gRQjvSskAUh+/gqVSNPA1AjGs
        1UqEJAUrwpPrXzf75kY2BNkCGG1Wr2Lt7dYqlMOFHptCJRup02mJbDp0RDjsPNg4jQQFb0O9h7L
        TSZQ+w37zHgEM=
X-Google-Smtp-Source: ADFU+vtwVoXJYFiQ5SK6HzFqzEbj82Zj32bKhP5ASSiRR8uiH5gj32MpBXJaUPshUVBOo4xx9bnUF5JFBux5rLA5Zw==
X-Received: by 2002:a17:90a:25c6:: with SMTP id k64mr14376431pje.9.1585555445329;
 Mon, 30 Mar 2020 01:04:05 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:03:51 +0800
Message-Id: <20200330080357.96989-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v2 0/6] Add support of setting advertiing intervals.
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Linux bluetooth, this is a series of patches for supporting
setting of LE advertising intervals from D-Bus API.

Hi linux bluetooth, this is the lib/mgmt part of supporting LE
set advertising interval series patches.
Thanks

Hi linux bluetooth, this is the advertising part of supporting LE
set advertising interval series patches.
Thanks

Hi linux bluetooth, this is the documentation part of supporting LE
set advertising interval series patches.
Thanks

Hi linux bluetooth, this is the monitor part of supporting LE
set advertising interval series patches.
Thanks

Hi linux bluetooth, this is the test part of supporting LE set
advertising interval series patches.
Thanks

Hi linux bluetooth, this patch is the btmgmt part of supporting
LE Set Advertising Interval series.
Thanks

Changes in v2:
- Rebase and resolve conflict in monitor/control.c

Howard Chung (6):
  lib/mgmt: Add LE Set Advertising Interval definition
  core/advertising: Add support for LE set adverting interval
  doc: Add documentation for LE Set Advertising Interval
  monitor: Add support for decoding LE Set Advertising Interval
  test: Add test for LE Set Advertising Interval
  tools/btmgmt: Add setting string for LE Set Advertising Interval

 doc/advertising-api.txt            | 13 +++++
 doc/mgmt-api.txt                   | 25 +++++++++
 lib/mgmt.h                         | 11 ++++
 monitor/control.c                  |  2 +-
 monitor/packet.c                   | 21 +++++++
 src/advertising.c                  | 90 ++++++++++++++++++++++++++++++
 test/example-advertising-intervals | 48 ++++++++++++++++
 tools/btmgmt.c                     |  1 +
 8 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 test/example-advertising-intervals

-- 
2.26.0.rc2.310.g2932bb562d-goog

