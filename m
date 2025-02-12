Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E087A215050
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379510; cv=none; b=LQNg2Eius287LjBETHmWfyasoVrBgcvb0nAQzqMRc4m2IQRqK3cYRtWXSgD8yaXaelRMNtFPEQZIhfJPPhueIps8ojcavXsGOsJUkAOnb3+lxdKS042VtAPrGXG/0iyzPyvmDO1yOaWZ0JDVkDNj6jYYZP4gnKoB8F2dKiKicCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379510; c=relaxed/simple;
	bh=trzlNZIC66s0ogqXm/b1we3q7IcaO2fsJuGI+XWD4vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqqRJ6Hy0rVJP/Irf6s6YetWDpRZ2GbZ03vcXMeC1ihchbkEijW+XVCcM20EG7SQyJHz/5vuiD9KXpOcSR3ARXfhtlF/ZVI84efI1NkflNbOCFpGYxjYVJfFWCpNXTTdIHFdBbxtDGbB4LOSDEbeyXEm/Gz5WWCUgWdccsjSKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvZNbVX7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvZNbVX7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f6d264221so57888365ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 08:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739379507; x=1739984307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D28Z+CapvE6uAzGgovUjdVqkil2tOLQ0WnNWGRvQ3fQ=;
        b=mvZNbVX73fqcaAKCmf5wSrRhouTJ12v9d5b2r82kV3vcWIfHEJ1qUpptaENNXCoBB/
         M360Bjys/ay8LeatGNJ7IrQK11iy4xSrzMzq2y7gp5lSb8VMUXqYFxrkhJ7EGDx/T0jP
         lH+/dkMtU8F4POHorRfZHtStdhZC+6NPzFL2eKRe90JZYDuuAiL3ZhlthN2P3Lvtozn/
         YJHqmp8QfgZKvdFnlEIWQfDcFWKbcYoMjWduehneq3feJNK7KFAFhAATNWpKE63Rcob4
         EFzfBoKpMmY/rFc4q1NL6H4yVi7+0y9M707Mj44wfudoZ6XZ440gDYcOI6P5uLN9Ny1o
         TVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379507; x=1739984307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D28Z+CapvE6uAzGgovUjdVqkil2tOLQ0WnNWGRvQ3fQ=;
        b=Qz5kcesN4sFORpd1kY4EJBawWSQ9J/DzBJzYj+1RCRH7C/z1wjSsSRG1AKL9/pz51R
         d466t9Nsu+K6tMo1cVnka0gK3BLbxEwjjbpj0EstV8B2350bepwbbmLi1z/Dot78Ys9u
         ZM4l6sjAQeiRpNmP/MNtruse31ZgPsQmyzsJ+4EsUS4SH4dHhdV04SEL6WXJrv/H/h36
         +76YAvTW1WHLsgb5bZcnzGILkb0Gv04gKhyewyQ0T3giL5+LkkWSNGb38wwE8OCIkBve
         OT0J9dd8MLxD1txQ0Yhnuj9maR8472vN2rU0RuuyQud2J4pskrlTxN7GwEkDJyYsDPV2
         Q8PA==
X-Gm-Message-State: AOJu0Yzrt7Yh4SG3MFOcOT9nUaFMrB3nx4fNHSO5vp7PQGlMACnJAq1u
	pE0TcmaIiKHl7ZIwsCqudbVEvLXlrcuDcDGczQu5BWDnLKS8/txgp6Ht1gVD
X-Gm-Gg: ASbGncv1HHGfXw5PZxVPh3vju8sSkTGDBv1Ym0B/YdXbO48zsIfLsnGGGOsBasm+iFt
	8x66CEFj7Plv9n3A396kDTO3trIey9JX09gsCy4RxHaqY9N8/4QK6O2X8Z+O2+iY1joPfjYp7wu
	ipARglqslMcMdQE2QXJJbJZM7G526CMw3mjr6J7nDYWD9uNBpa5FYn2+MfoR1pNO3hsqiIgu1Uy
	iSCTPPPWcorRD3f/82Nq+y7TjLuSQaMuW8VSWwfslSmqjkXIXUtG1KmhwFvTlluUuLnI8X7EG8b
	d2x9NFC6QoyXZx7ff4CzxJfX0SgF
X-Google-Smtp-Source: AGHT+IHLj60pEpGcoLrFJw03X+UJj6bmfx3oeV4MBa8SxKoeYycF7FWWFoRHpSy7MVeQV3DGVCf7zw==
X-Received: by 2002:a17:902:c941:b0:215:9bc2:42ec with SMTP id d9443c01a7336-220bbccccb5mr61494625ad.47.1739379507459;
        Wed, 12 Feb 2025 08:58:27 -0800 (PST)
Received: from vibhavp-an515-58.lan ([2401:4900:1c65:7513:a3e9:d4b3:2e2e:2ffd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f9b80sm1716336a91.38.2025.02.12.08.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:58:26 -0800 (PST)
From: Vibhav Pant <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ 1/1] adapter: Emit PropertiesChanged signal for Connectable as well
Date: Wed, 12 Feb 2025 22:28:20 +0530
Message-ID: <20250212165820.179487-1-vibhavp@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/adapter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 5d4117a49..c899f9d42 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -645,6 +645,9 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 			store_adapter_info(adapter);
 		btd_adv_manager_refresh(adapter->adv_manager);
 	}
+	if (changed_mask & MGMT_SETTING_CONNECTABLE)
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					     ADAPTER_INTERFACE, "Connectable");
 
 	if (changed_mask & MGMT_SETTING_BONDABLE) {
 		g_dbus_emit_property_changed(dbus_conn, adapter->path,
-- 
2.48.1

