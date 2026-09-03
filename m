Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6842E413
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426684; cv=none; b=So6kChbOFodAEr/QRW96LWVRFI12wK8oWGVNPb6fKxp3u9szMCqOKCjvAWvV6Qh8p8WOOXueHESfJwvqZOnhMY+Aml03i/BEQupXMLO/HcnQUvq4XunOElEhy6LKyTxalvGG6t/OJiL2HRqhOnKOJhYrhW7RTPBpXfcCHHaa0TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426684; c=relaxed/simple;
	bh=m6rRouBqTD8wYB6xYEA3iz5+ezLOrk/yv/8FzcqTaJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yzl0FImQPFwNYQ7JNSD6GQYLcy0bip7dwlHCFhQ53P06fgRjxLurX41UJydJMCkiZxB0eMQ5KWW+GO6RWPEWSfM5Kp65iT+Txiu+2tBW0wFjcInRMZK15bVwyGUWsaJEPAzVylmZmeId9rU4vq8tAslh4idfgAWK3lf5ghcz2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWX95n89; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWX95n89"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48442ea8f59so566510f8f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788426681; x=1789031481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RDCdGcCSOMXzzpQihpMv+rHNOJrDWM/vfqnwxo8WB5Q=;
        b=JWX95n89oCGWMzDULxVO0pyOTXAg11u84DQYH5d1EVdS9v0ThkAshlISBje3F2P9bQ
         Jtct6NsOe3Q14TKK+cTsEd8EmseZqn7bLvPl+WcGBRLJ5Ji5+ztDbg9kwO3PvN4vbgWU
         Xl5izIsayOMSZwrna3sWA8C/idEMab/y8+zFPSXHgkgPDSxhQZdgntq8im/9y266wDjR
         t+LgA4N13b5WoB2scwGv1OV2ZvgJFktKWDIlJW9agjNxM9BzqCxixWP9PZCoQ+P0Oc+U
         dgjSlr98NS3vNfDhkHqMHP14394FUJNx1/H90YncOkZFO03gArIq8uqAw9C+oR9xYnGS
         q7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788426681; x=1789031481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RDCdGcCSOMXzzpQihpMv+rHNOJrDWM/vfqnwxo8WB5Q=;
        b=otaHhzI2LhJct0D/StxPxLIGzfU1pSWHqDKHfR59LShmDEXfkYNyO7FCsJ2L14ySsq
         PG4kcfHOHY5UMRH5BvBfRMcdXTe41qO+XyHU53bYasO4Gy712eJd/qS+XoUPzXjhI0KJ
         wtcahMbMiG2lmvK9Hf3u7SC2UaL96z395DrRTlLyUcXq7KaSHtKIG0/aMQsfOpzNvaiS
         pGI8+fVEHT5wyUEPAcr00wdFjD1rj2OHvY1c0+ryESAaDE+kTDWR4LLdyU16faac3j7X
         iwh4lzpsD3yO7O4rOmb2YFu0aoMhPhiVyCCp9O+WdYTiDtsKEH6xS4uDbMyGv5ndvGBU
         Hgkg==
X-Gm-Message-State: AFuF++mPwF76FDYy8uoBdfiRvZC1xIJMMmDsWB/9X11IgKd3QrSQNyc1
	adTHhTGQ0LfmAWMBzd0MQl27CyerdEb/10pkC4nQX4/eSdtig0Q5fdyFIK5/Jc0m
X-Gm-Gg: AYBFou3MFad8B8eB89roaqjbbuBN3xHj0LVsihL8yGWlMY6R5l1qGbvE+RoojqgDFsw
	ehQ44NguXaFE9aGpW+b3mzhVyCmSo/6Kb7gmOGfZ0n9emrR9cPMBm5pfH/O3q3aINUW/dlUTjAI
	FJfAFkWg2nDYfSMPP7IoUTnH+zxVoqLFYsZtvECifYO5hGhCqsiNNqNM3ehTnzSjS5TNqZi68/Q
	mF9XMTS6fVHFT+8P3X2i/60FF1biRxoAVBHLc5TwcDh76ylxr8690azoYJ1/SVM560RPJ45cTiU
	q0AqeRFk3SSq0VVIYKCVL4aOZ+tTF5S5+C9v/7nXfnWYETM9YjGHqocY/98OZ9BepuKR5IkIS3t
	Ds+S56B6/ZKIij2Qd74BVeNdDN9LsdGijBaD6TGhJIUWotjvV+dIpH2r9kc3hzsP3EUiArRyoLT
	g7vziYF8vVhrPQGhiD4GpN264uQ82X+BnRCDqtdU5HfTtQzHSTXzJKy8HDDDZ9JSqp9J8nOu9H7
	eT7fE9dvCnIeRD0XzmrQGbVNZEdJbhgIlifUKtYfm2IzyeRXjdeMiPjlW2mg6o8
