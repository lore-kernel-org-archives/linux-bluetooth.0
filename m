Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CE61EFFB7
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785219891; cv=none; b=NlsgLfVwFtiVaLHuI3yhllnB/HqRkWN8ohD8AhbyV4Z2P4TQetvtTB1fbZhezikHzazPvISDTt3ijw+plRsbkthtR7Qr0Vy4O2U9ZXQPgRnnJBV//Uw9mVcH36YIr4LB8LmdScGaNw+P61A3Le2eW+5oUQnDsJl92Ch1mjdiKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785219891; c=relaxed/simple;
	bh=QGO8/sGPtzogws5vg1DJXHjzwIuWXEG6itfiKwUMMZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XjGRejin1LT0AxHaf++644npCUGGXT5JY6zufaGEVWborDJd8Ww2M6EFKVjDN3nK9/n8IDRwjxw6nw2dU6xniWYUxDNQcy+QIyMi2vf06EjUsHmgswQ5LosSf32H2imRvoB0X0eRAmHPuxkv9E4QIlvrmzq4OOaLXfuAK90iqeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSTPqYZb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSTPqYZb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7880EC2BCC6;
	Tue, 28 Jul 2026 06:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785219890;
	bh=QGO8/sGPtzogws5vg1DJXHjzwIuWXEG6itfiKwUMMZE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=SSTPqYZbJC0KWnFsKmSwbjzt/eITvPEj3prpzGfKf2HnVuoS20v0uUNIdZIdaC2/s
	 WVtk4t9oM9wUdUNb2u9xQDRiB/W69MsfQk54eCMQQ5dQ01tYfIBVaZfJr3rYAskQs/
	 Kj3wLACjUvXpQwFkCZE5tjwMyy0zdZlQiHQQgRLbSJroco0FdeZ7rJkSanY6Z8EiQF
	 wIaYf5MQqFm/sG297MHTuke+qhuy42TcVyNsiI2ZW/8gj7FMsHjbv5m9QaN0g1Lgez
	 JPkDQMNVYyVari4SquSgfw2xXgpq0w1wRNT8L8O9fCS+T/IlOEwRB2RCGiUwhJ5sTd
	 BgE6zYhK5iCPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B0BC531F9;
	Tue, 28 Jul 2026 06:24:50 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Tue, 28 Jul 2026 14:24:45 +0800
Subject: [PATCH BlueZ bluez v3] bap: Start BIG sync after receiving BIGInfo
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-big_sync-v3-1-6751ba0802ce@amlogic.com>
X-B4-Tracking: v=1; b=H4sIACxLaGoC/2WNyw6CMBBFf4V0bU0fINGV/2GMaYcBJgFqWm1Ew
 r9bu8K4vHPnnLuwgJ4wsFOxMI+RArkpBb0rGPRm6pBTkzJTQh1ErUpuqbuFeQJeVqBKBHGUSrL
 0fvfY0iurLswOT3yzazr3FB7Oz3kgylz+u6LkkgujKyE1amHN2YyD6wj24MasiWqL1htUfdFKt
 422ANriL7qu6wf3Hays5AAAAA==
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785219886; l=3109;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=5EgeiC5D9YMy9T7q0OAiM45TunnWa5Fy8xH/jWQT53U=;
 b=m4G0f/D3/jAaYufOpj4N7Z1KcwGUUwLTeN5a6x5mlsz9Xxnr04RMlc5ERhsNIb/OpBoF9vLSd
 NqaTTBK84TcCgk/wQBn6zL0ow0rAGjLJKvMgVRUkOJSEjNGeHrFtok6
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

The current implementation starts BIG sync before receiving a BIGInfo
report. According to the Bluetooth Core Specification, BIG sync should
only be initiated after BIGInfo has been received.

Starting BIG sync too early may cause unexpected controller behavior.

Trigger BIG sync from the BIGInfo callback, following the same approach
used by the short PA flow.

Fixes: https://github.com/bluez/bluez/issues/2345

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v3:
- Fixed coding style warning.
- Link to v2: https://patch.msgid.link/20260727-big_sync-v2-1-053fd3bcc3be@amlogic.com

Changes in v2:
- Fixed build error.
- Link to v1: https://patch.msgid.link/20260724-big_sync-v1-1-0a35013e30ba@amlogic.com
---
 profiles/audio/bap.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index dd4b3c8ff..473e4cfc2 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3650,7 +3650,8 @@ static void setup_refresh_qos(void *data, void *user_data)
 	setup->qos = *bt_bap_stream_get_qos(stream);
 }
 
-static void iso_do_big_sync(GIOChannel *io, void *user_data)
+static gboolean iso_do_big_sync(GIOChannel *io, GIOCondition cond,
+						void *user_data)
 {
 	GError *err = NULL;
 	struct bap_setup *setup = user_data;
@@ -3659,7 +3660,7 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	struct bt_iso_qos qos;
 	struct queue *links = bt_bap_stream_io_get_links(setup->stream);
 
-	DBG("PA Sync done");
+	DBG("BIG info received, do BIG sync");
 
 	g_io_channel_unref(data->listen_io);
 	g_io_channel_shutdown(data->listen_io, TRUE, NULL);
@@ -3682,6 +3683,7 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 			BT_IO_OPT_INVALID)) {
 		error("bt_io_set: %s", err->message);
 		g_error_free(err);
+		return FALSE;
 	}
 
 	if (!bt_io_bcast_accept(io,
@@ -3692,16 +3694,31 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 			iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
 		error("bt_io_bcast_accept: %s", err->message);
 		g_error_free(err);
+		return FALSE;
 	}
+
+	return TRUE;
+}
+
+static void long_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
+{
+	struct bap_setup *setup = user_data;
+	struct bap_data *data = setup->data;
+
+	DBG("Long PA Sync done");
+
+	/* store io and add watch that will call iso_do_big_sync */
+	data->io_id = g_io_add_watch(io, G_IO_OUT, iso_do_big_sync,
+							setup);
 }
 
 static void pa_and_big_sync(struct bap_setup *setup)
 {
 	GError *err = NULL;
 	struct bap_data *bap_data = setup->data;
-
 	DBG("Create PA sync with this source");
-	bap_data->listen_io = bt_io_listen(NULL, iso_do_big_sync, setup,
+
+	bap_data->listen_io = bt_io_listen(NULL, long_pa_sync_confirm_cb, setup,
 			NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(bap_data->adapter),

---
base-commit: 89d477bb5494eef0b24e5667be62f854da250a97
change-id: 20260724-big_sync-45c24ec09121

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


