Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCBF18BB93
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466862; cv=none; b=OM+tihyzKMSMoDbLCs8CJuDCHc+t0XtvZC+xgkqFwkrcN8GMWWfMXm7o5bMZiNjfh8T6BMksrmOpjuBDBxGL86Pe3caTC8yEJg2qDx9v8zGw+ZrAwN2OfjmRCo+tVar+xVEcKKsw4WFYwIRn8WB+cTe6V797T4Nnvc5Ag/ne+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466862; c=relaxed/simple;
	bh=QFfhlV5biqJYH43AS90witv/+Zbp6xAvB9kOeNNE5JI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EijMrPHAOgMKDLbwZqsaEA2WfOiyR7jP5MATaEdFM7K1qJls0n8PEGWtUVCCZ5s+v5yn/AnnPfD0UUAGCdVxmLDMOURBZHEhEccQlubaNNcZvVETn0h+c3UKukL7PfJQk+L5pCZBEtzJt8cLe6Rw3zONVi+WcKoL1LhVmZJziQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFcgCUdL; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFcgCUdL"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84ea28dbb01so555971241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 12:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727466859; x=1728071659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSOeItf6IZm728Ue+h5emPy+JTTaeU8B/LrHEVPO0i8=;
        b=GFcgCUdL9aF2RtjK7MHAxMAp7iyTpxJ6Cj+DPAAsp2jJkZHJsb15Q24F4HLrWbf6aj
         4kKo9P46BrBHM13x8ujjpEm5YXaYCoD2zvzOq1xngnzGZQXI4BwRY/6jUJfTMKPit6S4
         TbnT8osLPyd0hBZ7QvkZ9gF6dgiYKlXb5Bm2azPOltaZRVHylac8k0hKKG9l6qqtXtnl
         3C4Yd3dxUMxqTg6n1VNhr/vv17dklt8dLdQdmYD6U/mK1UWr4j5VYUTu+PerHkCMcAuS
         8Tvo+ZePbm2NfcL1z+jdTrMy2o39DgwVzMeLJWQnYQKsuviHK5RDKwLSZBRsWcblIy9s
         2pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727466859; x=1728071659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSOeItf6IZm728Ue+h5emPy+JTTaeU8B/LrHEVPO0i8=;
        b=CtXQEkDoWpBAA58D25nSwvQrk1dHjTMPda6W6pylg0H53hQPyOmyLrBm1FmdIlU5X9
         EXPUWlq1ORYNX89W+OrapUbHVyXuLTYkPrbHkB/GxS/seWe6ZWFHuYzfd90y4q2I9P2H
         F+rWip422JsEUNkDX1ogMLGOF3zlKyBwXqfvSsdbmLIiREjjAhUjCSB3xPLwaUZrXWJD
         q6ExsMFFxIu6u5vJ7nT/uf+1MdzvW8Yf1GrRCHLJHq2n5PLujP2EBXG42ZvjL2qCRTBS
         2t6p8VHd0R+iBE6ui5HRm+QAMeliSak8gD2O0Ib33Szxvsm2lmxS3nSVJbzwAhgHwq5O
         paMQ==
X-Gm-Message-State: AOJu0YyR9QvbXdGg6e3lMEaKzclX3VjAuc69yiL20jrpjOlzkxsNOr0q
	71RmNjWAxAq4F7SGMgYq/h8myvRK5xm+UuHJJbAsxHa9CD4HKc7VzkZL3w==
X-Google-Smtp-Source: AGHT+IE+pjp209utaTF3+glu7HXcyZc8qVgt5Qn4rdMfV32pcP84ihSsHs6alEPAURjG9mXyFls+uQ==
X-Received: by 2002:a05:6102:304f:b0:49b:c414:8a98 with SMTP id ada2fe7eead31-4a2e1171000mr4007038137.29.1727466859542;
        Fri, 27 Sep 2024 12:54:19 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a2bba3b41esm450476137.22.2024.09.27.12.54.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 12:54:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] client/player: Make endpoint.show print all endpoint with no argument
Date: Fri, 27 Sep 2024 15:54:15 -0400
Message-ID: <20240927195416.2527923-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes endpoint.show arguments optional and in case none is given
print all (local and remote) endpoints:

[bluetooth]# endpoint.show
Endpoint /local/endpoint/a2dp_src/sbc
	UUID 0000110a-0000-1000-8000-00805f9b34fb
	Codec 0x00 (0)
	Media Codec: SBC
	Channel Modes: Mono DualChannel Stereo JointStereo
	Frequencies: 16Khz 32Khz 44.1Khz 48Khz
	Subbands: 4 8
	Blocks: 4 8 12 16
	Bitpool Range: 2-64
Endpoint /local/endpoint/a2dp_snk/sbc
	UUID 0000110b-0000-1000-8000-00805f9b34fb
	Codec 0x00 (0)
	Media Codec: SBC
	Channel Modes: Mono DualChannel Stereo JointStereo
	Frequencies: 16Khz 32Khz 44.1Khz 48Khz
	Subbands: 4 8
	Blocks: 4 8 12 16
	Bitpool Range: 2-64
---
 client/player.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/client/player.c b/client/player.c
index 31d6f95c292b..39c14a9434cb 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2828,10 +2828,42 @@ static void print_local_endpoint(struct endpoint *ep)
 				ep->context);
 }
 
+static void print_endpoint_properties(GDBusProxy *proxy)
+{
+	bt_shell_printf("Endpoint %s\n", g_dbus_proxy_get_path(proxy));
+
+	print_property(proxy, "UUID");
+	print_property(proxy, "Codec");
+	print_capabilities(proxy);
+	print_property(proxy, "Device");
+	print_property(proxy, "DelayReporting");
+	print_property(proxy, "Locations");
+	print_property(proxy, "SupportedContext");
+	print_property(proxy, "Context");
+	print_property(proxy, "QoS");
+}
+
+static void print_endpoints(void *data, void *user_data)
+{
+	print_endpoint_properties(data);
+}
+
+static void print_local_endpoints(void *data, void *user_data)
+{
+	print_local_endpoint(data);
+}
+
 static void cmd_show_endpoint(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
+	/* Show all endpoints if no argument is given */
+	if (argc != 2) {
+		g_list_foreach(endpoints, print_endpoints, NULL);
+		g_list_foreach(local_endpoints, print_local_endpoints, NULL);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
 	proxy = g_dbus_proxy_lookup(endpoints, NULL, argv[1],
 						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
 	if (!proxy) {
@@ -2845,17 +2877,7 @@ static void cmd_show_endpoint(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 
-	bt_shell_printf("Endpoint %s\n", g_dbus_proxy_get_path(proxy));
-
-	print_property(proxy, "UUID");
-	print_property(proxy, "Codec");
-	print_capabilities(proxy);
-	print_property(proxy, "Device");
-	print_property(proxy, "DelayReporting");
-	print_property(proxy, "Locations");
-	print_property(proxy, "SupportedContext");
-	print_property(proxy, "Context");
-	print_property(proxy, "QoS");
+	print_endpoint_properties(proxy);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -4320,7 +4342,7 @@ static const struct bt_shell_menu endpoint_menu = {
 	.entries = {
 	{ "list",         "[local]",    cmd_list_endpoints,
 						"List available endpoints" },
-	{ "show",         "<endpoint>", cmd_show_endpoint,
+	{ "show",         "[endpoint]", cmd_show_endpoint,
 						"Endpoint information",
 						endpoint_generator },
 	{ "register",     "<UUID> <codec[:company]> [capabilities...]",
-- 
2.46.1

