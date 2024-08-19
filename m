Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1031DC494
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097069; cv=none; b=cRIP0jIk0EfxhhAv1MNSDhpH0AMyyKU8YWv20r2iHeH4SprbpZCF9oSj88GeJbFX37jA7yuFqkIqw8IHBooRI+jeTpELEeRrohdSHQhfryM/Gg1562EhlJYd3QQ3VAuaN3mezpEPQDwHg0gdOVLPnl1rkWfOMXzC0wx6lebrqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097069; c=relaxed/simple;
	bh=nxNYVWXINzhbAn74SGYRcjRaCgYiTeCql+pW8VeaNBc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ocl0zxYr8FhwqmRT986xnDk8yUz/Y3B+DSRX9deskJyyiKPfVfWbwon+TJm6BBKpbiqFqLuEzKzOHOWkaU+WtIAcoFeyk1PEeVu2wc2Dlowrz/5i+KbGAFSA4O+jO83Qv2TiB7UjXJBvI4q8NlKo1AKKmfDeUEKG71yPxXIR940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Df0EBPRS; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df0EBPRS"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84303532b90so1283527241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724097066; x=1724701866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWzVjAyVwLfGV2kU8BKXoXLbxsCiB8cJzAziqxNN2xg=;
        b=Df0EBPRSGwCF21uzZnVcnVDOozC6/W+Zkp0YrfpvUrBVTiRipvVHT0gsVRMC9UnQrp
         U9fiQWR84BTDHiEqwWZLZFal1JE8rqhw3vriZGARCbhdFRVmO4bSOUx1hesOQLBBomHW
         KTeZv19mQXKKDuLqwX8ZAA+hEInYnNJzwa9xkNtk7hXiKryb1qsH74DWERofh7UBmtMk
         UxJwBy4dHhESTmZBZDLwuNx4xaQJ0jYIL1Jus7o33HgrHt8y3V40f/ETdiqD+STV+IC9
         QWh65mgDtpGuYYCQgIZ31kx5wTI5OUjG4fBK+cUUIliYjFFxGShtXtnSO3sqVzL1TT7V
         sAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097066; x=1724701866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWzVjAyVwLfGV2kU8BKXoXLbxsCiB8cJzAziqxNN2xg=;
        b=bvZaxRXXgS92hZBKYxHI0MJ4IO4Y4DRJ+AHzy6ySz8ImWrXtWc5Ynl+huw9bwCuszM
         FILvQJQaboFEL1TkuDFA6FVq2dvjl3j2q6rcUY4vjYGlEGIe+WFqHTCGwecxYjl4bcvP
         saEG1GuC/rIxgFwUcIzI/i+G6QwrZ6MWuf3VLTWg5gjOWBElciVwSU/FrAnk+LAJQEEV
         ozPQzlGV0PHKeU3qqFepicCMyNNHylfzG2jnbPqcPb1gDiw908wNoUZDn/IhEcnXeELT
         YJzgMj3A0/8x28+4TPle23dTyJ/fYf7M9V8SgLFxpbW4DvgkeApKT9c0MzUvLh+b4vmO
         +N2A==
X-Gm-Message-State: AOJu0YytMGazby3UHiQalmtVnIdWXP1t11ovgQj7aSZr2rjEV+r7Z91P
	GkOVJBDyga1xd9NTT9qcCMar6+GthVaib1BO+OzJ50m7mFwk/3VS9xp4Ew==
X-Google-Smtp-Source: AGHT+IELizK7R+1vXCyi0jIghGAsZ92j8G/nVuF53lh0KgLP1Omlf22sEFE/xLv9mIl+CCrcDwYk4g==
X-Received: by 2002:a05:6102:3593:b0:494:829:835b with SMTP id ada2fe7eead31-4977990760amr14370924137.9.1724097065773;
        Mon, 19 Aug 2024 12:51:05 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-842fb70fdebsm1274530241.4.2024.08.19.12.51.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:51:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/4] client/player: Make endpoint.presets accept endpoint object
Date: Mon, 19 Aug 2024 15:51:00 -0400
Message-ID: <20240819195102.37393-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819195102.37393-1-luiz.dentz@gmail.com>
References: <20240819195102.37393-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes endpoint.presets accept local endpoints rather than just
UUIDs:

[bluetooth]# endpoint.presets /local/endpoint/ep0 32_1_1
---
 client/player.c | 65 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/client/player.c b/client/player.c
