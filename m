Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0FC2E8DF0
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035918; cv=none; b=XgK39f0Y6ZYlooakZmjeaXu9MXEnEcdyorysDzfZDZsMy0Pi+70e+v3LuI7pAXIbYGA94mNilZPEO7IQJaXUWJRfdFZtX8tDpkaK9BPg0qmIHlgnd2SHqN2LnHvE1UaJFbg53ghvHZ0Vvc0/XuNm89Sg+/72XWooSzuHQwSHgcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035918; c=relaxed/simple;
	bh=082khrpgekUBRa0tCxQHn9DEZbmu4Oe025Kg8HiZs0c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouk9L7ZA40vlU3+jQU288qkPv7XmaJEcFDdRKq1GQPyiVPu8GhRaYjprzTXFi4THjLrsrOqVeFRF3F3dkv1br+9UUMyVZOzuPGOA7W1zjiMit22zIGlXs8jb1mfWOXoyWeEkcIyZdAb10cfyWX1nfIMwKnceRMvsdDlrRaqs7b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ITDk88WQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ITDk88WQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035904;
	bh=082khrpgekUBRa0tCxQHn9DEZbmu4Oe025Kg8HiZs0c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ITDk88WQe0PRi8PRwFPLFzy0FbaMSfn7q345G38/jFL/wr2jaNNyfAmsf9fU1tvmj
	 tNdnOZQvj7KF1EhQN2XSYRKEfvn2x8wJ89C1bZ49QdtirIiuA+oS+yHeuxliqRklz2
	 x6G4qj7ysEJqPWMX2MUjIPoL+ivYVY2YVP4GIyDpD6VMqYT8l7Xi2vAeELZM7mz7Ov
	 oPzt8T6fZyMR6rOzaC96Yq0SuuQYJaxDG6gf3fGUewB8Qx0/YwC/OcEDFpk0JArPHp
	 /gaQCztQpDSbMmhmEkKpdRwlGnngooQMRf122yZgedBWFNbdQdmiPdpEQ4dKhRt/Wq
	 2jZ+6ClOK0u8w==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 901DC17E0930
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:44 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 09/27] audio/hfp-hf: Remove call interface during profile disconnection
Date: Fri, 27 Jun 2025 16:51:18 +0200
Message-ID: <20250627145136.421853-10-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627145136.421853-1-frederic.danis@collabora.com>
References: <20250627145136.421853-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 profiles/audio/hfp-hf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index e7bfe4f59..0fae3cd6f 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -1224,6 +1224,15 @@ static int hfp_connect(struct btd_service *service)
 	return telephony_register_interface(dev->telephony);
 }
 
+static void remove_calls(gpointer data, gpointer user_data)
+{
+	struct call *call = data;
+	struct hfp_device *dev = user_data;
+
+	dev->calls = g_slist_remove(dev->calls, call);
+	telephony_call_unregister_interface(call);
+}
+
 static int hfp_disconnect(struct btd_service *service)
 {
 	struct hfp_device *dev;
@@ -1232,6 +1241,8 @@ static int hfp_disconnect(struct btd_service *service)
 
 	dev = btd_service_get_user_data(service);
 
+	g_slist_foreach(dev->calls, remove_calls, dev);
+
 	if (dev->hf)
 		hfp_hf_disconnect(dev->hf);
 
-- 
2.43.0

