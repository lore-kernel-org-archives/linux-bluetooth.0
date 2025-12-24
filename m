Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5335502F
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766587555; cv=none; b=ZYPeAsvpDHQ1tjvLv2wX3IINwMOnHQSfz0s0gSNUlXUiSNmL9xylU/xXsWPQY500PtHKypgHeEiTJQM4lURl8syRyD07oxBqhuwiM/SwxpSBvc47ioLYZaEQDOL1j0ySyMhcb3uEqpcGwGhpBe6xTuBgcbuelorEkoguotz/O0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766587555; c=relaxed/simple;
	bh=HvH8H84GTAJ/8dMNofn1Dtgex9QQ+Z+avVSps60lnB0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7Ml2o3ETWPDhzX5uHd1c/TE4uSQEXKmDJkp3rFcvNplVvzZncoMRsUhdESMGSj1mvXZH0vGxUeMuNvdz3+1k3zgCAzQqEe3+3NU1cQ+gSZ+c8C5a6u+bV4r+XC7BaICnLPrt4aeynnStrbZ+7oy2233jLYhbQ+Dz4zRebXiUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NLapyBHn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NLapyBHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766587551;
	bh=HvH8H84GTAJ/8dMNofn1Dtgex9QQ+Z+avVSps60lnB0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NLapyBHngII6sNiisPer+c7zZvMy347pYo1udMSHQ6AL393+XAxYAQP2easrqnv6j
	 4nf1aVFtcbiQNz1bukDgoVq+ZjFUftyC9e3SFZU4R2ly9qrs0z9Q7DzqJ0rDDF7GFN
	 AN/ExcIlSaoCCIz3/xN/PZc4u0JhL/rvRHlqcSxHTTaWW1au3pQQfzn8LvjXVeqdBt
	 sfOWITwYisDKdmxHnDi9+hb86QkjegAOuiFJt7d46XioYzOFomadeaad7lPFNKd+6w
	 R2/0EbQc9pfnnw5sgCIqC6ZNSt7BDPE5+s30aiR87qjDQxbhz7qXlMSrU9l3WGpFTm
	 3NSIiOhdVgOkg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-0593-56E9-3f4c-22E6.rev.sfr.net [IPv6:2a02:8428:af44:1001:593:56e9:3f4c:22e6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 794BA17E0463
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 15:45:51 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] audio/hfp-hf: Update multiparty status on call creation
Date: Wed, 24 Dec 2025 15:45:45 +0100
Message-ID: <20251224144545.211533-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251224144545.211533-1-frederic.danis@collabora.com>
References: <20251224144545.211533-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 profiles/audio/hfp-hf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index ca40c46d0..c91b16426 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -158,12 +158,15 @@ static void hfp_hf_call_added(uint id, enum hfp_call_status status,
 	struct hfp_device *dev = user_data;
 	struct call *call;
 	const char *number;
+	bool mpty;
 
 	call = telephony_new_call(dev->telephony, id,
 					hfp_call_status_to_call_state(status),
 					NULL);
 	if ((number = hfp_hf_call_get_number(dev->hf, id)) != NULL)
 		call->line_id = g_strdup(number);
+	if (hfp_hf_call_get_multiparty(dev->hf, id, &mpty))
+		call->multiparty = mpty;
 	if (telephony_call_register_interface(call)) {
 		telephony_free_call(call);
 		return;
-- 
2.43.0

