Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB33C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 01:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiBJB72 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 20:59:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiBJB7Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 20:59:16 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9385C11
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 17:39:41 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id u16so1836158pfg.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 17:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EKXgK4hvTTvI6KIca/M1Yl6LgjBVeVLvORxpCeuBWYI=;
        b=MPnFr+iiV+bHIxw2dAsFblU8tI1rljyx8rcVSVbaXgt1bJs4Q00Lf58PmEHt6ZyQmV
         J8rGR+wFwvLe1mr361APTPNrGHaWXmqMJ1mWgV1cshb4HcTSRsSmWyu5hI80qhv2RByK
         D3ogjFmzR4RsVZdX2iUAZxV73wGUE8ev14Q4TGABCIl9x1y41VnURl/FMZ6Dp28glI0L
         ImiJHeOWX5o8GzK8kv19iRhcBJsovFGuUp0iXgzK1r0IX3/VzfeOR4WLrqe8waXI0+EO
         USpECu6aqQRtDzWFOTC1s9jOPtcaH3RnzndxhDOLV5TpQVF5u0kzm1ia7D4rTgDmEoW3
         12uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKXgK4hvTTvI6KIca/M1Yl6LgjBVeVLvORxpCeuBWYI=;
        b=pIYCWAhJLh9Gc067wVPLoE/437Mg5HrTJrSU6LisEKmFrDy5uhguKNABAQkXAqnSv2
         DeVkFxZT932DG93SiIReWP0OvkZXYrnUCmm0w9iuNAKZ4qquKds9+qHO81AMvVIVQQSX
         CooZZlOAfglHEtxWCOXsE1x5uW+3zBwslNeE6rkOdG3GCbKaRhvpG96NA4elwoxIlW3d
         5dCjUrl4OXhiNsyh8NlNK7EbcHH6HZ0ca7nLfHf66I8uahVKvZi1CU0+yq53z+uLuAmU
         GveHzBkhOUOM+H8j0H7pz+Wse0EW6ajygeI6IoAC6O88IQDMC0zwu61C38o2BkbdZv/q
         gKxA==
X-Gm-Message-State: AOAM531pLeaAAOmrzCkTTgW8L1amL8aSCmDxnFYr5LJx/UnvF3UEizLz
        jqumiCF+OAaBktWvWBDQRMfS+o8T9kpRcw==
X-Google-Smtp-Source: ABdhPJzuMgkl16dxow/XFCdDs7hP6ivVcDFQ+n2cLd1LRuz0LbZeWEO17z9fMKOpKkTUyM3UIkDh2A==
X-Received: by 2002:a63:287:: with SMTP id 129mr3998698pgc.158.1644450955391;
        Wed, 09 Feb 2022 15:55:55 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm3240799pfi.7.2022.02.09.15.55.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:55:55 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] bthost: Fix length calculation for RFCOMM header
Date:   Wed,  9 Feb 2022 15:55:51 -0800
Message-Id: <20220209235553.150294-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209235553.150294-1-luiz.dentz@gmail.com>
References: <20220209235553.150294-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the length calculation for large packets that requires more
than 1 byte.
---
 emulator/bthost.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index ec7a7eb0d..bb1219d28 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2373,20 +2373,25 @@ static void rfcomm_uih_recv(struct bthost *bthost, struct btconn *conn,
 	uint16_t hdr_len, data_len;
 	const void *p;
 
-	if (len < sizeof(*hdr))
+	if (len < sizeof(*hdr)) {
+		bthost_debug(bthost, "RFCOMM UIH: too short");
 		return;
+	}
 
 	if (RFCOMM_TEST_EA(hdr->length)) {
 		data_len = (uint16_t) GET_LEN8(hdr->length);
 		hdr_len = sizeof(*hdr);
 	} else {
 		uint8_t ex_len = *((uint8_t *)(data + sizeof(*hdr)));
-		data_len = ((uint16_t) hdr->length << 8) | ex_len;
+		data_len = GET_LEN16((((uint16_t) ex_len << 8) | hdr->length));
 		hdr_len = sizeof(*hdr) + sizeof(uint8_t);
 	}
 
-	if (len < hdr_len + data_len)
+	if (len < hdr_len + data_len) {
+		bthost_debug(bthost, "RFCOMM UIH: %u != %u", len,
+						hdr_len + data_len);
 		return;
+	}
 
 	p = data + hdr_len;
 
@@ -2408,6 +2413,8 @@ static void process_rfcomm(struct bthost *bthost, struct btconn *conn,
 {
 	const struct rfcomm_hdr *hdr = data;
 
+	bthost_debug(bthost, "RFCOMM data: %u bytes", len);
+
 	switch (RFCOMM_GET_TYPE(hdr->control)) {
 	case RFCOMM_SABM:
 		rfcomm_sabm_recv(bthost, conn, l2conn, data, len);
-- 
2.34.1

