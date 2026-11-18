Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029086;
	b=w7qdIzFFiUQ9nAFDDwd9k5Emk0I/8sMG1bgsNAoj5BpBaqJ9GN/nEP9xD52NkNkyaWIt
	 vNgI7c5xG6TjYYWf9mDJtOMsuidEH3Q3aplK2qHC6bHyFlPGj9DvBe8mn/d7ZltvSazxI
	 r3jv+Uj2jMx615IoDLMeVsZ2SohQHyb/pZv2jY5rJxjb8Tc6uIdyopEdsNBECJHGSkkOL
	 QvMUPhLXBSit9gO5sJ8dGMqJdw3m8sKqtrQTm6K/weuCEMjJtfa0svqtHfP67zAXQM034
	 4ktYQSh1doAhVfWoiVfVnpfReVCGvjqAPSbn0orF6NiZitIhh6Vfnxsh04VrxmVu+kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HrU8Bh5T1SPlOOXv7Kk39fzwLPRearCIicsjvDtC2VE=;
	b=YEAsF8WITE6MrHy7vW9/jRv4tGAQ+kOVIrvc2N8BlyZr1Bfn3W5R2Ex+c9wxjX2bTug+
	 i/sEYoMBedxwPQm/57zKiSvunkzHzbC3up8P0C/QjWyJg3PDglVYLiCEUidfRRM2wxqeD
	 4G0YSJbBCXapbRHLivvpArJELQNtTgMoVgNvYR745X5TmjrhAhnKQJXp4JZ5xlefH3HvD
	 UuMoJc0xviYaEPADRUWEx0sCLEs5lo3KN+H6UdJH2N8N/IYvbgBuTcYCYh475X5y9rSeH
	 PiUXHP5BEyfiTu1A70F5nsoeHxJAZBX91g6Ne794ksESyDeRMrOMJpVV4+gG2zCvgyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J8kDKCg2;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC2606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89CC2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J8kDKCg2
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ebf39def3aso501579e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029085; x=1795633885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HrU8Bh5T1SPlOOXv7Kk39fzwLPRearCIicsjvDtC2VE=;
        b=J8kDKCg2nb+Nm4jR6/dG9K5rZp9QE0WBMAL3RQpWzsGdLuC+X81UpQMFKpQODJMOjw
         Rwcs0IVSNkOsCUDS6R1i8uV3UfC7hAN+NBYZh3x9etWxI0a6lA4KiriRHnxt6tq48OCC
         g9dbx2lF0oTN49bV6X//zNq+g9sxF+uAZQlDFfqQOETu+K2aF4+tvIZ2rC+OqLtJTCry
         CSPFvFtsnjTfgTiEY+UAADyy47c2X9C7e0yZ817a8lmNcMWDqfJHK7cJLgcBoofraRbm
         DFFnX7ItOAPbu/Uujn+TSYqTdY0qiWNXzRe09Pp90yj/rp/cDTA0cEhjqWxG4hQWpPua
         VUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029085; x=1795633885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HrU8Bh5T1SPlOOXv7Kk39fzwLPRearCIicsjvDtC2VE=;
        b=Hs+r08NGmkzkeopOwcvGfZcHn2rlYh2l3AI6B/1+NeWapqZXySjcYTzHtzUZK6OzDp
         6orzXJp2zt62o0PvGJvvW8f+plMDMi1ojm27LF+BVwpEaGSq29eEv1SoRmbJuLmj12bN
         ydFZQdrr45nBwlNXCPaGvtitSYpqRCBs5bvtC3ZHyjzqqecaYnwQ910s0AoRODgDxBB9
         DJsfkYp2dmuAAM4p3hJmGsIx8gtfg1pwkDWiLb4Dhe/hKzJHnNh+N62AIt0KoA92sEut
         IbmP4FVSfN2tNy29O3i07xZxXcMbONn95OW5GeNgUzpvCcSIGn3LU1M2vYyIbL9DRd26
         C4AA==
X-Gm-Message-State: APuU4Z/p4kk3uxKjRmUVhb7tjBU7FlUEmrnpStTUTe/NHBcVhzIRMGMP
	Ob7o9aEQ2tdgUGDVkYdUeKkEdtA4CBfdXmNKta6zUw1MTy2YFV5FOLqFchXeL3TX
X-Gm-Gg: AYBFou2R1H4qWQGV0flOjmQQyY9hew8bFmglj/s9OamoVVyH2P6aSxxA04aHogZI8QJ
	mA////OXigcXZy5jTeJ8mTwBQlyhe0rnAngAaarqTUHNnQwrRzAVnktlP+mraSv9RBFLEBlqveH
	cSW5k3S18H6NPgUecKB083oTvyQM+K5ahcedzlB99ZK+zEsevRorirlWutjOMEt/rykvQqoNWyU
	A5XkZmbScqqaAd5JSBthDzFjvODClF/+xgeDx2w0BWNCatdvOncpMJhuMtZI4H3W+1S9mps8tR4
	g5YKeHi0J/TAVR/blu6VEzWeTRbLhF5gvTwMRfhnsopzFt7IL140KyzThTJMj4pnGVedH1VpIsB
	HdMowRssuLg3r/TRqZtWIZosDcGzezxfhhh/sWpI6bRizzBm5w8EYMiPd7GE+DmYET/bhxnECtW
	49dwIUUMyhxYHpHQ3uVsOd7liL0BLh/xRQ8tQYrdGx8pzaTkP2rExYOLqaDDtZQNeqkXARX7XSf
	tGf6A/exVNXtgr7lwj/KwYLGrkzwtsYegJd7Vc6Fd6ey5p9CrjLCcAjiBkq0xaNHiJEy6KQqoFK
	lxr/wr4VGTRVjFuZ29J9ndwdi3znTBqZX5h8dgqfaPLmwhGlKmDPI5QOxDDlChgh+69LiyNJQCQ
	xeTzlqIpcCl2TrvPur5HsYx5aWVZe8x01aytaz61Uydesba1ZUZOLbeoP7RRbBebmvY9yos/yL3
	gsyHA=
X-Received: by 2002:a05:6122:328e:b0:5ea:d14a:ef8f with SMTP id 71dfb90a1353d-5ee646af6a4mr1701056e0c.4.1795029085418;
        Wed, 18 Nov 2026 11:11:25 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:25 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 04/17] Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()
Date: Wed, 18 Nov 2026 14:11:05 -0500
Message-ID: <20261118191118.318779-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The advertising instance returned by hci_find_adv_instance() was
dereferenced without hdev->lock and could be freed concurrently.

Reported-by: sashiko.dev (linux-616b1f8e-06ec-4634-a907-5eb4e82f66df)
Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9cbf2e3009ac..a1f272c14a1e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2207,9 +2207,13 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 	if (hdev->adv_instance_timeout)
 		return -EBUSY;
 
+	hci_dev_lock(hdev);
+
 	adv = hci_find_adv_instance(hdev, instance);
-	if (!adv)
+	if (!adv) {
+		hci_dev_unlock(hdev);
 		return -ENOENT;
+	}
 
 	/* A zero timeout means unlimited advertising. As long as there is
 	 * only one instance, duration should be ignored. We still set a timeout
@@ -2239,6 +2243,8 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 					       secs_to_jiffies(timeout));
 	}
 
+	hci_dev_unlock(hdev);
+
 	/* If we're just re-scheduling the same instance again then do not
 	 * execute any HCI commands. This happens when a single instance is
 	 * being advertised.
-- 
2.56.0

