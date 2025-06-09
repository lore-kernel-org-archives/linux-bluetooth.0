Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D6325CC47
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479924; cv=none; b=eZEyv71SkOLWL1bb+NIgug4PToBg+BfKz9uNc2JXlNtKki3jc/0May1sddXnACmTOYOp6ubqPTBu8AJIZHfsRl1gtwUY7biazXPfK831baa3mhVB18CIOyj5baTdvmt322SsxsMC5Y7eUFNvS3GnXyadsdWW08pSMX6O3Doc4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479924; c=relaxed/simple;
	bh=dkYezuD9DVTD1jDAbkDk8WX+WPoA8yiGVjz3xXMQfd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyOTVfiVBvIoc47KG0c0w7B6Ylf+2mPw1RlaATvuZY3zRaHa/2atfdJCeRZPQhx0s9L5DtIpcjO8SMPWujHBXR11jYAyvvi11qFHDjRAMYjvnejyJCA7aB4lah+3yfO5bkPnk1qBRXFtUk0t6LeVuux9u2ZugFq++dpRMXUhAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJDmAijm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJDmAijm"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-adb4e36904bso852076266b.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749479921; x=1750084721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9IKKzuBJsN4xaI8I7pHyZieW0xYgtEgESKs0w0VwH0=;
        b=DJDmAijmdgNFWJ+9QWSaqeGTXaswTKzqRps3rzVBE1Rar1hH5vNr6mqk33OjFbe9m4
         bBS9qKxRr8T1mNyog/rYWW1p5uEe2AmsKr/HsoRPPWP/aUMeQfkAQ3/YaV3dLNux2d62
         1XCEsHZttGHCHfbmTZoCZ6GXYFaN1yA16vLrXdVk743RdpsgUnz7uzpLMYOaJyJBVgGO
         Q1TCZ2FoQLAO7RbwClZM6SWrhP08UTBf7OznGhLLhs0j0xvcbtWCCsRJh4j1zBOW9bmE
         oesqUr8FMyNyTU8F0qA+j5NVUnJe3XXWFMjrTVPw7lGmXnp1TdRO3GrTervjH65Lg2Up
         GyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479921; x=1750084721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9IKKzuBJsN4xaI8I7pHyZieW0xYgtEgESKs0w0VwH0=;
        b=IaQE/Ctj1cusewhACV9vn3ixVCn3tGMbJ4o6elyxbODgk3/CAel58ZU63kE7MIyg8D
         OvXGaG8FrgN2YpcfCqb1MlVxGzL3DmId7TUuroBFsbZ+1MvMPB8nM3NLqlaAD0yNR0sZ
         1f3kSPZMewWg/lbtGIDvfHaFT01CAr5p4iIPIkG553Eu9sKrguPe28yOc0SiC/clk/62
         MowkhRW5o5ejP1xRPda6CbeHTZurkVI5p1dHUCHW2xMeZU8ArZE5fumkxghOVV9wHa9w
         KtK6PXaXvW+qBmVAln0dpFGzfH8mDAZdwv3+7fUIrQaSXBF9EsypAGLG6bcbQOzCxm/N
         pGIw==
X-Gm-Message-State: AOJu0YwhCjCf61Y7t/Fy6dXj5fySS1lx33lU3YotmRHQRYg5qxN+5fz8
	EICYIf73TNa0PHDv5Gbt6b8QiAEf1OS4DKeLYFBf61SYL1hbwfHpERNzcMNfhw==
X-Gm-Gg: ASbGncukMLObexynamM3tsJ49ugoIU0iwFPElav/xTUYurXLOQExlLHp08WKfPhoWT1
	DrcJplkJ+nU2jNf71ZBeJoDEnuHP6NgYcoYplh9JlnO+Ud7YQ809y2mK9hk4xdw6sHJP8idY4MQ
	faHWP0o4E7o6yUJtNo5PcKg014BbsngAQ2CVtv2hfiF3VXHLiGcmMMbgQ2ZmUwe78Omzervtu1p
	2w9U/RcTxxXiKDGNsB+ogS4S6dPQxVkRoeHq5iL4beWCYK5u3yr3Qupm7m4bfAnOZecKeYf9S/J
	MxQMJ655C976dtsA1+7lICBlngohRGhrcAYBxThUPpfIuf2qmf95lmkNgqWjAE2BPVvzzLf+fh3
	5R159ShSK1vZhgT8WCtg=
X-Google-Smtp-Source: AGHT+IGyCqTSmEWZiZoDWrPB3R8JzfmhxBdVy62xZNoptwGmv3Yv4NkvrVqW/UjfdlqR9kGKF70dtA==
X-Received: by 2002:a17:907:8687:b0:ad8:93a3:299d with SMTP id a640c23a62f3a-ade1a9227fdmr1026402666b.30.1749479920769;
        Mon, 09 Jun 2025 07:38:40 -0700 (PDT)
