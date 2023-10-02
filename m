Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACBDE776D1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 23:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbjJBXNX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 19:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjJBXNW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 19:13:22 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E823AC
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 16:13:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c328b53aeaso2455535ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 16:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696288398; x=1696893198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0DzF5mqOD1kMWTkgMUl5iJBtPUnq8TgdRfUEKxTAb0=;
        b=Tow5NGx2qoS1i+5rRupn14fM9Oqfq4Fz/G9ULh1TVOsWtnTa31/oGWQBNlQi9gBmjA
         OWt3lRpbhFxSy0AbOVe+dyz1djiv92d4GScZp+1BEgyfbdbM8Ga4qKW7BKHteZvkgMsS
         XhQc2WwErckUJePWuteIOZbYt4OO12oJzbYLt+FSvpF0KiopiROP+axHe4snLXVBpR/f
         yukQ2oPTSxqwhC9jfAG2JFsASDns0276sNru3tPLGdzE5sKGaPhRmaRr/EJsTKK6ynTo
         NLPP+UFetzoo5pKL2GdUIiCwNP2m2YF+bmcX3/7f9h7qZ4lyTFlE5OjFYkplqAQ0XpOr
         zr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288398; x=1696893198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0DzF5mqOD1kMWTkgMUl5iJBtPUnq8TgdRfUEKxTAb0=;
        b=pidGTDr3SAUbLE4zYYXSSTfOt+K+holhkevMTaOmG/JFC6LGQdKHdjy4Lpg0ss8Ywu
         lD8MzQaYFQFgyDalDD1d6pk1PLkLr5aE5ZXlwc9CXj9lbxQhENO16IDlhOQuclwxvHZX
         sH3zToF+iQgMVlQnRoU8f338YE+1R9kcGBCjFHCVjRfAeO6H7vuFUndnqnHtUs/Gb/k8
         Egwbu25HTdbIICux1GuvMxbMe92BE8j6Kh0fFIKwOcEcnU0CyEzFy3RCJdMoXw4J6Jcy
         bS2Q/ejLmuBvZ7feNQPKQsU2rR2e7CKHJuMqkGm7fcPzb6xRcvo8tEiCkr3QuOqw0nR2
         5XCw==
X-Gm-Message-State: AOJu0Yw8/Pc5ZRQbe5JZu1BPLqE1JG7MQJnjpr//hzH+IAoeA1whGsLj
        nGMSYny5xnB2RlsNUpvnjKyWRoseoujHDxTp
X-Google-Smtp-Source: AGHT+IHtcqRVROIlUg6dmW8xcP3/xfL7roi+GlT64K7LwOoO2NnsmaWDR5MhC82mHOe5AgdjgiF1YQ==
X-Received: by 2002:a17:902:9b8e:b0:1c0:cbaf:6930 with SMTP id y14-20020a1709029b8e00b001c0cbaf6930mr11958854plp.54.1696288398399;
        Mon, 02 Oct 2023 16:13:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d34b00b001c75627545csm5181817plk.135.2023.10.02.16.13.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:13:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] device: Add btd_device_get_ltk
Date:   Mon,  2 Oct 2023 16:13:08 -0700
Message-ID: <20231002231311.3104749-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002231311.3104749-1-luiz.dentz@gmail.com>
References: <20231002231311.3104749-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btd_device_get_ltk function which can be used by plugins to
access the LTK key.
---
 src/device.c | 17 +++++++++++++++++
 src/device.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/src/device.c b/src/device.c
index 35ce1df0fe74..a734fff0dc73 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1938,6 +1938,23 @@ void device_set_ltk(struct btd_device *device, const uint8_t val[16],
 	queue_foreach(device->sirks, add_set, device);
 }
 
+bool btd_device_get_ltk(struct btd_device *device, uint8_t key[16],
+				bool *central, uint8_t *enc_size)
+{
+	if (!device || !device->ltk || !key)
+		return false;
+
+	memcpy(key, device->ltk->key, sizeof(device->ltk->key));
+
+	if (central)
+		*central = device->ltk->central;
+
+	if (enc_size)
+		*enc_size = device->ltk->enc_size;
+
+	return true;
+}
+
 static bool match_sirk(const void *data, const void *match_data)
 {
 	const struct sirk_info *sirk = data;
diff --git a/src/device.h b/src/device.h
index 0a9e51533ca5..8bb38669d457 100644
--- a/src/device.h
+++ b/src/device.h
@@ -132,6 +132,8 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
 bool device_is_disconnecting(struct btd_device *device);
 void device_set_ltk(struct btd_device *device, const uint8_t val[16],
 				bool central, uint8_t enc_size);
+bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
+				bool *central, uint8_t *enc_size);
 bool btd_device_add_set(struct btd_device *device, bool encrypted,
 				uint8_t sirk[16], uint8_t size, uint8_t rank);
 void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
-- 
2.41.0