index a52575479299..cfaf1137c92e 100644
--- a/client/player.c
+++ b/client/player.c
@@ -118,6 +118,7 @@ struct endpoint {
 	struct queue *transports;
 	DBusMessage *msg;
 	struct preset *preset;
+	struct codec_preset *codec_preset;
 	bool broadcast;
 	struct iovec *bcode;
 };
@@ -2101,13 +2102,23 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	return reply;
 }
 
+static struct codec_preset *endpoint_find_codec_preset(struct endpoint *ep,
+							const char *name)
+{
+	if (ep->codec_preset &&
+			(!name || !strcmp(ep->codec_preset->name, name)))
+		return ep->codec_preset;
+
+	return preset_find_name(ep->preset, name);
+}
+
 static void select_properties_response(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 	struct codec_preset *p;
 	DBusMessage *reply;
 
-	p = preset_find_name(ep->preset, input);
+	p = endpoint_find_codec_preset(ep, input);
 	if (p) {
 		reply = endpoint_select_properties_reply(ep, ep->msg, p);
 		goto done;
@@ -2149,7 +2160,7 @@ static DBusMessage *endpoint_select_properties(DBusConnection *conn,
 		return NULL;
 	}
 
-	p = preset_find_name(ep->preset, NULL);
+	p = endpoint_find_codec_preset(ep, NULL);
 	if (!p)
 		return NULL;
 
@@ -4192,28 +4203,42 @@ static void cmd_presets_endpoint(int argc, char *argv[])
 {
 	struct preset *preset;
 	struct codec_preset *default_preset = NULL;
+	struct endpoint *ep = NULL;
 
 	preset = find_presets_name(argv[1], argv[2]);
 	if (!preset) {
-		bt_shell_printf("No preset found\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
-
-	if (argc > 3) {
-		default_preset = codec_preset_add(preset, argv[3]);
-		if (!default_preset) {
-			bt_shell_printf("Preset %s not found\n", argv[3]);
+		ep = endpoint_find(argv[1]);
+		if (!ep) {
+			bt_shell_printf("No preset found\n");
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
-		preset->default_preset = default_preset;
+		preset = ep->preset;
+		argv++;
+		argc--;
+	} else {
+		argv += 2;
+		argc -= 2;
+	}
 
-		if (argc > 4) {
+	if (argc > 1) {
+		default_preset = codec_preset_add(preset, argv[1]);
+		if (!default_preset) {
+			bt_shell_printf("Preset %s not found\n", argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		if (ep)
+			ep->codec_preset = default_preset;
+		else
+			preset->default_preset = default_preset;
+
+		if (argc > 2) {
 			struct codec_preset *alt_preset;
 			struct iovec *caps = (void *)&default_preset->data;
 			struct iovec *meta = (void *)&default_preset->meta;
 
 			/* Check if and alternative preset was given */
-			alt_preset = preset_find_name(preset, argv[4]);
+			alt_preset = preset_find_name(preset, argv[2]);
 			if (alt_preset) {
 				default_preset->alt_preset = alt_preset;
 				bt_shell_prompt_input(default_preset->name,
@@ -4224,21 +4249,21 @@ static void cmd_presets_endpoint(int argc, char *argv[])
 			}
 
 			/* Check if Codec Configuration was entered */
-			if (strlen(argv[4])) {
-				caps->iov_base = str2bytearray(argv[4],
+			if (strlen(argv[2])) {
+				caps->iov_base = str2bytearray(argv[2],
 							      &caps->iov_len);
 				if (!caps->iov_base) {
 					bt_shell_printf("Invalid configuration "
 								"%s\n",
-								argv[4]);
+								argv[2]);
 					return bt_shell_noninteractive_quit(
 								EXIT_FAILURE);
 				}
 			}
 
 			/* Check if metadata was entered */
-			if (argc > 5) {
-				meta->iov_base = str2bytearray(argv[5],
+			if (argc > 3) {
+				meta->iov_base = str2bytearray(argv[3],
 								&meta->iov_len);
 				if (!meta->iov_base) {
 					bt_shell_printf("Invalid metadata %s\n",
@@ -4294,8 +4319,8 @@ static const struct bt_shell_menu endpoint_menu = {
 						cmd_config_endpoint,
 						"Configure Endpoint",
 						endpoint_generator },
-	{ "presets",      "<UUID> <codec[:company]> [preset] [codec config] "
-						"[metadata]",
+	{ "presets",      "<endpoint>/<UUID> [codec[:company]] [preset] "
+						"[codec config] [metadata]",
 						cmd_presets_endpoint,
 						"List or add presets",
 						uuid_generator },
-- 
2.46.0

