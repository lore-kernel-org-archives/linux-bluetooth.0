Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1826E542
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Mar 2024 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710614217; cv=pass; b=pi+Nl5kJpYTYF0M/VR5itN/KdZrpbLHymfOX+wCJjAUgWlHfI+5A0s91Lryhb5lx1414UjFQ7Ydic3oaPGntkqGhZYzPmfeZX2qjY9MrWSoaL46Ngorz9t4VqadFNK5ql136uF7+eI4T87B8Xj2O4ZVGxm/3XIRxGMyxCR4cwLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710614217; c=relaxed/simple;
	bh=Qgd7tC5rqpQHVJbt04ewOPHcnQGldpssPFwAeOpUck0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TyR/2D8S/vfBWSCQwcRYMbz2lunriLrO57U0o9EGG0vLLGVqbjW9bQh62yowfeyaf0ykWzg751ZIax+/d6wpd3K8b9sPMWmKzVgtIqSvA6lGM0IfcE2K65DAkqKkkLni+Ir9FNxmcnG3uNO+6iEI5vcOzefo1Tis60nbMAcYMFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=XBrJIOYs; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="XBrJIOYs"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Txqb10bZGzySM;
	Sat, 16 Mar 2024 20:36:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1710614205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hGSZjQuPPFYEdM55/0weBV1UsWRNWL134Dk1nJz12G8=;
	b=XBrJIOYsVcZZI5py8qngvQPIHTakQcaLOAf4Y0a9/WKJBCelxq6Dj2gVlrxuWbvdTvzF2J
	lnY1IfaXEMbsGUjCG9CR3UAvELraVadTx2clrenXlWvQ0YNPCgbYG+sKK9Azwh/LJNbnhO
	qwvn5FGlmiZjD07ctI091aP4JM5V0Hs=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1710614205; a=rsa-sha256; cv=none;
	b=hyKE9z7cG1Hags9YZ9nMlZrT4i83NBlG4lhwYXLVYUy2jxjCPpzgpv1VBHmuqgi6+naYf2
	oOO8ftp8+0nOAycAuZoIvBq2Aq2xNPluqO9U3+5vTUlOlL70cRLBPXmcHH7Z9ev1moH5bL
	pWH0oMZ0FWjYB1XNVF7p7GtEoxbjiIU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1710614205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hGSZjQuPPFYEdM55/0weBV1UsWRNWL134Dk1nJz12G8=;
	b=VVmyXWbQ1/IFoMTEtC3Bdb3d4lwPmxNbC+xIIK0XBJbPT6ahhMA0JFDv814NgBfUDUnDhm
	txmdcr9FIS+V04I8lXA84iI0vtD0c5w4ZinoyZv8xDXNq1YNENpqRXH2ygb6y8nBsIgSqV
	TuhGrZ6LpLUksl82ICSFLZZFkWQ3/U4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] a2dp: fix setup->err use-after-free
Date: Sat, 16 Mar 2024 20:36:38 +0200
Message-ID: <154e1a604eb8c3d924699489da72ea905915fb88.1710614196.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup->err is set to values that either are on stack of avdtp.c
routines, obtained from callbacks, or allocated on heap. This is
inconsistent, and use-after-free in some cases.

Fix by always allocating setup->err ourselves, copying any values
obtained from callbacks.  Add setup_error_set/init and do all setup->err
manipulation via them.

Fixes crash:

==994225==ERROR: AddressSanitizer: stack-use-after-return
READ of size 1 at 0x7f15ee5189c0 thread T0
    #0 0x445724 in avdtp_error_category profiles/audio/avdtp.c:657
    #1 0x41e59e in error_to_errno profiles/audio/a2dp.c:303
    #2 0x42bb23 in a2dp_reconfigure profiles/audio/a2dp.c:1336
    #3 0x7f15f1512798 in g_timeout_dispatch
    ...
Address 0x7f15ee5189c0 is located in stack of thread T0 at offset 64 in frame
    #0 0x466b76 in avdtp_parse_rej profiles/audio/avdtp.c:3056
  This frame has 2 object(s):
    [48, 49) 'acp_seid' (line 3058)
    [64, 72) 'err' (line 3057) <== Memory access at offset 64 is inside this variable
---
 profiles/audio/a2dp.c | 68 +++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index b43161a13..a3c294bc3 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -222,6 +222,7 @@ static void setup_free(struct a2dp_setup *s)
 		avdtp_unref(s->session);
 	g_slist_free_full(s->cb, g_free);
 	g_slist_free_full(s->caps, g_free);
+	g_free(s->err);
 	g_free(s);
 }
 
@@ -270,17 +271,34 @@ static void setup_cb_free(struct a2dp_setup_cb *cb)
 	g_free(cb);
 }
 
