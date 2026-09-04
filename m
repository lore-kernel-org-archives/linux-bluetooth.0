Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57E511187
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540833; cv=none; b=gL6IowzimqEWXMho17XxhouvGAyGyPGj/67eKyArbHyNifJLKKVAd/oTKGe2hfIPYucoFqf9fSIdbBv7yLHWjPrbtyNJdkG+DswaQiQpvTArE+IydqxXGQ/Nlh0Zyv+iy5Xv+DyPm3GrJ9GctPspzAevfpjkscnIzMnQX0PM/Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540833; c=relaxed/simple;
	bh=QRcFqxQk3jGN1bWvroUDWajbIVASOPg+HzU7G8sowLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYY1n3LFbKT042Vwh4lBj7aS4LZvWkeP8Z23eB0Ok7Va86C0b/vckVObzw6X+Oap3zHUjVZmI8UmE2yNv3GHfaxfGq58aDQ8TdpGGuNeAvnzl+bHfh18RhoOuLUqJwMV+wO/vtoiPl2us0P1U4Ide+rn9miBeHaPDUbT16Q8ZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZpCd6ZoD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZpCd6ZoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788540830;
	bh=QRcFqxQk3jGN1bWvroUDWajbIVASOPg+HzU7G8sowLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpCd6ZoDAgW1Q9/w+FP8V+y5LEYE4fX3/queXE4aSVwjwk+ttxStgMDMrjZ5F86r1
	 Gl0bpjdWmB4cDysutJZwvbB+VXAwCwAPXIfcAiorNW1jzkN4VPiw6hx+mQM+EXixtw
	 vRYKjeQYUTn97GPZC+VBsLb8QjeqkFzDRh4dBXK+odVc3Xe9S4qbaix5E3W75WiNBs
	 FL1Qq97z9T9jhHegIdUmcktSb7u6bLDYDhmtReJd+uQD4yqJUsJjwv0OVB0IKzQjqM
	 K0NUpudnU73FMRd9gTyw3BCEn/aVDvGkvlGP98xo5gMYMxhXF33sSQYjt1Pod/HBV4
	 sh6QIV1xS3y+w==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7DA0B17E092F;
	Fri, 04 Sep 2026 18:53:49 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [PATCH 1/4] profiles/audio: Support MCS track position writes
Date: Fri,  4 Sep 2026 22:23:29 +0530
Message-ID: <20260904165332.42046-2-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904165332.42046-1-raghavendra.rao@collabora.com>
References: <1654183666f442926c1301e1733567216b307981.camel@hadess.net>
 <20260904165332.42046-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

Use MPRIS Seek to handle MCS Track Position writes.

This is required by PTS GMCS/SR/SP/BV-02-C test.
---
 profiles/audio/mcp.c   | 22 ++++++++++++++++++++--
 profiles/audio/media.c | 32 ++++++++++++++++++++++++++++++++
 profiles/audio/media.h |  1 +
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index 8adf814e8..2d239ac4b 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -795,8 +795,26 @@ static uint16_t mcs_playing_order_supported(void *data)
 
 static bool mcs_set_track_position(void *data, int32_t value)
 {
-	/* TODO: add support to setting position in org.bluez.MediaPlayer */
-	return false;
+	struct mcs_instance *mcs = data;
+	struct player_link *p = mcs_get_active(mcs);
+	int64_t position_centisec = value;
+
+	if (!p)
+		return false;
+
+	if (value < 0) {
+		int32_t duration_centisec = mcs_track_duration(mcs);
+
+		if (duration_centisec == BT_MCS_DURATION_UNAVAILABLE)
+			return false;
+
+		position_centisec += duration_centisec;
+	}
+
+	/* Convert MCS centiseconds to a relative MPRIS microsecond offset. */
+	return local_player_seek(p->lp, (position_centisec * 10 -
+				local_player_get_position(p->lp)) *
+				G_TIME_SPAN_MILLISECOND);
 }
 
 static bool mcs_set_playing_order(void *data, uint8_t value)
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 95f9580b0..82117a2ed 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -157,6 +157,7 @@ struct local_player {
 	GTimer			*timer;
 	bool			play;
 	bool			pause;
+	bool			seek;
 	bool			next;
 	bool			previous;
 	bool			control;
@@ -2296,6 +2297,29 @@ bool local_player_pause(struct local_player *mp)
 	return local_player_send(mp, "Pause");
 }
 
+bool local_player_seek(struct local_player *mp, int64_t offset_usec)
+{
+	DBusMessage *msg;
+
+	DBG("");
+
+	if (!mp->seek || !mp->control)
+		return false;
+
+	msg = dbus_message_new_method_call(mp->sender, mp->path,
+					MEDIA_PLAYER_INTERFACE, "Seek");
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return false;
+	}
+
+	dbus_message_append_args(msg, DBUS_TYPE_INT64, &offset_usec,
+					DBUS_TYPE_INVALID);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
+
+	return true;
+}
+
 bool local_player_next(struct local_player *mp)
 {
 	DBG("");
@@ -2673,6 +2697,9 @@ static gboolean set_player_property(struct local_player *mp, const char *key,
 	if (strcasecmp(key, "CanPause") == 0)
 		return set_flag(mp, &var, &mp->pause);
 
+	if (strcasecmp(key, "CanSeek") == 0)
+		return set_flag(mp, &var, &mp->seek);
+
 	if (strcasecmp(key, "CanGoNext") == 0)
 		return set_flag(mp, &var, &mp->next);
 
@@ -3247,6 +3274,11 @@ static void app_register_player(void *data, void *user_data)
 			goto fail;
 	}
 
+	if (g_dbus_proxy_get_property(proxy, "CanSeek", &iter)) {
+		if (!set_flag(player, &iter, &player->seek))
+			goto fail;
+	}
+
 	if (g_dbus_proxy_get_property(proxy, "CanGoNext", &iter)) {
 		if (!set_flag(player, &iter, &player->next))
 			goto fail;
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 1c43075ba..43a85b1d6 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -73,6 +73,7 @@ bool local_player_have_track(struct local_player *lp);
 bool local_player_play(struct local_player *lp);
 bool local_player_stop(struct local_player *lp);
 bool local_player_pause(struct local_player *lp);
+bool local_player_seek(struct local_player *lp, int64_t offset_usec);
 bool local_player_next(struct local_player *lp);
 bool local_player_previous(struct local_player *lp);
 
-- 
2.43.0

