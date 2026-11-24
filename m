Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522647;
	b=cRwfBD1cqWJIzW3sV4TsRxVpRWNXfcS13SaV4RwA+B2K7mCCLglTBFMWBUuqjRpmmMp3
	 hUin6Uh1lzW/8Bb9JWeFq3MHRzhUEDemBTl12rHU7AyglMFKHcu/CLwXUBVgWRWoxtlo8
	 6sLvp9JUEmcpzfxddDgtbDjCMYMGCH7KmNu2CBre5NeUuAGdR/mcZaXy8fLdNRnd93XYh
	 /d61HWtt9ow0fY0Nxk01oooaFulP5xH2afDtD9iMqsf04i72nW7VLQHc1TeFeCmybknul
	 qIvsKblC0KWOe7Z/sBkIALbDm7E2tNHVCsE2gVeTNE+xVpLniBbmDWMLfnCb5hAO5Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522647;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z8CPHifgbrYj6tkLh25010bVskSYe89pgAlLXtXCMcA=;
	b=XdxpjFV+3oyKWGQHwJ4xH9q2ggAD3FMreXwPSJv5K77s42NOqmrnJ3tK/9+2vCBkY3gY
	 ycKZCQ+wYhSLrNUQv9CIXmymOIi8FgqLrn4YGsavhfYC70aVk9z6XjOCuy+S0F1KnJx1Z
	 Oo3GSyQelsZ7/pilWuvRzNVxJ5qbjH87pfZCqyC2qPyHltSKLvVlHhjy/8IuvpDA3/vq1
	 CPzmQbOP6wqXk76AE9F3isJ2wx8p5uffsZggJ41Vphcx3+FtMFUmTlgdUW/c78cAnsrb9
	 uWjFXRz2writz5WXp8CHr18PBKaIplGwx+vOE3/Bwo9MyqQIasXeO8OTouMr3utJ0Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hPsLBxx3;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380F606A336
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6380F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hPsLBxx3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795522644;
	bh=NmHlHxD6ZkScGBBB3+zgEJW6bIgZ9it26kku/JG79hc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hPsLBxx3WBpC6LaoCJyMuoP+N+L/KhKqOL39RoU8l6cenhWcRvmtFpg2MxTCO/+Zi
	 pqjikMTGQarroar/NkpioXfo4BPeJgMrpyrOHZYux68cmTq7HERFDGlGS4Zmnb9eZm
	 7Q4ZWL7tksvlOdUURj+l/E54f3dl1HPt8zY67+AqgLgUC1UBMMXUCfKj75GzUBgtpD
	 UALGd+B8eq/QYN7LmA+dn55XkPjM/NAt8EBzFBKmAz80xz2m9Dofx5jKFy11pYqJRq
	 3hNZdcjUe0PRrZzCNKNwGNdZzxpOxU8E2G5NnsC0yluV+a8RNRxgxP73sxLTFvHa1n
	 NARwws7R7EJIw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D0DAC17E0CF4
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:17:24 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/3] org.bluez.Device: Make Security Level props optional
Date: Tue, 24 Nov 2026 13:17:18 +0100
Message-ID: <20261124121719.280039-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124121719.280039-1-frederic.danis@collabora.com>
References: <20261124121719.280039-1-frederic.danis@collabora.com>
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