Received: from hyperion.tail59961f.ts.net (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade34ea5adesm452017866b.80.2025.06.09.07.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 07:38:40 -0700 (PDT)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Subject: [PATCH BlueZ 3/4] emulator: add option to listen on TCP
Date: Mon,  9 Jun 2025 16:38:10 +0200
Message-ID: <20250609143811.566331-4-d3dx12.xx@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609143811.566331-1-d3dx12.xx@gmail.com>
References: <20250609143811.566331-1-d3dx12.xx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 emulator/main.c   | 20 ++++++++++++++++++--
 emulator/server.c |  8 ++++----
 emulator/server.h |  2 +-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/emulator/main.c b/emulator/main.c
index 928588254..0d2f1e34f 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -47,6 +47,7 @@ static void usage(void)
 		"\t-d                    Enable debug\n"
 		"\t-S                    Create local serial port\n"
 		"\t-s                    Create local server sockets\n"
+		"\t-t[port=45550]        Create a TCP server\n"
 		"\t-l[num]               Number of local controllers\n"
 		"\t-L                    Create LE only controller\n"
 		"\t-U[num]               Number of test LE controllers\n"
@@ -60,6 +61,7 @@ static const struct option main_options[] = {
 	{ "debug",   no_argument,       NULL, 'd' },
 	{ "serial",  no_argument,       NULL, 'S' },
 	{ "server",  no_argument,       NULL, 's' },
+	{ "tcp",     optional_argument, NULL, 't' },
 	{ "local",   optional_argument, NULL, 'l' },
 	{ "le",      no_argument,       NULL, 'L' },
 	{ "bredr",   no_argument,       NULL, 'B' },
@@ -86,6 +88,7 @@ int main(int argc, char *argv[])
 	struct server *server5;
 	bool debug_enabled = false;
 	bool server_enabled = false;
+	uint16_t tcp_port = 0;
 	bool serial_enabled = false;
 	int letest_count = 0;
 	int vhci_count = 0;
@@ -97,7 +100,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "dSsl::LBAU::T::vh",
+		opt = getopt_long(argc, argv, "dSst::l::LBAU::T::vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -112,6 +115,12 @@ int main(int argc, char *argv[])
 		case 's':
 			server_enabled = true;
 			break;
+		case 't':
+			if (optarg)
+				tcp_port = atoi(optarg);
+			else
+				tcp_port = 45550;
+			break;
 		case 'l':
 			if (optarg)
 				vhci_count = atoi(optarg);
@@ -145,7 +154,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (letest_count < 1 && vhci_count < 1 && !server_enabled &&
-						!serial_enabled) {
+						!tcp_port && !serial_enabled) {
 		fprintf(stderr, "No emulator specified\n");
 		return EXIT_FAILURE;
 	}
@@ -213,5 +222,12 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "Failed to open monitor server\n");
 	}
 
+	if (tcp_port) {
+		struct server *tcp_server = server_open_tcp(SERVER_TYPE_BREDRLE, tcp_port);
+		if (!tcp_server)
+			fprintf(stderr, "Failed to open TCP port\n");
+		fprintf(stderr, "Listening TCP on 127.0.0.1:%d\n", tcp_port);
+	}
+
 	return mainloop_run_with_signal(signal_callback, NULL);
 }
diff --git a/emulator/server.c b/emulator/server.c
index ceb417a40..0ca7d42a3 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -311,7 +311,7 @@ struct server *server_open_unix(enum server_type type, const char *path)
 	return server;
 }
 
-static int open_tcp(void)
+static int open_tcp(uint16_t port)
 {
 	struct sockaddr_in addr;
 	int fd, opt = 1;
@@ -332,7 +332,7 @@ static int open_tcp(void)
 	addr.sin_family = AF_INET;
 	addr.sin_addr.s_addr = INADDR_ANY;
 	addr.sin_addr.s_addr = inet_addr("127.0.0.1");
-	addr.sin_port = htons(45550);
+	addr.sin_port = htons(port);
 
 	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		perror("Failed to bind server socket");
@@ -349,7 +349,7 @@ static int open_tcp(void)
 	return fd;
 }
 
-struct server *server_open_tcp(enum server_type type)
+struct server *server_open_tcp(enum server_type type, uint16_t port)
 {
 	struct server *server;
 
@@ -361,7 +361,7 @@ struct server *server_open_tcp(enum server_type type)
 	server->type = type;
 	server->id = 0x43;
 
-	server->fd = open_tcp();
+	server->fd = open_tcp(port);
 	if (server->fd < 0) {
 		free(server);
 		return NULL;
diff --git a/emulator/server.h b/emulator/server.h
index 294e86525..7d6b7be74 100644
--- a/emulator/server.h
+++ b/emulator/server.h
@@ -22,5 +22,5 @@ enum server_type {
 struct server;
 
 struct server *server_open_unix(enum server_type type, const char *path);
-struct server *server_open_tcp(enum server_type type);
+struct server *server_open_tcp(enum server_type type, uint16_t port);
 void server_close(struct server *server);
-- 
2.49.0

