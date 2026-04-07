Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FE2DF717
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596360; cv=none; b=bcB8/iI157YNFReclSHTmtJ09DCQoOf5i37QZqLBf+eqqgv9EoMz/Jye9Gy8lBZ/OP1HgrzAXafr9ByKfIzAWfHxqczocD7rWcqlZ/10rCcp/K2FZinmen08RWUBO09J2rwzVCOuQxGW8eRy2JGQrfR8NgLX/vA2CLZqHoK25rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596360; c=relaxed/simple;
	bh=Q/lbMJbIfDIHBN0SwYv4M8gZabvPhTiWw2jycJVIk2M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcRhyNLmIjofNSlX4riprWK1vjRmHRNrV1aK3OwfkzCNcCS/+FmIqjGPpKtCnoZiVzEGtoKBl/VPOnDUomJUCMw2WQD1oWRklA9fkwbOYpUKkxAT/mfBCj8vL2AmKcG34WB4wmN+Gzp7ydxyw1Tbmk97FFHnEiPSSzndabdSvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXWYxq9a; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXWYxq9a"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56a8e0ea02aso5826673e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775596358; x=1776201158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHFD7yyMSxNqk5qK72Jor8qKKJUVi3zD6MCKs9130t4=;
        b=gXWYxq9adSBe0JwNkwNFUaAAWKF0Dgwm40E2VE5rHbjR2iEiYs7hmzLhB2hWLWri1F
         XOYAT7ytPtikVAJv307C8DbCz9y/aO/fs+S954EyWQWGPKn/ilN6hrrdMqz9YdVFpCkc
         opji2moGaEkK2pWY+ugQYddXC3rFiu5N0/9hX4yt+pq+z0fY8W30wA8S8qefuObcjVQe
         NPrDcT78gHdQyL/JCwgkT7bEQs812snV5AGwvWZVVX/uaRYMMA5DgwQecfuMwQsUtEnf
         RHeGVCiseYVxUqOWqSAI4AU2RJNi7pjgLW/cZU9K7o3fr6aT9J5VZCuSVXGFO1QEuxal
         NqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596358; x=1776201158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VHFD7yyMSxNqk5qK72Jor8qKKJUVi3zD6MCKs9130t4=;
        b=PEGDk8gD/KG8qfJJrFmrhyei2TYMIrAwktM6TB2sq1FexMpbxD3aCePrBGCIbrE8pz
         Qj92+/N8ayFZVb4jS+tQJ/EfGj9y7rVMca6TbNqaP2iEqsNPQXPhA492krsbWaHr8PlA
         F3j4RaAwuOLpXdRguCG4bd9qmfKkfTseorz0/5NWCfqbC7H2CDTjHtWinNaVWcJOo+a5
         L9KXBDn3nQVv9PV0JSz3v+lRRh6e4WrccaXv0EQCZPRauixFOLetJVcnIVEZGFirTEG0
         K3SztZ4EPr3Pmwir5yE8Bc28WSrmiRivRywRFMBqZ04GPzf64FR3Ae2zWlNF6ScOidSW
         pt7A==
X-Gm-Message-State: AOJu0Yz0QNTXo9emhWL7+Z+Wy2gEdp266pD5j1bQ88GfjmgyAU4KZjZV
	TzHjqXZdILizP9O8n2r9GeMLyvkydVlUIbUIwjALqoLcoAOo/HED3C/ifoeuST0e
X-Gm-Gg: AeBDietF0GGggZMSamoX+Lmk2B94biLEsZCHovUBMFcMRhETml8BlamBVIFwehFUgIP
	5qUp/ZFJ4CDAU9EsXsIf8wMDCPzOxexUFIlBc+Y8GED+pZsyMOz4Hk/F3Wh9XGUEh6JDlR/7B2s
	GKBdj6d5naC7qczjN4/bO66xdGOgwCXUTss4sbgTsXSUeOy0NqQmzHPXjNn//s9HSVS43Q0Dvf7
	QKThKFnH6/5IZ/03T2L64EGrHh2G3WbZt/c0RH2h8MX3LKq3IILCYgSbPyTHJuVYDUmOm+2ZMqQ
	q+mr5PWdW8ldNXfmnL7Fx+OGar5etYfwx+dxSXYt4FrzIjJ4VtBPvnfcI7Q7KOX0NAoAAgq72qD
	6jmP7jam7BiRLG/FCBb1AN2ah9LGq4X6Fxht+YxlDe8yMNfPeiO0XO5E/NatUCanPz40WTt4lkn
	HX2VTuy7HRcioJUBGcNj7yxceYl1zNphq19rl5RwrIG2ttmPitsEfG0hzjTIAtzyYoaYeWEg220
	3h5CN9ijANiF7go8w==
X-Received: by 2002:a05:6122:7c8:b0:56a:ef51:4cae with SMTP id 71dfb90a1353d-56dab88672fmr6869513e0c.4.1775596357783;
        Tue, 07 Apr 2026 14:12:37 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9ba80290sm19418731e0c.3.2026.04.07.14.12.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:12:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] client: Prompt user to start scanning on connect command
Date: Tue,  7 Apr 2026 17:12:29 -0400
Message-ID: <20260407211229.61232-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407211229.61232-1-luiz.dentz@gmail.com>
References: <20260407211229.61232-1-luiz.dentz@gmail.com>
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

