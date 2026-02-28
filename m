Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144EE438FE4
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283103; cv=pass; b=FDOIm+nkBlz2H6j0mKyYKhT4OwCPc20QA0rYmBqBWcIvJ7u1puhlQ5nVYEG0juvUEmI+2OsMpSEfbgnZ0bG/NTZAsX0BC8ylVdMfMq7Ooki38YPdKdlg8sGx1za3K7BSF/rCvypFF+QqJb4ODyJLpeUlChdaXi7ewrngFNecOhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283103; c=relaxed/simple;
	bh=xbatIIUi+j6RAGEosH6MmHAUt+koICZnJHDfybkfVhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5/gmjbaj9IVKsqFsnIejDqVvAi+12SZ8bdu7j5udAPmCDlot/SvGxrwE0uOZTLseySLYQ/s4xawdbbgF3mDdhRuPtIVAOVg5EOpe6eS1mgU6WP5U9WLghx03xaxHrsjDQ4Anu//VaFIajpInEfZlVPCnaw18wMaN7h/vSqzYnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=GnHyEnM5; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=hEHkDb4N; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="GnHyEnM5";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="hEHkDb4N"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4fNQ765c7rz49Q6X
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 14:51:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1772283090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ONUfVrdU74xydIZxCoU0cVlHRotjMEzS3J5btiRC4I=;
	b=GnHyEnM59hGTpt//wTarLuD9EeTC1lPAfUQ+y1dgN/glbq2ycR1ZCswWRigLvoyren+Y5e
	zvB3pUEtyIUL/+f4FJ1CFbhtNRzollJXyrCoSZs/g/CF+hSQC2OPHlfaqI04eGRcSfFpng
	DEE4q7UhdvW7LBS6wPUU3vBOGVmAxV+gV1Xyl/1iNo7r0tWnKpaLWwNpdTBHG4zyZenkHy
	CD62xS4X2QkiexBZEN/OIfLFrK1GYQKgQYT/zuvS5ggAqObhAy53wTufmesjTIN1+Ks0gH
	5+UQxgL0zzUfvtF9/SdhaNpqyBL/JyOSLr+M4EyzGkmU6k9RiMSNuQ+Jy8h0/g==
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fNQ6x6tJHzyv6;
	Sat, 28 Feb 2026 14:51:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1772283082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ONUfVrdU74xydIZxCoU0cVlHRotjMEzS3J5btiRC4I=;
	b=hEHkDb4NE5YgoO0CtMwxQEbWjBPKwwJatz8ufy1IDo1b+ELDNyERepvDAWI+ikfA3bDjbx
	4bJemgL6TD/aCb2K4cGe3L1xrDXRt8JoM93v9+YiBP9UTt9RRSjjgE5cD9Jpryjrv0V7yS
	C2GH8VMyyDgpWs5tOFBb1quGHxuXkJ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1772283082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ONUfVrdU74xydIZxCoU0cVlHRotjMEzS3J5btiRC4I=;
	b=l4gm19fRpjEFfbwX2Xz2lemLyZOfXNuLark+7gF++2nYcC4nuZRUxq1GpcPEd62KxxGLOi
	07+4ih3zoRNP28BxU8dG2aDTlyJnRAbyiBKAovSlh95q4xjXpG4/LBD16wRb25CrXunK2v
	Uxjb3n8JZvr3UqnzOzjrKe2GcphoGGg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1772283082;
	b=PhdcgFLYr5ZMdh59rypgs5Ek31f9xvsWkow/xMefFWJC1kgch+haVRd5ya+TzpAEF2BIav
	tpehJ29CEKYxMirP4XlpxAIFuaeMXZVykTwICZevpKgM4AX9t2MeaAdacmaAhpAuDDCF+E
	Z3nvDuPjO61r/imj9SqlsrWmSYVYwL8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 02/11] emulator: btvirt: allow specifying where server unix sockets are made
Date: Sat, 28 Feb 2026 14:51:08 +0200
Message-ID: <31038fe214d7ad9036f85ede8f6e9b5eacfe9e87.1772282574.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772282574.git.pav@iki.fi>
References: <cover.1772282574.git.pav@iki.fi>
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

