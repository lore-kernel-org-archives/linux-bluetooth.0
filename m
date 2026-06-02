Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21DE3859F0
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434036; cv=none; b=fTGzW0t7qqmsLC+ATnpZLynbjZRLNov6Amjngxr9AKDK5O5Bj9Z4cJzAVgy/1urim/WGf6Fcn3gsHnxmX+oRyK8e0hNKsVse2MgTCwcGHxZ1Ot8ptQh8gO3A4gWWsovbRTeiCMTsyahFPBZZ8yjb0MhB3w6U/IAgnyPlFLRUHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434036; c=relaxed/simple;
	bh=91FRLqo09leHOfEK6+9ARCLfYWmf271AJ9VtRWEON58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arQqO3EDO00a4gdNB8LSUNkIuE7GxcEg9g/RQ4ID9TdPDSzs+eWBNP/cn50H7zTg5uD1n8orZfFBOZ43YPS4JS/zTzxuCwMFDbgG7j4TxpsdsVJy618rM6GwjOZAnKk0Bx6t413UF4GNyrsznLzbnz3gJWDAPq1yYeW/smLu69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jezd62Zy; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jezd62Zy"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9639e91e773so1899737241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780434034; x=1781038834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yV3gywVs9F9RhUHwuQZGUDFPvVFFnaQ2a77xeZdNJC0=;
        b=Jezd62ZygKjX7lNxXdnY7vixZ0V8QyLif3xlHgmNHmhl8XP/TxMDVxpHKGOtwA2qM8
         VSDLqYFMJkIj+csjuahZNl7gSLbIlL8wAwjgW/ThHY3LZsyvNbLT737MXG3AYlVKTkwV
         Bh9L/0wH+geogFuuxYPz1GV2MW39SfYw1Rf9INe/RsyjrYhaK8WUvj2tWw8msAMH30oG
         XpEokIvR3eOCP+5v+7pfYmkDISUWW64GSO5/riDAB8rDcI8QtBFWDD5L/nWux+Fg6wDN
         /50fve3OoxIevF+x+Zl1KlT73hmeiOU361/cLgwVyjl4vVUszt13HXo2PK6kRISbMQbX
         bw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780434034; x=1781038834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yV3gywVs9F9RhUHwuQZGUDFPvVFFnaQ2a77xeZdNJC0=;
        b=bq/jNVSHp6SKXr3obESaBXaYpo2mNJRXpWwRoh576iRVYK7T3j6CqeHfd6zDc9Tlp3
         cUuntW3runh8p4DXBpiPcZNqTsuagVZrdK+kz+oHpju9vaVP5YqlpBd8EI2q5wZhwxWq
         SQ+Zu6a3tmbgaEE8CZYJFXidu4bjihCwxbBYK57CHGXqCNricY+ML9akdJXlOvBS0Yxa
         wZgQHUJdFB4OKXds1ce889QYOottQQLuQj9qY4F6WMW2YAI7xX0vg+bhmqODggcb3u0G
         JwvBHBExBroxAfpa79iGWHRU98imnkuJenWLuSDVvIupT99A+OAvC5ywjYJ6RCEhTsW1
         Zr5Q==
X-Gm-Message-State: AOJu0Yz47wG2ZaOB/pbk7X+S6Aejw/WZn1AAAL5y1fCGlRXFb5gZFOJr
	tm/CeixdooITBdFNhl5hX7hrnnWJ8p258DgIvwm2w/5cGfJjrPkDdvCPDt4A7kk0H9A=
X-Gm-Gg: Acq92OERb7IauhyUzb/rnadkZUtdYqnJVSg3ll+PNTPVYyvbp4S39q+Rybb5+1Pl7PT
	O9EDRBnkxUERZjfZNayTAnvjqbSJD2o49Cwfeuv39pw5g13RL5sB+uEiFmlNfJU7NJZ422tdqEz
	x1gPqVgQzFWr3PRVNFMlgGuu/irb6Owb4hpYdFmW5svg4FyRxhIT1zkqEVhDlKPz1qwxRsEjwzS
	wzAi0f0KyUrejMGea8rpPl7uGAuUM2Erla5yhBw+76ojeDC/Rt2Ec6FPa6fXEaMpep8olXouLZW
	SfUHVbcbDOSBvdv/M5XoC2nfFIUgNI46m1QUsLvrWSCP3fstMjNNW35C+tkMoAxCrGvo1G9y+rp
	6gJ63jKF8LSSijWtTa3rD1wr7hQd2M/XNMr/R1ePv626+7gpzuj4EXA+hUS0WVulo4gyAtQ4ax+
	+7z7oG7HpHsExImJoE9/qWgnWP1KMw+a5T3miTyD9CV+Y+yF8slrVH7TxAWL2E51aYFqPf4Cn5k
	js1BEyn7YwCJ7neNGKoXciLSKnq
X-Received: by 2002:a05:6102:9d3:b0:631:b834:e052 with SMTP id ada2fe7eead31-6ec2f00709fmr187974137.12.1780434033668;
        Tue, 02 Jun 2026 14:00:33 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb6668702fsm496943137.10.2026.06.02.14.00.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 14:00:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/4] profiles/audio/bass: Handle PA_SYNC_NO_SYNC in handle_mod_src_req
Date: Tue,  2 Jun 2026 17:00:20 -0400
Message-ID: <20260602210022.213562-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602210022.213562-1-luiz.dentz@gmail.com>
References: <20260602210022.213562-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When the delegator receives a Modify Source operation with pa_sync set
to PA_SYNC_NO_SYNC while already synchronized to PA, release all
setups instead of updating BIS sync which would not apply the
requested termination.

