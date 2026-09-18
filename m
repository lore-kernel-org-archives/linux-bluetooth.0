Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01FC522EE7
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768764; cv=none; b=UKWBhSU1wfkPB3Hb8JBF5jSaj5bYtn4SaueNdadHeFiWmBDpePsMrl2L5IDn927JRxh+PG2AL6lT/WJtFVo7IBAh4M0UGnI50XOBUAOKYsPPRB2R2eX0dNMg424rFHQwuCbcaX0zZHAsWFvKF5KOXu4tF0RGaiJiY876EvA2nIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768764; c=relaxed/simple;
	bh=tsxnqOfgHrCVa0KIwC6bB1iOkZyZ5uHz1J0+CXWgHRQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bQUOZC5p08r7n7LkHYir8yvRCoCbRK6uVj8YunDh4ItB1YD1QEbIftnIPYA10G6MN9RT0m07bi+YBdLY9vJFds7AIxnYWIW29w9HaLJYwWANdpWRWD7SN7wKJs7HRu4wCyLGnwa1V4r0NblM0N7Xp7GzsZOt7WIJ6pgjSRLmZfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5TUSP7U; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5TUSP7U"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c83be8db39so693439e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789768761; x=1790373561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A6IyTXSk5/vu9RCb313HxCIHu9BZ5jHrNuxe5/3bihI=;
        b=f5TUSP7Us41XvoGTA0/7PXoNeqpfjPHQO/OsYOTf+66hB1qmT1+gb/CAnHMOp5YXfH
         T86WfEOgzRq8M4BCqUanOZXtc1mGiZGZvsGz3Pq3uwOCr5eCgk5TW9toz3vAoxVWnpyz
         h+gL5enbzCKHF5S0msxNlT5u8BlrEkoK56sgXA17gpULi49Ig/Rv/a+YM8BKS2HT/ID8
         w1vgfIpFMRnQ0i8jQDWSr1F/uEP3RQja6BviQS4pkxkCi2zrhVgTniSlblwY5HV1HnDU
         FG0eU0bwOClJUiNMeEJn6k1V58/5/OB9Ks8BzkRJqKphdJGKkXswSojND5j9jd/99gVT
         8W7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789768761; x=1790373561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A6IyTXSk5/vu9RCb313HxCIHu9BZ5jHrNuxe5/3bihI=;
        b=DV8T2WRHVgkoo0iosv4AXJqf230VJwZbw7vLbQEtsXDzSy6SJ4A8N9HAzjAPV2BnG2
         Hxb4wvr7bQQgbCZwCVGdLoqhnVdLtwP17oznon4BX7aBjB4C2EbXUGOPKIyr5Tmz4Qlo
         tQ/LT2J4+bHFrHCYQlOchUQbY3RuIgs5smdMU8RsXMvhnQPe8JN+rko0numv4Ie3fq6v
         3q9qJWDAyWL145/pVvRAFP7MjemBqJSFYZcdbhfzIsSPpXFbk6tnLogUVWqzI1hlpw6l
         AencexEv19EMcImNSiE8+bpCRW7r4YXp6bfmercWYBM0PhAkhYlvgSB+acFac35taiQx
         BfxQ==
X-Gm-Message-State: AFuF++meuiI2/axzw1P33YG1AaitSCf6ZevgkXoRR4vOEdiFkxj0TrCX
	gXh31F1zBtD91smXzOtEKB9ts/vYTCW1L7Pc0bm/ncsH2X3qsAGrq/KBRqbKdzbu
X-Gm-Gg: AYBFou0beEmv80I9iQPEAQkzdKUl0+gqZ5/WxEtLHG6skayxBUvV6pSLjTJmVoQQ18F
	u7MqV13gId4rRi6tcpsZjpEWFsH6t3YeQ3B1LILmYzbYuyhKc14DCPPrJFCsbS4EdljkKp9/wJx
	OC0ok2pB988E1wZYZssQuJ9u1pKqmKVqc/VR8YaaRv4s1T0E1hvdZkRelWcco6eqYWtYaPImxAs
	keOEoLK34zz4OyvCuSLVdlHVZAHIqi1MLUlw4fQuVQd0k1alTlBxn9dp0XlGlTZHe0fW0vFqFiZ
	x1f0d1UXfVlJljNI056wrMQUpDE7sJWr7VpgW5R95ShkrPdyDTCqnBak3wR2pR6dgzoodrmKrT4
	96b4dqM4KHIGB0omZQtF7eehl0hMOZYBRnpt59wAE7DWeEG1Av6Oo6nF6p8SjTAA180GNf+c4x/
	YqvbsW5jrLmi3ComDsrtFVKX1dRLFXBfrvd0pj1ntwrG6CHVp/VIiW6D+ksOfCNN7fK8DUhzpyS
	Sa8qdwi3usyHRvGva2TSWTS9/CneTBD4FTdFFMXDBVYlb2pwrWTBqNVlNsSlaAq
X-Received: by 2002:a05:6122:3c46:b0:5c6:7f44:b001 with SMTP id 71dfb90a1353d-5c9b578a7b6mr2046211e0c.0.1789768761401;
        Fri, 18 Sep 2026 14:59:21 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9c195a6desm763109e0c.14.2026.09.18.14.59.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 14:59:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] adapter: remove the devices from the list before freeing them
Date: Fri, 18 Sep 2026 17:59:15 -0400
Message-ID: <20260918215915.2572126-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The devices of an adapter are freed one by one when it is removed, but
the list keeps pointing at them until every one of them is gone, so it
refers to freed devices while the remaining ones are being removed.

Freeing a device looks devices up though, e.g. cleaning up its GATT
server reports the disconnection, which searches the list for the
device it belongs to, and the search reads the devices already freed:

  ERROR: AddressSanitizer: heap-use-after-free
    in bacmp lib/bluetooth/bluetooth.h:438
    in device_addr_type_cmp src/device.c:5657
    in btd_adapter_find_device src/adapter.c:1055
    in att_disconnected src/gatt-database.c:335
    in gatt_server_cleanup src/device.c:842
    in device_free src/device.c:918

Take each device out of the list before removing it, so only the ones
still to be removed are ever found.

This needs more than one device on the adapter to show up, which the
test of a coordinated set is the first to leave behind.

Assisted-by: opencode:claude-opus-5
---
 src/adapter.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 717db2ea9bfe..50b4dc6d724e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7293,7 +7293,6 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 
 static void adapter_remove(struct btd_adapter *adapter)
 {
-	GSList *l;
 	struct gatt_db *db;
 	struct btd_ranging_provider_manager *ranging_manager;
 
@@ -7302,13 +7301,19 @@ static void adapter_remove(struct btd_adapter *adapter)
 	g_slist_free(adapter->connect_list);
 	adapter->connect_list = NULL;
 
-	for (l = adapter->devices; l; l = l->next) {
-		device_removed_drivers(adapter, l->data);
-		device_remove(l->data, FALSE);
-	}
+	while (adapter->devices) {
+		struct btd_device *device = adapter->devices->data;
 
-	g_slist_free(adapter->devices);
-	adapter->devices = NULL;
+		/* Take the device out of the list before removing it, as
+		 * freeing it looks devices up, e.g. when cleaning up its
+		 * GATT server, and the ones already freed would still be
+		 * found.
+		 */
+		adapter->devices = g_slist_remove(adapter->devices, device);
+
+		device_removed_drivers(adapter, device);
+		device_remove(device, FALSE);
+	}
 
 	g_slist_free(adapter->discovery_found);
 	adapter->discovery_found = NULL;
-- 
2.55.0

