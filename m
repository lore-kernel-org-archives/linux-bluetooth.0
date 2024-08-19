Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC21DC496
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097068; cv=none; b=OYsK2d93Lhhg992MVE1xWyzVY1dzv9abp0bcA2mY+kh3rX80maBM1AXIi0KGJ8jXMFmrkj3oo2qBIiMgjMGtpbEbsELrzdcbqLR492R1CVf5o6riz0zmKSSs3S/CHgihloDmdXk2N8vSJIe+gxjyTWg3pdqBo7W6gBLTAXwtqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097068; c=relaxed/simple;
	bh=HnlKHD0HC4cMw07mdog3UQROwEa4DzmXONgtT/JU1KY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LuAy3S4TF5UGWI9BNT1oPg2G/70C3eHvBsjxuh5eDXha3152yHJKkWODIOADq4IcFnkmDjVi0REYgBrKNAYxOzrpP4GtWTIeRaJFUUn7UdLOf/QAO6x3u2WemUCCjn8R390MYUyj44drGm7DL280m0Rzvrs5XyPGw0B93xKTTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bygVdLUo; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bygVdLUo"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4928da539c3so1409578137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724097065; x=1724701865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQL4t95YTldwE0dZdSxtJhqYuIz/dJCVm21ENWvE8Cg=;
        b=bygVdLUoxurwdnh440OY9U//+bKzkc1iNh2OO6TFZvVCTvHRLY6F2cYIzZR280caFd
         MYdQz9RGpVRCc+9mL7Q3o7bYD1DY+ypyFRK7s9zRcl70b+rghGA01Ojyg0myP64iIqiR
         E7Js9zU8dHEXXdfHvkcPe7sTxGQnNijoIVv8udyLefuccAD9tIxD7ZFkrR3Lf2u87o5O
         szfiqnN8oEmof8Zu+sAZVcvoNvDfK17ODubuWHxh8PWDgSuwG/3bQK0Uz6xFu1lTQvtM
         hPkkVvT/e0IPPg6UqhUL0e+CMxDL8QWOKbRS+FJGT9tBZldVav/UPK8r8TuTyTfZuwng
         1Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097065; x=1724701865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQL4t95YTldwE0dZdSxtJhqYuIz/dJCVm21ENWvE8Cg=;
        b=s4x7WSTEnCBAUpw9Z3baywl0DXpt3OMThcnokRIWjmplfryT8hg2JGbGFW3CRq/W4F
         TnYYt4Zk6CLvdeZCHuXDi8+PoqDFOD+8pkptCmEq8ryxfR65n0bbfL3uzMX7JDiL0hzV
         LfZvdg7JT3JOIuCHg4cMpWRwsisjJdYTcHgDiT01H52I49fB2lOcYLVN90jEHrmeDtZX
         +arQgQoOAzvNlMwI7FuQA33jf61ZJd8EiZyiaVO8//CV/W1rjbRljtUrcrA8V8RwMGmF
         9RjdjOOzuAlJrWTSuGAJhVbfL31laoLisBeOZvvWac0XCrzZ+c/YFKSwQqiwrgygOyem
         u8OA==
X-Gm-Message-State: AOJu0YzJdHXPLvatIJajNQumCh8LVvljyhyISqs4NuyTJJnQjM6FPC7R
	13NPhay61vIHBC0vXH6o53EtPxsVQeYQXCg0H60JuAfgBx+CZlSqpmwAag==
X-Google-Smtp-Source: AGHT+IECzGcHK2gC26nm2O4tKuYjQ5Y1Jx3/xTJotXL8THL0RE1o2sWeWw4fhHLtU2kzby6ZkBl96Q==
X-Received: by 2002:a05:6102:508b:b0:493:b113:95b8 with SMTP id ada2fe7eead31-497798c78abmr11078370137.12.1724097064700;
        Mon, 19 Aug 2024 12:51:04 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-842fb70fdebsm1274530241.4.2024.08.19.12.51.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:51:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/4] client/player: Add support for entering metadata via endpoint.presets
