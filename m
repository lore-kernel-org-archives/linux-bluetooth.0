Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943194C9574
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689067; cv=pass; b=s/DSFsubLmd0BtSTVPSmydC9aotcd0W8fsC3HM03GQFG+XAf8okc2slc62MbzszkmKMd2o4NuAOVOyOoSvL6Tvh7Lm5+6NA713SA3puHDRLMiGgRvCxGlw4wzgcwUBK1zMnF3wBxql53VXx5hDavb8HDsH233Q5K7T5+1NoI2Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689067; c=relaxed/simple;
	bh=7+M7J0agbPzKTCyUGvc+L87kboa3eirD8ncJXh9dWOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU1Z0ku/BrzhBdVN+II6c6IukmtKh4QNuRn1Bu6yF2EZrtJkIQeq+/SRP/UrGaWV/1huQx1/YHzk5oXynbnSlPqFtIpoO10dHi/JxJslkahEghLW9dPINtfsmwpziubChxpW8VKEttoiioeYblWPcyDM5C1no9vLyj3Ch3IObFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=aVP2koYt; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="aVP2koYt"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzBn5fBlzywN;
	Wed, 13 May 2026 19:17:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jz5lQ4psIV7ZQsaii0lPy4wir2hgS/31M989uCrDIgQ=;
	b=aVP2koYtpu7FAgnDjjXBfhcW9QmQAyaXr3SodCvpPT0FwXG/+tSSbI7xyricEQTudU1XmM
	YC5NxVC4gNgejZx9DeSLMIQGEld8o9OfrMQ/Z0PI9PyMmj01GnQrdxhKZEh6OnGBv/c8SY
	x0Z0KOtffoK47oS0RbMSVSDkvUuD6SE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689057;
	b=tuSbySgbSvf1J1n4meIUfW+Ju8t27wvGl1OovTTxz3EuQHa+HmtQs2ti/X9qOGam6HiK/W
	skTwBXlbgbuEPkv6M5t7+8l+2ItoxagxQoF1XlYjNMV9cZvyfDtoUEGQ0ovzIpmY/kJBGA
	8iodqY7vXT0I9n3jEEI55MIKRJebZ34=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jz5lQ4psIV7ZQsaii0lPy4wir2hgS/31M989uCrDIgQ=;
	b=d/73DxltosJk5VNwqytMHsTWHsDFiPknhBDEh/jtb4LOjsiNo0rpDxvqyorZq4XdbIzXzG
	DmCOJmqXS7VkbLosV1UER8kWYPkgHYsSLOWSmj1PlH49D2LfwFVgXTR0wQNo1v7jdgsDRh
	yvX+vDheFcCRVf72WN8uU537RGNSA1M=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 02/16] emulator: btvirt: allow specifying where server unix sockets are made
Date: Wed, 13 May 2026 19:17:19 +0300
Message-ID: <7f07b23630f3dcb84eafcce2d30a57c9ea34a175.1778688966.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778688966.git.pav@iki.fi>
References: <cover.1778688966.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make --server to take optional path name where to create the various
server sockets.
---
 emulator/main.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/emulator/main.c b/emulator/main.c
index 456fcd98e..09d6e9adb 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <getopt.h>
 #include <sys/uio.h>
+#include <limits.h>
 
 #include "src/shared/mainloop.h"
 #include "src/shared/util.h"
@@ -46,7 +47,7 @@ static void usage(void)
 	printf("options:\n"
 		"\t-d                    Enable debug\n"
 		"\t-S                    Create local serial port\n"
-		"\t-s                    Create local server sockets\n"
+		"\t-s[path=/tmp]         Create local server sockets\n"
 		"\t-t[port=45550]        Create a TCP server\n"
 		"\t-l[num]               Number of local controllers\n"
 		"\t-L                    Create LE only controller\n"
@@ -60,7 +61,7 @@ static void usage(void)
 static const struct option main_options[] = {
 	{ "debug",   no_argument,       NULL, 'd' },
 	{ "serial",  no_argument,       NULL, 'S' },
-	{ "server",  no_argument,       NULL, 's' },
+	{ "server",  optional_argument, NULL, 's' },
 	{ "tcp",     optional_argument, NULL, 't' },
 	{ "local",   optional_argument, NULL, 'l' },
 	{ "le",      no_argument,       NULL, 'L' },
@@ -88,6 +89,7 @@ int main(int argc, char *argv[])
 	struct server *server5;
 	bool debug_enabled = false;
 	bool server_enabled = false;
+	const char *server_path = "/tmp";
 	uint16_t tcp_port = 0;
 	bool serial_enabled = false;
 	int letest_count = 0;
@@ -100,7 +102,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "dSst::l::LBAU::T::vh",
+		opt = getopt_long(argc, argv, "dSs::t::l::LBAU::T::vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -114,6 +116,8 @@ int main(int argc, char *argv[])
 			break;
 		case 's':
 			server_enabled = true;
+			if (optarg)
+				server_path = optarg;
 			break;
 		case 't':
 			if (optarg)
@@ -196,28 +200,35 @@ int main(int argc, char *argv[])
 	}
 
 	if (server_enabled) {
-		server1 = server_open_unix(SERVER_TYPE_BREDRLE,
-						"/tmp/bt-server-bredrle");
+		char path[PATH_MAX];
+
+		snprintf(path, sizeof(path), "%s/%s", server_path,
+							"bt-server-bredrle");
+		server1 = server_open_unix(SERVER_TYPE_BREDRLE, path);
 		if (!server1)
 			fprintf(stderr, "Failed to open BR/EDR/LE server\n");
 
-		server2 = server_open_unix(SERVER_TYPE_BREDR,
-						"/tmp/bt-server-bredr");
+		snprintf(path, sizeof(path), "%s/%s", server_path,
+							"bt-server-bredr");
+		server2 = server_open_unix(SERVER_TYPE_BREDR, path);
 		if (!server2)
 			fprintf(stderr, "Failed to open BR/EDR server\n");
 
-		server3 = server_open_unix(SERVER_TYPE_AMP,
-						"/tmp/bt-server-amp");
+		snprintf(path, sizeof(path), "%s/%s", server_path,
+							"bt-server-amp");
+		server3 = server_open_unix(SERVER_TYPE_AMP, path);
 		if (!server3)
 			fprintf(stderr, "Failed to open AMP server\n");
 
-		server4 = server_open_unix(SERVER_TYPE_LE,
-						"/tmp/bt-server-le");
+		snprintf(path, sizeof(path), "%s/%s", server_path,
+							"bt-server-le");
+		server4 = server_open_unix(SERVER_TYPE_LE, path);
 		if (!server4)
 			fprintf(stderr, "Failed to open LE server\n");
 
-		server5 = server_open_unix(SERVER_TYPE_MONITOR,
-						"/tmp/bt-server-mon");
+		snprintf(path, sizeof(path), "%s/%s", server_path,
+							"bt-server-mon");
+		server5 = server_open_unix(SERVER_TYPE_MONITOR, path);
 		if (!server5)
 			fprintf(stderr, "Failed to open monitor server\n");
 	}
-- 
2.54.0

