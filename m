Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0CC3D903F
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672558; cv=none; b=kBhC9Ek6s0QW+f7l7HIT7rJ+YvscnArBZKeVoHp8mSLTYAIQL3B2FfdhXTVPBSwVsgTJ1Ghk0f9PsahfJEXiTj1g8nGpL9iKZJQ9dCX5GNXi8QxcZH0hkJ0MESNZGNfK/zlETOgO313NrJyRb0esVKMcBfVm7RjRAjGCwFEkVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672558; c=relaxed/simple;
	bh=Q/lbMJbIfDIHBN0SwYv4M8gZabvPhTiWw2jycJVIk2M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWaK72o1BCcyjyHAOg+uGDWb68+bXj2DkGOK9/lsgs/zaa6WgJT4h9lSI/1G3hflmf5z6ZZzvR7sjxBhY5EmUXttWuraNzDVRxk/9WyQ3ipL6ZAFLe5Ctp2i9yvHN7YHl/x0FbRQOM8te8bofMj1ZcH6REFA76AvHtHBOaRV3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbQ20M+e; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbQ20M+e"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56e91f17a99so6381e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775672556; x=1776277356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHFD7yyMSxNqk5qK72Jor8qKKJUVi3zD6MCKs9130t4=;
        b=ZbQ20M+e5Z6Ym/7scV9+e8SSgGDpF5CONCvYV9r/qSr/I8YbMuk0f08z9bKbz7T4TT
         lcbEC1FchJ/E2oLCzR7lwqjhmGh60fFLP3B+SlEwKxL8d6vXEWgqFo75Bse9bKo9/f0M
         PrHn1NzW1+WEv+BzsqQrGkVWaNlChQWZzWpUMrcjLX49v2HsG2KcUol/Rm5w1kNQCQZW
         3jQViuJme9p/206K1KVmfSDVnHR9006AHDpcB9Q77iwHxx5czdbKJrhhkkGAodjYLsuU
         t2KS1ZkECNqh+ppNY/GafMU7aesitJy+0ldwk22WiFGuiaIiT8K9ZtOd/SjLXwnkCCuS
         Lemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775672556; x=1776277356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VHFD7yyMSxNqk5qK72Jor8qKKJUVi3zD6MCKs9130t4=;
        b=jAJsPSOGgEvjYyy7DBhgcdOroemabmbi6p1v+w0RjRWQLGslVJb40KLmtc4m/3xy0b
         iZ40UsIBKhiN67gBSEHnKQF0507myf+/Dz2LwOmJFqpf0G6jBe2zxgnU4f+goG48U/CP
         uG5Z7B7HThBzq7rQWp3X1LW6TglBMtGdWWAvkcdZHPx1QBJ5cR2iJG8cvx+t9dfhANcU
         yJuTQOZHXgP9m0960Q1So+MBRlitYmyHQcs/jjg5loL2WCyI9vSWl/AS3TGwMxf7PgZM
         VdBvPNC0Pkra0o/CFOBKLpJNtPl561qkDsJE0fiylUKM2LWFlaLXG+/Od5d0/NlFTaK+
         dSyw==
X-Gm-Message-State: AOJu0Yzv4Vbb+RYke4NAovlOP9/XM5mlYYcsFft5HNfxcUusPKQ5Jaut
	owkRtpc9/hCmJ16UtiXMpk21EXqqYXrfzr0i0+c3W9Be+SXrleIjEtmxk7R4tc9qrUs=
X-Gm-Gg: AeBDieucb1mIucdknlnKDm/nWXVZQRFXCF4EP+MdC8UTWfk4PHjHk18vvM6zXNohYYC
	LoHMCStza2RF0jVMQNy+/blSNj5IenSm+skRB6rT5sVlRb3SavbAEkFluzK1dF0hAj9Ru6lfDJp
	gSSNYFSLIfMVzh5sEpigF1CzKb8R/sTJX0KO2V0AzXkbxaMoGRP9VNs3QIZBuymEKDuEwGXv9oT
	zJKJN/c7HC0FjxfeE5MBp5fLRh/maM/COsKT7lMO15niGyu0X03iL4tv6rxhjHXgEKYdZePOeCa
	7FtIKW4KUZ+xhyP9/Dd0AxMGluPcstT8lGfKPACYRFzDWIpXLghGPmf0HILMd0+sgzgrgWeNN1o
	NtWTALqfI4mosqHVtim3Zxa2u2hhehxRe399g7OC/2xBzix3Ag5RvOvarQ1mwbiSDXPAoslHi38
	i6R02+O2gJIMbaYyoXaKfcmFb15Xyiv8AljFhkT/vek8Wsdlz0Zc8C/PEQInpH/ewv5hQ+miF2R
	EIBq077tQ4Sz73F3Q==
X-Received: by 2002:a05:6122:659a:b0:56a:f34d:f225 with SMTP id 71dfb90a1353d-56f2755e374mr697280e0c.11.1775672554874;
        Wed, 08 Apr 2026 11:22:34 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bce02f3sm20486962e0c.14.2026.04.08.11.22.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:22:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] client: Prompt user to start scanning on connect command
Date: Wed,  8 Apr 2026 14:22:22 -0400
Message-ID: <20260408182223.295711-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408182223.295711-1-luiz.dentz@gmail.com>
References: <20260408182223.295711-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If connect command don't find the device object make it prompt the
user to start scanning and set discovery filter pattern to given
address and mark it to auto-connect:

[bluetoothctl]> connect XX:XX:XX:XX:XX:XX
Device XX:XX:XX:XX:XX:XX not available
[XX:XX:XX:XX:XX:XX] Scan and connect (yes,no): y
SetDiscoveryFilter success
Discovery started
[NEW] Device XX:XX:XX:XX:XX:XX
[NEW] BREDR /org/bluez/hci0/dev_XX:XX:XX:XX:XX:XX
[CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
[CHG] BREDR XX:XX:XX:XX:XX:XX Connected: yes
---
 client/main.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index cb016a579f31..c04998bb0a9a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2210,6 +2210,37 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void prompt_scan_connect(const char *input, void *user_data)
+{
+	char *address = user_data;
+
+	if (!strcmp(input, "yes") || !strcmp(input, "y")) {
+		dbus_bool_t enable = TRUE;
+
+		free(filter.pattern);
+		filter.pattern = address;
+		filter.auto_connect = true;
+
+		filter.set = false;
+		set_discovery_filter(false);
+
+		if (!g_dbus_proxy_method_call(default_ctrl->proxy,
+						"StartDiscovery",
+						NULL, start_discovery_reply,
+						GUINT_TO_POINTER(enable),
+						NULL)) {
+			bt_shell_printf("Failed to start discovery\n");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		return;
+	}
+
+	free(address);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
 static void cmd_connect(int argc, char *argv[])
 {
 	struct connection_data *data;
@@ -2223,7 +2254,9 @@ static void cmd_connect(int argc, char *argv[])
 	proxy = find_proxy_by_address(default_ctrl->devices, argv[1]);
 	if (!proxy) {
 		bt_shell_printf("Device %s not available\n", argv[1]);
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		bt_shell_prompt_input(argv[1], "Scan and connect (yes,no):",
+				      prompt_scan_connect, strdup(argv[1]));
+		return;
 	}
 
 	data = new0(struct connection_data, 1);
-- 
2.53.0

