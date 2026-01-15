Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6D30E0C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487952; cv=none; b=bOKwbVw8Kz4QNa2tQvkDIziSsRZz78jm2x5kVXrP9wcY0uAujMZ/V+l+HuL0peh2Ex45hA2AkyH3g3ccyzjEdWSNBzT2x7tAJfLrK7AG3idRMgTl+KvqtlBzJOT4uuuv+t4EqSl/cvXhEubO/SxvdR/cY0ENV8e3WUA66L1qzxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487952; c=relaxed/simple;
	bh=p5agh71wO/AUeCFsuDnzqppOoBoj+RkKbJD1JzLaxoI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dpf9tIt035XRlKTXpCbGjzpmr/8UX5JwsVrjL3+1kf6dkmzDdu2KnLsw4DVOD9fKUG15yEgVeffdnhkaVLMMTFu7oN2OG/G5Zm8BUQg+tqu0DDYsXslKdHurYk1MZBmzPZrvZ2ol07+RexV5GQwih2nRbGGWW0cZ74Ginhqs26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fBSGlOjq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fBSGlOjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768487945;
	bh=p5agh71wO/AUeCFsuDnzqppOoBoj+RkKbJD1JzLaxoI=;
	h=From:To:Subject:Date:From;
	b=fBSGlOjqh8B8hv80sEKJjhlc75tkr5GGyDhLfjKnyKMuwsDHspo8BKDZ2v7/7gtHF
	 bVQfgeVTRzAA+fW5uyTa1XnCVogJBxUiSq7yJvxOxc8hes250JJxqYheYR4a8zmOMA
	 uKGazhQYvP/SPH97KEsIcK6SEJ7q8ps7kWmKWPbCeQQTim+1RBeLeoUllpOUezan7K
	 JYKUm7xVnhDR9ho17zqc5XrBZXJ8RTxSnynmq6+4tkDyqSMRS1o/5G8/WbORPwBYQZ
	 S5gmbcK7b3e4zT4UEtfinkw5PjRtUo/nxbPXok33NvpvDbtdl66Cs1oA+yf72GcR9s
	 sskoBANa2FI+Q==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-6f33-5C0F-0153-9768.rev.sfr.net [IPv6:2a02:8428:af44:1001:6f33:5c0f:153:9768])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2673117E10F8
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 15:39:05 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/btp: Fix typo
Date: Thu, 15 Jan 2026 15:38:59 +0100
Message-ID: <20260115143859.12834-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 src/shared/btp.h     | 2 +-
 tools/btpclient.c    | 6 +++---
 tools/btpclientctl.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/shared/btp.h b/src/shared/btp.h
index a99fdf075..ad18cfb3a 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -82,7 +82,7 @@ struct btp_gap_read_index_rp {
 #define BTP_GAP_SETTING_CONTROLLER_CONF		0x00004000
 #define BTP_GAP_SETTING_STATIC_ADDRESS		0x00008000
 
-#define BTP_OP_GAP_READ_COTROLLER_INFO		0x03
+#define BTP_OP_GAP_READ_CONTROLLER_INFO		0x03
 struct btp_gap_read_info_rp {
 	bdaddr_t address;
 	uint32_t supported_settings;
diff --git a/tools/btpclient.c b/tools/btpclient.c
index 3f060ebc0..e722b2242 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -287,7 +287,7 @@ static void btp_gap_read_commands(uint8_t index, const void *param,
 
 	commands |= (1 << BTP_OP_GAP_READ_SUPPORTED_COMMANDS);
 	commands |= (1 << BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST);
-	commands |= (1 << BTP_OP_GAP_READ_COTROLLER_INFO);
+	commands |= (1 << BTP_OP_GAP_READ_CONTROLLER_INFO);
 	commands |= (1 << BTP_OP_GAP_RESET);
 	commands |= (1 << BTP_OP_GAP_SET_POWERED);
 	commands |= (1 << BTP_OP_GAP_SET_CONNECTABLE);
@@ -370,7 +370,7 @@ static void btp_gap_read_info(uint8_t index, const void *param, uint16_t length,
 	rp.supported_settings = L_CPU_TO_LE32(adapter->supported_settings);
 	rp.current_settings = L_CPU_TO_LE32(adapter->current_settings);
 
-	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_COTROLLER_INFO, index,
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_CONTROLLER_INFO, index,
 							sizeof(rp), &rp);
 
 	return;
@@ -2715,7 +2715,7 @@ static void register_gap_service(void)
 				BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST,
 				btp_gap_read_controller_index, NULL, NULL);
 
-	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_COTROLLER_INFO,
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_CONTROLLER_INFO,
 						btp_gap_read_info, NULL, NULL);
 
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_RESET,
diff --git a/tools/btpclientctl.c b/tools/btpclientctl.c
index 72c54086d..df8d12e94 100644
--- a/tools/btpclientctl.c
+++ b/tools/btpclientctl.c
@@ -1488,7 +1488,7 @@ static void cmd_gap_read_info(int argc, char **argv)
 
 	index = atoi(argv[1]);
 
-	if (!send_cmd(BTP_GAP_SERVICE, BTP_OP_GAP_READ_COTROLLER_INFO,
+	if (!send_cmd(BTP_GAP_SERVICE, BTP_OP_GAP_READ_CONTROLLER_INFO,
 						index, 0, NULL))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
-- 
2.43.0

