Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369E2E8E0D
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035920; cv=none; b=c4qD1cX2925kKYZdhb245ugmBbJkRgvFFeYmNj7eQc/0iRB9Phhk5WZFNLRA9n0+llNeDPdFrXGZMMxe1sT6MMx6Cihqrd9ZnYLItSThVTpBy8lsz+qq05lHapGrNoRewoA8hxz4BVnaIFmH5O/FNJ3vHtKf0KALJYw7DKeAqnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035920; c=relaxed/simple;
	bh=QYjsqyxW+d+/TL1kkIr1vG/pv1MF6DrRbo375lHz++I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ku3CdBPUlm3n6taR8x6B+gOlE/t0NH9QEbGE8qd4gKFoAessH+WIUab2iYKme0WtTan3VkIzYVf0g9sA6VRjMKI/85mPrzBju4+hDQyFLVSN+Dgyg049OCxf0eT/AsS1SBYGmCxsyvCwjiwV8Q5Qjc1eo7m3JB20JmMhzl8F09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=drb767NE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="drb767NE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035907;
	bh=QYjsqyxW+d+/TL1kkIr1vG/pv1MF6DrRbo375lHz++I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=drb767NEEI7YHzAMzk+o/jnStpRWL+Cbots9PtNYmcU2sA9D/2W4dB00d92xiNah9
	 bm+jfBZRUgUSJq2r782jqHaqgdaWxoYmlpDDZMiq3s0gEaaf4+kA0aDFs7kOE5+dAm
	 yzcC3u6Yf52AvTaclHQFjHxOhSZ36M6Fv92OfFTh6iZZ0+xLCS5BQnd0BXK6MzM6lN
	 siY89K54ODWq+FxXB34ADTBBXHlLCuQo/jhq7rsS7niM315BcQj/5TlW0Kpx7mu41Y
	 u3IISCdGxkbor9UU2fxd0CZU6IxBwxN+vFJUzGEZA/9q94aIj2ZPegwYQt2plIPYMJ
	 vCOzLeTDywFkw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5AAB717E0B84
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:47 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 18/27] audio/telephony: Remove IncomingLine
Date: Fri, 27 Jun 2025 16:51:27 +0200
Message-ID: <20250627145136.421853-19-frederic.danis@collabora.com>
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

This property has been removed from the documentation.
---
 profiles/audio/telephony.c | 26 --------------------------
 profiles/audio/telephony.h |  1 -
 2 files changed, 27 deletions(-)

diff --git a/profiles/audio/telephony.c b/profiles/audio/telephony.c
index 2a4c19a58..5e88240e6 100644
--- a/profiles/audio/telephony.c
+++ b/profiles/audio/telephony.c
@@ -616,7 +616,6 @@ void telephony_free_call(struct call *call)
 		dbus_message_unref(call->pending_msg);
 
 	g_free(call->name);
-	g_free(call->incoming_line);
 	g_free(call->line_id);
 	g_free(call->path);
 	g_free(call);
@@ -662,29 +661,6 @@ static gboolean call_property_get_line_id(
 	return TRUE;
 }
 
-static gboolean call_incoming_line_exists(const GDBusPropertyTable *property,
-	void *data)
-{
-	struct call *call = data;
-
-	return call->incoming_line != NULL;
-}
-
-static gboolean call_property_get_incoming_line(
-	const GDBusPropertyTable *property,
-	DBusMessageIter *iter, void *data)
-{
-	struct call *call = data;
-
-	if (call->incoming_line == NULL)
-		return FALSE;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
-		&call->incoming_line);
-
-	return TRUE;
-}
-
 static gboolean call_name_exists(const GDBusPropertyTable *property,
 	void *data)
 {
@@ -742,8 +718,6 @@ static const GDBusMethodTable telephony_call_methods[] = {
 static const GDBusPropertyTable telephony_call_properties[] = {
 	{ "LineIdentification", "s", call_property_get_line_id, NULL,
 			call_line_id_exists },
-	{ "IncomingLine", "s", call_property_get_incoming_line, NULL,
-			call_incoming_line_exists },
 	{ "Name", "s", call_property_get_name, NULL, call_name_exists },
 	{ "Multiparty", "b", call_property_get_multiparty },
 	{ "State", "s", call_property_get_state },
diff --git a/profiles/audio/telephony.h b/profiles/audio/telephony.h
index b02111264..3f7580e80 100644
--- a/profiles/audio/telephony.h
+++ b/profiles/audio/telephony.h
@@ -70,7 +70,6 @@ struct call {
 	uint8_t			idx;
 
 	char			*line_id;
-	char			*incoming_line;
 	char			*name;
 	bool			multiparty;
 	enum call_state		state;
-- 
2.43.0

