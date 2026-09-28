Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07345D5FC
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616783; cv=none; b=Wl663b4cvhofYn80wujlvB4dccK3L08ptHdG8VRvm9aKxfmBaw6Ika06x44PDYR9xllhwoWSmP9zU7EDx6yHw2qp7DjN7X0deQ2A3ZcaD2sdZTTGNY3BBLt+B0ZEeQPL7xWJgaBhvbgjf/+xK42zG51zEi/Dx6qhAVpTvHdWLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616783; c=relaxed/simple;
	bh=cXuasgiFiW+AMbYj9pSxxfxlNE6GTEcQSe3q+CToo48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQknQjWLOT57Qz8QF8NMYEze27j0hAq0ndWFIn7b8EXK3XODhhy5AjNp62N8PWw+bWTvE7noiK3qrTeSaPv+ZwG9/2XcvA+MP3NgndQ+dOGHKtf6cEkxfxe/PLnZxfvuaTdajk2REngVHtyisE69GtVzVpd/q+XxMGGKcT4Hvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4sIbiRg; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4sIbiRg"
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5cddebe9b2cso1902180e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616781; x=1791221581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T9jycbnHJKQRW0bmwa+crip9eqUgy8bTsRbBitNSamg=;
        b=U4sIbiRgvu9dWNgy1D9un0ar0kx7f8owkRV32IyErfLBoOgpZAm+HYAdZR3O7mKaul
         PS3ZbyEP6UoHFUxjeKHabv2HQS7sHKXelyUJTTyRJuRrkcmLHIJVa9dhEJgL1gbA50i1
         Txzl5bVoYkYSSrajZTCU/hVT9o6ShLvZBLQ8Z2dIGlcNRq21X67a7J9702BaqkAye07o
         WSD5MXQse4iSKnzYLHGn2q103nefShSHpi8T8woc0OWvx+PfoP6VpmHsyCnAqjdTkHHX
         xhPrtCRkN2GdMOVNAhCvMGDHOgilLG+zjhZPxxDfwLq2Ivc5NiKs9qaQhAm3j5aQQzdj
         82Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616781; x=1791221581;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T9jycbnHJKQRW0bmwa+crip9eqUgy8bTsRbBitNSamg=;
        b=YhA0i5pyc10cs2ZPjOBE1UqHPNxrAWv3BrdI3P9o5IvrLUg6wrP0zEkKJ6yN2Wbwem
         k2SJ47VKEbdwmN0qoysCbWzVY35+kTRizW+aLSXWRKTl3FuLZIC1Tg+KiqbF7JxRGFtg
         KySjXAQmfj3lhsT59KD31IptXRvvw5vaHRVTr3e6yX6zkWKPdX+phnTzYPLDTTTtQ3D0
         29LPLqxqWZkuCe3pUEFZgbnZb+NUwYjaA32ovRdQVuCnTOa/kOJ4Zyei0qkhITJ25mjo
         HyuK+4W8RfuGsilOM4YTzq+bz3TzspKNZ7S/lozyZPsUGhrhN8X/oOYKzGVz2+Fsgjs1
         FziQ==
X-Gm-Message-State: AFq9FYLexm1qkxqbyHUl/RlPgPrK0VTw5x4aBFMfDdl0IFaUAGpcwiPX
	YfEZgsv60u4T9UPg779VVq2MtcvlQer5d/qlZR5rW+04qngBltJADQqnXLxQHOiIjik=
X-Gm-Gg: AYBFou2zEUeCG0uyQKAma2ABbm79jEfj3W1AThXYVK9jcXFbU+j8PymFMJc/ojQ6B5i
	1y0VLvvLI5VKVTgZrRB+vJo5Qshfst8Ui07EcRvbXYYGCvENJC9qWRAlV4UC+0UvfrJFRQxuGf5
	W79oGidmMXTPEtIdWFhYItO/7PRUjgJ2cJtDmFspWdJ2hoZOyXSNWiQuQu5+3uEtqO7GlaMzm6c
	qBiJtsT6CL38xWzgj2Aup7KwqMcsZ3j7NvQ1YnAm+pWcoLqIgDAHlBS9gz8c5xtHAI2+8nuYJuh
	z+9EZu5jFcODLltZumarwNIEO8FCY9q25aNBWUQDzia7aUMRinP3Tmq5SxarDGnWrZxxQmgxIAQ
	YgGvD9p829ab1dhSKcHhhOcsu65Em3GsNK209FB4BlwIZuUBoyiMY4wgjpwBhiPFW06d6biwr3z
	qCotN+V5rTkIqDiYQCbNEZY0wrYi+ajDQ9VOnYn/+QJ6iR5x0rnD/gyWYIa+GlYO2kSREQ0eR41
	iXD5FrjB/BfFjGFjDXx28cZX0LXkTHph0oZeoijcIfrji7/GmMCkzOjyN3OhnJt
X-Received: by 2002:a05:6102:441e:b0:7a6:a24e:811f with SMTP id ada2fe7eead31-7af1c79966cmr5598700137.7.1790616779645;
        Mon, 28 Sep 2026 10:32:59 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.32.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:32:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 04/21] emulator: Default to the latest BR/EDR+LE version
Date: Mon, 28 Sep 2026 13:32:23 -0400
Message-ID: <20260928173243.1073509-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
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

