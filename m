Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E804CA27A
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689070; cv=pass; b=evwb+1aX3Vkq+p0JuuHr87nwukV2KcMsKgMm6iR9u+Dgd7ZNEaR9mh3aDTmI/jO7HNlz1H8ZMLoNQyS8J3VcOdb+UTbcSFPSEs9fPwxgPIc6B6cmo4p28VtkwPLqFw/v//7skMAyPYnZT+jJNHd2o6PbhppYkE3EAsa1juOlsUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689070; c=relaxed/simple;
	bh=GzAYFxdCH2APdD75QtDkRLnH884a48UbqIGbkida5ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq+Ns9IwiRJMAMQtAhBCZKeDxf6fSr9NTnLQuVJna+wpNP1BKAleWUd6R4OKN12yD4x7+8mY89+nRSTI9t5F1nGxgcqyfwELPn2dyjQzEkz5tc/NoDy+Gx22jua/JlR2AtbgGP3b+9y0k3iWBce8+JPx+US4uvqkQXfs4zXAU88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=jvYzTcA4; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="jvYzTcA4"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzBp5Fc2z10SX;
	Wed, 13 May 2026 19:17:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jy0ZLgE8Y5qs3gMXFGVeSzllIVq9giLMPUJSld+Ltpg=;
	b=jvYzTcA4BpqHs7KOqEdIdUYLnQ4p1tp0cx1DB55N0ZV9vJ2wixjqQUnnRWPIUg+WIglO4O
	8Z1RpLFGKk7bCTf4SKt7VWQeCEtiuDizs1wTYiAOP+Jatq6ckJ4OzvzCC9hSFPXXn5id7U
	w0IeT2I3vrWoo0qgi4LnOy3NG05GaDc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689058;
	b=LGsJzvF42v0Wg8jgWxwe20mtd5EokNCsAWWh0VtuPM+BEYB19eWDIgIsOq12q3EQzngIHN
	kYN6t0sAjc2kTp1Cga0sK333rxtN55PflRJVw37abN1s/kweiRmvqA1LWjcgNOIG1WDo8A
	O9y6ZYh6EKbP8uF0FF00bUxGIv1gI5M=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jy0ZLgE8Y5qs3gMXFGVeSzllIVq9giLMPUJSld+Ltpg=;
	b=FdEJo77zmVE/Hjj696cB7D47EnMoR2rrjEQWXKthRT3FVwvPQKQN+z0197NReKOGZL9KTS
	+n/GG89v6PozR4Fu9yy2uqsHrql1JBtTJWhqDRk3wJSG41YfM7+2Z008O3jp2jYyPFq4j5
	Rw+afeX6nxI5D6xcHWDhO3LoXWsjLpM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 05/16] test-runner: enable path argument for --unix
Date: Wed, 13 May 2026 19:17:22 +0300
Message-ID: <751a15b60c31fdacb76b73e92fceac72b523c8a2.1778688966.git.pav@iki.fi>
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

Allow specifying the path for the controller socket to be used.
---
 tools/test-runner.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 48b7c1589..331cb6eb1 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -54,6 +54,7 @@ static bool start_monitor = false;
 static bool qemu_host_cpu = false;
 static int num_devs = 0;
 static int num_emulator = 0;
+static const char *device_path = "/tmp/bt-server-bredr";
 static const char *qemu_binary = NULL;
 static const char *kernel_image = NULL;
 static char *audio_server;
@@ -313,11 +314,10 @@ static void start_qemu(void)
 	argv[pos++] = (char *) cmdline;
 
 	for (i = 0; i < num_devs; i++) {
-		const char *path = "/tmp/bt-server-bredr";
 		char *chrdev, *serdev;
 
-		chrdev = alloca(48 + strlen(path));
-		sprintf(chrdev, "socket,path=%s,id=bt%d", path, i);
+		chrdev = alloca(48 + strlen(device_path));
+		sprintf(chrdev, "socket,path=%s,id=bt%d", device_path, i);
 
 		serdev = alloca(48);
 		sprintf(serdev, "pci-serial,chardev=bt%d", i);
@@ -1198,7 +1198,7 @@ static void usage(void)
 		"\t-m, --monitor          Start btmon\n"
 		"\t-l, --emulator[=num]   Start btvirt\n"
 		"\t-A, --audio[=path]     Start audio server\n"
-		"\t-u, --unix [path]      Provide serial device\n"
+		"\t-u, --unix[=path]      Provide serial device\n"
 		"\t-U, --usb [qemu_args]  Provide USB device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
@@ -1211,7 +1211,7 @@ static const struct option main_options[] = {
 	{ "auto",    no_argument,       NULL, 'a' },
 	{ "dbus",    no_argument,       NULL, 'b' },
 	{ "dbus-session", no_argument,  NULL, 's' },
-	{ "unix",    no_argument,       NULL, 'u' },
+	{ "unix",    optional_argument, NULL, 'u' },
 	{ "daemon",  no_argument,       NULL, 'd' },
 	{ "emulator", no_argument,      NULL, 'l' },
 	{ "monitor", no_argument,       NULL, 'm' },
@@ -1239,7 +1239,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "aubdsl::mq:Hk:A::U:vh",
+		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -1250,6 +1250,8 @@ int main(int argc, char *argv[])
 			break;
 		case 'u':
 			num_devs = 1;
+			if (optarg)
+				device_path = optarg;
 			break;
 		case 'b':
 			start_dbus = true;
-- 
2.54.0

