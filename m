Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A319DF62
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198573; cv=none; b=QyONFq9TA5fVkv3X8qoCD/qvEIlCEW0d6I0hRBRLIf6mfbVpzjHjPpHtD/D+61pAMR46OpJz9H5wC3gU6byUmTLG8BJwkL9CZJIBNPreo0O8mwt7FdHMBlzUb5H6WRFIZLCY6lKbgnArDc2Iu3WeFuP2Yu3xOG0WFk98Lkqdvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198573; c=relaxed/simple;
	bh=91FRLqo09leHOfEK6+9ARCLfYWmf271AJ9VtRWEON58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSKfxBq88JCkRsyVUAtnoUn3h78q77b79A5r5OXOtLSDrjvqAe4wZ6hMdrWteJO2IUimWDNDgXhAM8rsA1OZP6TeuO5dge9RGMisxKwemd84p9z5J2kxWFPbeNk6Tx+kBSLYrOyfycmp0SyUAWt2ZX6DQo6Ke6jeiIFRo6sQ8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCsF3gtN; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCsF3gtN"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9639b1ef167so19416241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781198565; x=1781803365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yV3gywVs9F9RhUHwuQZGUDFPvVFFnaQ2a77xeZdNJC0=;
        b=VCsF3gtNQDge2waJTryp9j9135CF4x5iV+zIsez5BljiL0s/R39lB864vBTcr11w1D
         Qbkli+iu4E+TEukxBOUi5jcj7GCtArRCGQqVubP1JSLD/S9PBTKmL6eqKbTsHihiYLN7
         HARt0zbieEyhnLPOT2q/QUcY3mTMx0csaH47WpzmQhuca95x53pRjerwX23RWb8Jlnw8
         RFSfMRbSqdjcyolxKFv0r/qj4YcX57a45fmHrX/vzgsIF9519iHX6GpaTrYzoUr/faRA
         qkh5heyc091h3AfgWegKCzBB7ZRjRJFz2CqNWzpLIo/0eSL0A/Spq3HuuPSRVrK2C4kJ
         CdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198565; x=1781803365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yV3gywVs9F9RhUHwuQZGUDFPvVFFnaQ2a77xeZdNJC0=;
        b=ZC9X3Rg3GaFj+7KOKlpNEEVL0vJ+3QSBsDJgaehbUNUxSlM7IQ3qBQtL8/0kd6cr1h
         QFHmQ1YdSlOhFn2+KdLTIJRUJk0O/vw802/xO4hMlqLG1XIYcCbMnoyVazxUBGLSKeXD
         tcHGonOAGQgizwFDAA7ptdaL+tT40uDWewfsvl+KxAi7uVSYptG1acXrt4cDTXUE/Lv7
         EBF02MH3437X03de8TmukkfSlaT39/autzgIfMMYs/VD1YxQWNXrbHn6M3MmdULnwvTW
         VgRrOJYabCmsaIEjzJOhyaJgsnbE+O2vpoG8QjjewLn6bYih3ObF7Vaga3dBKwiY/Fui
         27VQ==
X-Gm-Message-State: AOJu0Yy7exCxYT0Dhyz+85h9SFOSMHwIzxroLHK+xUJuWzz4a0ZYtHRT
	50VHTZNhFCcxije9kb+rBiMNMe2MzpcN7dtzNHutEPDZ9ogZSrRpprc/qdTEckzh
X-Gm-Gg: Acq92OHEqvIHyeTqUEQFjqtmq7p5+vJDRbrpxCM85PKwKOf4/zWkEEQt2QqF8CluJCy
	cphkLpNMKpkCIaIx3hiVMI2l2FLGenaLL8X6FlAGlv3GOFRSxXVih23L58yvXfZ8Ek/0NzJxGg7
	nOHx1ZjAtcUe4Oat60bsLOaE6KE+04yV1kheAsr+nRMqCvQdeU0EDG0cKuXTQ0MM+kFyIOhJWcg
	zb9F/1+hsrRxCQc/eEcxtXL8lc/YSTwYm4zyx6D/NBOccdB2dzpA5krs/qFOZZR5kfodDJLEXAw
	ZDnFQuNvKF/RoxW0JY24d0fvxkHDFU8iAjTqLsd3CjHpgpXfsbvMYdM6yHhgn1RQEO9Lf+sa6Z6
	nGOqfsB1gELZqAbbmKtsm04aI+i+ldsbhr/ocNcnlAQ61+6jBzpEwQB3yLqXBsd2Gr75BNdCipA
	IRBh3ituW6Fi3IA9cb9Kgb6wuocWxDVSSicy2GSf411q5dUeayOCFtwTLEOOWEdpJBviDKF0IC3
	IPdZmdOuwpWy1ZBVsvVJhEilaU/
X-Received: by 2002:a05:6102:580a:b0:612:7ddc:52ee with SMTP id ada2fe7eead31-71d5c471e3bmr2412817137.15.1781198565008;
        Thu, 11 Jun 2026 10:22:45 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-71d9267bb61sm1689828137.9.2026.06.11.10.22.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:22:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/4] profiles/audio/bass: Handle PA_SYNC_NO_SYNC in handle_mod_src_req
Date: Thu, 11 Jun 2026 13:22:33 -0400
Message-ID: <20260611172235.92930-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611172235.92930-1-luiz.dentz@gmail.com>
References: <20260611172235.92930-1-luiz.dentz@gmail.com>
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

