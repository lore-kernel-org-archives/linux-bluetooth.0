Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF02820DA
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671263; cv=none; b=eO+UhW9vTmlipu+inM3eYkDYgobtaA2sItovYmfeh4GQYd5zcVv176eCVqnSzaHHFcGOaj4cbVXHAc8w8qQ3PbCjlKC3Bw0SKcS3MaMamvCJsvao4lebM1MnaKaraNUpfSZ9aD5tXqnpyys313otqiulsJtG/iX1GbbPLVaCjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671263; c=relaxed/simple;
	bh=n8W3WEj4GtecX92VcOaLzYBlNm80gxDAS2h3xrgkj5c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5UqMU7pGPKpi+chG+iOgsLtf+9RVRb7owX0gjbiu39Y89JRuFUdTaxov6RT/ypsRouuPnnyRk4EluJzsEYZrprL7BzejkyvJuS0Xsap1QD8bWBIBEbZjicFWg8vVA1TLO5wRMGSwel+Eyw4Uh3EiZLYbDi8A/FNZLJFBatMUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hWvlKYX+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hWvlKYX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747671259;
	bh=n8W3WEj4GtecX92VcOaLzYBlNm80gxDAS2h3xrgkj5c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hWvlKYX+0epUHTTYpwR8CZRdkWs9QG886khFPE5ywQeTTWJU+FmAH1ImFx6ms+42+
	 eC08ChH5cBjgtA4gmO+EL/qopew2HHhuerwjPcGs9AuMoJK+mWk2iqTfbzSXztprXg
	 HVl31X/WNhaiJlkxUFTp8gr60eAwwcRiJB/AXH91K5BkD7gW7aAUDzUhXrDRaHxtcu
	 zkTjIsXbeJ98ux2pn1LxrhO2sWWB/+hNvxLNF+1AKQZz4M5WX+ArUyL335E6EDhaSs
	 BWmO0oMx9+lxN/JQpx3AZjVgeasShpfV+NxVKVuyn9XeNB4DVBYuySnjJ+rfuHj34K
	 GnIkMUKMtGt/g==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-131b-51fE-028d-5689.rev.sfr.net [IPv6:2a02:8428:af44:1001:131b:51fe:28d:5689])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3A90017E0FD4
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 18:14:19 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] doc/device: Add Disconnected signal
Date: Mon, 19 May 2025 18:14:11 +0200
Message-ID: <20250519161412.107904-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519161412.107904-1-frederic.danis@collabora.com>
References: <20250519161412.107904-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 doc/org.bluez.Device.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 80501eddd..6229f95ad 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -155,6 +155,23 @@ array{array{byte}} GetServiceRecords() [experimental]
 	:org.bluez.Error.NotConnected:
 	:org.bluez.Error.DoesNotExist:
 
+Signals
+-------
+
+void Disconnected(string reason)
+````````````````````````````````
+
+	This signal is launched when a device is disconnected with the reason of
+	the disconnection.
+
+	Possible reasons:
+
+	:disconnection-unknown:
+	:disconnection-timeout:
+	:disconnection-local-host:
+	:disconnection-remote:
+	:disconnection-local-suspend:
+
 Properties
 ----------
 
-- 
2.43.0

