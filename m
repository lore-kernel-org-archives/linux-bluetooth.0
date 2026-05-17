Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C82C3271
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779051103; cv=pass; b=o5ghLrCdAjQ8+s0nWSRPSozkI15YtpQNZGSlZRkxwhBpfEvZ77C/YSRLMDXELELfq0jsR1JPdbpqO+IODflagYMTtaXiDPCgn1yc1BxYSr5XVFhOa80mx97RPEzzghT4Iynt3XoXtzCMzEqCJjqFxuKBxirtHQMmqjtTAPmjsjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779051103; c=relaxed/simple;
	bh=rGuO3SH7LFlSuhEqFmmMtVGX22qCjw63HEOQO2BM4dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpGM5caoB93pEN2GYrDGUvFcseIw3EgBRUevge2PK1qiNY6NV9JzT31zqEQnooK5v1h+Inu95pq0zjhU6kd1mb8K/lak6mIaClrGUZ1EPOxwLs+GSWsQ2fGEkS8EVyIvaZEZD18Z16A+vk64VL0V/kbbH0x9QSHIMyG8dXC5t4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=h7e6B9Rr; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="h7e6B9Rr"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gJY510nPBzyTs;
	Sun, 17 May 2026 23:51:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1779051093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YbjlEo8QJ+W0p4r9cUhjHid6h5zicNeglZTeevcFxJY=;
	b=h7e6B9RrlGlX9+I8nx3r2yZAzOuroKZLxVfnSNSZL32ceg9khjEctMY8CtTedpEU8i5P2T
	eP2ZlAgGItUQs/s+HXXyBq1w8Y5KIJR9+a3fMgpy0XXX+FqTT5+WjYVh1DUFrPA++MNHel
	Ok/KsZaYT3b/GCPPpX0oqoQrn0jYvpY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1779051093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YbjlEo8QJ+W0p4r9cUhjHid6h5zicNeglZTeevcFxJY=;
	b=RG8sfzxBqaHr06KJ/puPg7/Tu6JSzcvb0pNT+iYJSD6ipLUuVKydzuHixaFvODqZweGzLU
	uFcmxSbZg2Zahv/57AJaS0w2vqHnJtd3cvpGOKMlQHpuSVxFoMnA0KntVdXrXTn7LjzTTB
	FjMjXvB3R5lx8n9oc1xYzThe+oetu2o=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1779051093;
	b=VPQUhzdLBsEWva8LavNcTYoB64rm/r9d6wYHR0gCObT4bDKycdbLKiZ0iFXjyxu7t6mSrV
	Hkx17xUTo0mEPKg00zDhMYT0MyUsdnTxyTkFytmeefMnGu5yeg0gjY8yEcI3tZq0pYLbhB
	nEstVktQ8m1pSguLqZu9iHTxGecjbMM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] tester.config: add missing CRYPTO_AES
Date: Sun, 17 May 2026 23:51:30 +0300
Message-ID: <478a4d370bc0b20b98223507166dfd580ae8477d.1779051031.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel commit 4a1507625b0 ("Bluetooth: SMP: Use AES-CMAC library
API") removed CRYPTO_AES from the default Bluetooth kernel config.

This causes Bluetooth testbots to fail silently with "Not Run" status:

Basic Framework - Success - init
  Read Index List callback
    Status: 0x00
Bluetooth: hci0: Opcode 0x0c03 failed: -110
Bluetooth: hci0: Opcode 0x0c03 failed: -110
  hciemu: Failed to open vhci
  Failed to setup HCI emulation
Basic Framework - Success - pre setup failed
Basic Framework - Success - done
...
SCO CVSD Listen Send - Success                       Not Run
Total: 30, Passed: 0 (0.0%), Failed: 0, Not Run: 30

Fix by explicitly requiring CRYPTO_AES.
---

Notes:
    See any recent CI test log from
    
    https://github.com/bluez/bluetooth-next/pulls
    
    for example
    
    https://github.com/bluez/bluetooth-next/commit/84ebde6f819c06cc1d804a471d9fb60b7986e190/checks/76408920221/logs
    
    https://github.com/bluez/bluetooth-next/commit/82f0e0c7d08eb21d0579471a3b5c004cf95dda08/checks/75862464065/logs

 doc/ci.config       | 1 +
 doc/test-runner.rst | 1 +
 doc/tester.config   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/doc/ci.config b/doc/ci.config
index bb3cb221f..2da3e14c4 100644
--- a/doc/ci.config
+++ b/doc/ci.config
@@ -112,6 +112,7 @@ CONFIG_BT_QCOMSMD=y
 
 CONFIG_BT_VIRTIO=y
 
+CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_CMAC=y
 CONFIG_CRYPTO_USER_API=y
 CONFIG_CRYPTO_USER_API_HASH=y
diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 60f18683c..ff2420ea8 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -84,6 +84,7 @@ Bluetooth
 	CONFIG_BT_HCIUART_H4=y
 	CONFIG_BT_HCIVHCI=y
 
+	CONFIG_CRYPTO_AES=y
 	CONFIG_CRYPTO_CMAC=y
 	CONFIG_CRYPTO_USER_API=y
 	CONFIG_CRYPTO_USER_API_HASH=y
diff --git a/doc/tester.config b/doc/tester.config
index 0cf5e2723..b9c5f34bc 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -43,6 +43,7 @@ CONFIG_BT_MSFTEXT=y
 CONFIG_BT_AOSPEXT=y
 CONFIG_BT_FEATURE_DEBUG=y
 
+CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_CMAC=y
 CONFIG_CRYPTO_USER_API=y
 CONFIG_CRYPTO_USER_API_HASH=y
-- 
2.54.0

