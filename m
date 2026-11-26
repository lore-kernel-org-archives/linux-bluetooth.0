Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795651484;
	b=HGZXQ5vk1JExTCVv5Dnf/0SfsB/NVNtGdmpZruqlvKgDVqppv5uoSu6mLhZFqqkREakz
	 R0qua9DqsMcc/xJXv5/rdVTuQYUDp04d4TLukKB2LNtgNp7pP5fREEQfYMRDfGUOe1gQA
	 fC/B7kXLqr6thoMufGebV/XV8ucTRx35rhVy42T9UoPbb9qVR2NiL7HSv4ZTRdNkhG172
	 CWlmTOBmJl00uV+zq7Dt0/DMb8RDdIDCipOpYb+nRcSCvfpBk8gsVDdaFxWLonFTRw79n
	 vBcpGqkUqR0qLVAveqOLHXCCwVKvgKnFeUogNk2c8yIQ8aKP/C0cM0nQZRs29HyZYYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=temVQvDVu+s05Df0IBCe5kNFmrbC8OpyvSIXnzE63yo=;
	b=t72FL9i1XuXQs1n7ie3a8ywWkHPId7mHszmgcHHiXoVssaWcjmm4wHG407dEldt+0CBb
	 3/jqK0aCguMIVOcO1itGDvo4VBZ6MvcNhccZ7ghWonMUlK9YPb1iVb5gGG5fBqZP3XZvh
	 igtgBoSF2Yz24d6lA0bbcpYGoNyVRFJjLL5M2dEH8iXIR7l/VwKXbN7ln5Z7pzfpgiZ9l
	 YuE1OFcaqJ8l4pCUgHG0xflQMsHvs6T2F9RZHxoOWVYeXarIjZAvFlhj04f2QnSYZ+XoB
	 T8fA89uYOKQQcp/oVPGDSJ8yLsan6C8DB6zPfEo6AX3MRLMi6RlukydyiV53c2i7tAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jpld5Cvl;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978AA606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 00:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 978AA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jpld5Cvl
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso4346056a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795651483; x=1796256283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=temVQvDVu+s05Df0IBCe5kNFmrbC8OpyvSIXnzE63yo=;
        b=jpld5CvlZnvsV3smmcefZ7IV4wBfhaoVsuPhKGhVO/FjSqPlnvc0XndbhxrArEP6e/
         PRkiU8nfyHFZzeI1ATL8U75fmq2cbb7w1oFokGzQaStxB2kbeju296JdQ/sllviiAfaR
         jALVjEXVSZXjhnUYdgoE7kq0e67+XXvVjeIV4hXtyxHKST5OYbQj1x9ty0J4FH9EfTY2
         gt2nHc6qpV9YnZwIBBtAvpfZuUQIdX3FEc8LD67345egfK7nTEe+opR0EtJK6Zc8pLRF
         YOKPIa6bY/0iVkRvLBcnBhwdDDpp87TV6eG9rzEoFnOaceLOmQKdpHBKiCcokM6I04vq
         a2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795651483; x=1796256283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=temVQvDVu+s05Df0IBCe5kNFmrbC8OpyvSIXnzE63yo=;
        b=IKucPgI1XlhyAMV7r4PZPHFGIbh0mueU5w1hMSctUU8l3+09BN/t1Ko0AbTI33skSi
         QlysT2b2OXeB18314Y4U7C9HSQvNvZGs8FbXnfKKgAmLP+wfBRUMeVMCRtav7kGrtG60
         NlZWDhEBwBfaGLUThwpVqUZFgayHY7GsL70c+AYvbPHANYMm2bp+COFCWBBJ0VqyI7pE
         U7w93DpMERuvWKhs22Ie+8padu+hOtpGUaB0ENezY96/S5vUd+fDiZi0VsMCXORXQ0Gn
         nEMsQY6+NneLruHxrhffGuXUfIXaDBbHM6E5PoK1EvNPdUbyt+315MhAvjb+BHJxXFpi
         cZ+A==
