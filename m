Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA12C32771
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 02:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606112467B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 02:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h9pBRg6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgA1CFL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:05:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38390 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgA1CFL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jan 2020 21:05:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so5818274pfc.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2020 18:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YehW6fGub6Pwi8VfSfLp5w1/7e08XsyNQJVG79iISfM=;
        b=h9pBRg6hfCmwzQL8O5l6KHlTr4uFn2cFqhGqRLubntUxkRmqEB4ES/BU2VsXOZGEU4
         RcbTX6ggoUzoeqFn0BuM3U4Wg4hqaAn2ed7cArRtJs6v2dbRXObiV/eUCFUBKMLTRAch
         jc7kEcQ8YFcBDtNg71MvInaU3mbBJZNl8+PZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YehW6fGub6Pwi8VfSfLp5w1/7e08XsyNQJVG79iISfM=;
        b=QbCYVm1/tyyNVOG0McsPzfEVoT235w90ZhaIL+bILG2Mt7P6k8fvvASJJuhwH9Z4Iw
         SqdVd8sUR3n2LYRfBtWa8o7sR1zFq7TEiRE/ZoQs9qGiV60A+Vj3g6dOAEZ2OEJTbaoH
         5L+o794jM75haUjQnGc2IIHjCRDaF06oSpbQR17v9+XNP+N3CJU2LLU1uRy7a7r53Ptm
         inXpYmbCkJnb+v5gT47RpqWOIMOhFA45yZi3vRK0kfg8otCH8YjMyC0fA73qopMmbuGg
         TRjGtNrUK1kRQnSf5WuEu89dO0Fz8k+riiCJpp2bnvbwCczl+QKeMIdlQXSRF1Uod8xQ
         bA5A==
X-Gm-Message-State: APjAAAX8YMdoQysClbucwkBHsmkyDHJ4I7PEprX6zZCQQwO13NPnwcQD
        GSFx8LCiG1Unr1zrXjB5NYcg/g==
X-Google-Smtp-Source: APXvYqxRQHFOeSynz3m24br4ZN2VGWjWP0n5YD9aLp8IKwFWfTi+58mEXLBMm5jKAj6Es2dqh/J3wQ==
X-Received: by 2002:a65:64c6:: with SMTP id t6mr21682053pgv.392.1580177110799;
        Mon, 27 Jan 2020 18:05:10 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id z19sm17119015pfn.49.2020.01.27.18.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 18:05:10 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v3 0/5] device: Allow devices to be marked as wake capable
Date:   Mon, 27 Jan 2020 18:05:00 -0800
Message-Id: <20200128020505.239349-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi bluez maintainers,

This change accompanies changes in the kernel to mark HID devices as
wake capable so they can wake the system from suspend. The
implementation depends on the Set Wake Capable management operation. It
is currently a separate management operation but it may be added as an
extension to an exiting operand like add_device (need some feedback
regarding this).

Per request on the last patch, I've moved docs/mgmt-api.txt into its own
patch so we can continue discussions on it.

This change was tested with appropriate kernel changes on v4.19
(verified that HID devices were being marked as wake capable in the
kernel).

Thanks
Abhishek

Changes in v3:
* Added profile_wake_support and made wake_capable dependent on it
* Added documentation for WakeCapable
* Mark HID device to support wake from suspend

Changes in v2:
* Separated docs/mgmt-api.txt into its own patch
* Added dbus api "WakeCapable" to set value
* Update device_set_wake_capable to be called by
  adapter_set_wake_capable_complete so we can emit property changed
* Newly added to show whether device is wake capable
* Removed automatically setting wake capable for HID devices

Abhishek Pandit-Subedi (5):
  mgmt: Add docs for Set Wake Capable
  device: Allow device to be marked as wake capable
  client: Display wake capable property with info
  doc/device-api: Add WakeCapable
  input: Make HID devices wake capable

 client/main.c           |   1 +
 doc/device-api.txt      |   5 ++
 doc/mgmt-api.txt        |  19 +++++++
 lib/mgmt.h              |   9 ++++
 profiles/input/device.c |   1 +
 profiles/input/hog.c    |   1 +
 src/adapter.c           |  65 ++++++++++++++++++++++
 src/adapter.h           |   2 +
 src/device.c            | 116 ++++++++++++++++++++++++++++++++++++++++
 src/device.h            |   5 ++
 10 files changed, 224 insertions(+)

-- 
2.25.0.341.g760bfbb309-goog

