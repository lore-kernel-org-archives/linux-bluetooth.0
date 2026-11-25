Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622426;
	b=FX88RdEia48b30Qrf+P5IatoSU73qxsTCOl3G1IwwGyPef8qfGWnyxXcAuHl5AOpvadE
	 zKf0vjNM9rgElNYcF2sbOyMG0D6kpJ1Avv9+upX8B8mTBvLh/bYEhKBXAXGtbJqkE+UMm
	 N5CN1CYAvFXjXYBcyEExO+apXsAOgaMl6TZEeDygXo6QlmLTMg9ekTSjnSkZ0OlKDO37l
	 eOz+qZ1BfhvbvQra2BK7IRYJeUWJjzrLEMWtTUbndd7g+MwSElWNg+sg+P/alHmhmSbgC
	 pEBPKIVUYpH0ZNECXwKbaAYgQTdbB9ccqQiCeThxmg7Ge4kJI5HkxghoGamx5JAEVnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622426;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z8CPHifgbrYj6tkLh25010bVskSYe89pgAlLXtXCMcA=;
	b=IAvHyizINr/sFXZ4+krtMnkuoygz6s4zJvfeT+YSkuidBOrHeZlNvEFpwGy5/wsakgzp
	 dnMmJBffGFOshsyOocV8zE4IJIJdCOQnV1R8sJdVOCpO9pgubgNA8aatB7KECPg4h9HJm
	 AZLwBJPlUC9NuMIulPyMVuXMWrYgExnO29k/SSUur2OxBPBAVwYYijGIBScQ1j9B4N+QD
	 L8lVmJOesX5RHqi12uHCONX37AeVHo/050bVCeuhWxZFRYtDCEGDDNl6MXZWiCJQZ5CYo
	 BOoFclQrgo/RyTU+RKGc3GdzoRTDs01u2NRe2RBY11maWCoy5Gbwh51nqpsOB4xY+fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=iq8DlxbP;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769D606A32D
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9769D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=iq8DlxbP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795622424;
	bh=NmHlHxD6ZkScGBBB3+zgEJW6bIgZ9it26kku/JG79hc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iq8DlxbPEVl2id5Pp6evXS37mJIa/ymGioEOnwqDMqc7B2g5RODw3VQmLFiVsZkl7
	 g2s3nFiacY28oGReC6Q1TshhBqaQDhzjGO7Ny0NPQ6agPI/S6+h2UyvMGAfzplEgA+
	 uUxNOYR85mUDjkFVpfiXT1ot2gazd3r8sV9Xn0Kf7E+kqr2dXaWuq24kN7ygfxQpD9
	 31wPkiYsJLKfEXAz8nVNAk5NhhrYfAhKFHiP6aKivD947vq66fyASbXq6L7khLuHEU
	 7NoD55uOURn7R4tGMhYTcMWFOT+nRs3smTznxxnxLz/u7999Y4bzTxztgRamgRUdXM
	 Pf2xQqD1xydQg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1A08017E1031
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:00:24 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 2/3] org.bluez.Device: Make Security Level props optional
Date: Wed, 25 Nov 2026 17:00:17 +0100
Message-ID: <20261125160018.590013-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125160018.590013-1-frederic.danis@collabora.com>
References: <20261125160018.590013-1-frederic.danis@collabora.com>
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