X-Gm-Message-State: APuU4Z+6DAvuFtGIxwOAZr2cykvyg6/v2MzYh5tuHURST0Im1zYl0SOc
	Kp9LTLQC1wufe/2h4OPMqL9h8wOZRxVTjHdXyDgm6p6d61F7PpfIpVH/w0FD6A==
X-Gm-Gg: AZFdTZd3Ci3s0a0Q8IUqb75InqvIJuEqBxuD/pk0de54kKYXs7NQVAjXp0V/jYdt1xn
	Qg1S2Vgf3ZvzsT49eKdnBcE45obj3zs3+0UwTuWC/EObKIVPyWn56t3O8XtnAd9uFrXu8uEQ0HZ
	S5CwFPC24bYKiv66J5YV1xlNppSU7+TBWIsIp7aVb8H/e3+T8/wwYLosZue7vCF9OMeHcBG1JdS
	T3GvCuUwX4nuqXrev7D5R1p8MAjEcfdbz787MTjUfaAGAOxdH2MPhkROD8Q8iVVznS0o2T66dgX
	M5OV4RkSxQa5isThwvPadOWBLHOjasJkGmNFD68js+GjX67R+iZSe5vXyjQJJrgdYDLs76X3mBf
	sSewDusZWJpuPdwMrSmcP4Q1w8CtrwzZNi3PSieBDOayjgbSRbf3vhbMJJI+b6tDNSh6RcsI3Rp
	1eFfIUlrTvxY6TyxKcbWXVqsj3pc/55lz+qRIYzdwjH/7Kte5e8zA0kgK3TJtJ07WHyRXL1uTb/
	+9QwX9LETbCxN9UyROJYud+SthwNeQLFp8owE9B17DFw+JM/1SN+SwLKSBh3ASyNH6LApeoVn/D
	+REV8G5epZS4ed749WhjhYs4Xr/NypTZ9k6hFiK/9jHDQ2yS7qJGFAIXUvOwB4MThGY9RFcEOaU
	gTSGriptPBtrK9L1kSznCFq6w7cKPNWKm1gXEg2Kqjz4ilCN3L5YgTAtTJzgZS4W4gKG07x7IDy
	wgcg==
X-Received: by 2002:a17:90a:d444:b0:3b4:15e3:3a53 with SMTP id 98e67ed59e1d1-3b41cb53acbmr18503178a91.66.1795651482731;
        Wed, 25 Nov 2026 16:04:42 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcfe23sm29613845a91.15.2026.11.25.16.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 16:04:42 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kiran K <kiran.k@intel.com>,
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] Bluetooth: btintel_pcie: fix context analysis error in YoYo config sets
Date: Wed, 25 Nov 2026 16:04:39 -0800
Message-ID: <20261126000439.318058-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_pcie_apply_yoyo_config_sets() takes mac_access_lock only for
PERIPH_MAC and DEVICE_MEM config sets, writes the pairs, and later drops
the lock under a second, identical type check. Clang's context analysis
cannot correlate the two conditions, so with CONTEXT_ANALYSIS enabled for
drivers/bluetooth the build fails:

  drivers/bluetooth/btintel_pcie.c:1052:12: error: mutex 'data->mac_access_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  drivers/bluetooth/btintel_pcie.c:1110:4: error: releasing mutex 'data->mac_access_lock' that was not held [-Werror,-Wthread-safety-analysis]

Move the pair-writing loop into a helper and take and release the lock
within a single switch case for the indirect config set types. No
functional change.

Fixes: 5bf3a9b6b720 ("Bluetooth: btintel_pcie: Serialize MAC access requests")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/bluetooth/btintel_pcie.c | 159 +++++++++++++++----------------
 1 file changed, 79 insertions(+), 80 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index d7d0e890dfbb..7cbf6d2df491 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -997,6 +997,70 @@ static void btintel_pcie_yoyo_send_hcmds(struct btintel_pcie_data *data,
 	mutex_unlock(&data->yoyo.lock);
 }
 
