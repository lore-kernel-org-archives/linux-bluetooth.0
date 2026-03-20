Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C0368958
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041081; cv=pass; b=GMMoGbu4hxK7Si/feUpPY6UIVfs3B6bpzLe1llmIMqD836+JdaHPGz4hcpEPcCfrWfSoccYiHh30feSYjVaEPRXqs0ZrQ8SIRPmWC5P0EPH+ffbBl7+AOUMHluDnLNdeGEMqxXhHl2MgMNzuUrHv0gbG/6aMdmjaqcvUF+T309o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041081; c=relaxed/simple;
	bh=xbatIIUi+j6RAGEosH6MmHAUt+koICZnJHDfybkfVhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWbZen4UWQGYnGlfIVO4Rpv7ITQnoDfJ54Bfm64lVQg+Bfpkh2AtaxI4cMpHrCdNZbDSEvSCvezqxldtGeY6vGwT7LFJtf8vVOcUy+6juL3wFuisRBoMI/v8ncGycB7uVGMqZslk+AgWTft28youhltExF4BVYD4osu/JbqUuDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=XFioOp/E; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=VObQACO6; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="XFioOp/E";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="VObQACO6"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4fcwGY5qMrz49Q5S
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 23:11:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1774041077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ONUfVrdU74xydIZxCoU0cVlHRotjMEzS3J5btiRC4I=;
	b=XFioOp/E7Mw7rT6PNAJ36S+RXsTDMFnyBBwF8cZdrtifNxm834JYP0JcP5wOqTPDiQ9Rri
	Q82fBE20CMGqvgfjIoyUaaJWkodJjesGF/1fB8SxN2h32LnAm58uh9jDGKzFT3oso8SRBD
	xNomUcAy2kiOFoVofxQ3sIMr65AzPiyzwjH71Gfjamzd/LfZ82v/Zf/DIzmiJs23O8d1/l
	qSHeJfTc+jxJ5bIcDG/BcvaQanLL09LTpDXTtTo7Et5c5t6D9NBn59FBFPLygIYnhwP3Gs
	V0eZ2ip2kq64+1g7k4C9bOV/3cXGAX+jaUGHqSjnJI0y1nAxls5BDKA+jnVRyA==
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwGQ06n1zyvd;
	Fri, 20 Mar 2026 23:11:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ONUfVrdU74xydIZxCoU0cVlHRotjMEzS3J5btiRC4I=;
	b=VObQACO6vkj5ITaMcZ0+uwjpayUM3d7X6RyXfhOSXccIFsNmEkhyyX3I6TQWeK5BaB7FFK
	OUgdmvDkb63pFqpMflB8dqvPF5RhGf/II76oAEwBa68FgvvQbFolnPyII4lYRQLGKrPZbL
	RJ01gHtJcxhvwq1GS6CuaHj/kJ/S/50=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041070;
	b=vqDzMbhtl9FNU0LJ0eHqjh4TFBz/QbO8xpgtbjAG3+CDSFN6u0MDZZs9cRICiS5N2fpcWn
	fuX6TnplFCS49/4tfw5r0bD0MSaj4H/Sy+Qh3myNMUdSjveu6eOU9c0QRz4qtFC7yJVcnt
	JHXlCFQes/MEztv2xyfx0MH8thrUaNQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ONUfVrdU74xydIZxCoU0cVlHRotjMEzS3J5btiRC4I=;
	b=dkozPUlfyohwElb576hVUOlSjTlTTzl17kZ9tKYZ93IWan5WwuW6hBKziNv6afQcM2yCgG
	s+r6G0/H9LUlaC4nCTSwtZwqD1VcObkUTYnmI8Di6nkP1t1lP6XbezQR594431GMWWFWXd
	grt3RSUmBN/6GQChebjJ2i0GvrM93Ic=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 02/20] emulator: btvirt: allow specifying where server unix sockets are made
Date: Fri, 20 Mar 2026 23:10:46 +0200
Message-ID: <41d54c33641f8a6004b3cb9a616c746119e2b156.1774041047.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774041047.git.pav@iki.fi>
References: <cover.1774041047.git.pav@iki.fi>
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

