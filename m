Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDA8EE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 18:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjHUSTJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbjHUSTI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 14:19:08 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D546A12C
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 11:18:51 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-54290603887so2080708a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692641930; x=1693246730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4tBilxFsqpx53dJSqfTUWv5FbMg/2gW36SANu2YnhY=;
        b=L3vmSX3AJkeNirpSq+tKvV6OyAXejhYCa7B/XSp65UpjuVJN0gzi+RCv8QqWXDB3vl
         cah/V4hvlWWMHM1Ttgj5HNKX76YcerAV/A/H852nBZBBDVY83qRVztsvtqo9gXd0ATvi
         s1s5q76CyXI4d5mxeKAd60bSXV6GRHwn9mFIQx+Aw6v4/rBfyV/DBTUpY4lYfYUNet3t
         TdrgdRXVLpNsAaG0INmmB9oTw6F4+5VO9vj7Drg4SfPJdlA6uBXYWdvQfqqyTmAzSNKS
         /y/UAkzwszuIH42Bk7VMNYd/+8bsc4sILWPOCE0HpxsQsFCdUuIzHRu005asm8oB4t2t
         uT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641930; x=1693246730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4tBilxFsqpx53dJSqfTUWv5FbMg/2gW36SANu2YnhY=;
        b=Yt4c5cLRoDOWh4YPdG6ktrylnoNauCIH84PzJC7KXPiQn+l9dvWUqtDij3LEQ+b4sP
         PVHC7LoWHAe0kvr8dmXa1/wkc/LyN7j+V9nkeghQY46XPSE+O4njcJrep9KatLd1EFPj
         w+vLNxHAVR+VpU71TM6Vv8g90+VGia7VJh/v4ZdImxdEXGZoxmhIU3bqiHyFXPm25gfn
         OSE01DAFgGq2kLSfqPEBsc1FU44VYbVHu0fXmxAQk1FUhH+TqIqkEvztlAD3AnL+65hu
         DY2nEexINRIScj0AO/UqKXt39vzPnmamdnudF4Kc7CXtk6Ks3ef+BeHV6wi/j68Pm1sd
         nPEA==
X-Gm-Message-State: AOJu0YyY4zXFsXHfm7o4V25c0tZuUd0fQMC5diZJ9uv/AZ5f74CZPBzW
        WjnzAdESNhk6HrtbXYll4ehSD6FULpg=
X-Google-Smtp-Source: AGHT+IF2S3J22T88DfXjxd8ImuWF+Mhkol0WTPbnSL6JIIR2nTcyfwn1YfWTLwEKg9IOjVpeeulgXg==
X-Received: by 2002:a05:6a20:7da6:b0:148:1e47:3459 with SMTP id v38-20020a056a207da600b001481e473459mr6541366pzj.51.1692641930377;
        Mon, 21 Aug 2023 11:18:50 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id i4-20020a63b304000000b0056420d3cd20sm5964312pgf.71.2023.08.21.11.18.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:18:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_core: Fix missing instances using HCI_MAX_AD_LENGTH
Date:   Mon, 21 Aug 2023 11:18:48 -0700
Message-ID: <20230821181848.3553863-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There a few instances still using HCI_MAX_AD_LENGTH instead of using
max_adv_len which takes care of detecting what is the actual maximum
length depending on if the controller supports EA or not.

Fixes: 112b5090c219 ("Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 6 +++---
 net/bluetooth/eir.c              | 2 +-
 net/bluetooth/mgmt.c             | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6fb055e3c595..6e2988b11f99 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -83,7 +83,7 @@ struct discovery_state {
 	u8			last_adv_addr_type;
 	s8			last_adv_rssi;
 	u32			last_adv_flags;
-	u8			last_adv_data[HCI_MAX_AD_LENGTH];
+	u8			last_adv_data[HCI_MAX_EXT_AD_LENGTH];
 	u8			last_adv_data_len;
 	bool			report_invalid_rssi;
 	bool			result_filtering;
@@ -290,7 +290,7 @@ struct adv_pattern {
 	__u8 ad_type;
 	__u8 offset;
 	__u8 length;
-	__u8 value[HCI_MAX_AD_LENGTH];
+	__u8 value[HCI_MAX_EXT_AD_LENGTH];
 };
 
 struct adv_rssi_thresholds {
@@ -726,7 +726,7 @@ struct hci_conn {
 	__u16		le_conn_interval;
 	__u16		le_conn_latency;
 	__u16		le_supv_timeout;
-	__u8		le_adv_data[HCI_MAX_AD_LENGTH];
+	__u8		le_adv_data[HCI_MAX_EXT_AD_LENGTH];
 	__u8		le_adv_data_len;
 	__u8		le_per_adv_data[HCI_MAX_PER_AD_LENGTH];
 	__u8		le_per_adv_data_len;
diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 8a85f6cdfbc1..9214189279e8 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -33,7 +33,7 @@ u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 	size_t complete_len;
 
 	/* no space left for name (+ NULL + type + len) */
-	if ((HCI_MAX_AD_LENGTH - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
+	if ((max_adv_len(hdev) - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
 		return ad_len;
 
 	/* use complete name if present and fits */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d6c9b7bc8592..ba2e00646e8e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5381,9 +5381,9 @@ static u8 parse_adv_monitor_pattern(struct adv_monitor *m, u8 pattern_count,
 	for (i = 0; i < pattern_count; i++) {
 		offset = patterns[i].offset;
 		length = patterns[i].length;
-		if (offset >= HCI_MAX_AD_LENGTH ||
-		    length > HCI_MAX_AD_LENGTH ||
-		    (offset + length) > HCI_MAX_AD_LENGTH)
+		if (offset >= HCI_MAX_EXT_AD_LENGTH ||
+		    length > HCI_MAX_EXT_AD_LENGTH ||
+		    (offset + length) > HCI_MAX_EXT_AD_LENGTH)
 			return MGMT_STATUS_INVALID_PARAMS;
 
 		p = kmalloc(sizeof(*p), GFP_KERNEL);
-- 
2.41.0

