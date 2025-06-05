Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2D27A92F
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147185; cv=none; b=ixlcHIBsJbyQwkJsIgY+08Ij8Vx2a3nAiH4ZARgIHyLw5W56XQhNX3v+biUJU8i+mbFV7+LSiuXK250tr+kxy4STFZEfnKsf8nGhsV7mLqWjdcDEIuMZSf7+8DxaJ/Qi4uSTEvFN+xeFpYgR9AVhGd2IuqXc7BroncVcWa9Uy44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147185; c=relaxed/simple;
	bh=0IvHSsHi3DjQJPzo9HfduelrISAOAg98OPQkjvkh6XQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMRFugVAWC04qvrRcNIMoL4G3Y/DhedOg8OcfQh0vKCpnhrckoe9lNsL0p/0wG/ax/z+VTpVB5Ntv2b8WLwFLhc7L+qer7Le+NSlDo8UZh0aKX5fzUmx7hJ1lqzy5FQXMlZ7BN5LMU6YTr0M4sz/yK9+CFPuLV9BjEGEA58+1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmGff1Ao; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmGff1Ao"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-528ce9730cfso397187e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749147182; x=1749751982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bh+BXn9teY/u/PqYZ8naxpjYF8CEwfqXlnH+SsUluSI=;
        b=NmGff1Aoe8iXV0SmLH8qkAC7rFZTKJqR6n1ooV5HsoHyOlFc8VjPw0hhFqxTWxz0GE
         FDutsL+rMJSjlqR0TldbUqadbzNGQ55Zoy1wplBGCeTzBn9aiPdne0M5r6TNQmfSFaHL
         ZaUxvGY7LHGoVBmcRXi2wtfJjN/YzpVjnXiE2lStLDh7aUPZqhOQ1ArYxz2+5JZ9TbSO
         r0K7brUVznVWjLHRWsIbzN4uAHnnJkH6h15ndvQAMQv9kfgfpnIz6c1p2IDDgGgUFZXt
         5cybvASUDhcLVmtaPKrD85fQPmHVGJtz9iOcB6565Z66iswGidymTxiIPhUxMSMWfoNs
         jJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749147182; x=1749751982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh+BXn9teY/u/PqYZ8naxpjYF8CEwfqXlnH+SsUluSI=;
        b=TnDuaANLm3fGtNdVOW5n/WEU14zbCFHdjRhbdXcJNK8LR1u2bc3NQ5WW9PADErE4jF
         gz7lURrSs77zaYdka5mXTXS1Nmhv070u2d5e89ScMWKz0W0kJ/YyzzklEe4A/fEMHCjq
         mHoC5An5wWFRFj6Y7yzgcyoy3QTFahHTYs/wIjOtXk/AWHfQKs5+RcT9ZAaDAcE9oQXX
         Tk/1s1VU4GAx0vnBKjzaLuW9B+5MeQ5MWDAcZOJ57MlRjFnEm8cJk6quRdbbdUm5cN8f
         FDUD1HY9361iNSRi8GkGR1xA1uchymznnyn8eyVbOI3yVgL/EAWqwzADsoU1pzeUcONt
         3xtw==
X-Gm-Message-State: AOJu0Yy85K6r/P3iH81edgf4pSWNzN7lV1WiMoboMSChfuU16enH1AN4
	wptp1Shb2wFhPI5bNqYObwUA6+yRIJtH0Mbu8aMzrAipxYZgGx2zONeOun2Av/EYoZw=
X-Gm-Gg: ASbGncu+NRr3Cym1ai+otFNFCNmVKoB698EfDWsr7RCzRBckC600h+U7AhR4mmJ+W5z
	8QfAcRdSq4FYwIMWUZxcZBisvIfx6trWQ0XXYJOwvK0E0cDeymLMe0v+P2QWR9DUg2zjsuSjQvp
	dWbMMs0f+Vk6XETondF1WVzDFxKYVpCXG3Cl5S55ixr2DMYOuN0EiEz9zi96EAHXH9ZoNVe/Ukj
	CtQutqOg5QLdLJbEwYtlI7e8jhyXbKidBvZpX4B1m75qbRXQ/iGL9jLM+HiyT2E27R2tS9y8G81
	SBklbH36KItArVCL63K+SfrFoQ06L/yd0Rum6UQAY0arJx64STC5Vw9amAojO4uN/WoVbCfFkz9
	ABvR6J9on1sjzNEsisab1
