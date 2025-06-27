Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0B2E972A
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035921; cv=none; b=QYCrgDTLUzLYBnDnbTMabdFgesEQ13O1vL6Gan27HfYt2hwCCYvHZY5Wdz4NId7yuLMOYiTgT7GbWblFy8f8Mv1siIXDIZUOVFhUddpBqlwe+vAJCZt+Tn0ROf7QX2oTs/snVsZ9UWGEmNNxeT0YAG09DZxiwSX9ua7OOKk9P+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035921; c=relaxed/simple;
	bh=CN/r5xU3o99pLkjP5QNHMR1yN5Z79wirbmfYsRpQD+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lb8ZXU3lEUtsVNo4lGYyVAwn7GM7czeV5tNAQ0/UeB1E6R0Ypqz/Lx1qYMlwKjknLnBsB0KlJr1QEZhBcfvN9VOknmeZFeyE9nZDiYUWAbLCXymd1gusQgFhAx/HHNUOF4lliTUOAPrnSKoyEXGbGFNi/LArw7XZP3PcofUJ7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jJ2/v7Cx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jJ2/v7Cx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035909;
	bh=CN/r5xU3o99pLkjP5QNHMR1yN5Z79wirbmfYsRpQD+g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jJ2/v7CxZlh4O1n/yjE7qGN1LJaeIfWe/vrbdFdIUlNkoBK1cWXq6EpsO3eRB4KtO
	 23pKobfixlKi4Ovwo5yj1Cw7CdXt4OHkQtXS8ThQ1jFyNAq9uK9/Nvse5nomPnU2dr
	 ymr+Gz83UaYYSspISCgdsccj+FXpD298iw4c3jKDkO1WZ2AhrNy3D9nbOdEEPa5W1m
	 KYmOenQSzl+yjkC78fHuzoGVnM6wco/eyaSBm8Knkd0BGaSARP2pL+LodpN+1qItZg
	 gzqVYrZvmoW1O5pyPZeUJ5kE9odfJi7Ih55824BzvigHIxjGP//6UrDrbA0xWDWvJz
	 Hjy1aN8kOWZxA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BDA3E17E0CE7
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:49 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 26/27] audio/telephony: Add call multiparty property support
Date: Fri, 27 Jun 2025 16:51:35 +0200
Message-ID: <20250627145136.421853-27-frederic.danis@collabora.com>
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
 profiles/audio/telephony.c | 15 +++++++++++++++
 profiles/audio/telephony.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/profiles/audio/telephony.c b/profiles/audio/telephony.c
index a5dace7c3..9e10a94a4 100644
--- a/profiles/audio/telephony.c
+++ b/profiles/audio/telephony.c
@@ -791,3 +791,18 @@ void telephony_call_set_line_id(struct call *call, const char *line_id)
 			call->path, TELEPHONY_CALL_INTERFACE,
 			"LineIdentification");
 }
+
+void telephony_call_set_multiparty(struct call *call, bool multiparty)
+{
+	if (call->multiparty == multiparty)
+		return;
+
+	DBG("device %s multiparty %u -> %u", call->path, call->multiparty,
+		multiparty);
+
+	call->multiparty = multiparty;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			call->path, TELEPHONY_CALL_INTERFACE,
+			"Multiparty");
+}
diff --git a/profiles/audio/telephony.h b/profiles/audio/telephony.h
index 5f2a4ae4c..9541d3edd 100644
--- a/profiles/audio/telephony.h
+++ b/profiles/audio/telephony.h
@@ -115,3 +115,4 @@ void telephony_call_unregister_interface(struct call *call);
 
 void telephony_call_set_state(struct call *call, enum call_state state);
 void telephony_call_set_line_id(struct call *call, const char *line_id);
+void telephony_call_set_multiparty(struct call *call, bool multiparty);
-- 
2.43.0

