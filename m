Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190F1AED53
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434244; cv=none; b=Hylz8oIcsHcu7z1Tit5qUVMKyyaWSNZ/c7HbjCPCnyRSxiseKdRLXb1up1lNCpNVfxS8VDFazkRBG4pJWoyxAN21LRXL6z451f12nWS4YPuVxzQjVeB42GLV4h40UNCWT2il6l5OBjwG1IoN2u+sEVHhB5KQKXofCk1lzoOlLK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434244; c=relaxed/simple;
	bh=TI+F+qXlPAM/QGcPTDx/AZKdzjIJK9XwpYc/em4RiVk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=M1e2URvn7Y8Ugv1BT+PelqpQheA7thwfA4OQ2J5Ahy8ZEGQImvUZtIWrIBSBh1VjFllxxcj0HX8WAVCsworYhTU34VQASTZdYyEfSqu7ogiQmzvoORKTDgkS3RR+s4A7GLQjbfsEhEZnzqATWM9rczNeuAWKVyuYaqBlfKT//Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQLUCPfv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQLUCPfv"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7ab76558a9so174851066b.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722434240; x=1723039040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GCnNDQkoFp9WDf4NMCU/dI6dSk0E8ysiqRP+ZDf/gd8=;
        b=OQLUCPfvb18psWu15GFzW4GGH2XLmoC4Ve5mLKXc9K8k+Whn4WzHj5fq0uGa2x3VZ4
         G3bjurSspAnpQ5tKcj7nR33Sg46YcOe3JvAoAzQ87kpl5qYeOyMMQsV39bacI3SLXBrg
         SA1QCJwHKB4f2xFXHnY2WFgMiPGWVLx6JTmVz5BiswS/ZIrW0V2T0wphsfYMse4iSQp7
         blKhZEvbi3aMoj7UUiT9WVBSztsxQH194dl3Xu4gPzjucvCg8h2AMKIVESZ5ak1nc/h5
         j/TRgmc2QoWZ/Nq5SoIYzZU95RI3ndkDGlGsrcNdBrAgehcsnkokqra2JrkHV7wB+Qq2
         h5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722434240; x=1723039040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCnNDQkoFp9WDf4NMCU/dI6dSk0E8ysiqRP+ZDf/gd8=;
        b=ZpxoNIVROjHmLRX42d8kYVg08cHc/SlCHmz6myM03AmBudBfjA8d5HWMnvE7BpyGsq
         g1egJmQDh7UueZFk/pl5R4lPyX2o0ltAvt2HmjFwF0cCimqL45C48YuI4UFQ6Qh2GoN8
         /k9LwnQV4PgTU4SHFQRYVkZMsRgIjKD/2AYftWyn8kzbyRvfswBxf/VRJ5zcjrmSZm2m
         NMKqOXVU1Ut440n0Ty1KMrsvTIsQOAsBQ8doToqG6PYdUFZSDVbwFYNpHksuohFF8wSx
         HwBCnKx7/psJG4fnHLAKuM0DFL4TWxVemcCSlGjXgls72ElmlSQ5ixyLJHNnV54UFX99
         fxyw==
X-Gm-Message-State: AOJu0YwSMuGp/UxPkRLCqJQTsMG++iwwNkfSZVDNCZ9huVyYDcB+y69w
	NFPKPC6viyM9WON5JF4KJ2Y19kuFPnFKhBM/Qj725yPvmYPMULu+3zCqaw6T
X-Google-Smtp-Source: AGHT+IG/yNyjFPgJPg87cbAuSzMdubsW2qbSG+YS33vcKrFbOArcgamYNVV/ubw1/OXqlEhi24WKRw==
X-Received: by 2002:a17:907:7244:b0:a7a:afe8:1015 with SMTP id a640c23a62f3a-a7d85aa7ef2mr543603666b.29.1722434240276;
        Wed, 31 Jul 2024 06:57:20 -0700 (PDT)
Received: from lvondent-mobl3.wlan.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad91041sm779143666b.174.2024.07.31.06.57.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:57:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/4] client/player: Fix not setting config target_latency with edpoint.config
Date: Wed, 31 Jul 2024 14:57:15 +0100
Message-ID: <20240731135718.429604-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not setting target_latency with endpoint.config command.
---
 client/player.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/client/player.c b/client/player.c
index 3c3587f2c..93d6b62e2 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1790,9 +1790,9 @@ static void append_ucast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 					DBUS_TYPE_UINT32, &qos->delay);
 
 	if (cfg->target_latency) {
-		bt_shell_printf("TargetLatency 0x%02x\n", qos->target_latency);
+		bt_shell_printf("TargetLatency 0x%02x\n", cfg->target_latency);
 		g_dbus_dict_append_entry(iter, "TargetLatency", DBUS_TYPE_BYTE,
-					&qos->target_latency);
+					&cfg->target_latency);
 	}
 
 	append_io_qos(iter, &qos->io_qos);
@@ -3765,6 +3765,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		/* Copy capabilities */
 		util_iov_append(cfg->caps, preset->data.iov_base,
 				preset->data.iov_len);
+		cfg->target_latency = preset->target_latency;
 
 		/* Set QoS parameters */
 		cfg->qos = preset->qos;
@@ -3960,7 +3961,7 @@ static void custom_target_latency(const char *input, void *user_data)
 	else if (!strcasecmp(input, "Balance"))
 		p->target_latency = 0x02;
 	else if (!strcasecmp(input, "High"))
-		p->target_latency = 0x02;
+		p->target_latency = 0x03;
 	else {
 		char *endptr = NULL;
 
-- 
2.45.0

