Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE828F3
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715423541; cv=pass; b=OcexJhv6yGmKr2vLYEyEwH1Ee3jN1O48K7MlClDqZiqF4gAhcOQ69xaQDrI7mD/VIxqH4zZa/5PJSWVzF/V+x4VA7Dt6egInNBANJxh01GU/hBuB0FTz9iUFgKb23fln/9Yzc5NrvG7FYqxgDorAl33Aks1tZFAYCcb/cTu3I/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715423541; c=relaxed/simple;
	bh=sMt8NM5nEqliNvsbMWL46LiVtqHsXYRxFt/gfA3iv4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=khwSLts5CE1iGGXsnBdNCMFbHya+QAsw1VV7BsrfFFyfUxzMM/WM5QTWI5HtgbsSNRytRKMr1CE3I99cgNDS9Jtu5u2ncXVsISNIHqfWbiRFhOfo5oZvMPaKLtS/UuPf0Skylm5jI3xUgPPxiws3b6BPFUF8bLuneeAUqoO/brg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=BCCfP3aP; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="BCCfP3aP"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Vc2B23c1rz49Pyk;
	Sat, 11 May 2024 13:32:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1715423531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/7gYJWPFx0fCbtvC5ThX3mdv4HB7t7f/ZJMSoiqpPZU=;
	b=BCCfP3aPUgmuguEpxhSaBO5Vpo+uIYYsQrSpkVJuHS2S1nYrfEMs3MqB6Ip+pUjxUt9Sbj
	qyyP8uA6+xFzyyk47shP9AjZq8khOhCGN0q8N2ZCqrFAolnuiMXu2rrjKHzX1+dNSNBDFd
	CWGmT0miug291rmNFQHV54LsMQV/uPKB4X79Ldo4Fa+8EF1DttHvcuoymKyEk/OBSszsHH
	Vnztq6OiasFsLMWQFwek/+no7K/Hfl7taaS/NV4SAz0/Ibx8C24nkXSLh8yHHaQAEy7OvY
	fRgHont5a/8Sau/KhdSFOeNBsH4i69A2dpEfaSYDmisrfNBxgC7oy+OTbI2b5w==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1715423531; a=rsa-sha256;
	cv=none;
	b=V1VE9BHIfD3ulAGT3zwCUg8Blmy4dSn872OQp6v2yfTv3Jj3Inpeh0FccwN+EIoky+n7vc
	hdPGNwjM2hjfCeeDC00Lk7mhCmbArK0e5bwBGLwR86nYA8UBUrY7/ucvZFMLrmiLuSJX2o
	VkBB6Mzuql82z3rZI4gD5julzFZAPr9bYPpAz62gITfncxvCabTB1zuj7J5/aql3FMJ20O
	g+zIrQjJEhn+Xsqgh4bSIYwY0DZmtB+P3CpAPYSQjqc2iCgEofxal4ZKfHHvKrwFdOHmeW
	NLbOJc3gZTrI2kYE8WBtFsun20dTxPpNaMDLXZ8rTCobzsPys/d0EtCvw+1PEA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1715423531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/7gYJWPFx0fCbtvC5ThX3mdv4HB7t7f/ZJMSoiqpPZU=;
	b=GKkxD/rz1D3Hi4sZnP72Ul2VDdF9gYAswpNtNhP+pMqot0TRt/3zFWBxdREq/JGtyGK5RR
	YBg1Gwy9RoVC8kSJ3uLAsL490KZhfN8O2sn4EOqc5VqDvC/cBBTkMFNpz9g2TN0RNHqeZV
	k1gLQ2PMu+FanFODCea9BbnEM/yGPZEUSo31nuV4FpIoQiEJjeuywojDgya00VQRfb4QPk
	tfdrFriFH2kQxPSfcmA3SQTZy2xg9M0UGnxSiLEisdoIE8ysesT3EpHMXW9h0i2oywt+xe
	1JkAXkzldjAxdGJEOANyaa1+W4RGwVCdwclFYGCNewdkZRum2VZGx1r9obf4lA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] tools: fix using too small buffers in test-runner
Date: Sat, 11 May 2024 13:32:07 +0300
Message-ID: <9b7b8130a4296de7e02435d7be3c6d00c4976427.1715423446.git.pav@iki.fi>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compiler warning:

tools/test-runner.c:309:57: error: 'sprintf' may write a terminating nul
  past the end of the destination [-Werror=format-overflow=]
---
 tools/test-runner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 243eab468..5bdcf42fc 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -302,10 +302,10 @@ static void start_qemu(void)
 		const char *path = "/tmp/bt-server-bredr";
 		char *chrdev, *serdev;
 
-		chrdev = alloca(32 + strlen(path));
+		chrdev = alloca(48 + strlen(path));
 		sprintf(chrdev, "socket,path=%s,id=bt%d", path, i);
 
-		serdev = alloca(32);
+		serdev = alloca(48);
 		sprintf(serdev, "pci-serial,chardev=bt%d", i);
 
 		argv[pos++] = "-chardev";
-- 
2.45.0

