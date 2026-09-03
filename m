Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7519492513
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436153; cv=none; b=pBp+drq7ngAs2r3u1N/ngtqwaLqPOQR9o5/qMygNp0BZBhT15EIoimwzP9eZnCJgfS9EH3x4Z2UUmkMMfZ1VPBiu8+sNvICXkb/FkEUibFPT1jo0/p4vQqDKMvonvythvM22fF2NjafUJVFH3uGLpxpajcWG5c4EqBrlh7XB0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436153; c=relaxed/simple;
	bh=x4DCjKXZqVKMfkEwvUtka7zKwB6MwAVOTdV0GZbxbO0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bl1x4hZjGaDRZiODnwQQllM+tzdsSrX7gc/6dSOhqRUTfeItUAOmMmjRbkDRgj8Rxa0DbIBKbxv7MaWL1L8WqO+nihSGljIY/rMHO4YrQOIlaUTqjR/KfsOfP7OxLP+xEvp6MP+Ax5/fztJxBAYfDeU8xwXgZD6g/NK1a9Hjivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KhpJodbq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KhpJodbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788436134;
	bh=x4DCjKXZqVKMfkEwvUtka7zKwB6MwAVOTdV0GZbxbO0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KhpJodbqTfQcr70/zDNF+UIylIARPm229nHbGzf8wzMntlCY5wXMc2kDivsobQ6V/
	 YSetLNzzBhq7BRMIXtFAFPHmn87I0Okfwnj3BysmnuRmeR+mOWpFufNdnzxdRX5XZv
	 TuCjdRTKVYNlfQrYkPlwQ72elNtb+3QqNuB7qenau8LmgFgRb1x29BLC/nnpg3ABiF
	 /57VOTAZU429qHSwEsKhk2IjU5htXJIEX+g3+uIsjXtfoNyRPUngM68IBo3nu0i7Wl
	 pMqzCCFAQ2YNJ6bb90zUqaHo1uZaYLHOrGiaohfA1IU8ZvL2486NMFdC8OYJX7T1sY
	 ZNgMxSryOk7mg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9A14517E0EB0
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 13:48:54 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] btio: add BT_IO_OPT_FORCE_ACTIVE support for L2CAP sockets
Date: Thu,  3 Sep 2026 13:48:48 +0200
Message-ID: <20260903114849.777525-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903114849.777525-1-frederic.danis@collabora.com>
References: <20260903114849.777525-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Introduce BT_IO_OPT_FORCE_ACTIVE in btio and plumb it through option
parsing and L2CAP setup.

When set, btio now programs BT_POWER on the underlying socket, allowing
callers to explicitly control force-active behavior.

Co-developed-by: Zhongjun.Yu@quectel.com
Signed-off-by: Zhongjun.Yu@quectel.com
---
v1->v2: Add missing Co-developed-by tag

 btio/btio.c | 35 +++++++++++++++++++++++++++++++----
 btio/btio.h |  1 +
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 4c69d6035..016035dff 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -68,6 +68,7 @@ struct set_opts {
 	int central;
 	uint8_t mode;
 	int flushable;
+	int force_active;
 	uint32_t priority;
 	uint16_t voice;
 	struct bt_iso_qos qos;
@@ -601,6 +602,17 @@ static int l2cap_set_flushable(int sock, gboolean flushable)
 	return 0;
 }
 
