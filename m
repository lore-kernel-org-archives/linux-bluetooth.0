Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C55274676
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422791; cv=none; b=mEeoTIGjhBSomaqV2mVetJd+AHuGq8u0VvsuVjSWeYLgk8eSKY+2TkrpYP7Mg89ChnFsEekYiKX9LMxPbI6lfYXcZSn73jed4r2uV4obfcJIiB5+MrJxFXAUI7G300Fm10nVqYj4o3rXg1fgITAbOh1yhOYOXdIAJ7w6LVJ1qZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422791; c=relaxed/simple;
	bh=XBCZKxjxAsw0xOzb4aERz6q1QNQYilkTjUu9py4QHS4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8ZQxA0ACc+cC5pYtCQpbo7xujQU3p7Bq+pNrB11nO/gbTGs0dNwhqE2VwUsnh7XWQ48XcfkMn0+J8bGJjCiTtU0Gjoymdjjm9CvXzTuU3cmrhe1BHwWzggLES2me4DJ2km6J+2jj//0+QxLorEos3wMa9pgV/w71S6yrsWfjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eBWJhAIP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eBWJhAIP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1748422779;
	bh=XBCZKxjxAsw0xOzb4aERz6q1QNQYilkTjUu9py4QHS4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eBWJhAIPa/30sMjj4O14QJhk9W9Jmu1Z66B35fHXYFDGwb0rGjh+NFNThWK2mkFRx
	 QtjqcSqgCKaAjFPJzeyF8xOb30C6qu3jALjuZFbaLbSnBndlfSLj/hzBBdFV0ePX0G
	 +dDDWcCIWDPj/xPnzhyLxw33Wo8l2pcAGfer8HKq1pQfNREp03NbUwDEXgnYfJt5E1
	 Sce75MRUvv1qOxj3gJSxEnshRbwpiTz1800j3jiV9/g8CLtE1osdKeoaQraG3Kjlnb
	 7kACE79iyEbL5y06TWnMa5HBZvTuGQVDZVe87bP4/J3Dc0RYS+PTep/ayEYAWuz3y7
	 3geCWyeQTWaqQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-AF44-1001-C79a-7427-1C18-f6a9.rev.sfr.net [IPv6:2a02:8428:af44:1001:c79a:7427:1c18:f6a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A05E417E37CD
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 10:59:39 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 10/10] audio/hfp-hf: Create existing call during SLC phase
Date: Wed, 28 May 2025 10:59:30 +0200
Message-ID: <20250528085930.227816-11-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528085930.227816-1-frederic.danis@collabora.com>
References: <20250528085930.227816-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 profiles/audio/hfp-hf.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index f05e5d38f..5f8fde1cd 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -538,10 +538,25 @@ static void ciev_call_cb(uint8_t val, void *user_data)
 
 	dev->call = !!val;
 
-	if (dev->call == TRUE)
-		g_slist_foreach(dev->calls, activate_calls, dev);
-	else
+	if (dev->call == TRUE) {
+		if (dev->calls == NULL) {
+			/* Create already active call during SLC */
+			struct call *call;
+
+			call = telephony_new_call(dev->telephony,
+							CALL_STATE_ACTIVE,
+							NULL);
+			if (telephony_call_register_interface(call)) {
+				telephony_free_call(call);
+				return;
+			}
+			dev->calls = g_slist_append(dev->calls, call);
+		} else {
+			g_slist_foreach(dev->calls, activate_calls, dev);
+		}
+	} else {
 		g_slist_foreach(dev->calls, deactivate_active_calls, dev);
+	}
 }
 
 static void callsetup_deactivate(gpointer data, gpointer user_data)
-- 
2.43.0

