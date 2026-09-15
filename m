Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21464B1276
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506951; cv=none; b=DiU8zursTKn+QgRKd+vyW3d1L6irk1jVmroikreEIFWLJZ4p2Gk175ozGsqOL6tPe58vaDCDJESbYVWtsygto+5gPjQ4j3G4UnoCllOAd8/GXuQi89LZ0l/Bl0/D0lgh5xgkDeqjAky2JYj52vsu2rpIktXSgq18z8TcLr/dge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506951; c=relaxed/simple;
	bh=8CZ4MwC4DoowuYARcDpi9Ch1/KOXvXe220mL5ViuxcU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsK/EuijHNq2rZ81RRtkXNYrOQhu7xHs0Tg+MCJkT6nN6Zy/fdqtZml3XuEDmNK8a8YstYN4GNteb/QaeGvtk8I6WWXL3AhBKLdQQhOaOPiQ7GVPtOZzlioLLZnqczzyXirGEKwnhc+zpsmNBXHz5JMz0tmCpbkoB8s7LSEhKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHfueDVA; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHfueDVA"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78a6c77d255so62249137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506948; x=1790111748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eJOMFGraK4vGToxt+AQS7vWPiIsy91K9taoUUfOPmy0=;
        b=GHfueDVA5rJUCREfrGFwp7SN/gjcz1qsHjbPYDz0zej+FClUtakxekPHUysz+Q/eXz
         qTdYWazpUB50KbNcyH0JqyEhDnENb14z96IpIbq96ZRxkHR8Ot+P4TXLTBXv4jdxFitb
         WbqIBXRX6ZIpuUEB3C5ggjogRzrZJm72M8LejD8w8v6bVgNMx41LFXDYAO/TovutWiNI
         alv7s/9a5pat6JqUDCDV2/P2YVXR7OmStPYSehzHCYvG+wuvpTHTcXcwKGmIjT+zl0vh
         ofr+zAdIh/U4cIvysnEilBue+PPE0Yu1xHPAB/aEw0LwfylYj7eepD/2EwzQfgBqjAA+
         GTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506948; x=1790111748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eJOMFGraK4vGToxt+AQS7vWPiIsy91K9taoUUfOPmy0=;
        b=PRxaOi3/5xjY+CMg35yqnERbTzkGugvLktEqUMioH/4W8CAij0gZ4zc2P62rJo1+jL
         WYTorWOmjVwQ/mn/4ojAeSJg2FJXD2NpIKdM8PKCYGjD35BZht4/8tTrgjytvO1k0mqP
         aK+ICQ/6joyHdmSyT7WfydwFnfCUaIxjykLWyrR3dXaHkQCEG+kjvJaw9QiksDCiHR1+
         kDogc2sn+nW0r6UQm+My8E/o8lvpRSdPVCL8TMVwapA79K4QjUv2/73UcWY0ywmoZClC
         PRrdfs6fneO8Rp1UhDF60vwc1kW2ByNW+aaTXK4Hj6fRu/q6MvKCHmm6o95Y+ewNevfB
         3ZjQ==
X-Gm-Message-State: AFuF++n8skb2SpfnwV4Nuifc84OjdySNJVxoDRDBWzs/xN+zEnVveX78
	ErVALyiH+7/utpWpBwDlLgdF7HfByZCwtW5LMucAr8RJ3Cj1jp/zcdddHow0ZGF9
X-Gm-Gg: AYBFou1cYgMXNcb/r62K/lzxdkcP5p9h942CjP4MlY2VwgIZFBRXppTDUcLuvMxrNhm
	U29dVR2A6QVeuctjwmM5D2gPNjRR8rmGD2r+W+lLQykvpUPBvrfTTrfeSZH8Rx5oALGHiEmDn1E
	/PY2PXZx51s5mpsHGFUaNxOl6SkS6152mGhe2x7rjiAXPjoGMEfCVzjCsFrjfy5EN14s0ldi5cT
	qmFApQ/x/e7mdt4rBmocvd8i0+WpL/lvJTKTnm4pqXsiw/RtPJOcjn79+ATmswgrVYf3UgX04DJ
	tcitGy+a/B8ec/lph07VdYuFsPp2L25sFwfh3SyvtdTv9/TUoSwVxuABvlwBWRdzgm0niJ8d/8d
	JK14EbOZQ283F/P6sjQrVcUtTPZc4LciWToTJ0MF/gwX3LRBKM/TBpkErV5HK03r7dJniTK+BPS
	kwow/hgglmtc7uRcAV+CLKolDi7YA3360pin58YeoHDXppiyTZRwXKc25uqMLOpXWLc5NgbRNRg
	EGonmgdBE6PtwsaPpU6VROEv0+V9qdVXrRwat8mmuHC9ZU+3XUkyElyBrZijTE2Qg==
