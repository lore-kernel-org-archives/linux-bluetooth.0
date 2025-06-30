Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16217C220
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270574; cv=none; b=AI0HUV8EiH9y9JGpKJWp7au67mp5haw3DpU4FT6rdvmYlyP6jvyAuEhVAqsWgXeYIhXfCzfurM705ewOFnPZhDZbbCw3gMH7DFAYctTIYhd35EUY4hWqZGK0zXaGZFBLZetadnNu3atZO+/io9C2qFbxkmN6xguOwl2nqGpowsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270574; c=relaxed/simple;
	bh=FuXXheqUfAJGWwYD4w3w59gWfPoAvkAVVbVgvnstBGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4a7nDokNh/fTDAVskfJZVmNyulZyYBmYF/VYO8EpMmTvB/BUERFLk50DJuGaM/HTadOtuTDqDePk94OG4mCCRZy70tkO4trcjThLZegtZrMNnymnuZXw6GK2bH78wUnoCzd63x3TCN7UApFXYoC8wKdjULGUrYrzVsdzSjXQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyqdHGiV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyqdHGiV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4734C4CEEF;
	Mon, 30 Jun 2025 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751270573;
	bh=FuXXheqUfAJGWwYD4w3w59gWfPoAvkAVVbVgvnstBGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EyqdHGiVVeLyHQkC/BEdj/pP47EqVLPnWjDMJ/sc+JwYDwACGWEaSGYdhGb2cdFkq
	 PxvBezCvufwHn7VhM2bMMuwvv4iTMvPALK3kdV3HAYoWNlvZENqTpCAr+46QkCFbDI
	 6RDioPxv/f1sRvLabxJJ6+8ufXkPd2ZKTbCPAFJrERXKNjHg5X2RU244XtIMSoOBs8
	 Tw3cQ3YAM0tJR939/KooPoL75Du0yjtUVcd7poZv97aw1tDeEpDdgpeT3e9gImSzRz
	 KC3c/deT2pkC44ju3zkECM83IaY2VNs7tKNYEpHW2XnHOqLTHFKLlbP5UaLz2oP0PT
	 GHMG3zQZYPm2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23DAC83000;
	Mon, 30 Jun 2025 08:02:53 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Mon, 30 Jun 2025 16:02:39 +0800
Subject: [PATCH BlueZ bluez v2 1/2] shared/bap: Set stream to idle when I/O
 is disconnected
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-bap_for_big_sync_lost-v2-1-1491b608cda5@amlogic.com>
References: <20250630-bap_for_big_sync_lost-v2-0-1491b608cda5@amlogic.com>
In-Reply-To: <20250630-bap_for_big_sync_lost-v2-0-1491b608cda5@amlogic.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751270571; l=1928;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=92SydGaaEdJmXbGkfC2lMGKWAMTe2TX3XrYlSHvTicg=;
 b=Ak+o43Nc+GzJ/M6egXdaBv/+cEWN9/0TTZ2kCyuoEnRdFzlJbxgMs5wIWEh8OX1fgIq6xhPDj
 T9IzHgTjv1hDxXP8xzXhwmjjaEYCI7ZjJc5k7fWjwMX/XovZEXMsM3I
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

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
 src/shared/bap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index bccbc73ff..984ae782d 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6584,6 +6584,11 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
 
 	DBG(stream->bap, "stream %p io disconnected", stream);
 
+	if (stream->lpac->type == BT_BAP_BCAST_SINK) {
+		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+		return false;
+	}
+
 	if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
 		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 

-- 
2.42.0


