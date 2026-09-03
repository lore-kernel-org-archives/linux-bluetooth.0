Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF3368D47
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472245; cv=pass; b=KvZ5jkfxr6PAxaAEKky2x718WAVQUmXdD/hBMsSDdZoq2kExCm9WaZ5b36V3sx4y0CwgKoe9g+jr/K6GoThGdlw3wLqyEgSFNjl5vdNqGA4iKQ0PcF7xjmeNJIg1aaTixjVJiVfIPzp9eKqKdclhB+sypKgjaVd7qIojDVGjGl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472245; c=relaxed/simple;
	bh=RRzqdnjxC56kk6bzaNLnL5uvwkXB7iaxIhBq/1yYrZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wk9B9J2Fx5QvN1xvOGsPL5gxehfb2BvRg2SDM1Bln1R5tBtyhCjzOhzI4RnoQdidj2Fo3GiuRok3t4Jah7Brsed455lNX8ShsquYXMx6VLvbgQfqVoHMrh4bZ7IPRY002jXSJ9kcE2VrfuyW35+b1UqT0GLGbQwEY8WAQcidoZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dsXR2GPy; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dsXR2GPy"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hbYDq6061zyQZ;
	Fri, 04 Sep 2026 00:50:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788472236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LRek2QpO/WhMxhLwLhubMJHpDDMM77FOhzRpXn973Vs=;
	b=dsXR2GPySIezAxADcOhy5pfDRobSwjTiEBLbJPnH01iY5waBoMI/abtD10FmHTYwugc5TS
	4G0seJZhU6CGM7eIjS7GvabmJ00LjMeQlprItiDLdwRLWanYWUIeTH84YqMuAy0n+/xPH8
	57eCKVSNgKG3NTBYsmz+icMNbAkUC5s=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788472236;
	b=OCRuF7zYmuf2aHgbSiIA3Qt7G+DJtx8fLJdGGNzpZZY73aprW/O/AM2CfLyu3dSusukUx0
	kzbKfoYGhsElhVyNu9mQaHyOXUt5AXVejQiarXg9TPlymmTAJZ4O18qp8XSKILqHA5lUCW
	byjYWJoClYaW2a0PBQbLtkPIntJffXc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788472236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LRek2QpO/WhMxhLwLhubMJHpDDMM77FOhzRpXn973Vs=;
	b=tHFpAasxPWV/AYFYur9uMSpIQ6sS0K8te62RjoMzx/e3q2KToPe4pXV63FgifHiwbRcKYF
	kPm4hAuvBJnLJv14aeIjg4ZDFgUhSiu4O6Yj3hpH7/fT7wuG6A4dCsNmIXW/msOm2wgxVR
	c+vwzl+JLGq2O/q7sN5clnX4bBmIBUg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] adapter: clear discovery_found list before discovery_cleanup()
Date: Fri,  4 Sep 2026 00:50:33 +0300
Message-ID: <3a496bd2c05e7e7f9f8285d155837208485b7a0b.1788471489.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

discovery_cleanup() tries to reset RSSI of devices in
adapter->discovery_found list.  When called from adapter_remove(), the
list contains only stale pointers as devices have been already freed,
leading to UAF.

Fix by freeing the discovery_found list in adapter_remove().

Fixes AddressSanitizer: heap-use-after-free
READ of size 1 at 0x7d5b585e033d thread T0
    #0 0x000000772b1a in device_set_rssi_with_delta src/device.c:7121
    #1 0x000000772daa in device_set_rssi src/device.c:7150
    #2 0x0000006aa808 in invalidate_rssi_and_tx_power src/adapter.c:1732
    #3 0x7feb5a35557f in g_slist_foreach (/lib64/libglib-2.0.so.0+0x6257f)
    #4 0x7feb5a355b56 in g_slist_free_full (/lib64/libglib-2.0.so.0+0x62b56)
    #5 0x0000006f67d2 in discovery_cleanup src/adapter.c:1747
    #6 0x0000006f904f in adapter_remove src/adapter.c:7219
    #7 0x0000006f9de2 in adapter_cleanup src/adapter.c:11165
    #8 0x000000418ca9 in main src/main.c:1719

freed by thread T0 here:
    #0 0x7feb5a5434cf in free.part.0 (/lib64/libasan.so.8+0xee4cf)
    #1 0x7feb5a337bb4 in g_free (/lib64/libglib-2.0.so.0+0x44bb4)
    #2 0x0000007519d7 in device_free src/device.c:963

previously allocated by thread T0 here:
    #0 0x7feb5a54424f in calloc (/lib64/libasan.so.8+0xef24f)
    #1 0x000000751fee in device_new src/device.c:4963
---
 src/adapter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 7390ceeee..d6eaa814b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7216,6 +7216,9 @@ static void adapter_remove(struct btd_adapter *adapter)
 	g_slist_free(adapter->devices);
 	adapter->devices = NULL;
 
+	g_slist_free(adapter->discovery_found);
+	adapter->discovery_found = NULL;
+
 	discovery_cleanup(adapter, 0);
 
 	unload_drivers(adapter);
-- 
2.55.0

