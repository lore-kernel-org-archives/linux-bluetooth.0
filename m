Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B84534B3
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920366; cv=none; b=YylNSR42l1490eMQw5AymayAXyUoZ/kil2zMr98etmD1zqNLySPnRs2lVT+8Y2u3X5JgtxdvLLlALis3AJLnLWXYeKUfMtYCcbrJSarcm61J8xyuJJvUyvprMjwIWAyVU5hpUEbgdfliI33fG2QPR/eqm49nBXgbFNVGoS2cYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920366; c=relaxed/simple;
	bh=s0AzpSkm9aroVq4taXN4TFEJabOf9mzigcGU4G60X/g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfQbRw1ZvawQicOoDkyBP7rGsG5nXQUnqn2IFGg7aJoo10MRjUDxwnC5KevaGjAbEdEO+qqIJ670s9kTQ05DX4HfaeBQj/C9QVj7cULphMyA9G3iRHy+S65UR2xUS4dxLos0PPtF0EDovLew7bQLnTKIFWGPT+CU3jjOEGzoIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxfM0inv; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxfM0inv"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-746d77537f8so397328137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920364; x=1785525164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bKZUldDKv+TzgBbtAILMHl5D8Pdp7TEL1kfyLI1s1M8=;
        b=YxfM0invlrcJAf+6QfeLxg2VsYPDckJxfpusq9Tst6HCO+KcVdLi+3HMwYvlGiuN0x
         JGjfI9UEEozY4RdnkSsaRMKNpx4a3wZJkP/mv9wnx2Ay8h6ylj9GFXBOeZODv4/RODIK
         BWCUU0zXbvI0nOXyIjZzOQ62Qj6Wj+yVR9wW34A9YTib2ZU+JxyAGwWz+/IFkungu311
         7ns3T+4FGIKEMA5VawvWekaRQyPdADM3sKzOYXvtxNyE5f8OExCtoQGlMsEgubAhKtC1
         42xJS3cb8yZFeeLDPlGwgfYa5hto4WulVo91pl2ZxEwA15xRa9jTZ6sm1OfrbrHiGFgz
         tQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920364; x=1785525164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bKZUldDKv+TzgBbtAILMHl5D8Pdp7TEL1kfyLI1s1M8=;
        b=Ke2OAL2PFocImHCUh9E97lSKPaG3wPbhXMkMjFDUrSXKthMHFXLj459ESku4eq25FB
         JYK+94CMj5aDrj9ER/ZdlXQgh1W9v4deSCj9pSiLg5dOV7o8mQGMcFJIrFjJybgpOMEa
         CPHuwwZSIJGDtB9QVpss+jWABbCZY3GPFnlKZrlvjDCEEcNF63wFc85yT9Yy6Djw18Vl
         kEbIGs4MguqcR3vXJvdIxsu+2+M3gf1Dgf/DZ8ktUshGv/hhoVEypPs5J1zGzB6K3lIQ
         VShGT3FHCXFd0usG3wmyHzXAk4oqHrsYrbmEmeBV93cttV2G9+8mVb222jllW/CF9u2L
         TABw==
X-Gm-Message-State: AOJu0YyefcNSbrDRe7XUv93xkgTZzpqemdUqABUxpMW3LHjoOSh5cTZL
	z3AIRQw8Jdf3i6Gpyk3zr6E+VLqLVPjwKXurxFt/2rn3qtGHvWYp8uGcfcyYAs8r
X-Gm-Gg: AR+sD13FpvZjwyhrL945GYLw/+fam2/sC34jR41Hl1Dckgj6T7+sxcVWBgFpRZ/93pJ
	C7SFR28h7u2MV62yMiUMLR8hLirRtV7344yPJ/BuLSmWv8Ba/ZYpcBNEluS+qlBytp4r7lxDkGD
	7UVxuHoVCkTyS0R2Nk7aSj+GR3ARaD7qcOcW+4e5CdM6Q1l0szWcr2xePCvjqAe9oO3T9wxicj6
	+bF+J0qOlnCxrjr/ZbQiNf6bSMC/pFLk4NuX9T69Wuz1BMZAAvhjbjPOTX59EycBqXxxvcMo8u7
	7uH3fZMQHYZwfTEvxuqdEzagfZFWy4awHcSGiJk7DZ04dk6N72Ibzfeh3SFIhB69mFko8eoRHLu
	bZhYmXVZkbbt/auZ0QUL7KlE0On4zzpalJo0LER43rU89wt5I2HX7AkytmTDY3O4eiqtUqlRjsu
	GtLALG50RAhxLe14wmobSAFBNa+Dd4AFcvnXnVPq2UrJbQUdhRavLwQmPsJ4yw1FI7HQvfRS2F6
	6jDXYjVoOg=
X-Received: by 2002:a05:6102:80a9:b0:739:15ef:cdfb with SMTP id ada2fe7eead31-74d5d9c013amr4892185137.5.1784920363858;
        Fri, 24 Jul 2026 12:12:43 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 08/12] client/mgmt: Add conn-subrate command
Date: Fri, 24 Jul 2026 15:12:21 -0400
Message-ID: <20260724191225.1815634-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724191225.1815634-1-luiz.dentz@gmail.com>
References: <20260724191225.1815634-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add conn-subrate command to load connection subrate parameters
for a device via MGMT_OP_LOAD_CONN_SUBRATE.

