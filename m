Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91404A4839
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264810; cv=none; b=TniNCJAOXVbBws9OiG//9Gm3m4mZtlGxjS9nTPvYBciSHt6fvKeEpRan529Q5ImubFelBDdlJCeFFioGRP8siT/bKYwsgwSnYtSCTURRkIMI/j/TT1GPuPP16aGZWOD0GdWWeGUinZobVRAJm6Auu/q/3isrNu6lj82dugyQJKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264810; c=relaxed/simple;
	bh=xq8sOK+jqVXt+sGUzSaDD3mz3kqYi0uamMWLGLnbwfQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXAvxtPMGspmrczZfX9PrTpZdCRz43Wia2rPVsFkN4E2clHspDB59YNxcCzASeOP6/yVF8zpFAmY4Q5L0d1vYXJtIM5D9bISGrr2iJ+k8n95zsrmrR642zbtaZNFx+h6WQVOPpGcqXnaQVPM5WzdYX4+G+KECDo9L8sv4cCPOlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXZtEk8W; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXZtEk8W"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-7856441f7dcso951338137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264807; x=1790869607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WRUO4dGD9GwElU1wEz0nQz+wfMYIGrewnknxx+MgLf8=;
        b=GXZtEk8WQT/xxLtCNr2hqJaAN4NHpjLoizex3QqJqBfwlWtinv0M5wARPcdYx0yY+a
         fJdW7SOPykD66kVm9p0I8EmclEqBdjiQ58ym9klv8tsF++bRvtO6j4oplkPC6/xPWtnv
         9ptTeHsegs2cOY6iek2MM5K7pr2KWLx1MAVJgkw1CYpPu1UoQGvbO4yhXucUmiHWZzCW
         tFsdZYM/s21wBpAVIvMMC8fu/SJLA4pO1etDujSR5QHjVvsDzj4OnLp4dJdCDXGbswIz
         wEbS04+KSpD+9Wpler48u0/wfQGQ5bC0+Pqoxzv0/ORDNYCQJzZSBH9dc1KQo7Awi/EU
         rxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264807; x=1790869607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WRUO4dGD9GwElU1wEz0nQz+wfMYIGrewnknxx+MgLf8=;
        b=1qyPYDVzdsZUf4wDRFK1KpVLwdUdmonkP6xdeQ1wlFa8SLYdK7vcfXKcls8wtwwQQi
         fyVd79yVemS76PzcbmDj3v+SpcNzYxp7QiLa43PFRTag9FHcUctrz/B8UuLJ/tkk1HMK
         Q6vuWWFK+FV51xqRusgufrYgwLnhtwbulomYaTPrp1MV4xyGkRJ9NOrG/qn7zliYxJ7v
         8E+90dq/qhsKPTt6YXkiLL279Z1NAhmXa+1hmmrHvszpzXNNu3/8b72srGKc5zOsCCej
         EJPpFLjp1LgrFWHGq+siUNikaC1iqqp5jKVeu0YNpE+6EZu+eePDr/H0VFLaW13WgpLO
         OSBw==
X-Gm-Message-State: AFuF++lFLxx2sGD1/kgVjVv0ZkX0EeoG4YqcMP2n9+z7W1R9arqXIJXw
	FnsEs15aotSQNWn/XpqaV0sF2ypvF0LxQNDbIpaphPOyXnbNZg/XA+AWxJ2LEbAV2Wqeuw==