Date: Mon, 19 Aug 2024 15:50:59 -0400
Message-ID: <20240819195102.37393-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/player.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/client/player.c b/client/player.c
index f1cd909663eb..a52575479299 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1228,6 +1228,7 @@ static const struct capabilities {
 struct codec_preset {
 	char *name;
 	const struct iovec data;
+	const struct iovec meta;
 	struct bt_bap_qos qos;
 	uint8_t target_latency;
 	uint32_t chan_alloc;
@@ -2069,7 +2070,10 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	}
 
 	/* Copy metadata */
-	cfg->meta = util_iov_dup(ep->meta, 1);
+	if (preset->meta.iov_len)
+		cfg->meta = util_iov_dup(&preset->meta, 1);
+	else
+		cfg->meta = util_iov_dup(ep->meta, 1);
 
 	if (ep->broadcast)
 		qos = &preset->qos.bcast.io_qos;
@@ -4205,7 +4209,8 @@ static void cmd_presets_endpoint(int argc, char *argv[])
 
 		if (argc > 4) {
 			struct codec_preset *alt_preset;
-			struct iovec *iov = (void *)&default_preset->data;
+			struct iovec *caps = (void *)&default_preset->data;
+			struct iovec *meta = (void *)&default_preset->meta;
 
 			/* Check if and alternative preset was given */
 			alt_preset = preset_find_name(preset, argv[4]);
@@ -4218,14 +4223,37 @@ static void cmd_presets_endpoint(int argc, char *argv[])
 				return;
 			}
 
-			iov->iov_base = str2bytearray(argv[4], &iov->iov_len);
-			if (!iov->iov_base) {
-				bt_shell_printf("Invalid configuration %s\n",
-							argv[4]);
-				return bt_shell_noninteractive_quit(
+			/* Check if Codec Configuration was entered */
+			if (strlen(argv[4])) {
+				caps->iov_base = str2bytearray(argv[4],
+							      &caps->iov_len);
+				if (!caps->iov_base) {
+					bt_shell_printf("Invalid configuration "
+								"%s\n",
+								argv[4]);
+					return bt_shell_noninteractive_quit(
 								EXIT_FAILURE);
+				}
 			}
 
+			/* Check if metadata was entered */
+			if (argc > 5) {
+				meta->iov_base = str2bytearray(argv[5],
+								&meta->iov_len);
+				if (!meta->iov_base) {
+					bt_shell_printf("Invalid metadata %s\n",
+							argv[5]);
+					return bt_shell_noninteractive_quit(
+								EXIT_FAILURE);
+				}
+			}
+
+			/* If configuration was left empty then ask the
+			 * parameters.
+			 */
+			if (!caps->iov_base || !caps->iov_len)
+				goto enter_cc;
+
 			bt_shell_prompt_input("QoS", "Enter Target Latency "
 						"(Low, Balance, High):",
 						custom_target_latency,
@@ -4236,6 +4264,7 @@ static void cmd_presets_endpoint(int argc, char *argv[])
 	} else
 		print_presets(preset);
 
+enter_cc:
 	if (default_preset && default_preset->custom) {
 		bt_shell_prompt_input("Codec", "Enter frequency (Khz):",
 					custom_frequency, default_preset);
@@ -4265,7 +4294,8 @@ static const struct bt_shell_menu endpoint_menu = {
 						cmd_config_endpoint,
 						"Configure Endpoint",
 						endpoint_generator },
-	{ "presets",      "<UUID> <codec[:company]> [preset] [config]",
+	{ "presets",      "<UUID> <codec[:company]> [preset] [codec config] "
+						"[metadata]",
 						cmd_presets_endpoint,
 						"List or add presets",
 						uuid_generator },
-- 
2.46.0

