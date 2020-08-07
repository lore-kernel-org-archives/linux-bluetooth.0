Return-Path: <SRS0=11Tl=BR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3840C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 21:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2332086A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 21:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLTXn3KD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgHGVYj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGVYi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Aug 2020 17:24:38 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BF1C061756
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2020 14:24:37 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id y7so2415445qvj.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2020 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5wEq7H/aTNQaC+MLpK5FtBm7PEKzvcE/3MXY5TiR0Ys=;
        b=YLTXn3KDoWVX7zL61wg+vMsOZgSPtjTr51oWZbrLqqzqKyIfqXC4GFPtbCERqT1CCs
         VA+R71NO8RSRnNH9tH/ODzTAqhbP9PfQaUkVo1wEduD8mzCeGgiKxGvx6uey/1ORdHlz
         Z1IA5b/U6cxZJqSJyPnoabyei0tqTQEUlc+MNSTTefOGCd7A13ZZTavYw4EFAu1KT3sO
         z/OEzCawQ45+MV1OyrFgRcqOgbmpVw6euOovQ4zp7j2x1//iNIFAy8IvqGrH7oka3beI
         7awR6Ix5LphIEfJni0C9dFzKDq6zGkgz3Y0aRHt7SmfxxxvCAcWFYlt81oRwuefX18ky
         fghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5wEq7H/aTNQaC+MLpK5FtBm7PEKzvcE/3MXY5TiR0Ys=;
        b=kLhrS+OBy7B+Gg/Ri5qzznwW/9a5Ci1p8Snb9D2oFfGKps8UUY1r6CFy36O8jxyMN/
         ujDF2juTAuy4Wbxe4gWc7hS5Hn0btemVtxB0WkvQZKc6+cmp/2Oikfhbv4ZCAjxo0+K7
         8p/lWYoe7vVs+/QskiYbjzoRQvfaNrkMQgnSUD0w6UONslP/TEqk/rXJy9nDxglxo5ob
         sJ/hs+TD6W/YqyYfOARf8GPZkei4weiLZlZQ7k3K5EPRpsJ+E/BoSS8d+eFAB9k0a14R
         qLXjMJaPea2xeZg9QzsUxUcqUD7PbvbQpnm3vK1n4pw0QRt6F2FhZZpkkqW4UWivZ8No
         AlvQ==
X-Gm-Message-State: AOAM532Ye+kXcGlZy65Uqw2TJAy2nH+6HOCiyCFcJR6L5GBumhRB7r1s
        OKJTk8TzfD9ua74mIqXGgRrc6LF9SC9nrA==
X-Google-Smtp-Source: ABdhPJzXSkwcXJXmHIWjMQ6VwywoEfsm9VoC3QzWrKQhwFovJgEMB/aFmjst1ySbYhBAPUGbD/yC7GxwT3EI5Q==
X-Received: by 2002:a0c:cc94:: with SMTP id f20mr16875759qvl.159.1596835476792;
 Fri, 07 Aug 2020 14:24:36 -0700 (PDT)
Date:   Fri,  7 Aug 2020 14:24:33 -0700
Message-Id: <20200807142429.BlueZ.1.I588558f1e38231193d6e955a4008ce54712d5c89@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [BlueZ PATCH] Disable auto-connect on cancel pair
From:   Manish Mandlik <mmandlik@google.com>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        sonnysasaka@chromium.org, linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

While pairing process is in progress, service discovery starts in the
background. If HOG profile is detected, auto connect is enabled for
that device. This causes future advertisement from that device to
trigger a pairing even if the user has already cancelled the pairing.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 src/device.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/device.c b/src/device.c
index 470596ee4..ab5bb123e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2870,6 +2870,15 @@ static void device_cancel_bonding(struct btd_device *device, uint8_t status)
 	if (!bonding)
 		return;
 
+	/* Auto connect may get enabled during the service discovery even
+	 * before the pairing process completes. In such case, disable it
+	 * when the user has cancelled the pairing process.
+	 */
+	if (device->auto_connect) {
+		device->disable_auto_connect = TRUE;
+		device_set_auto_connect(device, FALSE);
+	}
+
 	ba2str(&device->bdaddr, addr);
 	DBG("Canceling bonding request for %s", addr);
 
-- 
2.28.0.236.gb10cc79966-goog

