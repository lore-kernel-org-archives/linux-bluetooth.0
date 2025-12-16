Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5E1C5D77
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878939; cv=none; b=uIQeYWrXPu3OYVg0NHGHxbpaYQL45/qlP5hdZFpSX1k2tVYWzzmuHGvKS902+ITxPeFITqJsmkOA5bhlF1etTNE90TCrkZefGdwBGWiWOZl60a9CBD34olsXyQO7OiOOwrfMT5JMDM0ozXk4he19fE0UgfQpdg+irW+92I1EZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878939; c=relaxed/simple;
	bh=2PfAvArHLFe8hklkl1H8RD8/GAGbcP2zhbRQAi7zXKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OgSZOheCMBnnm1d1BnLaF1vhQXzCQkXZ1P3TbBLCJwkNKOyp4r2GQGUZPv4YeQ2K+1AQvJqTs+IjFnTHsLjsTiNpwO4XfSTA69WHdlhpMIOG8GT5jAAoFUDIvTgSr3L56+x2GWLWEJiEh3w/gscAB8QVc1eXwpyAOmjlsug2p7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa4UAYys; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa4UAYys"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4A58C4CEF1;
	Tue, 16 Dec 2025 09:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765878938;
	bh=2PfAvArHLFe8hklkl1H8RD8/GAGbcP2zhbRQAi7zXKo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Sa4UAYysz7HoNVeDrY8rqXikkj0qCE4PtPqP8QoKg2MPfFCaii7cWeV9Ao9judrQP
	 eDUG9EV3/S3Z55PSwTxc/C68qOnLOFZvDpHcTaiZrI6dEF1cMhPDBYyDSu0UW7loYt
	 U7o7uY3bKYIoBzln5/4jkOv2All5552XXJdz2g0hQX4eUbMsGrclKGvna/5jBX7k+o
	 y4kMcUZNC6S0VCEkji/Iig5pmb+7/75Uyb9HD6rxClgULXbPqqrnKdypS9jkeoxtY9
	 v+YHwSKjUXzQVMCmkTo7sVkMTqlm8FvuZ3aNPG5WZw1JprcCWbM0knFGBNQhjbu3xK
	 lPdpikY3lzLCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B78D5B16C;
	Tue, 16 Dec 2025 09:55:38 +0000 (UTC)
From: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Date: Tue, 16 Dec 2025 17:55:36 +0800
Subject: [PATCH bluez] bap: add PA sync monitor timeout
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-bap-pa-sync-v1-1-b1ada9e1a299@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAJcsQWkC/x3MSwqAMAwA0atI1gZsUAleRVxUjRqQWloUP3h3i
 8u3mHkgSlCJ0GQPBDk06uYSTJ7BsFg3C+qYDFRQZcjU2FuP3mK83IBcsiEhZuIRUuGDTHr+txb
 6dZcbuvf9ANE/uMlkAAAA
X-Change-ID: 20251216-bap-pa-sync-84812e28828d
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765878937; l=3588;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=zdZd1Fkwtc7/GqcEgJ03kSMgb45XmyXlaY7hNJfm7mo=;
 b=Ik/72iMAZtnktvwx96ZNND/rXbVX+XyCvovW5qBZjsASuwWHjMXibO2YvXzFsrXOmQmnjxh2Y
 Q+e7tc/apr9Aw2kiDeqC0ZAuSVjUKxn2Psbn4E6ITn9W5cNhSULAFBx
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=
X-Endpoint-Received: by B4 Relay for ye.he@amlogic.com/20250225 with
 auth_id=348
X-Original-From: Ye He <ye.he@amlogic.com>
Reply-To: ye.he@amlogic.com

From: Ye He <ye.he@amlogic.com>

When PA sync times out, the BAP broadcast probe may remain
pending and fail to exit, even if LE scanning is triggered
again.

This adds a monitor timeout to ensure the pending probe
is properly aborted when PA sync does not complete, avoiding
stuck states.

err print from kernel:
  hci0: command 0x0000 tx timeout

Signed-off-by: Ye He <ye.he@amlogic.com>
---
 profiles/audio/bap.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index cda10a643fdea8314c8717b81961546403bc2dc3..61aad856ff9156fc9048e7a215397abb4f473458 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -48,6 +48,7 @@
 #include "src/shared/bap.h"
 #include "src/shared/tmap.h"
 #include "src/shared/gmap.h"
+#include "src/shared/timeout.h"
 
 #include "btio/btio.h"
 #include "src/plugin.h"
@@ -139,6 +140,7 @@ struct bap_data {
 	struct queue *bcast_snks;
 	struct queue *server_streams;
 	GIOChannel *listen_io;
+	unsigned int listen_timer;
 	unsigned int io_id;
 	unsigned int cig_update_id;
 	bool services_ready;
@@ -174,6 +176,9 @@ static void setup_free(void *data);
 
 static void bap_data_free(struct bap_data *data)
 {
+	if (data->listen_timer)
+		timeout_remove(data->listen_timer);
+
 	if (data->listen_io) {
 		g_io_channel_shutdown(data->listen_io, TRUE, NULL);
 		g_io_channel_unref(data->listen_io);
@@ -1559,6 +1564,11 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 
 	DBG("BIG Info received");
 
+	if (data->listen_timer) {
+		timeout_remove(data->listen_timer);
+		data->listen_timer = 0;
+	}
+
 	bt_io_get(io, &err,
 			BT_IO_OPT_BASE, &base,
 			BT_IO_OPT_QOS, &qos,
@@ -3566,6 +3576,21 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 	bap_data_remove(data);
 }
 
+static bool pa_sync_timeout_callback(gpointer user_data)
+{
+	struct bap_data *data = user_data;
+
+	error("PA sync timeout, remove broadcast source device %s",
+				device_get_path(data->device));
+
+	data->listen_timer = 0;
+
+	/* remove device to force exit from pending bcast probe */
+	btd_adapter_remove_device(data->adapter, data->device);
+
+	return FALSE;
+}
+
 static int pa_sync(struct bap_data *data)
 {
 	GError *err = NULL;
@@ -3595,8 +3620,14 @@ static int pa_sync(struct bap_data *data)
 	if (!data->listen_io) {
 		error("%s", err->message);
 		g_error_free(err);
+		return -1;
 	}
 
+	data->listen_timer = timeout_add(
+				/* unit: 10ms */
+				bap_sink_pa_qos.bcast.sync_timeout * 10,
+				pa_sync_timeout_callback,
+				data, NULL);
 	return 0;
 }
 
@@ -3647,6 +3678,11 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 
 	DBG("PA Sync done");
 
+	if (data->listen_timer) {
+		timeout_remove(data->listen_timer);
+		data->listen_timer = 0;
+	}
+
 	g_io_channel_unref(data->listen_io);
 	g_io_channel_shutdown(data->listen_io, TRUE, NULL);
 	data->listen_io = io;
@@ -3702,7 +3738,15 @@ static void pa_and_big_sync(struct bap_setup *setup)
 	if (!bap_data->listen_io) {
 		error("%s", err->message);
 		g_error_free(err);
+		return;
 	}
+
+	bap_data->listen_timer = timeout_add(
+				/* unit: 10ms */
+				bap_sink_pa_qos.bcast.sync_timeout * 10,
+				pa_sync_timeout_callback,
+				bap_data, NULL);
+
 }
 
 static void bap_ready(struct bt_bap *bap, void *user_data)

---
base-commit: ba4978255c3cfb244a89782b30b115c2c9b58c81
change-id: 20251216-bap-pa-sync-84812e28828d

Best regards,
-- 
Ye He <ye.he@amlogic.com>


