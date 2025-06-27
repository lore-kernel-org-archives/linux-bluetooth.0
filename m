Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D92E8DF1
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035917; cv=none; b=HPnj/b42v9gjxJUMJy7lvXkktFk3ZTK405/gUGdCq10SDWmcGn7PKxvz0iDPaAQYUghWY+Rq4dRtHtmdgBhnhp7+nsJ6FnJ9ZoDCpX5KG+/IR0J2ydsbBfuDSRzbI/Dgoe0fLv5dDYXy7uotvL2vLed4xHcdfRh6v4M55+lLMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035917; c=relaxed/simple;
	bh=4kBTWzo22hqxlY9xYLDXFde6cmZ+3G8sNlZRuyYdCd8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQoKZ1AvB55WiptYNvl5XFwsuR1QcjVlZDJsBGP9spqIbl0aWMDzvRLpMNGmDnZNNUzvFi2vgyhXio+oqUJ/csIxTLg8G7ck0wmgs3dOObAhItNQLczJN+/3NMpPLTDU45MIa7rxW+nXprgAh4RKgFR9MzQT5Q47AdLk5OnJYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=obIRKYA0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="obIRKYA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035905;
	bh=4kBTWzo22hqxlY9xYLDXFde6cmZ+3G8sNlZRuyYdCd8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=obIRKYA0Qr2bLnEXsNfIZtUbYcQxW6Dd2E+JTYUQLLeTEjVTRzCiC+FuMF78iYbWe
	 OHj0Johk7h7FqA1IKFGGTEDRG/Hr6UDPnXNS3ncYvaYqpYLFLoi7e2zydxdaXC5LP2
	 7/BuoajSuAfXMSFz5UmMBK+iMAtFtrV5rvzTkZmBTQzs7w9jSML3ez6027lPOybN4j
	 X1MJrjLbD6/KneRmPhROu7FdD/+8KNVpP/usp38ZYqnwptzl4UfgN/gyipwx9/AIut
	 eWanYVHt/kMbmSD7/XQJ4dmZcknAIgiKaZgD5Qr/6sNjC+u+Zg30PkmxvgMlV66gZc
	 1y6T+iK/qZ07Q==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2FB2817E0985
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:45 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 11/27] audio/telephony: Add hangup_active and hangup_held functions
Date: Fri, 27 Jun 2025 16:51:20 +0200
Message-ID: <20250627145136.421853-12-frederic.danis@collabora.com>
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

From: Frédéric Danis <frederic.danis.oss@gmail.com>

---
 profiles/audio/telephony.c | 26 ++++++++++++++++++++++++++
 profiles/audio/telephony.h |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/profiles/audio/telephony.c b/profiles/audio/telephony.c
index 83a7ff40c..2a4c19a58 100644
--- a/profiles/audio/telephony.c
+++ b/profiles/audio/telephony.c
@@ -204,6 +204,30 @@ static DBusMessage *hangup_all(DBusConnection *conn, DBusMessage *msg,
 	return btd_error_not_supported(msg);
 }
 
+static DBusMessage *hangup_active(DBusConnection *conn, DBusMessage *msg,
+	void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	if (telephony->cbs && telephony->cbs->hangup_active)
+		return telephony->cbs->hangup_active(conn, msg,
+					telephony->profile_data);
+
+	return btd_error_not_supported(msg);
+}
+
+static DBusMessage *hangup_held(DBusConnection *conn, DBusMessage *msg,
+	void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	if (telephony->cbs && telephony->cbs->hangup_held)
+		return telephony->cbs->hangup_held(conn, msg,
+					telephony->profile_data);
+
+	return btd_error_not_supported(msg);
+}
+
 static DBusMessage *create_multiparty(DBusConnection *conn, DBusMessage *msg,
 	void *user_data)
 {
@@ -340,6 +364,8 @@ static const GDBusMethodTable telephony_methods[] = {
 	{ GDBUS_ASYNC_METHOD("HoldAndAnswer", NULL, NULL,
 						hold_and_answer) },
 	{ GDBUS_ASYNC_METHOD("HangupAll", NULL, NULL, hangup_all) },
+	{ GDBUS_ASYNC_METHOD("HangupActive", NULL, NULL, hangup_active) },
+	{ GDBUS_ASYNC_METHOD("HangupHeld", NULL, NULL, hangup_held) },
 	{ GDBUS_ASYNC_METHOD("CreateMultiparty", NULL,
 						GDBUS_ARGS({ "calls", "ao" }),
 						create_multiparty) },
diff --git a/profiles/audio/telephony.h b/profiles/audio/telephony.h
index aaf41888d..b02111264 100644
--- a/profiles/audio/telephony.h
+++ b/profiles/audio/telephony.h
@@ -43,6 +43,10 @@ struct telephony_callbacks {
 					void *profile_data);
 	DBusMessage *(*hangup_all)(DBusConnection *conn, DBusMessage *msg,
 					void *profile_data);
+	DBusMessage *(*hangup_active)(DBusConnection *conn, DBusMessage *msg,
+					void *profile_data);
+	DBusMessage *(*hangup_held)(DBusConnection *conn, DBusMessage *msg,
+					void *profile_data);
 	DBusMessage *(*create_multiparty)(DBusConnection *conn,
 					DBusMessage *msg,
 					void *profile_data);
-- 
2.43.0

