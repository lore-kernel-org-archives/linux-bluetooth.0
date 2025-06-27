Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B32E92DD
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035922; cv=none; b=FZaH2zaShGabbANXjEVJuahwQLmZ6i6/PezVkfCt6CCeI3Wr3j7ApFcF4+qBCJZM+BLVW4PW6pWBWKC7YdGJz3XVNsna1+aI6Si+m/zTDLlxVj6IQzHfdq9f72Px2A95y9331AuCed8FZO1gsHLrjPW8rl+rLsTzWtFcO7RKwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035922; c=relaxed/simple;
	bh=OVHhikPU6HIv1oDTRwFAfS0eqmNcKu2P/tWSmfCLn9k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4SxGDrtXRVoY4q4B+7P4Jqkds0iOiH1tGrFQEHY+zUELSeHeaqS5ZRCYNoXdR6YTTKUPjP85IsR3xZwIZpthYNYBs3FXlFyPd7XEFLyEIbIRrgtplKuL1uog+3o7lKzPAq0j5UpRzCzdWQb1zXKUUTiv0/0ykkm8Ovb/W0fTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NlvloKbk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NlvloKbk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035909;
	bh=OVHhikPU6HIv1oDTRwFAfS0eqmNcKu2P/tWSmfCLn9k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NlvloKbkPZhl0FroNAoPq8lG8hSTo8Z8ncEIJEXoVWikxwBxhthy0Groftf3Cz5bn
	 BE4X8kIQ6jg8xA7rxA0l9jC6L+lNGSgb6C2594q4oYjmR6FG+32SJ8b+TgoPYkIuPf
	 Y3GoUlNWQE09dDrFnldRitCJrhYXEiaB7b4J1uwSHo9u0sGrLhLQmO9ek6GM2NBYfo
	 4NgKPtgNZyNW4SE0fUiLgANrwkOxIJc/unySf7WxLtxUwf5G59eyNXF/Ijhmoxxc0G
	 55Fe1N3cs98vj7xhXYMp85zcDWp27AFWgT4RGyz2WAsmUQom2gc8txK54qZNgwm4Hh
	 o7CXkS0L9kJhA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7209517E0CE6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:49 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 25/27] audio/hfp-hf: Enable extended error if supported by remote AG
Date: Fri, 27 Jun 2025 16:51:34 +0200
Message-ID: <20250627145136.421853-26-frederic.danis@collabora.com>
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
 profiles/audio/hfp-hf.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index afe06296d..5542bce96 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -450,6 +450,25 @@ static void cops_cb(struct hfp_context *context, void *user_data)
 	telephony_set_operator_name(dev->telephony, name);
 }
 
+static void ccwa_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	DBG("");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: CCWA error: %d", result);
+		return;
+	}
+
+	if (dev->features & HFP_AG_FEAT_EXTENDED_RES_CODE) {
+		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev,
+								"AT+CMEE=1"))
+			info("hf-client: Could not send AT+CMEE=1");
+	}
+}
+
 static void nrec_resp(enum hfp_result result, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -463,9 +482,12 @@ static void nrec_resp(enum hfp_result result, enum hfp_error cme_err,
 	}
 
 	if ((dev->chld_features & CHLD_3WAY_FEATURES) == CHLD_3WAY_FEATURES) {
-		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev,
-								"AT+CCWA=1"))
+		if (!hfp_hf_send_command(dev->hf, ccwa_resp, dev, "AT+CCWA=1"))
 			info("hf-client: Could not send AT+CCWA=1");
+	} else if (dev->features & HFP_AG_FEAT_EXTENDED_RES_CODE) {
+		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev,
+								"AT+CMEE=1"))
+			info("hf-client: Could not send AT+CMEE=1");
 	}
 }
 
@@ -487,12 +509,12 @@ static void clip_resp(enum hfp_result result, enum hfp_error cme_err,
 			info("hf-client: Could not send AT+NREC=0");
 	} else if ((dev->chld_features & CHLD_3WAY_FEATURES) ==
 			CHLD_3WAY_FEATURES) {
-		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev,
-								"AT+CCWA=1"))
+		if (!hfp_hf_send_command(dev->hf, ccwa_resp, dev, "AT+CCWA=1"))
 			info("hf-client: Could not send AT+CCWA=1");
-	}
-}
-
+	} else if (dev->features & HFP_AG_FEAT_EXTENDED_RES_CODE) {
+		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, dev,
+								"AT+CMEE=1"))
+			info("hf-client: Could not send AT+CMEE=1");
 static void cops_status_resp(enum hfp_result result, enum hfp_error cme_err,
 							void *user_data)
 {
-- 
2.43.0

