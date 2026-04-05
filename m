Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41EB23E32B
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392818; cv=pass; b=COWWy17nOTpcq2xFJE1fScWkQZfrK1USPHfoA7ea+zm4CjrG4Wur64+7FYPB5vl8vjVUBLbm3BxX1SwnVLBfsy2Ew+FJhFKGeLK8DXuw7sN30uRU5pbizXATR57a1vxoHmeYhRV1IK6e06/loiOmrP0N8FtRPS1H1/E0pT8PJ0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392818; c=relaxed/simple;
	bh=xbatIIUi+j6RAGEosH6MmHAUt+koICZnJHDfybkfVhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjAdrcI5TFevQf1QLmUswoP+tIoe1JyuooGxzAglm4JuipX7irLTs4PSY9i4Kz9ROgEhCNc+s5nnNAwBB7Ux4ardHAKNNttzn4KrzZHdP+G+73+ZucfvLc0sqC3Ft3XqTjzdNt3wr/yrif7mAzww1SVQN82l6pOINrYxTH7XFFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=WffexXt2; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="WffexXt2"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpX9M2ZWRzyxD;
	Sun, 05 Apr 2026 15:40:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ONUfVrdU74xydIZxCoU0cVlHRotjMEzS3J5btiRC4I=;
	b=WffexXt2wwnJyFG5vFUs4kYQ4QSUJSzIRbYHqg58CMPgrZdS0XIn/s1tCeq9Z/BugCzCth
	gMWEPRXtREk3AQRKOT8nGNPdfPBTAliSWW7d4qZz7Gs8RUxYI9UpR5DmgFwkJHSs9C0X7o
	TPTT18OwbIEJ6g0mA+KP6PjVVhkxtzQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ONUfVrdU74xydIZxCoU0cVlHRotjMEzS3J5btiRC4I=;
	b=fEJMTI3VGZy7qNwWxg0HuWSL/6tP5dn9tsIBTb5vHZi1l2IGVNSTmLov8BYuAePoekqIFU
	/SBBIIO1hqcEggfsKU8hDYv8ut0/a2oMhSs10G2Qojvik1rQknt8TD4+jg2T6sO5Og6GP5
	3JHkTByP3x3NhP7ptyhC2gPi3PKQGmU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392807;
	b=BAGEVY77MmM8gRm99ldhTQ/1rRdrL0EE8gk0SWFR7iJM2j49fp7XqjQ2+Tpr2uM1ioQmD2
	2EKZCp7skCgSlVtNHurlc52w3ZACyct3JcUjcZvTa4DncMEb6mc5eKGGXeVIl2CwtJQ46j
	5CIAtVnoVlfw6iJbFz3xIF6vt8XISac=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 02/20] emulator: btvirt: allow specifying where server unix sockets are made
Date: Sun,  5 Apr 2026 15:39:43 +0300
Message-ID: <a5e94ef722b84c3e4ec417b5136616fcd31e3978.1775392680.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775392680.git.pav@iki.fi>
References: <cover.1775392680.git.pav@iki.fi>
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
2.53.0

