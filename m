Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C237C92B
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242080; cv=none; b=oAXsivW7EV7STAVu0bw5QgLyQ6nll2SKkrhCMXIsRfcBs5nRVwHEdeYdKx1l2H2cExo4Vet0KfvWuOj3+aCJQMYMsjz3YBlqPkZfdFZiYMYPBk+AVRedEy2moEuCZ6R87ez1BTPIT5GF0mJD9LsepCqTRPcr1pNYQ54DhXCm7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242080; c=relaxed/simple;
	bh=2F+TH1TM1acXvmLfa2fLN5mrNnqXNYeDm2GaQ5xlfQQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iHiMrWQCxcZAlkyfvVQYlbYpkPwaD1kchiO9/03x5kOMO/bYPj2213giQa8Bs7208PCI2u6f5FqKs8rNBwJyEoeETSblfgYT9X2TNx1WIyEWeqcN9lqtoeqZuDLmR2f2NMECAqRDhIrwJx1JJniP4DNYXhwMJqN+2Qb+oY04bSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L15NdrTX; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L15NdrTX"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bbce8a02b5so97903e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782242078; x=1782846878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDZ2JtdsIg0YMG6AxdlQ7+ijohmZbDaNAfUnxVkAxWk=;
        b=L15NdrTXfTsXJ08nyNFYZQg71ezaOLQi7vXdewH9jOacmgcjhZ+UYbAqKSfRgYMUUC
         AEJej774gB3Cx8EOyPtbt7D/78im6s5ZSZ28Pbs+l1rd1CuF+pzUCO1zjtTPOCEzFgMx
         qxcIPDyka9eTYWWcDUD3zW0vP2PXB4ENGPQHM4UDW/c9/qh6StoF9hnEpRYoxtqY+t4r
         5pybVlaTIQWXOxaVoI75ybkvjg22Cnd3c0DmJPdMbHj2bxKSniOk2DR6+DmiZ2dAVP92
         pgLimvVSEm1ZrR/y7ECvxpfltJ5Ba+fs5dk+HdYZ3niCvdYuqJUIPUFmjHeC0UQWLGD8
         qr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782242078; x=1782846878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDZ2JtdsIg0YMG6AxdlQ7+ijohmZbDaNAfUnxVkAxWk=;
        b=O8uWMy9HNKsrk3gT+JTcB0MZ2Y7GSsRcmUrwOscW/Yvt7N4M+88DSuphjG776qC2oB
         Xw82ViMv8JDB22WMMqbiyE0vN0gWlqoHQlr7NCsEocKpvFMG9ItmXgMoMkb3mxSNOoZh
         ClC2T0u1iHiB6CgC3Zk/0gHrPb9HDisu2qwgfLBRK4kr/54AQvmwbdxLeIUPvPVu9myA
         gZ8HQi/jwnMJs+vKUMdf01+Eb/kxA1f6qG87MgU1zLh5s8Up7n7yQB+cuZMbYLV1QRJK
         nlqwiLvjmTA03N6oMYP4DBxrxTZNL9FYqWiygK15HEkqBuTOfLgT+xnj/Y9APzjfX0q5
         NQlg==
X-Gm-Message-State: AOJu0Ywb38sQpDbKAOLsdynTc6tT19vKDTgm+b+HXGX8mZu/Lt+XRr6c
	rvljv689Nr4l1oqS/SWGU14Dryv5TVCIsrkrPOP3xZFi+BMgvfTgR9cVC6c9hwWzYoxPGw==
X-Gm-Gg: AfdE7clvmgy9RIt3uwMvP8elVNpIA26yOw4ycicummUlFN6Cqt4JeZS7ukQMlofgo03
	Aj+2/BabayVf6KrxLfIjpomKLw1+t940hXBCRb/+NhRCdY/NG1pNED+r4cbU5m5ckloEgFRzjHR
	6UyRP1i/k7byfFcelsxtjCsDQgIjaNKDS06W8qjmTCMJIZ0T7NrJF0deCDgfibikKw3bjaArUeb
	/uae4GNzOnDTzSLQdwDn2pnjM1pl0GbGoC4np4GFcDnbWPAp8ucz1OPn55It5h6YdG/tp+h5Sm4
	hQ6vs8GZ6UqDewLMQnEPA7zaLBgZ7Fjknfl8e+4AfS0GdrR5G2BK2I7T3n2GQWeQfrJDeQYhP5h
	FRjTNoxzsja4Q1VfURRewfP22jEVy6wBsH/KbgFpU+UPQpGjQo/Ld3Uh+i0aX6q/afN1roTIRV2
	HxejYyTnp1Q/FcGJS1mXq/OwDHMi807Uo0+lWY+DxRM/RRIRdl+ioVx7nNeVBvpaS90n03WXdhC
	PgZqtw=
X-Received: by 2002:a05:6122:3c53:b0:5bb:e749:8752 with SMTP id 71dfb90a1353d-5bc3ec49b9bmr167864e0c.3.1782242078517;
        Tue, 23 Jun 2026 12:14:38 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9670c0e9590sm8965546241.3.2026.06.23.12.14.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 12:14:38 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] bass: Fix possible crash on bass_update_bis_sync
Date: Tue, 23 Jun 2026 15:14:30 -0400
Message-ID: <20260623191432.270241-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bass_update_bis_sync does use bass_remove_bis which may end up
removing the current entry causing a crash on entry->next, to avoid
that prefetch the next entry.
---
 profiles/audio/bass.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index a5ef80fbc835..533d45babfeb 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -2014,11 +2014,15 @@ static void bass_update_bis_sync(struct bass_delegator *dg,
 	const struct queue_entry *entry;
 
 	/* Check if existing setups if BIS needs to be added/removed */
-	for (entry = queue_get_entries(dg->setups); entry;
-				entry = entry->next) {
+	for (entry = queue_get_entries(dg->setups); entry;) {
 		struct bass_setup *setup = entry->data;
 		uint8_t state;
 
+		/* Prefetch next entry since the likes of bass_remove_bis can
+		 * end up removing the next entry.
+		 */
+		entry = entry->next;
+
 		state = bt_bap_stream_get_state(setup->stream);
 
 		DBG("stream %p: BIS %d state %s(%u)", setup->stream, setup->bis,
-- 
2.54.0

