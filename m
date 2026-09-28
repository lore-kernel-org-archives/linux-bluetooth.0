Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A44F6483
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625656; cv=none; b=ukLbkpSheNMIgvJFgIeQ+nHCeFTfGhAYLtCkDD9aMXgEtWDSoymxnCClsTgPCe06kIXc0FMzTgccwauUnmI2WycyiOq4LCA0FCSndgLntDZB8mEYQLEG7Z91rXvoFsUb7xkWAFyGW7x7TrEUNSautnuG/AMbfix/j3k3QNr9fiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625656; c=relaxed/simple;
	bh=cXuasgiFiW+AMbYj9pSxxfxlNE6GTEcQSe3q+CToo48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJ1rgAL/GveY7vizSo/pCJFhzIsa0v4TLbctNB/i7AHH5K4t2GtWwkZHEOO5kZG7XqYD2sq+2cXfrK230FqQCh6Ml/2IovsDt0mPLBbUs70OsnMdHo9Cz7IqvsdJSCVFABIAADBiC8x2cVdBcHkvcInxm0/i0k3FkRzNaWrdjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTBHTZpU; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTBHTZpU"
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-795a0ab5227so1107662137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625653; x=1791230453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T9jycbnHJKQRW0bmwa+crip9eqUgy8bTsRbBitNSamg=;
        b=VTBHTZpU0SglDRlDP/hER39PzLtFsCJbWJi6md/ZjErzMtpyoZdslmUTaIMGxXRR8h
         XVzP3frrS4Xd44eSsAkF6/X2DUckiBolkc1FFX+8uhkIvS5f+yhLGlGxgKld9FXqX2xc
         x5GNLoGUh6mSBLM4QFyfnYg9LMh7LW1vGqlTRQ690Re7yycH4+vu/CDh1nKkSf2NWFaQ
         BdzwgHlw0BeRp1ACzjxW2Mg1U8j+WgNosXN3GCjEMN5ngWputHcHjvr41f2/zt5F0RV7
         Ba+Y2Vh4dcpRIZIoTbN5GVMzk4uYDcwzLemw6sbjh7XB6I9OLesxVZPdPNnRFvkXVg+M
         F+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625653; x=1791230453;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T9jycbnHJKQRW0bmwa+crip9eqUgy8bTsRbBitNSamg=;
        b=o2FHxpzd2ZfhzcAkfi4pPwXFatB13wkUCrbnxgwUhXL00XoVBnhrQuGpkWFDMK/xCQ
         TMHTfFlci1Av4JsEqk8Nw1VnF50oYHMxE3udTCN2rmxdt7PT7ZzU64k08zqp40n+WEyE
         YXycgi24FMGFAGtpmmQjlDfXHJ12XvujRZYC7g3XulhGPTC+pt2U99Z64X4jlu5lASSi
         P+D0yZG2m9XTcCXA/1jQQX+37OqLcTyEU5AJxvuKi53BXAesHizybzBTdSRZSP1SUyGK
         eiftyCQ4U73KPvzUPaysX7iV53p9QLeh8jeNsD1LFhUo8KNz6Vs8ifhtu0JS8av5ewdP
         v09Q==
X-Gm-Message-State: AFq9FYJ5i4LLqeFoaPNRB6o/USr0CpF9DcSiZ/XUaW9FFnEmpLZHI7XS
	fqoP4XdGALjfO551K063/zWmm6vO4UIZGQv/Bn5ru4LxBlTdaJGUzSk83nIV4ieYA40=
X-Gm-Gg: AYBFou1qQ6J9Ojx3IETxtve3DsywilbGFpa5FvOzskNhQvLNDDB0thMmwg1vvejFKO2
	zc810j3vKN/tZXhLH78TvHylBRhOBqKWXxiJ990t2fbLNjt3KEVePz0sGjhokT3/ZMsrUmpJaYf
	LHHVyardf7F8xUCMubTC+wstCC0eF76PLNwTO1WP/9yeHYdTmPhMmVTK/A1a6ErkptKYFCEro38
	gehu3QwvJsLr5N83zAZAe6QT+CjkHl1TmDBrnuK88DdvGNbcrcQCW0dB3pDz14UeQcMLh+xVmkk
	s/0sSCiMyTDid9uWW0itVlLWDFiz754/LInSHIHqNwsbscLvRSRkVUIoovozEGyEyRrF9iU8mI8
	OQTMfuzr8zHIteibcqr8Y0aI+W+AwGsg0dKgSnUvdEDDwarqO33COqqI5uuqAZ+2X9zsoPsK1/n
	BMxA6X3fN+GYTxNn0K7fRCzOQbZ67bgH2hJ98GgTn4WLv/iDq/7QBKlc5W3XHMylM7sYngXTiOK
	mUgPX/D1Kqul4R7Jqb2qpVhGlCzUzu2BDywNhmD7k5xoIamTlj/e1qCDD43r47D
