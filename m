Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D234678C
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392819; cv=pass; b=JkWFB5hUDgdDJ24sZma7G/4orOLBAINp2NAupgM38IHOG17iDYRxfJBqeYXT2wE5RcwdiPwcG9F4SbgtgNqxU5RQ3vpSjzoyeBxyhmVugsmUYT7J/XbdamftWi1C8Ka/mwgeNb9HzJesIHYf4ol7AZsN25FV+x62l1CmxIPF0VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392819; c=relaxed/simple;
	bh=/4hlxYOcBRVe8vRTjE174hY+Kp1pwzCeyKjKJYUkL60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fL/OVIIDhH3Xm+i0GGLT02e/rOgZJ74AtgO63Eq8UhPYSRUu7JVwlmJ89eGqNL6tqTmlHpyB1G8TEWZTVr8PjU+OXgrN5BMBDiVi27ZqVm/BqnJIpPyheDTimXLoXTlbm20GqnDSb7n5k2RaZyZMP0k+9pRmZS3NNUWlb5MJX/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=uUmkcIcE; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="uUmkcIcE"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpX9Q47b7z1054;
	Sun, 05 Apr 2026 15:40:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSkUbT92t9xFXhTpserl6v3U3SPk7FQtUIAypVA1wuQ=;
	b=uUmkcIcEKHt6+ra5FhZsx2f9aDJSozOX++2jHqLDc4OGNAkN6SmFa3HHsUcV83BLZE/4jE
	vbfeecDTMAQN1PQDIjabB652k2PvOfub3udF1Kg0Uhupt8v0ccjZNX+P59VkNJNFLU/gIK
	QYiD+4kXCSJ889E6elUk/i2+CtgCn6A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSkUbT92t9xFXhTpserl6v3U3SPk7FQtUIAypVA1wuQ=;
	b=Um9gUMkNoYB6+QQbMk3t64/IZ2wCf+1gIC7UPulUzF83X8Kb0dgN5aHk1//NEQ0X32QDNw
	UxJJKBgkh2Zplm33IMjNap5jGL3SI3TmLTUedznKxv0hdOHzdvP+Lz0MiQ2Ytx5XEknz8b
	ODYvE4YfdqpGbhHO+MCXrzKjGG1k9xU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392810;
	b=G6ozN/SorVTKAtdVGLkAcagphJrwksn+ot8cumwkpQMx2FvKQHx8J7a3Fv/j2kIA5xF5DN
	SiXDMPpZkd+9547Uh39yfmd7PdIvtt6vC4G9X8DsZvXpW5Fn5Inn5QfUuwmsJjtBGHgQFR
	jxgmR2mIItgGqIoGYXJQiW0ozlsUVic=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 09/20] test-runner: use virtio-serial for implementing -u device forwarding
Date: Sun,  5 Apr 2026 15:39:50 +0300
Message-ID: <a2a31a601fb941d905b96a21cc39dc3412a04040.1775392680.git.pav@iki.fi>
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
2.53.0