+static void
+btintel_pcie_yoyo_write_pairs(struct btintel_pcie_data *data,
+			      struct btintel_pcie_yoyo_config_set *config_set,
+			      resource_size_t bar0_len)
+{
+	u32 pair_addr, addr, value;
+	u32 i;
+
+	for (i = 0; i < config_set->num_pairs; i++) {
+		pair_addr = get_unaligned_le32(&config_set->pairs[i].address);
+
+		/* Calculate the effective address by adding the address offset */
+		if (check_add_overflow(pair_addr, config_set->addr_offset, &addr)) {
+			BT_WARN("YoYo: config set address overflow (0x%08x + 0x%08x)",
+				pair_addr, config_set->addr_offset);
+			continue;
+		}
+
+		value = get_unaligned_le32(&config_set->pairs[i].value);
+
+		switch (config_set->config_set_type) {
+		/* Direct Address Access (CSR) */
+		case BTINTEL_PCIE_CFGSET_CSR:
+			/* Validate the effective address for CSR access (Direct Address)
+			 * addr not aligned to 4 bytes or exceeds the BAR0 length
+			 */
+			if ((addr & (sizeof(u32) - 1)) ||
+			    bar0_len < sizeof(u32) ||
+			    addr > bar0_len - sizeof(u32)) {
+				BT_WARN("YoYo: bad CSR address 0x%08x for BAR0 length %llu",
+					addr, (unsigned long long)bar0_len);
+				continue;
+			}
+
+			BT_DBG("YoYo: CSR write [0x%08x] = 0x%08x", addr, value);
+			/* addr may be PRPH_DEV_* or HBUS_TARG_WRPTR */
+			spin_lock(&data->dev_mem_lock);
+			btintel_pcie_wr_reg32(data, addr, value);
+			spin_unlock(&data->dev_mem_lock);
+			break;
+		/* Indirect Address Access (Peripheral MAC and Device Memory) */
+		case BTINTEL_PCIE_CFGSET_PERIPH_MAC:
+		case BTINTEL_PCIE_CFGSET_DEVICE_MEM:
+			/* The config-set TLV comes from an untrusted external file;
+			 * reject null or unaligned targets.
+			 */
+			if (!addr || (addr & (sizeof(u32) - 1))) {
+				BT_WARN("YoYo: bad indirect address 0x%08x for type %u",
+					addr, config_set->config_set_type);
+				continue;
+			}
+
+			btintel_pcie_wr_dev_mem(data, addr, value);
+			BT_DBG("YoYo: indirect write type %u addr 0x%08x value 0x%08x",
+			       config_set->config_set_type, addr, value);
+			break;
+		default:
+			BT_WARN("YoYo: unknown config_set type %u",
+				config_set->config_set_type);
+			break;
+		}
+	}
+}
+
 static void
 btintel_pcie_apply_yoyo_config_sets(struct btintel_pcie_data *data,
 				    u32 time_point)
