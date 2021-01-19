Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA9DC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 21:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D466122DD3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 21:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390089AbhASVGW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jan 2021 16:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbhASUoC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jan 2021 15:44:02 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89055C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 12:43:22 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id n7so13729029pgg.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 12:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNZtkCbUa8hD8i5c8Z88wPPZUgfGlIac4Ln9H9P6rjQ=;
        b=DCm3qDCVSKAJdzglfBL+yhBYAk1i5rGUUfC2003rmZQBQo2iL9R5tkkge5C82iidfg
         ZYbUimvLxJV/InGQxnigu2TB/MENW+sCh/v4Za5KYZW0WaRBf+1qjlpg/RCi359WlMBP
         iu6n7b55NdIG+vi9FhIzv9Zj57GOjAo3CD9GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNZtkCbUa8hD8i5c8Z88wPPZUgfGlIac4Ln9H9P6rjQ=;
        b=Q65hy9+RPdayRfsG9HIq875DuOPnn9Fi1VyQnLNSSZ/Sacc+uLmn5fY8Q57WjZRE2k
         Gu/6oKfEoup3dZNkWxb/w1Il/5UbUu1gCTbRRgan/C2QXjSDGbahAdJvVzM61QT9NGMJ
         s2RCzjTHxU0IBdGvHWZw9Qst6iw4eytD5u0Kxy2UNK6nNNOv3tV/OJEv3Kz6XOAKV5ay
         JS7/bRpbnxw4bnP/tSRKfs6MnqAyLWTHR4yVZU7WfTtjQqJ1e6AsAq1F9AAHhWR0VUVD
         wUgWDdLWr3uS4nDrmz3Y0B29CT7vrX3KRPSd14D/tXiqtxmTIbEV1aqKu9UnxY7awXSh
         Zj5Q==
X-Gm-Message-State: AOAM531yJ0OXkyY5e/eZz7iSsAXKfRDyfajJtUj2tlAgVJajl5wjJ8Hz
        FkQiIDVsVBVJXodCQX0kst6g8g==
X-Google-Smtp-Source: ABdhPJyDDGGUQhc5IeVLwoRYLYcF75sBQMwTBofM+cMEtxjL5hJ2Vczkyh9F39LursT9eYuZzfZoWw==
X-Received: by 2002:a63:1865:: with SMTP id 37mr6142729pgy.206.1611089001995;
        Tue, 19 Jan 2021 12:43:21 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id x15sm13835pfa.80.2021.01.19.12.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:43:21 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mcchou@chromium.org,
        michaelfsun@google.com, linux-bluetooth@vger.kernel.org,
        apusaka@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth: btusb: Expose hw reset to debugfs
Date:   Tue, 19 Jan 2021 12:43:11 -0800
Message-Id: <20210119204315.2611811-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Marcel,

This series updates the reset gpio based recovery from command
timeouts with the following changes:
  * Refactor duplicate code to use a single btusb_gpio_cmd_timeout
  * Reduce the number of command timeouts needed for reset to 3
  * Expose the gpio based hardware reset to debugfs for testing

The last one is important to us so that we can confirm new chips support
hardware based reset (which is part of our requirements for BT chips).

We will probably also add the 'toggle_hw_reset' debugfs entry to other
drivers that support hardware based reset (i.e. hci_qca, hci_h5, etc) in
subsequent changes.

Thanks
Abhishek



Abhishek Pandit-Subedi (3):
  Bluetooth: btusb: Refactor gpio reset
  Bluetooth: btusb: Trigger gpio reset quicker
  Bluetooth: btusb: Expose reset gpio to debugfs

 drivers/bluetooth/btusb.c | 107 +++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 41 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

