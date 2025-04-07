Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA538221D88
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056116; cv=none; b=UVPztq9L1M1id0LhDnwzpWXxKHSc0T4DXArs1i0FaVTIAlirb0cpRCQFVdl87StYmgsX51a6RKXqSdcFqE8vj8zzhDwin+WN2f42sRuftOZhdpDhiPPnFZk4bF49sRg7ztHhrnhnFd5AbyrD6i9CwRHpQ0c1US7a02bXtMJWMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056116; c=relaxed/simple;
	bh=RLeTl37TW4N6Zfr0lHg8RGps8YFC3vjs7wWMgOXyoYw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk7nPfSwTHWEuI5aNdvTpDPPGg8gHKL9CAzSCn2cCuiIw3gtm0t+dR3b7xd9CE8rPTVt/dHxNicMXFMtbKLqxAl6S09yap+kLQMLqocy27wpHDUECtcqaGOoaIuNKjNN+snuRkvI5eQWjDtsvfFUgthgkFS3gzxpsggerB90iN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkHAeFq/; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkHAeFq/"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-524125f6cadso4515002e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056112; x=1744660912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zRNsq30CgpjucwwcKkU/6QUB6ZkvtlRSn7jRFOzCxI=;
        b=AkHAeFq/VTQLscI0zcvCxtuGfu7E/pC84NV6GgN6FIXr7vNHCqdD8F1ofFXm2eWP2J
         VweoJuSzQrsLiWNQhsGFJRduu/iWmiFZ5S+eJZ2VjV1wX1NQDXxHXuwAFUoPISpeVO8u
         vaMbzwFGMdyB45bShTswJhrFCHP+kcDV7qM8/Qs+35YrMTDbsLvscyLnILu/q7gWx4Ad
         geOcpRyTe4oP2tPyzEWV0fWk9lKcUDeLoQ2hIKza6XmpbkJVnyselE0AniPWpJLOxNHh
         Cl6b3tKIxTr1rM3sOp4fU+cSk2Zb60lHjp/8s8/fw7wvjzScyvYDoUs36GnJWaNC5v0I
         jZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056112; x=1744660912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zRNsq30CgpjucwwcKkU/6QUB6ZkvtlRSn7jRFOzCxI=;
        b=JhfPFjv6IhNMAAnAGKoJdxxMAkhq6cM4Mzkc4q6H+YIP/kPG8PfpvshHZj282TS4bB
         32DmRldAWDe2tCFUiygTC7c4AclLy7dkQWsr8RKolj6Cje912xAbj5RCVL60+g9v0r1A
         EznRYngBrooicYbbM+QRzXW9/qtwK7Wn6yC6mC1MVhBYF0374Z0M6BYzoMCojlTRF2PV
         qsCYXj69dv3pEFxszQBKAciSiXW+RHDznk6sHT12pXr0PLml21IWH7+TF2S6qc+PG+ew
         Qw5KOrWXC7HuGlKrmeDKWmVg4Lekc/KKVYuCqV6aINd4nmkMymkoJ6ivDoomjuW4ZV3V
         UXEg==
X-Gm-Message-State: AOJu0YzlFH9KoUKhW9zVCnJYCd7+JwOPbdMSPiPA6LsGkxFxo9oBrldn
	zo9e0ph/51QHRC8Ds4diO3iPj4iyCd8ssHpXXIOy8HYqQ7tm9NWPNp3qdUio
X-Gm-Gg: ASbGnctGEFAs0+ZSHpSKcGIhSOVUr3IGNax4aTOuENNzlgvmhvT/avk87RAbN+xiqlN
	xUZlthGSBdko1v6hmBCWPD5fiTqWZJISdAc8NNhd0+t2s4ZTX45Zh+Y5vWhsG+dhCvg2R4EydTE
	2Xc9S0+Lj23VCZuqt/+RbGds4N3oVD/yY0ZQOpHbfEiT3poff+j40tX0A4EuJm/DHGjd4OOiHcg
	tDrISHh9+jBak3cE73h090TGBuDjvsiogOqqhnGM6U9YABc/yPgfg85vW3NDUW1MFrv49OsFOoD
	Inio4u2yce+3IMU+p6C5nuZWuZoslc6htPXyUk6zKPHgpIbUXAF+nCJ0IolAHb78HE/XHLYgA8Q
	xDVXVFnq6rPaRPQ==
X-Google-Smtp-Source: AGHT+IF85pW/TGF3YVHqcnEKOGdNS1AKxEckvTyajAT6GaK5QEMDlf49pi8ubaipPV0t7iHDYWoI8Q==
X-Received: by 2002:a05:6122:2516:b0:520:6773:e5ba with SMTP id 71dfb90a1353d-52765c03cd1mr11542751e0c.2.1744056112355;
        Mon, 07 Apr 2025 13:01:52 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.01.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:01:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 09/15] shared/bap: Fix not notifying idle state
Date: Mon,  7 Apr 2025 16:01:15 -0400
Message-ID: <20250407200124.881534-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407200124.881534-1-luiz.dentz@gmail.com>
References: <20250407200124.881534-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The idle state must be notified like any other state.
---
 src/shared/bap.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index dbeb43fe509d..ec23e882f389 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1138,6 +1138,21 @@ static void stream_notify_release(struct bt_bap_stream *stream)
 					bt_bap_get_att(stream->bap));
 }
 
+static void stream_notify_idle(struct bt_bap_stream *stream)
+{
+	struct bt_bap_endpoint *ep = stream->ep;
+	struct bt_ascs_ase_status status;
+
+	DBG(stream->bap, "stream %p", stream);
+
+	memset(&status, 0, sizeof(status));
+	status.id = ep->id;
+	status.state = BT_ASCS_ASE_STATE_IDLE;
+
+	gatt_db_attribute_notify(ep->attr, (void *)&status, sizeof(status),
+					bt_bap_get_att(stream->bap));
+}
+
 static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
 {
 	if (!bap || !bap->ref_count || !queue_find(sessions, NULL, bap))
@@ -1712,6 +1727,7 @@ static void stream_notify(struct bt_bap_stream *stream, uint8_t state)
 
 	switch (state) {
 	case BT_ASCS_ASE_STATE_IDLE:
+		stream_notify_idle(stream);
 		break;
 	case BT_ASCS_ASE_STATE_CONFIG:
 		stream_notify_config(stream);
-- 
2.49.0

