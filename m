Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593436;
	b=UVoGVWsG7cw1LCm3K/Sa7vfxyp0SakinYLtlQ2BJilOsxwGJ92ypPe1w87u1fZtSR+GV
	 7Q30L1OLYu8qmqsaeDFmM1jFMdl+5pZr+NrTBX/jGYhs14+8eu8H4gBgC+3EBA51+SHiZ
	 hRii3NjYZ1/AboAtTE0no7ZTJFjzMM2ng/80xfz7A3nK8OABZnv1F8Lft5hWr4lYgJ02U
	 +XBvbem3+bLYbtpEGC4JAMYctr2Luzx/0eE/SO0jpdXSznuKBRLQ/waYYsHxrLJOZx4t+
	 lNRli8wH1NDcWhmXEwKkSIhhu7+ceRAHVsrZPA+UtmE6cDkF380xthsISqCsYTFlWBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593436;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z8CPHifgbrYj6tkLh25010bVskSYe89pgAlLXtXCMcA=;
	b=JhDtHJXeeJeQcmxSQaoRPA6Ai8Tarw6/oOLzwcbQs6+OoISqKA4Tha4LKiHazAA+27q9
	 pcKP/bxp3KSuAouMJjbOeKzmofVTALcPUSNghGIJwdfKRvWAH8oRYuCF8XfX9dq+Lpo6J
	 K2uu2Q1/h/N/hddwN7zAqliU1CsCMjm6z2bmgVhEPmCnMuyv1HZgb7NQmndFcTbISZTYU
	 Esu4+dfqGthet1LKGrbpudVdsJHO5mDtrPsI4LLWbR/BZoP2ZqHHTeIXMcBh2WCOnKPZ9
	 eSZhs4+cAjFc+k6sn611icflIld5i1aB4Rxt3w7n2rj/edmPdiM2zUnMeowaNZq2tVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XNdEApBQ;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C61606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3C61606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XNdEApBQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795593434;
	bh=NmHlHxD6ZkScGBBB3+zgEJW6bIgZ9it26kku/JG79hc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XNdEApBQyBWxrdHahV+3arIncS0/SfCEaP5tGYdia2yQajs7Z7LbXigO2Eu7pkGPv
	 hvsn8uL/E3R84pFGU77xfDEU6ZUXcN+gRYiF7huJ7nBrw000aC03g1Np0p9uLgV5bX
	 5ClOdDSUEAROdlNheWq4a90jqVHTYN+eZ5WTrFxGPnA8RQtNRKGMeh20I23Uv2ZoTP
	 /SSEMFbGVpIhGA22e/adcm70y5w5s4gn/siGRaXDmPiF5OU+P87mYQ8TxAS1j6dRy6
	 TQrDG84xyRl9fr67y3djjmUThRfNE/Z6jVFqD6jdJLYuOxRD/+5GFXGqgis2ERjDBM
	 f2UHtd3eC+ggA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6CB4117E0FB8
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:57:14 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/3] org.bluez.Device: Make Security Level props optional
Date: Wed, 25 Nov 2026 08:57:08 +0100
Message-ID: <20261125075709.459719-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125075709.459719-1-frederic.danis@collabora.com>
References: <20261125075709.459719-1-frederic.danis@collabora.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The SecurityLevel and EncryptionType properties are available only
when kernel supports MGMT_EV_SECURITY_LEVEL_CHANGED events.
---
 doc/org.bluez.Device.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index f3e4bfa4a..6a433024e 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -490,8 +490,8 @@ Examples:
 
 :bluetoothctl: > bearer <dev> [last-seen/bredr/le]
 
-byte SecurityLevel [readonly, experimental]
-```````````````````````````````````````````
+byte SecurityLevel [readonly, optional, experimental]
+`````````````````````````````````````````````````````
 Indicate the Security Level of a connection.
 
 Possible values:
@@ -511,8 +511,8 @@ Possible values:
 :4:
 	FIPS authenticated pairing with encryption
 
-byte EncryptionType [readonly, experimental]
-````````````````````````````````````````````
+byte EncryptionType [readonly, optional, experimental]
+``````````````````````````````````````````````````````
 Indicate the Encryption type in use for a connection.
 
 Possible values:
-- 
2.43.0

