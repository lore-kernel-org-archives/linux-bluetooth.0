Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFED62D3757
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533013; cv=none; b=PB4+3ClQRG6pwuKAFKJxXk4INfG4Ms/v6j/mMfje4cQu0Q0pznkbZpd9KiBCZThzp8W5/0+sIl/RDJvBED+aaze6Y6bPomiL1HgCNRkxQYaaTNh7pvfNaB+70/F7XTemD9aJvGI56hkqlBUYLv2cOKpnVINzQP5mjuM7USxnuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533013; c=relaxed/simple;
	bh=U90gis2UnA/s8f8VN5i7TXG/a3cNPlfqY6UmmJnmbYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqTZdF/SHXOAoIVN1mOCLybW3NpsPW3/boX5J3nSGHjf0XhW9zEKysPaGZMY0jb10YtN9Ylvs2gP0gPSGwM7UWR7mJJ1hMoiv/1gQ7VLNLvM5ipJNowBHO+iyfZ5UA5gbJrxeVju/+oeQvMtwwbLhDsN3nzYIpQVL9G/maFn0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C701243194;
	Thu,  3 Jul 2025 08:56:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 14/19] profiles: Fix typos
Date: Thu,  3 Jul 2025 10:53:22 +0200
Message-ID: <20250703085630.935452-15-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703085630.935452-1-hadess@hadess.net>
References: <20250703085630.935452-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght

Found using codespell.
---
 profiles/audio/a2dp.c      |  2 +-
 profiles/audio/avrcp.c     |  4 ++--
 profiles/audio/bap.c       |  2 +-
 profiles/audio/bass.c      |  2 +-
 profiles/audio/micp.c      |  6 +++---
 profiles/battery/battery.c |  2 +-
 profiles/gap/gas.c         |  2 +-
 profiles/health/mcap.c     | 18 +++++++++---------
 profiles/input/hog-lib.c   |  2 +-
 profiles/midi/libmidi.c    |  2 +-
 profiles/midi/midi.c       |  2 +-
 11 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 7c0f9c54a9e8..fe58b8fb351d 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -334,7 +334,7 @@ static int error_to_errno(struct avdtp_error *err)
 		return -perr;
 	default:
 		/*
-		 * An unexpect error has occurred setup may be attempted again.
+		 * An unexpected error has occurred setup may be attempted again.
 		 */
 		return -EAGAIN;
 	}
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 831f1dc8bf12..df28bf0b398c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1324,7 +1324,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp *session,
 	len = 0;
 
 	/*
-	 * From sec. 5.7 of AVRCP 1.3 spec, we should igore non-existent IDs
+	 * From sec. 5.7 of AVRCP 1.3 spec, we should ignore non-existent IDs
 	 * and send a response with the existent ones. Only if all IDs are
 	 * non-existent we should send an error.
 	 */