Also reset the encryption state to no encryption when the last BIS
index is cleared from a subgroup, so subsequent source additions
start with a clean encryption state.
---
 profiles/audio/bass.c | 72 ++++++++++++++++++++++++++++++++++++++++---
 src/shared/bass.c     |  6 ++++
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index f018f8b3ad7f..5eb7bff076bb 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -420,7 +420,13 @@ static void setup_clear(struct bass_setup *setup, int bis)
 
 	bt_bass_clear_bis_sync(dg->src, bis);
 	setup->stream = NULL;
-	queue_remove(setup->dg->setups, setup);
+
+	if (!queue_remove(setup->dg->setups, setup))
+		/* Setup has already been removed from the queue (e.g. during
+		 * handle_mod_src_req PA_SYNC_NO_SYNC processing). Skip
+		 * disconnect check and free since the caller handles cleanup.
+		 */
+		return;
 
 	/* Remove any pending bcode request associated with setup */
 	req = queue_remove_if(dg->bcode_reqs, match_bcode_setup, setup);
@@ -596,6 +602,8 @@ static void bass_remove_bis(struct bass_setup *setup)
 {
 	struct queue *links = bt_bap_stream_io_get_links(setup->stream);
 
+	DBG("%p", setup);
+
 	queue_foreach(links, stream_unlink, setup->stream);
 	bt_bap_stream_release(setup->stream, NULL, NULL);
 }
@@ -618,6 +626,8 @@ static void setup_disable_streaming(void *data, void *user_data)
 
 static void bass_add_bis(struct bass_setup *setup)
 {
+	DBG("%p", setup);
+
 	queue_foreach(setup->dg->setups, setup_disable_streaming, NULL);
 	setup_configure_stream(setup);
 }
@@ -1941,8 +1951,40 @@ static int handle_set_bcode_req(struct bt_bcast_src *bcast_src,
 	return 0;
 }
 
+static bool check_bis_sync(struct bt_bass_mod_src_params *params, uint8_t bis)
+{
+	uint32_t bitmask = 1 << (bis - 1);
+	struct iovec iov = {
+		.iov_base = params->subgroup_data,
+		.iov_len = 0,
+	};
+
+	/* Calculate subgroup data length based on each subgroup's
+	 * bis_sync (4 bytes) + meta_len (1 byte) + meta fields.
+	 */
+	for (uint8_t i = 0; i < params->num_subgroups; i++) {
+		uint32_t bis_sync;
+		uint8_t meta_len;
+
+		iov.iov_len += sizeof(bis_sync) + sizeof(meta_len);
+
+		memcpy(&bis_sync, params->subgroup_data + iov.iov_len -
+				sizeof(bis_sync) - sizeof(meta_len),
+				sizeof(bis_sync));
+		memcpy(&meta_len, params->subgroup_data + iov.iov_len -
+				sizeof(meta_len), sizeof(meta_len));
+
+		if (le32_to_cpu(bis_sync) & bitmask)
+			return true;
+
+		iov.iov_len += meta_len;
+	}
+
+	return false;
+}
+
 static void bass_update_bis_sync(struct bass_delegator *dg,
-				struct bt_bcast_src *bcast_src)
+				struct bt_bass_mod_src_params *params)
 {
 	const struct queue_entry *entry;
 
@@ -1954,11 +1996,14 @@ static void bass_update_bis_sync(struct bass_delegator *dg,
 
 		state = bt_bap_stream_get_state(setup->stream);
 
-		if (!setup->stream && bt_bass_check_bis(bcast_src, setup->bis))
+		DBG("stream %p: BIS %d state %s(%u)", setup->stream, setup->bis,
+				bt_bap_stream_statestr(state), state);
+
+		if (!setup->stream && check_bis_sync(params, setup->bis))
 			bass_add_bis(setup);
 		else if (setup->stream &&
 				state == BT_BAP_STREAM_STATE_STREAMING &&
-				!bt_bass_check_bis(bcast_src, setup->bis))
+				!check_bis_sync(params, setup->bis))
 			bass_remove_bis(setup);
 	}
 }
@@ -1981,9 +2026,26 @@ static int handle_mod_src_req(struct bt_bcast_src *bcast_src,
 	if (err)
 		return err;
 
+	DBG("PA sync state %d", sync_state);
+
 	switch (sync_state) {
 	case BT_BASS_SYNCHRONIZED_TO_PA:
-		bass_update_bis_sync(dg, bcast_src);
+		if (params->pa_sync == PA_SYNC_NO_SYNC) {
+			/* Release all setups. Note: bass_remove_bis may
+			 * trigger synchronous state transitions that call
+			 * setup_clear which will return early since the
+			 * setup has already been removed from the queue.
+			 */
+			struct bass_setup *setup;
+
+			while ((setup = queue_pop_head(dg->setups))) {
+				bass_remove_bis(setup);
+				setup_free(setup);
+			}
+
+			delegator_disconnect(dg);
+		} else
+			bass_update_bis_sync(dg, params);
 		break;
 	case BT_BASS_NOT_SYNCHRONIZED_TO_PA:
 		if (params->pa_sync == PA_SYNC_NO_PAST) {
diff --git a/src/shared/bass.c b/src/shared/bass.c
index 19cc9531d617..65ee4a8cbb18 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1930,6 +1930,12 @@ int bt_bass_clear_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis)
 		if (sgrp->bis_sync & bitmask) {
 			sgrp->bis_sync &= ~bitmask;
 
+			/* If there are no BIS index left then reset encryption
+			 * state to no encryption.
+			 */
+			if (!sgrp->bis_sync)
+				bcast_src->enc = BT_BASS_BIG_ENC_STATE_NO_ENC;
+
 			iov = bass_parse_bcast_src(bcast_src);
 			if (!iov)
 				return -ENOMEM;
-- 
2.54.0

