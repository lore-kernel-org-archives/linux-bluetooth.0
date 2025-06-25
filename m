Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68E25E806
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860361; cv=none; b=Nu2jKwRVabudxyXbGt9B5mJAKjCdfi5O4U++kG8ZQXO1Ub9Hc+QNTQjuqnP7wzc2l/UHNA6FyC8lAc/mga11bnfOLEpSA0DfGWxouKyOjj95N2LcSlmvT9eFBvIvqTdKSc3N9TFHm7SFQaaRZm2wHY/FI+tHDBSef7aVzNc+0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860361; c=relaxed/simple;
	bh=yRrgrDBR78n8Ln1znVzbD/oKnXostvZBavuQE2k2TuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eO8uW7oeXzlJfrLjBWGQd8hhP9Ixftt+0meteZj4/00hfVtYRCyLQ+6wa1aneAVMivPdnR3m4V33Lhafw3fgSBBgYR/ye3zD8z+0u/PMWbQJXbqJylbTu9+eoLjqJfExgG2TyTM8Mszy9p6/QBLTQnleaLSzAjlGBYlAcVo1Lig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=GOKev6yp; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GOKev6yp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=wAKTzfeuFHMggSX/FDbC0FfHlm1qb5olGqR+0neFYnE=; b=GOKev6ypaVuFqFwVzqExlUpJiD
	fC6+3TiZ+ahF3cF5iGfTC9WZFJfkEJ+liaE8mTt9rcFBAymRt5dC/Zf0Q6ZEM2YmvbDelsMbPhPuC
	FEr6VEQjaQLxvNNIHuHDxkXlyVozHpX/KhQiaaPx37DvPdURNa5JAzp6lO4VzUQlhoeHEwtwwiTuA
	EdO4U5/uB+TP4alL2g5Wrow9/IGDlkKbYcchgDABspg9nxD0m9YEOshLRYle7Oizr7EywgC+yHpA3
	y5mjoxtvJ8zNNLnT11fJI00GNH0jiCsRPmqZEvAXV4u4hHJ5rZoXMezPIg0E74XMT4W+9jnCdwkXO
	c/QDWNcQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: linux-bluetooth@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] gatt-client: avoid UAF after acquire notify failure
Date: Wed, 25 Jun 2025 16:05:45 +0200
Message-Id: <20250625140545.1610812-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a disconnect happens during AcquireNotify dbus calls, a lot of
debris is left over. Subsequent calls to AcquireNotify will return
NotPermitted and StopNotify leads to an UAF, crashing bluetoothd.

Fix that by also clean up the socket stuff on failure.

This was provoked by putting the device into some RF shielding bag
and open and close it quickly.

Valgrind output:

bluetoothd[26032]: [:1.126:method_call] > org.bluez.GattCharacteristic1.AcquireNotify [#145]
bluetoothd[26032]: [:1.126:error] < org.bluez.Error.NotPermitted [#145]
bluetoothd[26032]: [:1.74:method_call] > org.freedesktop.DBus.Properties.GetAll [#895]
bluetoothd[26032]: [:1.74:method_return] < [#895]
bluetoothd[26032]: [:1.74:method_call] > org.bluez.GattCharacteristic1.StopNotify [#896]
==26032== Invalid read of size 8
==26032==    at 0x1A5721: notify_io_destroy (gatt-client.c:1562)
==26032==    by 0x1A7290: sock_io_destroy (gatt-client.c:1171)
==26032==    by 0x1A7290: destroy_sock (gatt-client.c:1192)
==26032==    by 0x1A73D6: characteristic_stop_notify (gatt-client.c:1698)
==26032==    by 0x1CF478: process_message (object.c:293)
==26032==    by 0x49CB71B: ??? (in /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.32.4)
==26032==    by 0x49BB62A: dbus_connection_dispatch (in /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.32.4)
==26032==    by 0x1CBCEF: message_dispatch (mainloop.c:59)
==26032==    by 0x48BF61E: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BF9D7: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BFC8E: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x202114: mainloop_run (mainloop-glib.c:65)
==26032==    by 0x202501: mainloop_run_with_signal (mainloop-notify.c:196)
==26032==  Address 0x5a7a430 is 0 bytes inside a block of size 32 free'd
==26032==    at 0x484417B: free (vg_replace_malloc.c:872)
==26032==    by 0x1DEC0F: complete_notify_request (gatt-client.c:1663)
==26032==    by 0x1DEC0F: enable_ccc_callback (gatt-client.c:1735)
==26032==    by 0x1DB8FF: disc_att_send_op (att.c:464)
==26032==    by 0x1DB8FF: disconnect_cb (att.c:676)
==26032==    by 0x2017A4: watch_callback (io-glib.c:173)
==26032==    by 0x48BF61E: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BF9D7: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BFC8E: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x202114: mainloop_run (mainloop-glib.c:65)
==26032==    by 0x202501: mainloop_run_with_signal (mainloop-notify.c:196)
==26032==    by 0x12E60C: main (main.c:1535)
==26032==  Block was alloc'd at
==26032==    at 0x48417B4: malloc (vg_replace_malloc.c:381)
==26032==    by 0x1D2F4D: util_malloc (util.c:46)
==26032==    by 0x1A5DD3: notify_client_create (gatt-client.c:1426)
==26032==    by 0x1A5EFC: characteristic_acquire_notify (gatt-client.c:1588)
==26032==    by 0x1CF478: process_message (object.c:293)
==26032==    by 0x49CB71B: ??? (in /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.32.4)
==26032==    by 0x49BB62A: dbus_connection_dispatch (in /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.32.4)
==26032==    by 0x1CBCEF: message_dispatch (mainloop.c:59)
==26032==    by 0x48BF61E: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BF9D7: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
---
 src/gatt-client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 3c31a422e..a146d52cb 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1539,8 +1539,7 @@ static void register_notify_io_cb(uint16_t att_ecode, void *user_data)
 	struct bt_gatt_client *gatt = chrc->service->client->gatt;
 
 	if (att_ecode) {
-		queue_remove(chrc->notify_clients, client);
-		notify_client_free(client);
+		destroy_sock(chrc, chrc->notify_io->io);
 		return;
 	}
 
-- 
2.39.5

