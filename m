Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BE1F5821
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745750698; cv=pass; b=VR5TgRS8pYQ3T4uqWkIlM+IVhOXhCedHKVWP8Z//cSVX7MLWkPJO7xqrzkcyBmRo//1erQTb3kPUr1zJkfuF7a/bsF3/z1SbYwCSzqOC3B10o/fiGw4n/pKUT20vhrPvuoDmSugAfre58ry5lOVhhY03Qmr8cTKWs6ol/7mau14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745750698; c=relaxed/simple;
	bh=2eIcF11R4y8YSEOlKtCK/ypYEHPgW8khGnY8uEeNKuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIwaYaCm+uQhQ2sXsOkGMz5xtP/DSNcAqxcdKcDIrwnDLQJxBb3RYLwuN9EUf7uno5Kci1SfmDNk7d2Gabt4RinBBojQxINZLP3iyIdfHe31peDGJ3gSeFstjFVCf8QfCIWX+9QACNJgG1JhgEix3rtzcyDgAgdPjglW9j70SX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=O7zFb+GZ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="O7zFb+GZ"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Zljrh6qJqz49QKK;
	Sun, 27 Apr 2025 13:44:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745750693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGVdXYo19TJjQxJ11y5ttsqlc+cF9jVl//LSJcPcRD4=;
	b=O7zFb+GZNB5Ja5QBfrTQWUWFy8uOcjHlraXiDK0kS0oEwK6eWTZRGMxh2YO4LdVNtopmQ8
	05kowz5NR08F3JIxivyFhKQT4x5NTIVy16pTzziwOImxOlLYWCjJOEcZskfpPoMKfXo4vC
	EQ86Ed4CIWFGAU1UgRAF8gO3QetQAIGEvHEqjSVhVvtMkyqlou1btr+hJ5i9nEVK6T2Iox
	LMUruG7b+fwV911ZhvIyFvwCsDUjKCBSqj4bdtzBLBrzDijEQ6qsNX7zZJBopsLjrjDvB/
	exQNunWTf8iZRNx7OO8+8/1ajNPgYJeD904wP6N4c+i7bZFsKc0YyCkYAGQKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745750693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGVdXYo19TJjQxJ11y5ttsqlc+cF9jVl//LSJcPcRD4=;
	b=t3YOhljigsUE9IkzW9/ifDiqm/gm74kJMtUoj3wjymlcu21eiK2svLiCpVLTTeiucvNwOi
	/UYNTeuc7t1F27KHu8paT3nI+60n3TvIKtchpMNrA87QoBf7D+hAH4gD40hLoVJoWndWF1
	+ITwX+/3rQT/Ie3eK0eRCWs8GC5eu5+opQtNvqmg3XDPQP5rrjRt492PHPO2sI7tuiCI+X
	PgTg3Dcob9m4zH5Nmiylhk0EWsEK2zJco8VFsSQ+25AMt8y9uzn44tszwZ6yJ5lQcxTPpT
	uCrVDisRFmriOIG+lel9wuxyApryBd4k+V7GtPDg7+Pf9uyz8Nh/GNBCGLuxhw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745750693; a=rsa-sha256;
	cv=none;
	b=NrTyCEkZj4nwmfx8yQoiUGkDhNTVz9jceLisRCouK0aiRiOqd49HM9Mn12t/u10qJbULAi
	EYjUrjyB0eBvow7aREJRMgZKPInOkADCC3ZL4kQKa96NoKA2hxM0RVXEvF3obbanW74pJX
	nMVDd4ZOUT61GMtn+AY7DK/5XT+3mewQq6LdkbNVG0jRajMVSZeixBHw3W7b7qOot4C9up
	aJ4zRMDs9y0jTH/Mm8YziT/DMfuOg/HFIGrw6M1zQNOSy8VtbYWTgY5HCn6zdMnTxZvIiu
	bGTxNhIDNh4sIb4ZpxLxaJkY+24a/ZpceOjR+bpWcyYs5IEWp8/vFdxig+P3Ug==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/5] hciemu: set bthost ACL MTU to match btdev
Date: Sun, 27 Apr 2025 13:44:37 +0300
Message-ID: <258a6c7a911bd864ad15e81bd7155ddf47a1fa6f.1745750626.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <b4a9c82f09efddcff2e604546c33e3737d8955c5.1745750626.git.pav@iki.fi>
References: <b4a9c82f09efddcff2e604546c33e3737d8955c5.1745750626.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the bthost ACL MTU to avoid generating larger packets than the btdev
ACL MTU.

This tests RX timestamping on ACL fragmentation.
---
 emulator/btdev.c  | 11 +++++++++++
 emulator/btdev.h  |  3 +++
 emulator/hciemu.c |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 76bae5ea1..cf5c36bb4 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -7460,6 +7460,17 @@ const uint8_t *btdev_get_adv_addr(struct btdev *btdev, uint8_t handle)
 	return ext_adv_addr(btdev, ext_adv);
 }
 
+void btdev_get_mtu(struct btdev *btdev, uint16_t *acl, uint16_t *sco,
+								uint16_t *iso)
+{
+	if (acl)
+		*acl = btdev->acl_mtu;
+	if (sco)
+		*acl = btdev->sco_mtu;
+	if (iso)
+		*iso = btdev->iso_mtu;
+}
+
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states)
 {
 	memcpy(btdev->le_states, le_states, sizeof(btdev->le_states));
diff --git a/emulator/btdev.h b/emulator/btdev.h
index a96c1a325..c7b3b468a 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -84,6 +84,9 @@ uint8_t btdev_get_le_scan_enable(struct btdev *btdev);
 
 const uint8_t *btdev_get_adv_addr(struct btdev *btdev, uint8_t handle);
 
+void btdev_get_mtu(struct btdev *btdev, uint16_t *acl, uint16_t *sco,
+								uint16_t *iso);
+
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states);
 
 void btdev_set_al_len(struct btdev *btdev, uint8_t len);
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index ccc57aada..8529caae8 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -308,6 +308,7 @@ static struct hciemu_client *hciemu_client_new(struct hciemu *hciemu,
 {
 	struct hciemu_client *client;
 	int sv[2];
+	uint16_t mtu;
 
 	client = new0(struct hciemu_client, 1);
 	if (!client)
@@ -342,6 +343,9 @@ static struct hciemu_client *hciemu_client_new(struct hciemu *hciemu,
 	client->host_source = create_source_bthost(sv[1], client->host);
 	client->start_source = g_idle_add(start_host, client);
 
+	btdev_get_mtu(client->dev, &mtu, NULL, NULL);
+	bthost_set_acl_mtu(client->host, mtu);
+
 	return client;
 }
 
-- 
2.49.0