+static int l2cap_set_bt_power(int sock, int force_active)
+{
+	struct bt_power pwr = {0};
+
+	pwr.force_active = force_active;
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_POWER, &pwr, sizeof(pwr)) < 0)
+		return -errno;
+
+	return 0;
+}
+
 static int set_priority(int sock, uint32_t prio)
 {
 	if (setsockopt(sock, SOL_SOCKET, SO_PRIORITY, &prio, sizeof(prio)) < 0)
@@ -696,8 +708,8 @@ static gboolean set_le_mode(int sock, uint8_t mode, GError **err)
 
 static gboolean l2cap_set(int sock, uint8_t src_type, int sec_level,
 				int imtu, uint16_t omtu, uint8_t mode,
-				int central, int flushable, uint32_t priority,
-				GError **err)
+				int central, int flushable, int force_active,
+				uint32_t priority, GError **err)
 {
 	if (imtu != -1 || omtu || mode) {
 		gboolean ret = FALSE;
@@ -736,6 +748,11 @@ static gboolean l2cap_set(int sock, uint8_t src_type, int sec_level,
 		return FALSE;
 	}
 
+	if (force_active >= 0 && l2cap_set_bt_power(sock, force_active) < 0) {
+		ERROR_FAILED(err, "l2cap_set_bt_power", errno);
+		return FALSE;
+	}
+
 	if (priority > 0 && set_priority(sock, priority) < 0) {
 		ERROR_FAILED(err, "set_priority", errno);
 		return FALSE;
@@ -968,6 +985,7 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 	opts->central = -1;
 	opts->mode = L2CAP_MODE_BASIC;
 	opts->flushable = -1;
+	opts->force_active = -1;
 	opts->priority = 0;
 	opts->src_type = BDADDR_BREDR;
 	opts->dst_type = BDADDR_BREDR;
@@ -1043,6 +1061,9 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_FLUSHABLE:
 			opts->flushable = va_arg(args, gboolean);
 			break;
+		case BT_IO_OPT_FORCE_ACTIVE:
+			opts->force_active = va_arg(args, int);
+			break;
 		case BT_IO_OPT_PRIORITY:
 			opts->priority = va_arg(args, int);
 			break;
@@ -1387,6 +1408,7 @@ parse_opts:
 		case BT_IO_OPT_SOURCE_CHANNEL:
 		case BT_IO_OPT_DEST_CHANNEL:
 		case BT_IO_OPT_MTU:
+		case BT_IO_OPT_FORCE_ACTIVE:
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
 		case BT_IO_OPT_BASE:
@@ -1544,6 +1566,7 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 		case BT_IO_OPT_IMTU:
 		case BT_IO_OPT_MODE:
 		case BT_IO_OPT_FLUSHABLE:
+		case BT_IO_OPT_FORCE_ACTIVE:
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
@@ -1658,6 +1681,7 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_CENTRAL:
 		case BT_IO_OPT_MODE:
 		case BT_IO_OPT_FLUSHABLE:
+		case BT_IO_OPT_FORCE_ACTIVE:
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
@@ -1795,6 +1819,7 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_CENTRAL:
 		case BT_IO_OPT_MODE:
 		case BT_IO_OPT_FLUSHABLE:
+		case BT_IO_OPT_FORCE_ACTIVE:
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_ISO_BC_NUM_BIS:
@@ -1963,7 +1988,8 @@ gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...)
 	case BT_IO_L2CAP:
 		return l2cap_set(sock, opts.src_type, opts.sec_level, opts.imtu,
 					opts.omtu, opts.mode, opts.central,
-					opts.flushable, opts.priority, err);
+					opts.flushable, opts.force_active,
+					opts.priority, err);
 	case BT_IO_RFCOMM:
 		return rfcomm_set(sock, opts.sec_level, opts.central, err);
 	case BT_IO_SCO:
@@ -2014,7 +2040,8 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 			goto failed;
 		if (!l2cap_set(sock, opts->src_type, opts->sec_level,
 				opts->imtu, opts->omtu, opts->mode,
-				opts->central, opts->flushable, opts->priority,
+				opts->central, opts->flushable,
+				opts->force_active, opts->priority,
 				err))
 			goto failed;
 		break;
diff --git a/btio/btio.h b/btio/btio.h
index 3e69092b1..f088c3cd4 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -42,6 +42,7 @@ typedef enum {
 	BT_IO_OPT_CLASS,
 	BT_IO_OPT_MODE,
 	BT_IO_OPT_FLUSHABLE,
+	BT_IO_OPT_FORCE_ACTIVE,
 	BT_IO_OPT_PRIORITY,
 	BT_IO_OPT_VOICE,
 	BT_IO_OPT_PHY,
-- 
2.43.0