+static void setup_error_set(struct a2dp_setup *setup, struct avdtp_error *err)
+{
+	if (!err) {
+		g_free(setup->err);
+		setup->err = NULL;
+	} else {
+		if (!setup->err)
+			setup->err = g_new0(struct avdtp_error, 1);
+		memcpy(setup->err, err, sizeof(struct avdtp_error));
+	}
+}
+
+static void setup_error_init(struct a2dp_setup *setup, uint8_t type, int id)
+{
+	struct avdtp_error err;
+
+	avdtp_error_init(&err, type, id);
+	setup_error_set(setup, &err);
+}
+
 static void finalize_setup_errno(struct a2dp_setup *s, int err,
 					GSourceFunc cb1, ...)
 {
 	GSourceFunc finalize;
 	va_list args;
-	struct avdtp_error avdtp_err;
 
-	if (err < 0) {
-		avdtp_error_init(&avdtp_err, AVDTP_ERRNO, -err);
-		s->err = &avdtp_err;
-	}
+	if (err < 0)
+		setup_error_init(s, AVDTP_ERRNO, -err);
 
 	va_start(args, cb1);
 	finalize = cb1;
@@ -576,10 +594,7 @@ done:
 
 	finalize_config(setup);
 
-	if (setup->err) {
-		g_free(setup->err);
-		setup->err = NULL;
-	}
+	setup_error_set(setup, NULL);
 
 	setup_unref(setup);
 
@@ -588,11 +603,9 @@ done:
 
 static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret)
 {
-	if (ret == FALSE) {
-		setup->err = g_new(struct avdtp_error, 1);
-		avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
+	if (ret == FALSE)
+		setup_error_init(setup, AVDTP_MEDIA_CODEC,
 					AVDTP_UNSUPPORTED_CONFIGURATION);
-	}
 
 	auto_config(setup);
 	setup_unref(setup);
@@ -671,8 +684,7 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 
 		if (cap->category == AVDTP_DELAY_REPORTING &&
 					!a2dp_sep->delay_reporting) {
-			setup->err = g_new(struct avdtp_error, 1);
-			avdtp_error_init(setup->err, AVDTP_DELAY_REPORTING,
+			setup_error_init(setup, AVDTP_DELAY_REPORTING,
 					AVDTP_UNSUPPORTED_CONFIGURATION);
 			goto done;
 		}
@@ -683,8 +695,7 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 		codec = (struct avdtp_media_codec_capability *) cap->data;
 
 		if (codec->media_codec_type != a2dp_sep->codec) {
-			setup->err = g_new(struct avdtp_error, 1);
-			avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
+			setup_error_init(setup, AVDTP_MEDIA_CODEC,
 					AVDTP_UNSUPPORTED_CONFIGURATION);
 			goto done;
 		}
@@ -704,10 +715,9 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 			return TRUE;
 		}
 
-		setup_unref(setup);
-		setup->err = g_new(struct avdtp_error, 1);
-		avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
+		setup_error_init(setup, AVDTP_MEDIA_CODEC,
 					AVDTP_UNSUPPORTED_CONFIGURATION);
+		setup_unref(setup);
 		break;
 	}
 
@@ -886,7 +896,7 @@ static void invalidate_remote_cache(struct a2dp_setup *setup,
 		/* Set error to -EAGAIN so the likes of policy plugin can
 		 * reattempt to connect.
 		 */
-		avdtp_error_init(setup->err, AVDTP_ERRNO, -EAGAIN);
+		setup_error_init(setup, AVDTP_ERRNO, -EAGAIN);
 	}
 }
 
@@ -910,10 +920,10 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (err) {
 		if (setup) {
 			setup_ref(setup);
-			setup->err = err;
+			setup_error_set(setup, err);
 			invalidate_remote_cache(setup, err);
 			finalize_config(setup);
-			setup->err = NULL;
+			setup_error_set(setup, NULL);
 			setup_unref(setup);
 		}
 
@@ -1116,7 +1126,7 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	if (err) {
 		setup->stream = NULL;
-		setup->err = err;
+		setup_error_set(setup, err);
 		if (setup->start)
 			finalize_resume(setup);
 	} else if (setup->chan)
@@ -1191,7 +1201,7 @@ static void start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	if (err) {
 		setup->stream = NULL;
-		setup->err = err;
+		setup_error_set(setup, err);
 	}
 
 	finalize_resume(setup);
@@ -1270,7 +1280,7 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	if (err) {
 		setup->stream = NULL;
-		setup->err = err;
+		setup_error_set(setup, err);
 	}
 
 	finalize_suspend(setup);
@@ -1418,7 +1428,7 @@ static void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	if (err) {
 		setup->stream = NULL;
-		setup->err = err;
+		setup_error_set(setup, err);
 		finalize_config(setup);
 		return;
 	}
@@ -1528,7 +1538,7 @@ static void reconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	if (err) {
 		setup->stream = NULL;
-		setup->err = err;
+		setup_error_set(setup, err);
 	}
 
 	finalize_config(setup);
@@ -2885,7 +2895,7 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 
 	setup->seps = seps;
 	if (err)
-		setup->err = err;
+		setup_error_set(setup, err);
 
 	if (!err) {
 		g_slist_foreach(seps, foreach_register_remote_sep, setup->chan);
-- 
2.44.0

