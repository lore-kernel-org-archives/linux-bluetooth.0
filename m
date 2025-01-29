Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59811A2399
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140607; cv=none; b=EkpZQywzHne8da9vNPR52+4csUwYw9XA99D4QTC8U4VsmPr/JNbaIjm40Jvly+8M47Sqm/ogoFYj4MRVholfdbIi8JsrQAO0Fg97BiMdeSK2fdgtW3JqaOssOc3foLevMqOn4MJP9OjfFxa5hNfzhkRng4hKJh5tU3q5rhPSBGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140607; c=relaxed/simple;
	bh=y2LQOEdPCR3Sf/nG1z6ZhgMbFHWS4NfegBPWEClS0Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZzTtmgh18rqbSG4HENuDrxZC+gEDyF4weZiFp9IlS2asHorPQnTU9KK0ZNL7g5Yx+Ofm85KEaLloXbLKun5FP29gDu46GiKlzIAUq6KwEnMoaOzf/5KsU8jvPspV4Jh4C10sojW0PefJu81UqRICu0XFgoSZGquGiAumP1QQ9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=pjy/zhuy; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="pjy/zhuy"
Received: from localhost.localdomain (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id E340340737DF;
	Wed, 29 Jan 2025 08:50:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E340340737DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1738140600;
	bh=Zo3cXudIT+TDkq+sTyJrIbYDBZsIg8LgBsOWq8KgfoA=;
	h=From:To:Cc:Subject:Date:From;
	b=pjy/zhuyH7v3dKsg6+CcDxvIjEdgkfRq+Db2NpAFqH2H6IQAxNsuo0vovUxMoLigm
	 6WARmPt++lv4xjqL64G0xncMBtJ/mrUqMe440mqnWoUfF/25TpGp6OVVVqS7cscfoZ
	 whdlm+99nX7oAKtoHYMTPi+5mmOJG5tLkJnrK0ls=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: linux-bluetooth@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH BlueZ v2 1/2] audio: actually try to enable MTU auto-tuning
Date: Wed, 29 Jan 2025 11:49:49 +0300
Message-Id: <20250129084950.41987-1-pchelkin@ispras.ru>
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
v1->v2: incorporate error handling in case the kernel still doesn't
support MTU auto-tuning

 btio/btio.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 2d277e409..7b38bc819 100644
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
@@ -666,17 +667,24 @@ static gboolean set_le_mode(int sock, uint8_t mode, GError **err)
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
 
-		if (src_type == BDADDR_BREDR)
-			ret = set_l2opts(sock, imtu, omtu, mode, err);
-		else {
-			if (imtu)
+		if (src_type == BDADDR_BREDR) {
+			ret = set_l2opts(sock, imtu, omtu, auto_mtu, mode, err);
+
+			/* Back to default behavior in case the first call fails:
+			 * it may happen if the used kernel still doesn't support
+			 * auto-tuning the MTU 
+			 */
+			if (!ret && auto_mtu)
+				ret = set_l2opts(sock, imtu, omtu, 0, mode, err);
+		} else {
+			if (imtu || auto_mtu)
 				ret = set_le_imtu(sock, imtu, err);
 
 			if (ret && mode)
@@ -986,6 +994,8 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 			opts->imtu = va_arg(args, int);
 			if (!opts->mtu)
 				opts->mtu = opts->imtu;
+			if (!opts->imtu)
+				opts->auto_mtu = 1;
 			break;
 		case BT_IO_OPT_CENTRAL:
 			opts->central = va_arg(args, gboolean);
@@ -1890,7 +1900,7 @@ gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...)
 	switch (type) {
 	case BT_IO_L2CAP:
 		return l2cap_set(sock, opts.src_type, opts.sec_level, opts.imtu,
-					opts.omtu, opts.mode, opts.central,
+					opts.omtu, opts.auto_mtu, opts.mode, opts.central,
 					opts.flushable, opts.priority, err);
 	case BT_IO_RFCOMM:
 		return rfcomm_set(sock, opts.sec_level, opts.central, err);
@@ -1941,7 +1951,7 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
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