X-Gm-Gg: AYBFou01wY/4DvIs8WYg74EACj7Hmu8qXvb4fYvb1s+GgGFIO2ppwP4CjbjRwEZI3su
	RyFJb726HDeGeRhBjOJTI0YNVccAtnMiFSZfxsy5+/Hf2oTa6lIrnYYCzf4LE68742m11qSWbAz
	STmjhRH84NFC99LznS/Yci9CRWAZDtFHlt5vv61odEnC/G2DNkkubOwIejucow6fXAbqDcx50LY
	b/jNcV7l4mILocmO/tVNg2QUgUA8K6JBCqyxEqe7C+xZCOYlQ/FMjRAnc2cPoLcx0jfeyD/Zx0c
	Sv8stZQ4ewlzYENVSs64DtFVaZPiQL9YnHUmjcxqsJME4I7bnpQijncJeaO/rzEiWGat00KEQiO
	eTq5mfgkMjvx8OWecSNm2hSgOPkoPbURyv7RnL/IGZ9+6rRpmY8f1YKpH6M/j49uK+11KMQn0X4
	fDdBIMYb9pg7EUzfyKZJhqOpNeu1SpcHKTFHoPFRXVTLTG85Pah1hf2UxEBrIJQUZtDlEsHEv6Z
	xwHdff+PQat26pPjGNr1OX9Hb8JQEfhdOzqAIC8msqnanGoOk9kqf54kr2Tln39
X-Received: by 2002:a05:6102:c54:b0:7a8:10eb:9775 with SMTP id ada2fe7eead31-7af1c79b7cbmr1493155137.4.1790264807230;
        Thu, 24 Sep 2026 08:46:47 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5674f44sm7412428137.3.2026.09.24.08.46.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:46:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/9] emulator: Default to the latest BR/EDR+LE version
Date: Thu, 24 Sep 2026 11:46:27 -0400
Message-ID: <20260924154631.369299-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924154631.369299-1-luiz.dentz@gmail.com>
References: <20260924154631.369299-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Emulate BR/EDR+LE 6.2 controllers by default, for both local (-l) and
server (--server, --tcp) controllers, so the latest features such as
Shorter Connection Intervals (LE Connection Rate Request) are
supported, e.g. by test-functional which uses --server.

Add the -C/--core=<version> option to emulate older versions instead:
5.0, 5.2, 6.0 or 6.2.
---
 emulator/main.c   | 54 ++++++++++++++++++++++++++++++++++++++++++++---
 emulator/server.c | 15 ++++++++++++-
 emulator/server.h |  2 ++
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/emulator/main.c b/emulator/main.c
index c21640adc359..b18e77cf191b 100644
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
 
@@ -54,6 +54,9 @@ static void usage(void)
 		"\t-U[num]               Number of test LE controllers\n"
 		"\t-B                    Create BR/EDR only controller\n"
 		"\t-A                    Create AMP controller\n"
+		"\t-C, --core=<version>  Core Specification version of the\n"
+		"\t                      BR/EDR/LE controllers:\n"
+		"\t                      5.0, 5.2, 6.0 or 6.2 (default)\n"
 		"\t-T[num]               Number of test AMP controllers\n"
 		"\t-h, --help            Show help options\n");
 }
@@ -67,12 +70,37 @@ static const struct option main_options[] = {
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
@@ -101,7 +129,10 @@ int main(int argc, char *argv[])
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
@@ -109,7 +140,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "dSs::t::l::LBAU::T::vh",
+		opt = getopt_long(argc, argv, "dSs::t::l::LBAC:U::T::vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -140,12 +171,22 @@ int main(int argc, char *argv[])
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
@@ -164,6 +205,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!type_set)
+		type = bredrle_type;
+
 	if (letest_count < 1 && vhci_count < 1 && !server_enabled &&
 						!tcp_port && !serial_enabled) {
 		fprintf(stderr, "No emulator specified\n");
@@ -214,6 +258,8 @@ int main(int argc, char *argv[])
 		server1 = server_open_unix(SERVER_TYPE_BREDRLE, path);
 		if (!server1)
 			fprintf(stderr, "Failed to open BR/EDR/LE server\n");
+		else
+			server_set_bredrle_type(server1, bredrle_type);
 
 		snprintf(path, sizeof(path), "%s/%s", server_path,
 							"bt-server-bredr");
@@ -255,6 +301,8 @@ int main(int argc, char *argv[])
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

