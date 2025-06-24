Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E2529CE1
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 06:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750745061; cv=none; b=XGqd7VRwkIKCoC7TjIbAouCZ9ouFVAQvpNSjf/abTpKwQURZl8XljlYE1Jsi6lwcoTUPHFzsln71u3QeVcnPHVTkgG0E5Wqwx1wYLb9Ba4qSNxM9chlistm71ZsDDSJwca8g/g5Vbtk/ljwk1dPsiaXWWn2KHJSG9Byv0tdzDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750745061; c=relaxed/simple;
	bh=538LgiZ7VUVHUSGwV/O/7r87Y1kzfFtDfURJIN/qg70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=axsiQVxw2wFnC7VY4MVA8yNX3iKYKMHdqKVWYOZofi69dCY+lz0GIsrtqwQBaM73nBmf8eigMjGmQernvW7SeVgyCVy300zCCYYhQreMWIHW+7fBLtp7K+mzj3il4vdyP/x5ksq3cPuMK5N4nMxtvsgXNP+BDBsZ5FLtRPdzLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sxo1a0o9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sxo1a0o9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2183AC4CEE3;
	Tue, 24 Jun 2025 06:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750745061;
	bh=538LgiZ7VUVHUSGwV/O/7r87Y1kzfFtDfURJIN/qg70=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Sxo1a0o9lJG1IqO4lDhvkfMTCSCO2cSNzRe8JEDR7LvWQzMgp5jyRacqmX4Z9hcEO
	 bN3UbZ1Jh7IQ4jzFpoR10soxLzCRsUNzpqZj/Wvvizs6zx9lo1X6ZULJX3f72ceOqw
	 eQYERMJhH4oLU/JL+rsghGJEcv8pBsmtaMY3PdpRrcVwOrD3HJGyNw3H0Bcp/Y849j
	 6SNWIukU6NHtzM6p3Wx2und/j9aztciK0GOCjEkoQ/4Jv1yThhMTajAel8MNql8L9M
	 PDZAfRpKWOb79I9bsX+Shzsrog5tDnZr8cc48BHgvuMzMLcMf2tRSnBv4Hbm1YY4pp
	 YAfAGLQPAkvAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FACDC77B7C;
	Tue, 24 Jun 2025 06:04:21 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Tue, 24 Jun 2025 14:04:17 +0800
Subject: [PATCH BlueZ bluez] shared/bap: Set stream to idle when I/O is
 disconnected
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAOA/WmgC/x3MQQqDMBBA0avIrA1oqpF6FSkhE0c7IIlkbNGKd
 29w+Rb/nyCUmAT64oREXxaOIaMuC/BvF2ZSPGaDrnRbGd0odKudYrLIs5UjeLtE2ZR5NJ3xpnu
 OiJDbNdHE+/0dAJcP/eB1XX8TtvK4bgAAAA==
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750745059; l=3551;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=NnW6oCsp7Gte23sNn8PxIxPN0k6NBhSjprOBezp/bpQ=;
 b=geP9VZMgorkMMNCVVZ1CXDo8OloIkJzCS1Q0kLPEe+L3ZiQEcvFbr5nd36JFz39kRaelW9Znl
 dXAf08jHfhsArzKB8bcb4CNZi8qrhsei18iMKyEY8AS8DArPujqleIz
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

When the CIS link is disconnected, the ASE status transitions from Releasing to
Idle.

  > HCI Event: Disconnect Complete (0x05) plen 4           #1484 [hci0] 67.947425
  		Status: Success (0x00)
  		Handle: 512 Address: 5C:B1:E1:2F:01:B9 (Resolvable)
  		Identity type: Random (0x01)
  		Identity: E8:D5:2B:59:57:A6 (Static)
  		Reason: Remote User Terminated Connection (0x13)
  = bluetoothd: src/shared/bap.c:stream_io_disconnected() stream 0x..   67.948018
  = bluetoothd: src/shared/bap.c:bap_ucast_set_state() stream 0xdff..   67.948145
  = bluetoothd: src/shared/bap.c:stream_notify() stream 0xdffda8 st..   67.948275
  = bluetoothd: src/gatt-database.c:send_notification_to_device() G..   67.948525
  = bluetoothd: profiles/audio/bap.c:bap_state() stream 0xdffda8: r..   67.948679
  = bluetoothd: profiles/audio/transport.c:bap_state_changed() stre..   67.948967
  = bluetoothd: profiles/audio/transport.c:transport_update_playing..   67.949061
  = bluetoothd: profiles/audio/transport.c:media_transport_remove_o..   67.949106
  = bluetoothd: profiles/audio/transport.c:media_owner_free() Owner..   67.949149
  = bluetoothd: profiles/audio/transport.c:media_transport_suspend(..   67.949375
  = bluetoothd: profiles/audio/transport.c:transport_set_state() St..   67.949423
  = bluetoothd: src/shared/bap.c:bap_ucast_detach() stream 0xdffda8..   67.949574
  = bluetoothd: profiles/audio/media.c:pac_clear() endpoint 0xdd2d2..   67.949710

When BIG sync is lost, the stream status transitions from Streaming to Idle.

  > HCI Event: LE Meta Event (0x3e) plen 3                #3189 [hci0] 118.870863
  	LE Broadcast Isochronous Group Sync Lost (0x1e)
  		BIG Handle: 0x00
  		Reason: Remote User Terminated Connection (0x13)
  = bluetoothd: src/shared/bap.c:stream_io_disconnected() stream 0..   118.871183
  = bluetoothd: src/shared/bap.c:bap_bcast_set_state() stream 0xdf..   118.871227
  = bluetoothd: profiles/audio/bap.c:bap_state_bcast_sink() stream..   118.871258
  = bluetoothd: profiles/audio/bass.c:bap_state_changed() stream 0..   118.871307
  = bluetoothd: src/gatt-database.c:send_notification_to_device()...   118.871384
  = bluetoothd: profiles/audio/transport.c:bap_state_changed() str..   118.871452
  = bluetoothd: profiles/audio/transport.c:transport_bap_update_li..   118.871509
  = bluetoothd: profiles/audio/transport.c:transport_update_playin..   118.871555
  = bluetoothd: profiles/audio/transport.c:transport_set_state() S..   118.871610
  = bluetoothd: src/shared/bap.c:bap_bcast_sink_detach() stream 0x..   118.871660
  = bluetoothd: profiles/audio/media.c:pac_clear() endpoint 0xdd25..   118.871689

Fixes: https://github.com/bluez/bluez/issues/1343

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 src/shared/bap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index bccbc73ff..d51f3106e 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6584,10 +6584,8 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
 
 	DBG(stream->bap, "stream %p io disconnected", stream);
 
-	if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
-		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 
-	bt_bap_stream_set_io(stream, -1);
 	return false;
 }
 

---
base-commit: ae1b7f6ba805f82742bbc32ff275e268248ef9f8
change-id: 20250624-bap_for_big_sync_lost-63476c679dbb

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