X-Received: by 2002:a05:600c:37c3:b0:49c:f13e:e4f with SMTP id 5b1f17b1804b1-49cf15aeffemr5910055e9.12.1788426680671;
        Thu, 03 Sep 2026 02:11:20 -0700 (PDT)
Received: from MYL150-3871.localdomain (80.151.89.79.rev.sfr.net. [79.89.151.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee3acf2csm52835575e9.0.2026.09.03.02.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:11:20 -0700 (PDT)
From: Nicolas Thibert <nithibert@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Nicolas Thibert <nithibert@gmail.com>
Subject: [PATCH BlueZ v2] adapter/advertising: fix mgmt endian bug
Date: Thu,  3 Sep 2026 11:10:59 +0200
Message-Id: <20260903091059.161705-1-nithibert@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several places in adapter.c and advertising.c write a native-endian
value directly into a __le16/__le32 field of an mgmt command struct,
skipping the cpu_to_le16()/cpu_to_le32() conversion used everywhere
else in this codebase for the same purpose. This is a no-op on
little-endian hosts (where cpu_to_le16()/cpu_to_le32() are themselves
no-ops), which is why it has gone unnoticed, but corrupts the value on
big-endian hosts.

Confirmed live on MIPS big-endian (OpenWrt/ath79): set_blocked_keys()
sends key_count=2 (2 blocked keys), which the kernel's
__le16_to_cpu() correctly interprets as 512 (0x0002 byte-swapped is
0x0200) since the wire bytes were never actually swapped to little-
endian on the way out -- producing "expected 8706 bytes, got 36
bytes" / "Failed to set blocked keys: Invalid Parameters" errors in
dmesg/bluetoothd logs.

add_advertising()'s cp->duration and refresh_extended_adv()'s
cp.duration/cp.min_interval/cp.max_interval have the identical bug. It
is inert with bluetoothctl's default (0) duration/interval values (0
byte-swapped is still 0), but A/B tested live (patch removed vs.
applied, bluetoothctl's advertise submenu "interval 100 100" set
explicitly) confirms this is not just a theoretical correctness fix:
with the bug present, the device stops being discoverable by a real
BLE scanner the moment a non-default interval is requested, and
becomes discoverable again immediately once patched. Any application
that sets an explicit advertising interval or duration hits this.

v2: use cpu_to_le16()/cpu_to_le32() instead of htobs()/htobl(), as
requested by Luiz. Retested live on the same MIPS big-endian board
(blocked keys + explicit advertising interval): behaves identically
to the v1 fix, no regressions.
---
 src/adapter.c     | 5 +++--
 src/advertising.c | 8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7390ceeee..edbdb53b5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10219,10 +10219,11 @@ static bool set_blocked_keys(struct btd_adapter *adapter)
 					sizeof(blocked_keys)] = { 0 };
 	struct mgmt_cp_set_blocked_keys *cp =
 				(struct mgmt_cp_set_blocked_keys *)buffer;
+	const uint16_t key_count = ARRAY_SIZE(blocked_keys);
 	int i;
 
-	cp->key_count = ARRAY_SIZE(blocked_keys);
-	for (i = 0; i < cp->key_count; ++i) {
+	cp->key_count = cpu_to_le16(key_count);
+	for (i = 0; i < key_count; ++i) {
 		cp->keys[i].type = blocked_keys[i].type;
 		memcpy(cp->keys[i].val, blocked_keys[i].val,
 						sizeof(cp->keys[i].val));
diff --git a/src/advertising.c b/src/advertising.c
index 1ed09c902..3f70fb4e9 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1042,7 +1042,7 @@ static int refresh_legacy_adv(struct btd_adv_client *client,
 
 	cp->flags = htobl(flags);
 	cp->instance = client->instance;
-	cp->duration = client->duration;
+	cp->duration = cpu_to_le16(client->duration);
 	cp->adv_data_len = adv_data_len;
 	cp->scan_rsp_len = scan_rsp_len;
 	memcpy(cp->data, adv_data, adv_data_len);
@@ -1093,13 +1093,13 @@ static int refresh_extended_adv(struct btd_adv_client *client,
 	 */
 
 	if (client->duration) {
-		cp.duration = client->duration;
+		cp.duration = cpu_to_le16(client->duration);
 		flags |= MGMT_ADV_PARAM_DURATION;
 	}
 
 	if (client->min_interval && client->max_interval) {
-		cp.min_interval = client->min_interval;
-		cp.max_interval = client->max_interval;
+		cp.min_interval = cpu_to_le32(client->min_interval);
+		cp.max_interval = cpu_to_le32(client->max_interval);
 		flags |= MGMT_ADV_PARAM_INTERVALS;
 	}
 
-- 
2.34.1

