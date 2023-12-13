Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vztZKP92"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29CDAC
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 00:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702457417;
	bh=nJpa2TiPtn+b4EII7Nr4w/r6ldy/NtBawrd32K7u5RQ=;
	h=From:To:Subject:Date:From;
	b=vztZKP929C8f5HGFKGJ13LxOb8SQ/1CR2rPBjQtTWhR1QG6dbgal0h/meDIlJiUIO
	 EhlH9VfukG5AOyMPUSSwbAUTfx9vqUf9Cxdx42bx/qiUMr6laRVv73GdnhICreyzCU
	 C+nf50vF9fKtvLo/BlQgv5KSigBOw1aZSRK7MoZOAx/onqo833hjz/Zxj195jSBHcP
	 sfXT0Py44iqFcjRtf7RZYA0dBHl1Nze2sZ7s+/vFlCl1O7X/jrCtR9K5A7IOM4YpAq
	 5KZ5Dz7fLkgXf1wypfY9AUoGFb6RZsKlNSMll3HvGtEiYNoSMHZOoYTgeu4RYZ3Owk
	 nGkru8GOGPxFg==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7ACD43781482
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 08:50:17 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] hog-lib: Fix HoG discovering characteristics order
Date: Wed, 13 Dec 2023 09:50:11 +0100
Message-Id: <20231213085011.1152912-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

PTS test HOGP/RH/HGRF/BV-01-I fails as inconclusive after waiting for
second report map read request with message 'Please send ReadRequest to
read Report Map characteristic with handle = 0x00E7'.
Handle which has already been read, as it can be seen in btmon traces.

This commit change the recursion order to read instance characteristics
before recurring to next instances.

Closes: https://github.com/bluez/bluez/issues/657
---
 profiles/input/hog-lib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 7ff1ede3d..db62a3c9f 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1780,12 +1780,6 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 
 	queue_foreach(hog->bas, (void *) bt_bas_attach, gatt);
 
-	for (l = hog->instances; l; l = l->next) {
-		struct bt_hog *instance = l->data;
-
-		bt_hog_attach(instance, gatt);
-	}
-
 	if (!hog->uhid_created) {
 		DBG("HoG discovering characteristics");
 		if (hog->attr)
@@ -1798,6 +1792,12 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 					char_discovered_cb, hog);
 	}
 
+	for (l = hog->instances; l; l = l->next) {
+		struct bt_hog *instance = l->data;
+
+		bt_hog_attach(instance, gatt);
+	}
+
 	if (!hog->uhid_created)
 		return true;
 
-- 
2.34.1

