Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392391E51F5
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844680; cv=pass; b=QvbeX7fldz1ARYtjkW89WKdXPU4oQH4LAlkyp6OAxHMcQ6PJkIpAuLAgAvgq9TrLRA4XPQDp4rsRHRNWV2f0WKQE213kOmNDM+yZ+zN206kWflZHbbTTCetbot7byndBFipKwD1R4NQSi93IRIFD1/uCq8OsKjMPDpn8jrOEN2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844680; c=relaxed/simple;
	bh=Pwx3hH36t6gVhmXIC+DngVRHU9kXWvZspxBEY2Wuhko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KO1ejkQCoGPtUWx/U3d4VAuhuRaFPW0In8rVQ81F3kL2G4htOqB54On8eAAg9he3HEVXd8CQD+6M9PMrKd+MWZVYzrWIBG9peReZ7jdEq75fN1/8pgrT5cNXQY98QgNL3nPSH2xvzjbKgko4tp/y167f6NyI8K37+Of9HlzvNYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=mfXTj5H/; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="mfXTj5H/"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z4qV82Dqrz4BKJ1;
	Sat,  1 Mar 2025 17:57:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740844672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ry7H3NZM02h6zjB6Cz3Dotr5se19uHMHfSUvNGpUZ4=;
	b=mfXTj5H/oF2EO2S8dotAMghRxImBYMrrH7pTGqLTQJ+DuumbDVSY1l8J7PIpOz9d3E71bN
	YNOMZ+GL4H9OVXjRAle/31ND/AKtvsA1b0ncqidRnIoTNHVGa6+hjFu3kjlJx2H5q07+qs
	SWAzjLZQSzqroBNlVIYLwCgezqYi4QHFKEFva65es3KSORfIUyrHFmt+vQFBLWzFWjsEff
	OS6PdZmGUos45zeEWyCBiFXxKdVkf6QrXselL11/bVN9YHl7CKeDghrt0CcKvzxTqK9IWh
	/xaqEjqagQNePA9nfEiXErLRRpMptqdJx1h/7pkdJ0ApqRc0qh//uHx6PRk8GA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740844672; a=rsa-sha256;
	cv=none;
	b=AOYS3kgDMaHegSdtbp/6S7IJCSx4/vF9C06GGhqbBhv3g4ag7/pnJMBWbfMHZCzTsAubM7
	7YxOnomNib8glOwtdfTxijWG58Jm+W66TrZT0PeCAOc9NYk9RTEdmYGTQOW4TDj++4ADgc
	uIvdE/rLESaeFeOEQoLX7+lP7NyDTpU8hSUEYYEkjaiWw+KS3lrZCp0paVIv2rhs8z1wmw
	+Ky/sxp/2HgudDhKLykEdMuxLsROEtB5gAU3DVxO2E1E51u1Q37yv6WlrzCCmRlN1xsVYO
	vhp1f6tTEdgK7wUcuDwBNb6o69ACP4n2jH3IqeoXgFeCaqBUjiCzN54XTJdMIg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740844672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ry7H3NZM02h6zjB6Cz3Dotr5se19uHMHfSUvNGpUZ4=;
	b=Fh4oao8pVE9SOcT6lEC3sPVxlexDRjOivhPWAAjUMinYHilpGL6MXYdyOJQZdF7CYkzjfb
	xwlwjAQF73q8Nn7kBFlK2ypUbxOpWOr/a2CKMN1xuh4rF/ykTpE0/G843vQDCtE0aUzcsm
	Gt79fTj5GAHxNgKHpUDZyjwlaGej0fRHnbiLzn/SEuGADnkWs1ik4gqedDc06x7GHxyVzM
	rp0DMRhu1vj2rZ1iQZj0GiYLkl2Hu1l60pUFsStrJc+DNX3iH4n9r6e1ezkcPfFU/YisS/
	5mIh6RfMaE5uHshLcbj2pCRj+bB7vzysW2OCZflL2mp1pG677UzdgjDUANgyIw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 8/9] bap: do not try QoS before links are updated & io created
Date: Sat,  1 Mar 2025 17:57:39 +0200
Message-ID: <643267ffb9f4c4b2b7b5e36b551f890f3e9e81c4.1740844617.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740844616.git.pav@iki.fi>
References: <cover.1740844616.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not possible to QoS in config_cb, even if stream is in Config
state, because stream->io may not exist and stream links are not yet
updated. The stream links are updated only before bap_state(), so the
completion of config has to be handled only there.