@@ -1004,7 +1068,6 @@ btintel_pcie_apply_yoyo_config_sets(struct btintel_pcie_data *data,
 	struct btintel_pcie_yoyo_config_set *config_set;
 	resource_size_t bar0_len;
 	int ret;
-	u32 i;
 
 	if (!data)
 		return;
@@ -1016,98 +1079,34 @@ btintel_pcie_apply_yoyo_config_sets(struct btintel_pcie_data *data,
 		return;
 
 	list_for_each_entry(config_set, &data->yoyo.config_set_list, list) {
-		u32 pair_addr, addr, value;
-
 		if (config_set->time_point != time_point)
 			continue;
 
 		switch (config_set->config_set_type) {
 		case BTINTEL_PCIE_CFGSET_CSR:
+			btintel_pcie_yoyo_write_pairs(data, config_set, bar0_len);
+			break;
 		case BTINTEL_PCIE_CFGSET_PERIPH_MAC:
 		case BTINTEL_PCIE_CFGSET_DEVICE_MEM:
-			break;
-		default:
-			BT_WARN("YoYo: unknown/unsupported config_set type %u, skipping",
-				config_set->config_set_type);
-			continue;
-		}
-
-		if (config_set->config_set_type == BTINTEL_PCIE_CFGSET_PERIPH_MAC ||
-		    config_set->config_set_type == BTINTEL_PCIE_CFGSET_DEVICE_MEM) {
 			mutex_lock(&data->mac_access_lock);
 			ret = btintel_pcie_get_mac_access(data);
-			if (ret) {
+			if (ret)
 				BT_WARN("YoYo: MAC access failed for config set (%d), skipping",
 					ret);
-				/* get_mac_access() asserts MAC_ACCESS_REQ before it
-				 * polls, and leaves it set on timeout; drop it so the
-				 * request bit is not leaked.
-				 */
-				btintel_pcie_release_mac_access(data);
-				mutex_unlock(&data->mac_access_lock);
-				continue;
-			}
-		}
-
-		for (i = 0; i < config_set->num_pairs; i++) {
-			pair_addr = get_unaligned_le32(&config_set->pairs[i].address);
-
-			/* Calculate the effective address by adding the address offset */
-			if (check_add_overflow(pair_addr, config_set->addr_offset, &addr)) {
-				BT_WARN("YoYo: config set address overflow (0x%08x + 0x%08x)",
-					pair_addr, config_set->addr_offset);
-				continue;
-			}
-
-			value = get_unaligned_le32(&config_set->pairs[i].value);
-
-			switch (config_set->config_set_type) {
-			/* Direct Address Access (CSR) */
-			case BTINTEL_PCIE_CFGSET_CSR:
-				/* Validate the effective address for CSR access (Direct Address)
-				 * addr not aligned to 4 bytes or exceeds the BAR0 length
-				 */
-				if ((addr & (sizeof(u32) - 1)) ||
-				    bar0_len < sizeof(u32) ||
-				    addr > bar0_len - sizeof(u32)) {
-					BT_WARN("YoYo: bad CSR address 0x%08x for BAR0 length %llu",
-						addr, (unsigned long long)bar0_len);
-					continue;
-				}
-
-				BT_DBG("YoYo: CSR write [0x%08x] = 0x%08x", addr, value);
-				/* addr may be PRPH_DEV_* or HBUS_TARG_WRPTR */
-				spin_lock(&data->dev_mem_lock);
-				btintel_pcie_wr_reg32(data, addr, value);
-				spin_unlock(&data->dev_mem_lock);
-				break;
-			/* Indirect Address Access (Peripheral MAC and Device Memory) */
-			case BTINTEL_PCIE_CFGSET_PERIPH_MAC:
-			case BTINTEL_PCIE_CFGSET_DEVICE_MEM:
-				/* The config-set TLV comes from an untrusted external file;
-				 * reject null or unaligned targets.
-				 */
-				if (!addr || (addr & (sizeof(u32) - 1))) {
-					BT_WARN("YoYo: bad indirect address 0x%08x for type %u",
-						addr, config_set->config_set_type);
-					continue;
-				}
-
-				btintel_pcie_wr_dev_mem(data, addr, value);
-				BT_DBG("YoYo: indirect write type %u addr 0x%08x value 0x%08x",
-				       config_set->config_set_type, addr, value);
-				break;
-			default:
-				BT_WARN("YoYo: unknown config_set type %u",
-					config_set->config_set_type);
-				break;
-			}
-		}
-
-		if (config_set->config_set_type == BTINTEL_PCIE_CFGSET_PERIPH_MAC ||
-		    config_set->config_set_type == BTINTEL_PCIE_CFGSET_DEVICE_MEM) {
+			else
+				btintel_pcie_yoyo_write_pairs(data, config_set,
+							      bar0_len);
+			/* get_mac_access() asserts MAC_ACCESS_REQ before it
+			 * polls, and leaves it set on timeout; drop it in both
+			 * cases so the request bit is not leaked.
+			 */
 			btintel_pcie_release_mac_access(data);
 			mutex_unlock(&data->mac_access_lock);
+			break;
+		default:
+			BT_WARN("YoYo: unknown/unsupported config_set type %u, skipping",
+				config_set->config_set_type);
+			break;
 		}
 	}
 }
-- 
2.56.1

