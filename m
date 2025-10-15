Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406E320CB6
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542830; cv=pass; b=cZc2Q+znJqeYnNyUWaXVborVLS4+kVkNXKFiregk9g9rTDosx3NIxqydKnAzJ6J05yJm5hi09Y1Lhv+RTlm68gGcPVIyKqOHY4MjFvyS8iWS8fH6201pcmuJ+tmiDKN+YGF+fA8M5xFwOGC95i3Q7xgxI53ZW8RU5YVzQHnq73o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542830; c=relaxed/simple;
	bh=SKTPfv9Steujs590ITDhxuwvlmB7Hw97zL9aWZajgYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RRCY9Hk2rAjkSsWRLHuu1i0urzvhCBmCzbj09ZOdO+hyHyib2yJmzsY3bK45a8mrrsTjcnRZYAIdi7vbDER/Pp/cwUI3kJ18fYUaARMndKF6sYr8MlfUh3D3qX6L+N986JRqt5bkweL3zie5fDUKhVrNswUeiTMeJEFSlcv0fc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=bLgvC7UT; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="bLgvC7UT"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cmwJb2SW1zyQw;
	Wed, 15 Oct 2025 18:40:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1760542815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I7kBqBhGExd/y1HzSPjWFv7/2CaKxcayAee3Cwn/FK8=;
	b=bLgvC7UTVuj4umpM6ViOZcZUulLsIGCy912vl6N3GIDl1i1b7fRDicleKypKiET7W49RZ4
	ZC3PsN6KlMYl7pTT2wXeqrLpt+j6IhUCmTnjAgoCFFy5qtUjriSmFSvjzww3rCHgtgUNJ/
	Hjgr1ESRoGGUgKDz/HoIPTCYKwJB+cY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1760542815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I7kBqBhGExd/y1HzSPjWFv7/2CaKxcayAee3Cwn/FK8=;
	b=lpnQcWNxgUViCemxti05Yrw9ZVl5ZuCUl9P0uVkV4KKr9ImP3wXJl1i08iiw5RXA6BfzKD
	jbD7vNOEL3lxaMNNv/YystChOzFV4ZB8leo+gwIOrkGYhFklj3v1AckiWXRzmVkXATyiEX
	GGJmwmy6t4KlZGaI3CPzvf8sjhIYrTY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1760542815; a=rsa-sha256; cv=none;
	b=rQjGafMkmjpveu7dF+EXI4goi+vAWgqPfYGoEs+SofArHGnl0+iy7rhObzenrD+OTXRr3S
	IItMlVR5JODTzVnl43IjJ+MuPpGK7cxibgf+BO3eE2TYsxg5d15uvhUUPsN52NN8aU/fLP
	tEe6uy0saRmwYyX6y611Lz2/En+GnQ8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] bap: tolerate inverted STREAMING and iso_connect_cb()
Date: Wed, 15 Oct 2025 18:40:11 +0300
Message-ID: <d442c20f47eb10f51c19480988964e881f6b0049.1760542606.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ordering of STREAMING and iso_connect_cb() is unspecified, as
kernel/Glib do not preserve the order of these events.

STREAMING before iso_connect_cb() causes transport to fail Acquire()
since bt_bap_stream_io::connecting == true.

Fix by marking IO as connected even though the connection didn't yet
complete. The socket fd is valid, although not yet writable/readable.

Fixes: https://github.com/bluez/bluez/issues/1506
---
 profiles/audio/bap.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 2994881cc..b776511c5 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2874,6 +2874,27 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		}
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
+		/* Order of STREAMING and iso_connect_cb() is nondeterministic.
+		 *
+		 * If iso_connect_cb() did not complete yet, mark IO as
+		 * connected regardless, otherwise transport fails acquiring it.
+		 * If the connect doesn't actually succeed, it is handled via
+		 * normal disconnect flow.
+		 */
+		if (setup) {
+			int fd;
+
+			if (!setup->io || !setup->cis_active)
+				break;
+			if (!bt_bap_stream_io_is_connecting(stream, &fd))
+				break;
+			if (fd != g_io_channel_unix_get_fd(setup->io))
+				break;
+
+			DBG("setup %p stream %p io not yet ready",
+								setup, stream);
+			bt_bap_stream_set_io(stream, fd);
+		}
 		break;
 	}
 }
-- 
2.51.0