@@ -1376,7 +1376,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp *session,
 		goto err;
 
 	/*
-	 * From sec. 5.7 of AVRCP 1.3 spec, we should igore non-existent IDs
+	 * From sec. 5.7 of AVRCP 1.3 spec, we should ignore non-existent IDs
 	 * and set the existent ones. Sec. 5.2.4 is not clear however how to
 	 * indicate that a certain ID was not accepted. If at least one
 	 * attribute is valid, we respond with no parameters. Otherwise an
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 66403fcb7997..a1ca26bdc848 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2953,7 +2953,7 @@ static uint8_t get_streams_nb_by_state(struct bap_setup *setup)
 				entry; entry = entry->next) {
 		ent_setup = entry->data;
 
-		/* Skip the curent stream form testing */
+		/* Skip the current stream form testing */
 		if (ent_setup == setup) {
 			stream_cnt++;
 			continue;
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 2cda00b690ca..c853fbc4ae89 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -546,7 +546,7 @@ static void bis_handler(uint8_t sid, uint8_t bis, uint8_t sgrp,
 
 	queue_push_tail(setup->dg->setups, setup);
 
-	/* Only handle streams required by the Brodcast Assistant. */
+	/* Only handle streams required by the Broadcast Assistant. */
 	if (!bt_bass_check_bis(dg->src, bis))
 		return;
 
diff --git a/profiles/audio/micp.c b/profiles/audio/micp.c
index 3f0845dcb328..4f0bde1438ce 100644
--- a/profiles/audio/micp.c
+++ b/profiles/audio/micp.c
@@ -87,7 +87,7 @@ static void micp_data_add(struct micp_data *data)
 	DBG("data %p", data);
 
 	if (queue_find(sessions, NULL, data)) {
-		error("data %p allready added", data);
+		error("data %p already added", data);
 		return;
 	}
 
@@ -145,7 +145,7 @@ static void micp_detached(struct bt_micp *micp, void *user_data)
 
 	data = queue_find(sessions, match_data, micp);
 	if (!data) {
-		error("unable to find sessio");
+		error("unable to find session");
 		return;
 	}
 
@@ -197,7 +197,7 @@ static int micp_probe(struct btd_service *service)
 	ba2str(device_get_address(device), addr);
 	DBG("%s", addr);
 
-	/*Ignore, if we probed for this device allready */
+	/*Ignore, if we probed for this device already */
 	if (data) {
 		error("Profile probed twice for this device");
 		return -EINVAL;
diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 5318d40d12b4..5be78ab14c7b 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -151,7 +151,7 @@ static void read_initial_battery_level_cb(bool success,
 	struct batt *batt = user_data;
 
 	if (!success) {
-		DBG("Reading battery level failed with ATT errror: %u",
+		DBG("Reading battery level failed with ATT error: %u",
 								att_ecode);
 		return;
 	}
diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 08aaf19cb332..a4831d38f43b 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -99,7 +99,7 @@ static void read_device_name_cb(bool success, uint8_t att_ecode,
 	char *name;
 
 	if (!success) {
-		DBG("Reading device name failed with ATT errror: %u",
+		DBG("Reading device name failed with ATT error: %u",
 								att_ecode);
 		return;
 	}
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index 2e4214a6984f..74fffa71a2d1 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -2416,7 +2416,7 @@ static gboolean read_btclock(struct mcap_mcl *mcl, uint32_t *btclock,
 	/*
 	 * FIXME: btd_adapter_read_clock(...) always return FALSE, current
 	 * code doesn't support CSP (Clock Synchronization Protocol). To avoid
-	 * build dependancy on struct 'btd_adapter', removing this code.
+	 * build dependency on struct 'btd_adapter', removing this code.
 	 */
 
 	return FALSE;
@@ -2506,7 +2506,7 @@ static gboolean initialize_caps(struct mcap_mcl *mcl)
 
 	_caps.ts_acc = 20; /* ppm, estimated */
 
-	/* A little exercise before measuing latency */
+	/* A little exercise before measuring latency */
 	clock_gettime(CLK, &t1);
 	read_btclock_retry(mcl, &btclock, &btaccuracy);
 
@@ -2878,7 +2878,7 @@ static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 			return;
 		}
 
-		/* Convert to miliseconds */
+		/* Convert to milliseconds */
 		phase2_delay = bt2ms(phase2_delay);
 
 		if (phase2_delay > 61*1000) {
@@ -2961,12 +2961,12 @@ static void proc_sync_cap_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	gpointer user_data;
 
 	if (mcl->csp->csp_req != MCAP_MD_SYNC_CAP_REQ) {
-		DBG("CSP: got unexpected cap respose");
+		DBG("CSP: got unexpected cap response");
 		return;
 	}
 
 	if (!mcl->csp->csp_priv_data) {
-		DBG("CSP: no priv data for cap respose");
+		DBG("CSP: no priv data for cap response");
 		return;
 	}
 
@@ -2979,7 +2979,7 @@ static void proc_sync_cap_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	mcl->csp->csp_req = 0;
 
 	if (len != sizeof(mcap_md_sync_cap_rsp)) {
-		DBG("CSP: got corrupted cap respose");
+		DBG("CSP: got corrupted cap response");
 		return;
 	}
 
@@ -3009,12 +3009,12 @@ static void proc_sync_set_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	gpointer user_data;
 
 	if (mcl->csp->csp_req != MCAP_MD_SYNC_SET_REQ) {
-		DBG("CSP: got unexpected set respose");
+		DBG("CSP: got unexpected set response");
 		return;
 	}
 
 	if (!mcl->csp->csp_priv_data) {
-		DBG("CSP: no priv data for set respose");
+		DBG("CSP: no priv data for set response");
 		return;
 	}
 
@@ -3027,7 +3027,7 @@ static void proc_sync_set_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	mcl->csp->csp_req = 0;
 
 	if (len != sizeof(mcap_md_sync_set_rsp)) {
-		DBG("CSP: got corrupted set respose");
+		DBG("CSP: got corrupted set response");
 		return;
 	}
 
diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 22599f71a394..dbf4dad96bc5 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1132,7 +1132,7 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	if (value == HOG_PROTO_MODE_BOOT) {
 		uint8_t nval = HOG_PROTO_MODE_REPORT;
 
-		DBG("HoG is operating in Boot Procotol Mode");
+		DBG("HoG is operating in Boot Protocol Mode");
 
 		gatt_write_cmd(hog->attrib, hog->proto_mode_handle, &nval,
 						sizeof(nval), NULL, NULL);
diff --git a/profiles/midi/libmidi.c b/profiles/midi/libmidi.c
index 5b77cd3f52f1..6f2914a8c2ef 100644
--- a/profiles/midi/libmidi.c
+++ b/profiles/midi/libmidi.c
@@ -423,7 +423,7 @@ size_t midi_read_raw(struct midi_read_parser *parser, const uint8_t *data,
 		snd_seq_ev_set_sysex(ev, parser->sysex_stream.len,
 		                     parser->sysex_stream.data);
 
-		midi_size = 1; /* timestampLow was alredy processed */
+		midi_size = 1; /* timestampLow was already processed */
 		goto _finish;
 
 	case 0x80 ... 0xEF:
diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
index bab309bca7c3..0976842e80b2 100644
--- a/profiles/midi/midi.c
+++ b/profiles/midi/midi.c
@@ -319,7 +319,7 @@ static int midi_accept(struct btd_service *service)
 
 	err = snd_seq_client_id(midi->seq_handle);
 	if (err < 0) {
-		error("Could retreive ALSA client: %s (%d)", snd_strerror(err), err);
+		error("Could retrieve ALSA client: %s (%d)", snd_strerror(err), err);
 		goto _err_handle;
 	}
 	midi->seq_client_id = err;
-- 
2.50.0