Usage:
  conn-subrate [-t type] <address> <min_interval> <max_interval> \
               <subrate_min> <subrate_max> <max_latency> \
               <cont_num> <supv_timeout>
---
 client/mgmt.c             | 88 +++++++++++++++++++++++++++++++++++++++
 doc/bluetoothctl-mgmt.rst | 21 ++++++++++
 2 files changed, 109 insertions(+)

diff --git a/client/mgmt.c b/client/mgmt.c
index 50558a313866..cd2ef80221ad 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -6038,6 +6038,90 @@ static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 								NULL, NULL);
 }
 
+static void conn_subrate_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0)
+		error("Load Connection Subrate failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+	else
+		print("Connection Subrate loaded successfully");
+
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static const struct option conn_subrate_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "type",	1, 0, 't' },
+	{ 0, 0, 0, 0 }
+};
+
+static void cmd_conn_subrate(int argc, char **argv)
+{
+	struct mgmt_cp_load_conn_subrate *cp;
+	uint8_t type = BDADDR_LE_PUBLIC;
+	int opt;
+	uint16_t index;
+	size_t cp_size;
+
+	while ((opt = getopt_long(argc, argv, "+t:h", conn_subrate_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 't':
+			type = strtol(optarg, NULL, 0);
+			break;
+		case 'h':
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+		default:
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc < 8) {
+		bt_shell_usage();
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	cp_size = sizeof(*cp) + sizeof(struct mgmt_conn_subrate);
+	cp = malloc0(cp_size);
+	if (!cp) {
+		error("Unable to allocate memory");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	cp->param_count = cpu_to_le16(1);
+	str2ba(argv[0], &cp->params[0].addr.bdaddr);
+	cp->params[0].addr.type = type;
+	cp->params[0].min_interval = cpu_to_le16(strtol(argv[1], NULL, 0));
+	cp->params[0].max_interval = cpu_to_le16(strtol(argv[2], NULL, 0));
+	cp->params[0].subrate_min = cpu_to_le16(strtol(argv[3], NULL, 0));
+	cp->params[0].subrate_max = cpu_to_le16(strtol(argv[4], NULL, 0));
+	cp->params[0].max_latency = cpu_to_le16(strtol(argv[5], NULL, 0));
+	cp->params[0].cont_num = cpu_to_le16(strtol(argv[6], NULL, 0));
+	cp->params[0].supv_timeout = cpu_to_le16(strtol(argv[7], NULL, 0));
+
+	if (mgmt_send(mgmt, MGMT_OP_LOAD_CONN_SUBRATE, index, cp_size, cp,
+					conn_subrate_rsp, NULL, NULL) == 0) {
+		error("Unable to send load connection subrate command");
+		free(cp);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	free(cp);
+}
+
 static void cmd_select(int argc, char **argv)
 {
 	mgmt_cancel_all(mgmt);
@@ -6233,6 +6317,10 @@ static const struct bt_shell_menu mgmt_menu = {
 		cmd_get_flags,		"Get device flags"		},
 	{ "set-flags",		"[-f flags] [-t type] <address>",
 		cmd_set_flags,		"Set device flags"		},
+	{ "conn-subrate",	"[-t type] <address> <min_interval> "
+				"<max_interval> <subrate_min> <subrate_max> "
+				"<max_latency> <cont_num> <supv_timeout>",
+		cmd_conn_subrate,	"Load Connection Subrate"	},
 	{ "hci-cmd",		"<opcode> [event] [timeout] [param...]",
 		cmd_hci_cmd,	"Send HCI Command and wait for Event"	},
 	{} },
diff --git a/doc/bluetoothctl-mgmt.rst b/doc/bluetoothctl-mgmt.rst
index 646c2dcb4365..91406041c3cb 100644
--- a/doc/bluetoothctl-mgmt.rst
+++ b/doc/bluetoothctl-mgmt.rst
@@ -1293,6 +1293,27 @@ Set device flags
 :Example Clear all flags for LE public device:
 	| **> set-flags -f 0x00 -t le_public 11:22:33:44:55:66**
 
+conn-subrate
+------------
+
+Load Connection Subrate
+
+:Usage: **> conn-subrate [-t type] <address> <min_interval> <max_interval>
+	<subrate_min> <subrate_max> <max_latency> <cont_num> <supv_timeout>**
+:[-t type]: Address type - 1 for LE Public, 2 for LE Random
+:<address>: Bluetooth address of the device
+:<min_interval>: Minimum connection interval (units of 0.125 ms)
+:<max_interval>: Maximum connection interval (units of 0.125 ms)
+:<subrate_min>: Minimum subrate factor
+:<subrate_max>: Maximum subrate factor
+:<max_latency>: Maximum peripheral latency (subrated connection events)
+:<cont_num>: Continuation number
+:<supv_timeout>: Supervision timeout (units of 10 ms)
+:Example Load subrate for LE public address device:
+	| **> conn-subrate -t 1 00:11:22:33:44:55 8 3200 1 4 0 2 200**
+:Example Load subrate for LE random address device:
+	| **> conn-subrate -t 2 AA:BB:CC:DD:EE:FF 16 1600 2 8 0 4 100**
+
 RESOURCES
 =========
 
-- 
2.54.0

