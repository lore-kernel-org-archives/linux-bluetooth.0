Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB654963CF
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436151; cv=none; b=OTwVb/L8If0F5ehnhSMebn9PwSdzOeTRn0Fnji417h8Zr/q20kT9enHM60k2P3/MTiJM4f0G8tRPf9QVFyzGYU52ugdtthEsUsuHMn4DYMECigqLG/qDWocb3ES3RrHTD+lRgz2whftSW78ylrOxHWo0n1rgZzn3Fo68PxHWUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436151; c=relaxed/simple;
	bh=j11K4Rd22r1nfh19XFfYsI1FZjF93PMycr8wgEaBgbk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srGvYIC9SKtLd/kFg0nrFgfM3Wz5ziJ1BxgWh/FwCgBv32fU4n/2FYPSgI7JCrIzNr36nysOpLIEzLodpxmJdNb+iVGBtR1ES590moRvJOyLBwHuuzOE3TpM3qZHTi8aJXZOEVa0cGVf6S1fWfeusywwIRFu2dOZSiKErMMQ6Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=acJopzYm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="acJopzYm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788436134;
	bh=j11K4Rd22r1nfh19XFfYsI1FZjF93PMycr8wgEaBgbk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=acJopzYmqYgeSRrntQ2KtyCfzwxZeMM7aa2yAlAXmSwPIPUzXJeST+a6DUxs67YS5
	 HL3XiBNbH4qHCai3iPwquk297GEDGt0rlSd8nttw8gNAazugQBIiR4YwxGvKYN/Yb5
	 ym4lDS+4Fopa5SacJphlmCdC8f6OFjvRapS7XRnWQsff5xbqiC1Vw2a9GsNkRXPyk0
	 RnmhCmsYYu/5dllbRriTuddcEfF6LUiY8KBFEZZOm79rHaWU3xWB4xIVFtAL5bLvJv
	 +zLqvtHaLe/nOSYuP52oRaN4xRBd8CvgqUvJX/7I4cPtoe31qSmBy1kZc+2xFUKKIV
	 ksZ7D5yirzxVA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D46DE17E1164
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 13:48:54 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] profiles/input: disable force-active for Nintendo Switch Pro v1
Date: Thu,  3 Sep 2026 13:48:49 +0200
Message-ID: <20260903114849.777525-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903114849.777525-1-frederic.danis@collabora.com>
References: <20260903114849.777525-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

For Nintendo Switch Pro v1 controllers (VID:PID 057e:2009), set
BT_IO_OPT_FORCE_ACTIVE to BT_POWER_FORCE_ACTIVE_OFF on the HID interrupt
channel during connection setup.

This avoids repeated host-triggered Exit Sniff requests and reduces
Sniff/Exit Sniff churn linked to unexpected disconnects.

Co-developed-by: Zhongjun.Yu@quectel.com
Signed-off-by: Zhongjun.Yu@quectel.com
---
v1->v2: Add missing Co-developed-by tag

 profiles/input/device.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 5b1be2b16..c2abe2451 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1065,6 +1065,9 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 	return FALSE;
 }
 
+#define NINTENDO_VENDOR_ID 0x057e
+#define NINTENDO_PRO_CONTROLLER_PID 0x2009
+
 static int hidp_add_connection(struct input_device *idev)
 {
 	struct hidp_connadd_req *req;
@@ -1101,6 +1104,19 @@ static int hidp_add_connection(struct input_device *idev)
 		goto cleanup;
 	}
 
+	if ((req->vendor == NINTENDO_VENDOR_ID) &&
+		(req->product == NINTENDO_PRO_CONTROLLER_PID)) {
+		if (!bt_io_set(idev->intr_io, &gerr,
+					BT_IO_OPT_FORCE_ACTIVE,
+					BT_POWER_FORCE_ACTIVE_OFF,
+					BT_IO_OPT_INVALID)) {
+			error("btio: %s", gerr->message);
+			g_error_free(gerr);
+			err = -EFAULT;
+			goto cleanup;
+		}
+	}
+
 	/* Encryption is mandatory for keyboards */
 	/* Some platforms may choose to require encryption for all devices */
 	/* Note that this only matters for pre 2.1 devices as otherwise the */
-- 
2.43.0