X-Received: by 2002:a05:6102:1488:b0:7b4:879c:bb87 with SMTP id ada2fe7eead31-7b4879cc10fmr1449714137.14.1790625653011;
        Mon, 28 Sep 2026 13:00:53 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.00.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:00:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 04/23] emulator: Default to the latest BR/EDR+LE version
Date: Mon, 28 Sep 2026 16:00:10 -0400
Message-ID: <20260928200031.1209311-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Emulate BR/EDR+LE 6.2 controllers by default, for both local (-l) and
server (--server, --tcp) controllers, so the latest features such as
Shorter Connection Intervals (LE Connection Rate Request) are
supported, e.g. by test-functional which uses --server.

Add the -C/--core=<version> option to emulate older versions instead:
5.0, 5.2, 6.0 or 6.2.

Assisted-by: OpenCode:claude-opus-5.5
---
 doc/test-functional.rst |  4 ++-
 emulator/main.c         | 55 ++++++++++++++++++++++++++++++++++++++---
 emulator/server.c       | 15 ++++++++++-
 emulator/server.h       |  2 ++
 4 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
index 3ffcbf6dec5c..826210b73ce7 100644
--- a/doc/test-functional.rst
+++ b/doc/test-functional.rst
@@ -227,7 +227,9 @@ Controllers
 
 By default a single ``btvirt`` process runs on the developer machine and
 provides an emulated BR/EDR/LE controller to every VM host over a UNIX
-socket, also bridging the air interface between them::
+socket, also bridging the air interface between them. The controllers
+emulate the latest Core Specification version supported by ``btvirt``,
+6.2, older ones can be emulated with its ``-C/--core`` option::
 
     VM host #0                 developer machine              VM host #1
     ┌────────────┐            ┌─────────────────┐            ┌────────────┐
diff --git a/emulator/main.c b/emulator/main.c
index c21640adc359..b0e295b17609 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -24,8 +24,8 @@
 #include "src/shared/util.h"
 
 #include "serial.h"
-#include "server.h"
 #include "btdev.h"
+#include "server.h"
 #include "vhci.h"
 #include "le.h"
 
@@ -54,6 +54,10 @@ static void usage(void)
 		"\t-U[num]               Number of test LE controllers\n"
 		"\t-B                    Create BR/EDR only controller\n"
 		"\t-A                    Create AMP controller\n"
+		"\t-C, --core=<version>  Core Specification version of the\n"
+		"\t                      BR/EDR/LE controllers created with\n"
+		"\t                      -l, -s and -t:\n"
+		"\t                      5.0, 5.2, 6.0 or 6.2 (default)\n"
 		"\t-T[num]               Number of test AMP controllers\n"
 		"\t-h, --help            Show help options\n");
 }
@@ -67,12 +71,37 @@ static const struct option main_options[] = {
 	{ "le",      no_argument,       NULL, 'L' },
 	{ "bredr",   no_argument,       NULL, 'B' },
 	{ "amp",     no_argument,       NULL, 'A' },
+	{ "core",    required_argument, NULL, 'C' },
 	{ "letest",  optional_argument, NULL, 'U' },
 	{ "version", no_argument,	NULL, 'v' },
 	{ "help",    no_argument,	NULL, 'h' },
 	{ }
 };
 
