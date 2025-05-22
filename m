Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E26628A402
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928994; cv=none; b=UOcimxVBgWk6ePHmKyJmdKhRmfNrwV1vCwN+sWl9cEAFv5RmrTccuAMBwEIuahaYZVmw8zXXcptZQZXNbu5w4Ki7q2j825ZEqmpluvvjeGr/hbO7hS5Had5+fMv6Z3eihjBhGr506CzjeMaugWE1hs8LYJwbkll+L77BfYocNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928994; c=relaxed/simple;
	bh=vVPxUDfLT+zq80E6y7maiE1cuSQVEa2zPhJsfchN3yo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxOQBiSCXahY804Q0VjAw/CdaUkmdVcm72MxX4TC9yGrRRsyRJ/r8mfmL6xssFdpclJsqh0x6eyh5DfadLYCmFQkhKiz4sHqqduNynyMPOyuUtpBxi+ALNd34XMnwOQDDfZH1e+ezQoOaGwFFN3AcRiCUWVQj57BDBb8H0InoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fBVYvMs8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fBVYvMs8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747928990;
	bh=vVPxUDfLT+zq80E6y7maiE1cuSQVEa2zPhJsfchN3yo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fBVYvMs8bbuIb934TKFAB5Nn1QoZ//gmxrz7GwOArEpi/SHPVusFvAycvg+xcZgAG
	 CIP1/3fLhmOy99d3KxnFFSiX6egrnvSFd6p7Ybq3at8AsQNnn0ZOhUMbpmLZtS4VDt
	 EOBAVBHT4HMNQrIRi/QB3SXaR57mFCT3O7J+/wHbZzzyp2PnYDVkivmJW4VIOjdd06
	 9YLJ0iV7ExS84zIAorukt4Sy07GdEhVJw91NEpkCnyPE/SenRkN0Q/c1ydNBA6bNRl
	 zr7LXFTaq3Ii+xBTnUYYgOQfFuIOwxLQZEvFWaIREilalDjo9OybQ65+BkHw+rNJ4/
	 1P9J2mqDknnDw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-c115-20FF-2911-21D4.rev.sfr.net [IPv6:2a02:8428:af44:1001:c115:20ff:2911:21d4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9B18117E1595
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 17:49:50 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/3] doc/device: Add Disconnected signal
Date: Thu, 22 May 2025 17:49:43 +0200
Message-ID: <20250522154944.665655-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522154944.665655-1-frederic.danis@collabora.com>
References: <20250522154944.665655-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
v1->v2: Replace text reason by numerical reason
	Improve documentation
v2->v3: Replace numerical reason by name and message

 doc/org.bluez.Device.rst | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 205f65761..39e51f79c 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -155,6 +155,47 @@ array{array{byte}} GetServiceRecords() [experimental]
 	:org.bluez.Error.NotConnected:
 	:org.bluez.Error.DoesNotExist:
 
+Signals
+-------
+
+void Disconnected(string name, string message)
+``````````````````````````````````````````````
+
+	This signal is launched when a device is disconnected, with the reason of
+	the disconnection.
+
+	This could be used by client application, depending on internal policy, to
+	try to reconnect to the device in case of timeout or unknown disconnection,
+	or to try to connect to another device.
+
+	Possible reasons:
+
+	:org.bluez.Reason.Unknown:
+
+	:org.bluez.Reason.Timeout:
+
+		The link supervision timeout has expired for a connection or the
+		synchronization timeout has expired for a broadcast.
+
+	:org.bluez.Reason.Local:
+
+		The local device terminated the connection, terminated synchronization
+		with a broadcaster, or terminated broadcasting packets.
+
+	:org.bluez.Reason.Remote:
+
+		This disconnection can be due to:
+			- the user on the remote device either terminated the connection
+			  or stopped broadcasting packets,
+			- the remote device terminated the connection because of low
+			  resources,
+			- the remote device terminated the connection because the device
+			  is about to power off.
+
+	:org.bluez.Reason.Authentication:
+
+	:org.bluez.Reason.LocalSuspend:
+
 Properties
 ----------
 
-- 
2.43.0

