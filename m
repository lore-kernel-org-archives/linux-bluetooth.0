Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943D2C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB0520774
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjR0nK+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgC3HEv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:04:51 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37308 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgC3HEu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 03:04:50 -0400
Received: by mail-pg1-f201.google.com with SMTP id q15so14171327pgb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c38wUvtWc9xaFSLYpIT9xHL1ndQr3Bpo0kDMTwnucV4=;
        b=KjR0nK+ERVfHJF1VnyvrvMfQTqWtr1W7PFe6j4IJs39tT5k+AI8dtbHiSRBj4qxIEh
         4cm1Dv1t1EBSTmwlVU8hBKghCXlWMmbjw18Fy4QNKk3Hh9PDP4JWBoJ7wbkI4MyjpqF3
         Py8yEHuo4bqa1SW3dv828zfKZGv183BK1nNVUOkGs6Bu2aKU3plm4urJNvUqy931lZVS
         9teUsah0noMbHtgbAWXq93Vy8mETjIpaDk0J1hPfQ1ez5b+ADzjPxxmUC/aiwUJZtNzZ
         g0nMuMHH0JH6EkZMbe9Qe8fQm7llcvWt4Jd1d7PjZN3lcpgusGoPJFgWv7HoKs9CZAqo
         0lOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c38wUvtWc9xaFSLYpIT9xHL1ndQr3Bpo0kDMTwnucV4=;
        b=f9Y3MAifR6h4s3exxa8y2wcvK16bap9++zPuV0URfSfmk+DRRuo/zKiResVux1SBV9
         dTc8UFOz2raXH1TDLmfqPhz39K046UmODpKXwlZ+ROFuXC7L1K/oUeAIGN+zxJTL68ku
         UA0pYvGECWFK9o9xROmFLXOtivpG6LTSuDPRfyWdXfvS9I3hJYFJKgLc1Vi7k+lvaWp+
         hBGTztV4A2Wsef3kNpVlYRuXfOTlTmvj5coWRZQVX3Sc4rrthHnPtUef337UKMPxgosf
         XB47SZfsyBpLuy0+8heGULAZ2OQn8SzNZOfOZbxP/9OCYjcVmk0PeqsmBaq0nuOXcqLO
         xujQ==
X-Gm-Message-State: ANhLgQ2/k1rKYcZZoi7P+Oj8z+H+qQ/eRKG34LKURCNektG0GRjtRByR
        aeay7E5QngpcVxldLAwS0u9hU7IjHIQCJaHRQQhkN3ITxlIzgPH0uqUp+ax/aZG5yu+6i5ZYw+T
        +Tyd74vl7JvW0S42wojNDeem0ZkV74ljC8ingcPmCBj0jH42jkIM/arqYzhymoroIv4TvrMo9lR
        udIEoKXrbiDxM=
X-Google-Smtp-Source: ADFU+vs5jMRxDgzu6yRVnf3veHVY2Cbv0YsIcnXpg7l5wfPoFAyfAGDRD3XteIue9LvhJUF7l2gJYBxtmG17tSAHhQ==
X-Received: by 2002:a17:90a:4497:: with SMTP id t23mr13764726pjg.102.1585551887593;
 Mon, 30 Mar 2020 00:04:47 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:04:32 +0800
Message-Id: <20200330070438.37316-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v1 0/6] Add support of setting advertiing intervals.
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
 monitor/control.c                  |  1 +
 monitor/packet.c                   | 21 +++++++
 src/advertising.c                  | 90 ++++++++++++++++++++++++++++++
 test/example-advertising-intervals | 48 ++++++++++++++++
 tools/btmgmt.c                     |  1 +
 8 files changed, 210 insertions(+)
 create mode 100644 test/example-advertising-intervals

-- 
2.26.0.rc2.310.g2932bb562d-goog