X-Google-Smtp-Source: AGHT+IGY8BlzKOc7G2pti9vgA9R/epdYpXhnXhfZSCwMax2DIg+iR9fzTm6A5OERAMwaCjvINPyt3w==
X-Received: by 2002:a05:6102:548b:b0:4e5:958d:4962 with SMTP id ada2fe7eead31-4e772882c16mr457692137.2.1749147182073;
        Thu, 05 Jun 2025 11:13:02 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ebd194c7bsm4173241.3.2025.06.05.11.13.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 11:13:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] client: Add assistant.show
Date: Thu,  5 Jun 2025 14:12:56 -0400
Message-ID: <20250605181256.853484-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605181256.853484-1-luiz.dentz@gmail.com>
References: <20250605181256.853484-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds assistant.show command:

assistant.show --help
Assistant information
Usage:
	 show [assistant]
---
 client/assistant.c                | 63 +++++++++++++++++++++++++++++--
 client/bluetoothctl-assistant.rst |  7 ++++
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/client/assistant.c b/client/assistant.c
index ffefa25baf9b..88795cdd3cd3 100644
--- a/client/assistant.c
+++ b/client/assistant.c
@@ -395,15 +395,72 @@ static void cmd_list_assistant(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void print_assistant_properties(GDBusProxy *proxy)
+{
+	bt_shell_printf("Transport %s\n", g_dbus_proxy_get_path(proxy));
+
+	print_property(proxy, "State");
+	print_property(proxy, "Metadata");
+	print_property(proxy, "QoS");
+}
+
+static void print_assistants(void *data, void *user_data)
+{
+	print_assistant_properties(data);
+}
+
+static char *generic_generator(const char *text, int state, GList *source)
+{
+	static int index = 0;
+
+	if (!source)
+		return NULL;
+
+	if (!state)
+		index = 0;
+
+	return g_dbus_proxy_path_lookup(source, &index, text);
+}
+
+static char *assistant_generator(const char *text, int state)
+{
+	return generic_generator(text, state, assistants);
+}
+
+static void cmd_show_assistant(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	/* Show all transports if no argument is given */
+	if (argc != 2) {
+		g_list_foreach(assistants, print_assistants, NULL);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	proxy = g_dbus_proxy_lookup(assistants, NULL, argv[1],
+					MEDIA_ASSISTANT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Assistant %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print_assistant_properties(proxy);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static const struct bt_shell_menu assistant_menu = {
 	.name = "assistant",
 	.desc = "Media Assistant Submenu",
 	.pre_run = assistant_menu_pre_run,
 	.entries = {
-	{ "list",         NULL,    cmd_list_assistant,
-						"List available assistants" },
+	{ "list", NULL, cmd_list_assistant, "List available assistants" },
+	{ "show", "[assistant]", cmd_show_assistant,
+					"Assistant information",
+					assistant_generator },
 	{ "push", "<assistant>", cmd_push_assistant,
-					"Send stream information to peer" },
+					"Send stream information to peer",
+					assistant_generator },
 	{} },
 };
 
diff --git a/client/bluetoothctl-assistant.rst b/client/bluetoothctl-assistant.rst
index 75166a6e7928..33fbcbc764cf 100644
--- a/client/bluetoothctl-assistant.rst
+++ b/client/bluetoothctl-assistant.rst
@@ -28,6 +28,13 @@ List available assistants.
 
 :Usage: **> list**
 
+show
+----
+
+Show assistant information.
+
+:Usage: **> show [assistant]**
+
 push
 ----
 
-- 
2.49.0

