Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E822E8DEE
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035920; cv=none; b=NlFFekrlT3LjmZqy8EGQSXn4NhQ1+EVpA/HRF+S1rNysFomm3BlH6eu6Tp9RTh8Ddtu6DjiNSROMol/cVtwvcVMTDuZEI0Fj2c48Yqbcx70Ftpi1xi5LK35bBHj/IIa+YJ1pA1EZU0IasoX0cxALBrRyOUaru0SBDzVvgW4Fe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035920; c=relaxed/simple;
	bh=BXqJCKS5MbMuJC+mSW5x1u8dGBK89bIzcvezE0WMMUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8Qg7bYNccIwej/Ez4hrScKWXeSQPIdw6Nsd794piH2AK7hqAmq6yu1bzxI5GrKJVw5/tLgfylwAxclpl5yxRAoZWuMvRbY8wKLXm9ezJE8pQrMFFU/Xr44vOaekBtOrNwxsFvD+zDbQGQTJNjS44Mvyx6OgndLBvhChQy3d+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aopgTzon; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aopgTzon"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035908;
	bh=BXqJCKS5MbMuJC+mSW5x1u8dGBK89bIzcvezE0WMMUg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aopgTzonPCcLhOFUOfkh3JtkVyFDoElhro5j3XV9uiP1qukCpmjx4MXpEh/Lx0nOY
	 f2hpXU5WqL0VP96kmLo+Tu3s1qyetng5cgMjruOmODbX9rVliRy01P1VZ38Wfchjxl
	 7JTimduOK83FyrEgxrXw1SZGAJ6Ugi+LFy+1kAzTLEZzHopUH75jXTSM6ebDT2RaBK
	 582p7fXx1EAfkH4g5v2bhm08lDLTklbabu8JMQGN8COkStwB+XbbDW8xMYxX3wsFHg
	 9YoCvJmfj7abLU97ixA/IS46WpfyOWy55Wo72pFMoW8Y+Eaz/qpcYpGH6gAZgx5qx0
	 X7Vz5lfvthzFA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 422B117E0C83
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:48 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 21/27] audio/telephony: Add call line identication property support
Date: Fri, 27 Jun 2025 16:51:30 +0200
Message-ID: <20250627145136.421853-22-frederic.danis@collabora.com>
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
 profiles/audio/telephony.c | 16 ++++++++++++++++
 profiles/audio/telephony.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/profiles/audio/telephony.c b/profiles/audio/telephony.c
index 5e88240e6..a5dace7c3 100644
--- a/profiles/audio/telephony.c
+++ b/profiles/audio/telephony.c
@@ -775,3 +775,19 @@ void telephony_call_set_state(struct call *call, enum call_state state)
 			call->path, TELEPHONY_CALL_INTERFACE,
 			"State");
 }
+
+void telephony_call_set_line_id(struct call *call, const char *line_id)
+{
+	if (call->line_id && g_str_equal(call->line_id, line_id))
+		return;
+
+	DBG("device %s call id %s -> %s", call->path, call->line_id, line_id);
+
+	if (call->line_id)
+		g_free(call->line_id);
+	call->line_id = g_strdup(line_id);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			call->path, TELEPHONY_CALL_INTERFACE,
+			"LineIdentification");
+}
diff --git a/profiles/audio/telephony.h b/profiles/audio/telephony.h
index 3f7580e80..5f2a4ae4c 100644
--- a/profiles/audio/telephony.h
+++ b/profiles/audio/telephony.h
@@ -114,3 +114,4 @@ int telephony_call_register_interface(struct call *call);
 void telephony_call_unregister_interface(struct call *call);
 
 void telephony_call_set_state(struct call *call, enum call_state state);
+void telephony_call_set_line_id(struct call *call, const char *line_id);
-- 
2.43.0

