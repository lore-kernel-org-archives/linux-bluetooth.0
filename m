Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8F1DE4E0
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738098267; cv=none; b=eFPhgWFA2QFYmGg1SfH0Ld38WJuvxKAQvkxP9ARv7depJRtnQ20BNdSmbsq/rEstLEYj2O0uwhJEp/fTuQk/lP2E1ICQsMFjb16z/uA+Up+4KM3tXonz/j0b/kFttJiJ9i+RaQR7xyF+7O42hlVlC7aNVK4Ne72q0MtZV0RmuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738098267; c=relaxed/simple;
	bh=j43/ZBCAaYSgLuPfIKJDLbIOU2L/NydPxL9F/Hu6jsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tz5gXaryrhHAs4tN0nuPi6399O/LBtnleC9WI1ariQ6vSmtl+hZqX/IpSgL6lOMho4Q2iepzx+9EIPUIql5j0XTMkR0RvDaxRl9A0iO4r7/rGFBEjxFeYhVhc7e/VPfdJfjjBKgeFxi33ztdhoCJUX5Nc0uv96qRJVmNGFkY18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=UlWZm3IE; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="UlWZm3IE"
Received: from localhost.localdomain (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id EBACD40777C4;
	Tue, 28 Jan 2025 21:04:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EBACD40777C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1738098255;
	bh=CdNkfwRkR3DNjt9v6isI/9YKQo9XjSiqnKA8b5Db5z4=;
	h=From:To:Cc:Subject:Date:From;
	b=UlWZm3IERPpKzJ7Uh1rlSaL1XmZNMKLuLu/BQ9owOTlEYE7/VaBdoirW6hkl+yjtB
	 0wufj3PqpDtLT9vfcvjR390/zuwMLdg0LD0HJnnhE88pugIMs/N78JozbxC7eFTqzD
	 heBA2xeFP4pXLsc11cbv0HJYlr0SODkERDmBnuiM=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: linux-bluetooth@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH BlueZ 1/2] audio: actually try to enable MTU auto-tuning
Date: Wed, 29 Jan 2025 00:03:53 +0300
Message-Id: <20250128210354.73732-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A "0" for the input MTU passed to the underlying socket is supposed to
indicate that its value should be determined by the L2CAP layer.
However, the current code treats a zero imtu just as if there is
nothing to change.

Introduce an additional flag to indicate that the zero imtu is
explicitly requested by the caller for the purpose of auto-tuning.
Otherwise, the similar behavior remains.

Found by Linux Verification Center (linuxtesting.org).

Fixes: ae5be371a9f5 ("avdtp: Enable MTU auto tunning")
---
 btio/btio.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 2d277e409..74a4003b6 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -66,6 +66,7 @@ struct set_opts {
 	uint16_t imtu;
 	uint16_t omtu;
 	int central;
+	uint8_t auto_mtu;
 	uint8_t mode;
 	int flushable;
 	uint32_t priority;
@@ -610,7 +611,7 @@ static uint8_t mode_l2mode(uint8_t mode)
 }
 
 static gboolean set_l2opts(int sock, uint16_t imtu, uint16_t omtu,
-						uint8_t mode, GError **err)
+				uint8_t auto_mtu, uint8_t mode, GError **err)
 {
 	struct l2cap_options l2o;
 	socklen_t len;
@@ -622,7 +623,7 @@ static gboolean set_l2opts(int sock, uint16_t imtu, uint16_t omtu,
 		return FALSE;
 	}
 
-	if (imtu)
+	if (imtu || auto_mtu)
 		l2o.imtu = imtu;
 	if (omtu)
 		l2o.omtu = omtu;
@@ -666,17 +667,17 @@ static gboolean set_le_mode(int sock, uint8_t mode, GError **err)
 }
 
 static gboolean l2cap_set(int sock, uint8_t src_type, int sec_level,
-				uint16_t imtu, uint16_t omtu, uint8_t mode,
-				int central, int flushable, uint32_t priority,
-				GError **err)
+				uint16_t imtu, uint16_t omtu, uint8_t auto_mtu,
+				uint8_t mode, int central, int flushable,
+				uint32_t priority, GError **err)
 {
-	if (imtu || omtu || mode) {
+	if (imtu || omtu || auto_mtu || mode) {
 		gboolean ret = FALSE;
 
 		if (src_type == BDADDR_BREDR)
-			ret = set_l2opts(sock, imtu, omtu, mode, err);
+			ret = set_l2opts(sock, imtu, omtu, auto_mtu, mode, err);
 		else {
-			if (imtu)
+			if (imtu || auto_mtu)
 				ret = set_le_imtu(sock, imtu, err);
 
 			if (ret && mode)
@@ -986,6 +987,8 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 			opts->imtu = va_arg(args, int);
 			if (!opts->mtu)
 				opts->mtu = opts->imtu;
+			if (!opts->imtu)
+				opts->auto_mtu = 1;
 			break;
 		case BT_IO_OPT_CENTRAL:
 			opts->central = va_arg(args, gboolean);
@@ -1890,7 +1893,7 @@ gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...)
 	switch (type) {
 	case BT_IO_L2CAP:
 		return l2cap_set(sock, opts.src_type, opts.sec_level, opts.imtu,
-					opts.omtu, opts.mode, opts.central,
+					opts.omtu, opts.auto_mtu, opts.mode, opts.central,
 					opts.flushable, opts.priority, err);
 	case BT_IO_RFCOMM:
 		return rfcomm_set(sock, opts.sec_level, opts.central, err);
@@ -1941,7 +1944,7 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 				server ? opts->psm : 0, opts->cid, err) < 0)
 			goto failed;
 		if (!l2cap_set(sock, opts->src_type, opts->sec_level,
-				opts->imtu, opts->omtu, opts->mode,
+				opts->imtu, opts->omtu, opts->auto_mtu, opts->mode,
 				opts->central, opts->flushable, opts->priority,
 				err))
 			goto failed;
-- 
2.39.5
