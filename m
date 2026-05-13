Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6B74CA279
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689070; cv=pass; b=hliEBWHJU/1NyH8hvRI+N0BH4dSxwABu84Z2YFuVJEzRMOHuadgi19EDMdQ2z/i5Zp4Aj2KxbMQ/EHMezv6pSqmv/d3aWZ3B684c6qa9elgwS/kPpGMIwUwwzhWuWuiLAZYyAEtXvb3mqA7pHghmN5CvBkF4YeVtsseBsp9JNVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689070; c=relaxed/simple;
	bh=ZZTsQfjbr70DmSnCepEJOmMgM5B6avHmBoVmg+3th+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbL/BD5/UqUR6ZSwJHtPBQi1ykMsag5RC2W3ZDEfc4qInviDnX4H2xqjOgmGS/V+FMhkSrLvLYAXZfBu/CZ9kUw2F77Py0pXb9ZveIMr8Zk4P3p1xjVsQXn4LlJf+ys9BQL6yCZaI1pb2rXd0qfD0CrHQJGDY0JS38/SRMiK+YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qKNOjJTr; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qKNOjJTr"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzBq55ypzyZB;
	Wed, 13 May 2026 19:17:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HqNlGy1bcubGN7AMATeQllUyvR56fuKIywKzhPJYQE=;
	b=qKNOjJTr+Xay5XjCeOBcG13hp6A2AW8oilM40sMPHclBkDxJOVzzP9+K81NHgpI82woMM5
	4EduV9+cuWLWePZ59Z7C7vIYWHpxA2MQdMQB60nU3vLLNca8hedbcvAzkRL2fhaDsE9jqC
	IQ/KyS8TjpEsxZGkkFWZZXbwx8DHxeg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689059;
	b=GelYbB03AxIPLn80rYMK6KBaUmplFGopuYs7+0lM/7KoDh6YcuGObxL1SypCpgy3xhM351
	5GutsdcgZYb2DewCl+llQKVRdHbhKRi9noPMXKyQdScuFSFotHovKVH9/rcCrJTpaslF0E
	ngdZ3Zbn/HdPHIKYg7NKtHxBWJPjwf0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HqNlGy1bcubGN7AMATeQllUyvR56fuKIywKzhPJYQE=;
	b=TuXceCTV7Uhn0XcRL2at3bA5Y2AzLcvPRarkaAocR2VhAAxpNLzMK4De28RQxwrA9Q5wla
	c8ZXmfN66vBR1JXcwmvH8CoX5Q6d9FATLTj1O2PUlgEcbG2hgJrXzNjAxfREm2owQ33goA
	He4G9sZ31QRbOsVJHUUqH8pmVB/Kpmg=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 08/16] test-runner: use virtio-serial for implementing -u device forwarding
Date: Wed, 13 May 2026 19:17:25 +0300
Message-ID: <5d818c768189b6d0a8e5a4b90eb41cc7b9932624.1778688966.git.pav@iki.fi>
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

Using pci-serial to forward eg. btvirt sockets is unreliable, as qemu or
kernel seems to be sometimes dropping part of the sent data or insert
spurious \0 bytes, leading to sporadic errors like:

    kernel: Bluetooth: hci0: command 0x0c52 tx timeout
    kernel: Bluetooth: hci0: Opcode 0x0c52 failed: -110
    btvirt: packet error, unknown type: 0

This appears to occur most often when host system is under load, e.g.
due to multiple test-runners running at the same time.  The problem is
not specific to btvirt, but seems to be in the qemu serial device layer
vs. kernel interaction.

Change test-runner to use virtserialport to forward the btvirt
connection inside the VM, as virtio-serial doesn't appear to have these
problems.
---
 tools/test-runner.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index b3e0b0cfe..0e3bfb8b7 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -306,7 +306,7 @@ static void start_qemu(void)
 				testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
-			(sizeof(char *) * (6 + (num_devs * 4))) +
+			(sizeof(char *) * (8 + (num_devs * 4))) +
 			(sizeof(char *) * (usb_dev ? 4 : 0)) +
 			(sizeof(char *) * num_extra_opts));
 	memcpy(argv, qemu_argv, sizeof(qemu_argv));
@@ -330,14 +330,19 @@ static void start_qemu(void)
 	argv[pos++] = "-append";
 	argv[pos++] = (char *) cmdline;
 
+	if (num_devs) {
+		argv[pos++] = "-device";
+		argv[pos++] = "virtio-serial";
+	}
+
 	for (i = 0; i < num_devs; i++) {
 		char *chrdev, *serdev;
 
 		chrdev = alloca(48 + strlen(device_path));
 		sprintf(chrdev, "socket,path=%s,id=bt%d", device_path, i);
 
-		serdev = alloca(48);
-		sprintf(serdev, "pci-serial,chardev=bt%d", i);
+		serdev = alloca(64);
+		sprintf(serdev, "virtconsole,chardev=bt%d,name=bt.%d", i, i);
 
 		argv[pos++] = "-chardev";
 		argv[pos++] = chrdev;
@@ -910,7 +915,7 @@ static void run_command(char *cmdname, char *home)
 	}
 
 	if (num_devs) {
-		const char *node = "/dev/ttyS1";
+		const char *node = "/dev/hvc0";
 		unsigned int basic_flags, extra_flags;
 
 		printf("Attaching BR/EDR controller to %s\n", node);
-- 
2.54.0