+static const struct {
+	const char *version;
+	enum btdev_type type;
+} core_versions[] = {
+	{ "5.0", BTDEV_TYPE_BREDRLE50 },
+	{ "5.2", BTDEV_TYPE_BREDRLE52 },
+	{ "6.0", BTDEV_TYPE_BREDRLE60 },
+	{ "6.2", BTDEV_TYPE_BREDRLE62 },
+};
+
+static bool parse_core_version(const char *version, enum btdev_type *type)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(core_versions); i++) {
+		if (!strcmp(core_versions[i].version, version)) {
+			*type = core_versions[i].type;
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static void vhci_debug(const char *str, void *user_data)
 {
 	int i = PTR_TO_UINT(user_data);
@@ -101,7 +130,10 @@ int main(int argc, char *argv[])
 	bool serial_enabled = false;
 	int letest_count = 0;
 	int vhci_count = 0;
-	enum btdev_type type = BTDEV_TYPE_BREDRLE60;
+	/* Default to the latest version supported by the emulator */
+	enum btdev_type bredrle_type = BTDEV_TYPE_BREDRLE62;
+	enum btdev_type type;
+	bool type_set = false;
 	int i;
 
 	mainloop_init();
@@ -109,7 +141,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "dSs::t::l::LBAU::T::vh",
+		opt = getopt_long(argc, argv, "dSs::t::l::LBAC:U::T::vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -140,12 +172,22 @@ int main(int argc, char *argv[])
 			break;
 		case 'L':
 			type = BTDEV_TYPE_LE;
+			type_set = true;
 			break;
 		case 'B':
 			type = BTDEV_TYPE_BREDR;
+			type_set = true;
 			break;
 		case 'A':
 			type = BTDEV_TYPE_AMP;
+			type_set = true;
+			break;
+		case 'C':
+			if (!parse_core_version(optarg, &bredrle_type)) {
+				fprintf(stderr, "Unsupported version: %s\n",
+								optarg);
+				return EXIT_FAILURE;
+			}
 			break;
 		case 'U':
 			if (optarg)
@@ -164,6 +206,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!type_set)
+		type = bredrle_type;
+
 	if (letest_count < 1 && vhci_count < 1 && !server_enabled &&
 						!tcp_port && !serial_enabled) {
 		fprintf(stderr, "No emulator specified\n");
@@ -214,6 +259,8 @@ int main(int argc, char *argv[])
 		server1 = server_open_unix(SERVER_TYPE_BREDRLE, path);
 		if (!server1)
 			fprintf(stderr, "Failed to open BR/EDR/LE server\n");
+		else
+			server_set_bredrle_type(server1, bredrle_type);
 
 		snprintf(path, sizeof(path), "%s/%s", server_path,
 							"bt-server-bredr");
@@ -255,6 +302,8 @@ int main(int argc, char *argv[])
 		tcp_server = server_open_tcp(SERVER_TYPE_BREDRLE, tcp_port);
 		if (!tcp_server)
 			fprintf(stderr, "Failed to open TCP port\n");
+		else
+			server_set_bredrle_type(tcp_server, bredrle_type);
 		fprintf(stderr, "Listening TCP on 127.0.0.1:%d\n", tcp_port);
 	}
 
diff --git a/emulator/server.c b/emulator/server.c
index e3eda8458ae0..5a827b24531e 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -38,6 +38,7 @@
 
 struct server {
 	enum server_type type;
+	enum btdev_type bredrle_type;
 	uint16_t id;
 	int fd;
 	struct queue *clients;
@@ -281,7 +282,7 @@ static void server_accept_callback(int fd, uint32_t events, void *user_data)
 
 	switch (server->type) {
 	case SERVER_TYPE_BREDRLE:
-		type = BTDEV_TYPE_BREDRLE52;
+		type = server->bredrle_type;
 		break;
 	case SERVER_TYPE_BREDR:
 		type = BTDEV_TYPE_BREDR;
@@ -361,6 +362,7 @@ struct server *server_open_unix(enum server_type type, const char *path)
 
 	memset(server, 0, sizeof(*server));
 	server->type = type;
+	server->bredrle_type = BTDEV_TYPE_BREDRLE62;
 	server->id = 0x42;
 
 	server->fd = open_unix(path);
@@ -429,6 +431,7 @@ struct server *server_open_tcp(enum server_type type, uint16_t port)
 
 	memset(server, 0, sizeof(*server));
 	server->type = type;
+	server->bredrle_type = BTDEV_TYPE_BREDRLE62;
 	server->id = 0x43;
 
 	server->fd = open_tcp(port);
@@ -455,6 +458,16 @@ void server_close(struct server *server)
 	mainloop_remove_fd(server->fd);
 }
 
+bool server_set_bredrle_type(struct server *server, enum btdev_type type)
+{
+	if (!server || server->type != SERVER_TYPE_BREDRLE)
+		return false;
+
+	server->bredrle_type = type;
+
+	return true;
+}
+
 bool server_set_debug(struct server *server, server_debug_func_t callback,
 			void *user_data, server_destroy_func_t destroy)
 {
diff --git a/emulator/server.h b/emulator/server.h
index 1844a9871af1..5fc3a284f53f 100644
--- a/emulator/server.h
+++ b/emulator/server.h
@@ -25,6 +25,8 @@ struct server *server_open_unix(enum server_type type, const char *path);
 struct server *server_open_tcp(enum server_type type, uint16_t port);
 void server_close(struct server *server);
 
+bool server_set_bredrle_type(struct server *server, enum btdev_type type);
+
 typedef void (*server_debug_func_t)(const char *str, void *user_data);
 typedef void (*server_destroy_func_t)(void *user_data);
 bool server_set_debug(struct server *server, server_debug_func_t callback,
-- 
2.55.0