X-Received: by 2002:a05:6102:358d:b0:79c:6276:4cdb with SMTP id ada2fe7eead31-7a0257aea0amr158871137.4.1789506948420;
        Tue, 15 Sep 2026 14:15:48 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm746860241.1.2026.09.15.14.15.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:15:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 09/11] client: allow a capability with the auto agent
Date: Tue, 15 Sep 2026 17:15:26 -0400
Message-ID: <20260915211528.1223784-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915211528.1223784-1-luiz.dentz@gmail.com>
References: <20260915211528.1223784-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The auto agent registers with no capability, which is KeyboardDisplay,
so a peer pairing with it may well choose the entry of a passkey. That
is a method the auto agent cannot answer: it only replies by itself to
the confirmation and the authorization requests, and the passkey entry
is left to the user, who is not there to answer it in a test.

The pairing then only completes once the request times out, 30 seconds
later, and it completes as a failure.

Accept a capability after the name, e.g. auto:NoInputNoOutput, to let
the capability be the one pairing Just Works, which requires no answer
at all. Plain auto keeps registering as before.

Assisted-by: opencode:claude-opus-5
---
 client/agent.c       | 14 ++++++++++++--
 client/main.c        | 14 +++++++++++---
 doc/bluetoothctl.rst |  6 +++++-
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index ff5e57ff27a5..a678d5f785a9 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -403,11 +403,21 @@ void agent_register(DBusConnection *conn, GDBusProxy *manager,
 
 	agent_capability = capability;
 
-	if (!strcasecmp(agent_capability, "auto")) {
+	if (!strncasecmp(agent_capability, "auto", 4) &&
+			(!agent_capability[4] || agent_capability[4] == ':')) {
 		bt_shell_printf("Warning: setting auto response is not secure, "
 				"it bypass user confirmation/authorization, it "
 				"shall only be used for test automation.\n");
-		agent_capability = "";
+		/* The capability to register with can be given after a
+		 * colon, e.g. auto:NoInputNoOutput, so the pairing does
+		 * not choose a method the auto response cannot answer,
+		 * like the entry of a passkey.
+		 */
+		if (agent_capability[4])
+			agent_capability += 5;
+		else
+			agent_capability = "";
+
 		methods = auto_methods;
 	}
 
diff --git a/client/main.c b/client/main.c
index d8d2e32d9556..4d13fa1b1e1a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1416,9 +1416,17 @@ static void cmd_agent(int argc, char *argv[])
 	dbus_bool_t enable;
 	const char *capability;
 
-	if (!parse_argument(argc, argv, agent_arguments, "capability",
-						&enable, &capability))
+	/* The capability of the auto response is given after a colon,
+	 * e.g. auto:NoInputNoOutput, so it cannot be looked up in the
+	 * list of arguments.
+	 */
+	if (argc > 1 && !strncasecmp(argv[1], "auto:", 5)) {
+		enable = TRUE;
+		capability = argv[1];
+	} else if (!parse_argument(argc, argv, agent_arguments, "capability",
+						&enable, &capability)) {
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
 
 	if (enable == TRUE) {
 		g_free(auto_register_agent);
@@ -4034,7 +4042,7 @@ static const struct bt_shell_menu main_menu = {
 							NULL },
 	{ "discoverable-timeout", "[value]", cmd_discoverable_timeout,
 					"Set discoverable timeout", NULL },
-	{ "agent",        "<on/off/auto/capability>", cmd_agent,
+	{ "agent",        "<on/off/auto[:capability]/capability>", cmd_agent,
 				"Enable/disable agent with given capability",
 							capability_generator},
 	{ "default-agent",NULL,       cmd_default_agent,
diff --git a/doc/bluetoothctl.rst b/doc/bluetoothctl.rst
index ed4cd0703281..cc58e1f5be19 100644
--- a/doc/bluetoothctl.rst
+++ b/doc/bluetoothctl.rst
@@ -301,11 +301,15 @@ for pairing and allows you to choose the IO capabilities of the controller.
 The valid agent capabilities are: DisplayOnly, DisplayYesNo, KeyboardDisplay,
 KeyboardOnly, NoInputNoOutput.
 
-:Usage: **> agent <on/off/auto/capability>**
+:Usage: **> agent <on/off/auto[:capability]/capability>**
 :Uses: **org.bluez.AgentManager(5)** method **RegisterAgent**
 :<on/off/auto/capability>: Agent mode - "on", "off", "auto", or capability type (DisplayOnly, DisplayYesNo, KeyboardDisplay, KeyboardOnly, NoInputNoOutput) (required)
 :Example Enable agent with default capability:
 	| **> agent on**
+:Example Enable agent answering automatically, only for test automation:
+	| **> agent auto**
+:Example Enable agent answering automatically with the given capability:
+	| **> agent auto:NoInputNoOutput**
 :Example Disable agent:
 	| **> agent off**
 :Example Enable agent that can only display pairing codes:
-- 
2.55.0

