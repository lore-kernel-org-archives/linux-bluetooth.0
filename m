Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447885;
	b=lH1HgQA6jAtOxRH/cZocUmlT3Zv2d8w6fz9cvO92JDepLuhs/oQkSJLNrAR8UNDhmnBa
	 V5LeeA3sqi1R3H/QUnxcyRpd2yE3qDL7BDNaL8p0T7IFTUg6jekLwKyoHbiMwJaiuLMbL
	 bH+jRHlxKEA1mzVEuZ2lH4dqyfEXh78BK4dyx37PB7yl4l27oAmwFE2Lp7J4f9DUkEqQZ
	 4bfCEEX5nHuy9TG5DTdcCeHK/gtcqn1IMmSQeLQkhp/S5IFaviDfZdM9Eugxw83ivTVKR
	 CYe9BWGKlhFtyZl9weW7JMHxGyb/hgqlYC9195BO5wQvMRO68aKg3/uL6/aaKhdHnjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447885;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z8CPHifgbrYj6tkLh25010bVskSYe89pgAlLXtXCMcA=;
	b=wLkwZm5wbxcZdn5a9+JhpQC/F0CtrPWbmsxkLOnsasqXoCdzxpP4U9bDSq5ZY6ZzVXga
	 cfwy/Pu6qA4BUx4Vwywo7/r3bYQ69RFor+dB6Ya4iuUYOXlbL6v+0fsyXxLO6IU0iAit+
	 /q6fIR+sIYW5GAv1iwz8XPDf8TS3QjgfpPbSqoSvhe6u8Ieu3CD/pZUGFysHM2+THPkLh
	 cGruSY02O4uul8w7OsMTRfFDrYQ/5wfe2Lzx9DgxHIpetx0yJMM2uJ+kaMlgzdrZ41w9F
	 gK75XFa4SIBMtt/tVNLwZcnPrfaIpMHnPVNDiyLKQtnc1/70mzSVB1vUJHaBa/BQEJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="mvl/cAzO";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4180606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4180606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=mvl/cAzO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795447883;
	bh=NmHlHxD6ZkScGBBB3+zgEJW6bIgZ9it26kku/JG79hc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mvl/cAzOwqTTPhVo5u7XoAd8TddS33qvrAy44MN6/962gqg/871JAlER8S50/pi4R
	 EX/lvsX/cxenJDXaaRwq+ZiXsYfj6zX8SfradaCFmtgSi0H5GE3NxsFZrTXdHXzZiY
	 uFrzIR3q2CcBDmH/RtpiLIWkdAqErNYSMkM5tql25YKfr/QWaARzoN0OZYkhJ8ONCn
	 Ec3U6u0pzKTweSCDF5RqnIwCDYyL8BroIJ+EVa1Uzu0u7tyulk9Z8G5eW8x3ksGf6U
	 OYtbM+8CSTaUtAkgl88jLpCYTUK/lUzCO3N9fi1+dBZbdSSLYMRFO22jM/cIx86u28
	 yWhGzqoTsJq0g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C33A17E0CD7
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:31:23 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] org.bluez.Device: Make Security Level props optional
Date: Mon, 23 Nov 2026 16:31:16 +0100
Message-ID: <20261123153117.135583-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123153117.135583-1-frederic.danis@collabora.com>
References: <20261123153117.135583-1-frederic.danis@collabora.com>
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

