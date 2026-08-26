Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102746EC79
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762503; cv=none; b=kHVBdMftd/+2AjUNFvIJClnMykDYPaBVKfaeZ81Gml95Dt3sA8oUGICOWjKLLmGhDFtr3DfioSrMtTC12QGm/SGuD3lQ3ogyJ1Q3tqmwU8OW1U6qZIl6vX2f/EvCFZEExdu11WZ8wCJc4DsEGnnyPNIQkj8xkedxNCZEw3itehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762503; c=relaxed/simple;
	bh=RRUTNxLDrUUenFA0wM19V8L6YEyZtHgJze8ZC3+LqR0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdt7EBVjRTpR0Jak/1SJwT81TVlOz5YuyFBdJwpBaGo01131AiAkc9XYzmCmzud49WbKJAs165LQ8S18Wve868KVDcbbeaddwzFSQupSk1lxy8z3an0Myw3C0rtpuUByqZ4zX2UMZs1f2BK2RaMapLYLVk7ZIWIJFnaKWC2Go/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f0gDlMJn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f0gDlMJn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787762471;
	bh=RRUTNxLDrUUenFA0wM19V8L6YEyZtHgJze8ZC3+LqR0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f0gDlMJnntwtpK0uKXHKYpqbQmW7RbBMyyB3VAMRu22pNjmsaGsyFCGewYSpYPGKI
	 X5SmF8dk3vROQV9loRW8E6NDfrUpXxVpgRn7NukgoIC/A/G0xw7oGJ2pmncsgoKStT
	 6Opa5qV47OcKi0xVPmzryuKPLgjANcyRu78sXxNS/m0MwX38whhzH7iosuBD5ykZpx
	 RC5mIkT+a11pzAuRpkpjowFWBdBCmDC9qVUDN7xyKW8HtGh1wBZAZyu9C287wDCKIN
	 Vf5ApeGeVLhTXSLg1YX8d+uZP16BYwZK/yxxHOEBN1fnvLsy7Dlin2OKJ0iN31qmIr
	 mJPi2PLTREwLw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C9F9517E0A4C
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 18:41:11 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] btio: add BT_IO_OPT_FORCE_ACTIVE support for L2CAP sockets
Date: Wed, 26 Aug 2026 18:41:05 +0200
Message-ID: <20260826164106.293951-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164106.293951-1-frederic.danis@collabora.com>
References: <20260826164106.293951-1-frederic.danis@collabora.com>
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
---
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

