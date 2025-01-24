Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66914AD3D
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737181; cv=none; b=GsVJLSgyj9x8S2GrcMytV1thuSVnbj4erWv4jvsxqMLTIvhU4SFo4yTHtvssvO0w9c+GO1C/wX7Bx8YZieo+hDTISq2VldyV9sm3Eeasg/wGxiX0wPoDtER+urG7opUU3pU6+qX6ucXFEH4xl/joIZGXZCXtfAT6hmcnFvEsnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737181; c=relaxed/simple;
	bh=jiRvnTssMkkUGfeskJiYqzoJKZ8O6iL2CulHuIsZA9Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUhzwERv0WFgSCmLfcDriWZ2Y7jvaTQqcz7tctdx35whlpOvaamSo7zh24c8JN9Zcgrx8kwqp4wVogS0fh5iJkYmv/RdQex748chby9pmp4Pn4rbfQYPYoauJCXbeIJx2XC+WVf7nwWLlL+zQ2HSdF8o1L9ceS27t3vrHwS2PDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=at9H7fv0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="at9H7fv0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737737177;
	bh=jiRvnTssMkkUGfeskJiYqzoJKZ8O6iL2CulHuIsZA9Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=at9H7fv0da7zvplIySV2E09gTneDXLRDhKhNQWvcNgPQCf5B8BW98090pUzGB/ZqM
	 3Sl/31tOt1ljNvo2fe1ACCIWZq55cQjiNGhdETflvgoHE3WsOi1yyo92AH0G3rC015
	 QivDIDHBtSvlY4v2fUM/CCuT6LbK/W3glEtTgJDsPEOyA/jNJe98F2f/d6Egb1JLrV
	 f9BnsEBFSk3GiLCz4xd3hGtnnFuWVsH7hTWF6XO9aGwRZziCbH33dcIYg7zEsqa68Y
	 1ulMKS9vkrlEMJQaRR8jR2EexxsjXbNtZh+PjTGsOKlI3JuO7MIbuCzypyzpy5sL6v
	 qPthAjF7k1Cfw==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5826717E04AC
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 17:46:17 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] mpris-proxy: Fix infinite list items reception
Date: Fri, 24 Jan 2025 17:46:11 +0100
Message-ID: <20250124164611.1175429-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124164611.1175429-1-frederic.danis@collabora.com>
References: <20250124164611.1175429-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Samsung Music app on Android phone send play list items in loop if
highest bit is set to 1, so limit playlist to 0x7FFFFFFF items.
---
 tools/mpris-proxy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 1f6c86777..df67fb089 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -1692,6 +1692,7 @@ static const GDBusPropertyTable tracklist_properties[] = {
 static void list_items_setup(DBusMessageIter *iter, void *user_data)
 {
 	DBusMessageIter dict;
+	uint32_t val = 0;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -1699,6 +1700,12 @@ static void list_items_setup(DBusMessageIter *iter, void *user_data)
 					DBUS_TYPE_VARIANT_AS_STRING
 					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
 					&dict);
+	dict_append_entry(&dict, "Start", DBUS_TYPE_UINT32, &val);
+	/* Samsung Music app on Android phone send play list items in loop if
+	 * highest bit is set to 1, so limit playlist to 0x7FFFFFFF items
+	 */
+	val = 0x7FFFFFFF;
+	dict_append_entry(&dict, "End", DBUS_TYPE_UINT32, &val);
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-- 
2.43.0