Wait for both events to complete before proceeding to QoS.
---
 profiles/audio/bap.c | 80 +++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 46512a7f3..da1f9feb1 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -83,6 +83,7 @@ struct bap_setup {
 	struct iovec *base;
 	struct future *qos_done;
 	struct future *close_done;
+	bool config_done;
 	void (*destroy)(struct bap_setup *setup);
 };
 
@@ -851,32 +852,49 @@ static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
 	future_clear(&setup->qos_done, code ? EIO : 0, "Unable to configure");
 }
 
+static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
+				struct bt_bap_stream *stream, int defer);
+
+static void setup_qos(struct bap_setup *setup)
+{
+	struct bap_data *data = setup->ep->data;
+	struct bt_bap_stream *stream = setup->stream;
+
+	if (setup->id || !stream)
+		return;
+
+	setup_create_io(data, setup, stream, true);
+	if (!setup->io) {
+		error("Unable to create io");
+		if (bt_bap_stream_get_state(stream) !=
+						BT_BAP_STREAM_STATE_RELEASING)
+			bt_bap_stream_release(stream, NULL, NULL);
+		return;
+	}
+
+	/* Wait QoS response to respond */
+	setup->id = bt_bap_stream_qos(stream, &setup->qos, qos_cb, setup);
+	if (!setup->id) {
+		error("Failed to Configure QoS");
+		bt_bap_stream_release(stream, NULL, NULL);
+	}
+}
+
 static void config_cb(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
 					void *user_data)
 {
 	struct bap_setup *setup = user_data;
+	const char *err_msg = "Unable to configure";
 
 	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
 
 	setup->id = 0;
 
-	if (!code) {
-		/* Check state is already set to config then proceed to qos */
-		if (bt_bap_stream_get_state(stream) ==
-					BT_BAP_STREAM_STATE_CONFIG) {
-			setup->id = bt_bap_stream_qos(stream, &setup->qos,
-							qos_cb, setup);
-			if (!setup->id) {
-				error("Failed to Configure QoS");
-				bt_bap_stream_release(stream, NULL, NULL);
-			}
-		}
-
-		return;
-	}
-
-	future_clear(&setup->qos_done, EIO, "Unable to configure");
+	if (code)
+		future_clear(&setup->qos_done, EIO, err_msg);
+	else if (setup->config_done)
+		setup_qos(setup);
 }
 
 static void setup_io_close(void *data, void *user_data)
@@ -1128,6 +1146,8 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
+	setup->config_done = false;
+
 	if (setup->metadata && setup->metadata->iov_len)
 		bt_bap_stream_metadata(setup->stream, setup->metadata, NULL,
 								NULL);
@@ -1655,6 +1675,8 @@ static void setup_config(void *data, void *user_data)
 		return;
 	}
 
+	setup->config_done = false;
+
 	if (setup->metadata && setup->metadata->iov_len)
 		bt_bap_stream_metadata(setup->stream, setup->metadata, NULL,
 								NULL);
@@ -2086,9 +2108,6 @@ static bool is_cig_busy(struct bap_data *data, uint8_t cig)
 	return queue_find(sessions, cig_busy_session, &info);
 }
 
-static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
-				struct bt_bap_stream *stream, int defer);
-
 static gboolean setup_io_recreate(void *user_data)
 {
 	struct bap_setup *setup = user_data;
@@ -2473,25 +2492,10 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-		if (setup && !setup->id) {
-			setup_create_io(data, setup, stream, true);
-			if (!setup->io) {
-				error("Unable to create io");
-				if (old_state != BT_BAP_STREAM_STATE_RELEASING)
-					bt_bap_stream_release(stream, NULL,
-								NULL);
-				return;
-			}
-
-			/* Wait QoS response to respond */
-			setup->id = bt_bap_stream_qos(stream,
-							&setup->qos,
-							qos_cb,	setup);
-			if (!setup->id) {
-				error("Failed to Configure QoS");
-				bt_bap_stream_release(stream,
-							NULL, NULL);
-			}
+		if (setup) {
+			setup->config_done = true;
+			if (!setup->id)
+				setup_qos(setup);
 		}
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
-- 
2.48.1

