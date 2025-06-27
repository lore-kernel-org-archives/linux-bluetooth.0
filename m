Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0852E7F25
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035917; cv=none; b=etESr8dpWHZCQK/idZaFeFfaEYkhdSF+gATc8TlDsfKhxVK6Ta97oUWv7sIZF0vYlHSF4jBH+NnzGNo9Rn9XzTZq9n7PVwq6iiZ+GCPwHfDDA2qUUcckt4QxqzbNdczSa2g7nmjdMjC9aJbQW16rmo2xBV2jLgIeUIeUOg1/Jzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035917; c=relaxed/simple;
	bh=eplKknFxrbJJQJYyvVEvcXhMNlWpOkONHZKYQyRA/Vw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rvr4P3ta20awY+lfZGiWbgW5Igg7zulMEXZdk09SuOLP1Hid+Hk/IpM+DXWRT/LOEF97iT+Dta5um2kkIOnhhEeukjEk8dXUgsB/uY15lUnAPmGHW7EHTCSkeLAGMfFqpo42adgHEigjhHZndI4GkmU3wPJ76Ioq3iWrDe400Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mBzpEopK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mBzpEopK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035905;
	bh=eplKknFxrbJJQJYyvVEvcXhMNlWpOkONHZKYQyRA/Vw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mBzpEopKeCJMBEwLtrysyQP46s3Pig8n+Twj2PvXEWPwlwMamnFVY+84a8Q4W5n/k
	 Lbr4UNvPT8rQtfS61ijH9ToAQG/FxHWga20ZSGutjERV3zVXN6CRwVbinqicfMIg29
	 8J5ZyYuBtMIttQ5KrL63KOBNP1cK8od9JxWeTOjyFxlNdNbwgLfa1xXPGENgUFG4yJ
	 cn22myYdor+PS4SyUPmkRPRdwinEjhzB1mSIuHOxNFBn8/jRsPCHzA+GNX56T0UxeB
	 7rNvBE2CreUb9EDS2/NPpQarwEtR19gdeSWnJOHE/3yh0XQTOi5JOcIjMcSniLsj2Y
	 JYuiMzDyXykzg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D99BA17E0939
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:44 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 10/27] audio/hfp-hf: Create existing call during SLC phase
Date: Fri, 27 Jun 2025 16:51:19 +0200
Message-ID: <20250627145136.421853-11-frederic.danis@collabora.com>
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
v1->v2:
  - Use first available index of call for new call

 profiles/audio/hfp-hf.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 0fae3cd6f..ad759b8c3 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -565,10 +565,26 @@ static void ciev_call_cb(uint8_t val, void *user_data)
 
 	dev->call = !!val;
 
-	if (dev->call == TRUE)
-		g_slist_foreach(dev->calls, activate_calls, dev);
-	else
+	if (dev->call == TRUE) {
+		if (dev->calls == NULL) {
+			/* Create already active call during SLC */
+			struct call *call;
+			uint8_t idx = next_index(dev);
+
+			call = telephony_new_call(dev->telephony, idx,
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

