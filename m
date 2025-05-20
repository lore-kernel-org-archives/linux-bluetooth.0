Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76467258CD6
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758391; cv=none; b=hdjLnjK8vTCU1853vvGtYSj07sW2BBHx871pPkvrGEbWA0EU0xOSWnk8NbFkeOnRIwjOog12JKh6TV9Nkvfb/qroZphlTfgh6jWS5WQASQ1xrf5NF2MeRktsF81hY7iDhA1LLtWwT4zLjPPOy6ZT1rMICLA9kkrfa1/JuMjusdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758391; c=relaxed/simple;
	bh=BatNll1pKlLXzjH3MgMv7QhUCtLBjNuCalR9JC29lRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnQtFtV0Ehv5c8xB9dpSkY/9iGL8TkU6GuXZfo+Eh/xpYCXmpRsuZdGfU9uI3zhAYI7X19xKZy57OT6yTH+EQ7+bWZx7KYqMGBkdzIfZIW9/lTUbY///ix4Y0lg6iXsUXhmMGezRTasCvH1TEbeT2I2XWttx1In8ah2s+XCafok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VHZhtlo+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VHZhtlo+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747758387;
	bh=BatNll1pKlLXzjH3MgMv7QhUCtLBjNuCalR9JC29lRY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VHZhtlo+GC6whPj5yGmbSuk3Fm7E0ixT1vaAVDUoab2Ce7aM9W2Sy60rQ/tes3cce
	 Xy2d+Q5LEJdkCWqaFKgBpAjg+YzbWg2x124AsRnrHVzy2RSBDsoX8Np4IfsYtBWUEM
	 rMeuX0O3dMt/oBY4Ug0q8DH2FQc60BktLso9ylmyOC+/9rNRSrvzmkakVJ9PwfeEkX
	 XArCKLbhhIVJfGnrj4OeRbU82A/DB34MTozoHKdNU0HbMNGajn25jcyXEvPdyZZ4pI
	 3u6r8QXvwllmdB/Y6CyJdax4uX5Dqjx0kE3AY+4nEF5p3bOcK6Oo1nYUwwn1x8e8wY
	 KNSyLqElL4Xdw==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-AF44-1001-66a1-C560-f4d8-070F.rev.sfr.net [IPv6:2a02:8428:af44:1001:66a1:c560:f4d8:70f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 739F217E156C
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 18:26:27 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] doc/device: Add Disconnected signal
Date: Tue, 20 May 2025 18:26:20 +0200
Message-ID: <20250520162621.190769-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520162621.190769-1-frederic.danis@collabora.com>
References: <20250520162621.190769-1-frederic.danis@collabora.com>
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

 doc/org.bluez.Device.rst | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 80501eddd..771b7613f 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -155,6 +155,53 @@ array{array{byte}} GetServiceRecords() [experimental]
 	:org.bluez.Error.NotConnected:
 	:org.bluez.Error.DoesNotExist:
 
+Signals
+-------
+
+void Disconnected(byte reason)
+````````````````````````````````
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
+	:0:
+		Unknown.
+
+	:1:
+		Timeout.
+
+		The link supervision timeout has expired for a connection or the
+		synchronization timeout has expired for a broadcast.
+
+	:2:
+		Disconnected from local host.
+
+		The local device terminated the connection, terminated synchronization
+		with a broadcaster, or terminated broadcasting packets.
+
+	:3:
+		Disconnected from remote.
+
+		This disconnection can be due to:
+			- the user on the remote device either terminated the connection
+			  or stopped broadcasting packets,
+			- the remote device terminated the connection because of low
+			  resources,
+			- the remote device terminated the connection because the device
+			  is about to power off.
+
+	:4:
+		Authentication failure.
+
+	:5:
+		Local host suspend.
+
 Properties
 ----------
 
-- 
2.43.0

