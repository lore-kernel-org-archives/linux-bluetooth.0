Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683140;
	b=R56A3SeURq85X7uzMl1NSid7gF6W5wE5H/JY2WCgb42t9OLWo5WJlgM52iQgUT3BnMbE
	 EW14SsADnKk5vt+s0miH6R2R53j9Ww5eNIXN98q4vCIHbdbsL6OnjEEwVQDy7ZgJzbla+
	 FGlnNguvRT0h07V68png4IhHOzsSeog+XcfA4BnR+D0I+df0EZfbv6qo0QbO3TMzoZYCN
	 LK27OxhyKt662QfqRpuFKHZC5P7CAzX6JJQoJ6pZVRrg4ig6Z9ptED15823ry7/i9E1Cp
	 GZCrtwm9V816mzIYV+ofeq5FBay9qmOpMZAuL5AC34T9+ZNakRNa/oyPT2D3yQkKl6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683140;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z8CPHifgbrYj6tkLh25010bVskSYe89pgAlLXtXCMcA=;
	b=L/4rjHxJwY1V8Ubdw5hhY8od+vdA1L/9/kW/7C3FKTGCkvVfOIPKm3FF3k323OmrmjBR
	 X+3nOrUPwDya4zuA2wBQvy14yuFQAyGDs1YZlq5tlkdjIN2zKv7xbTS9QPcFRuU0DWREk
	 SkB+3aoPx54YNv3gI4Ojs2RBcEfFojhSnxLji/l49qX1dDXN2Lg/Psq3EIHz4K/IOKx5F
	 okZZAygcVnBBiGbm6jr54MGRgGRLLsIC0qMH50Pzs557owXdKeCXio6NTN6/KylSQNtma
	 EddbQiExobUAakqzaQKjT7vfsORufC8XYyYGHsLSlweZGtjr+s4zVFOOpeWgv3b3KvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=EmCgktXX;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F5606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 08:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD5F5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=EmCgktXX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795683137;
	bh=NmHlHxD6ZkScGBBB3+zgEJW6bIgZ9it26kku/JG79hc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EmCgktXX358ChPngCVEZohc3xrq0WVXWLJjCnv7V0GH3c93DSlDMuWq8XhJL2An40
	 bo9pv2tRPb+N9b1X/uqn2h1Nh4QCUKivcJQ/XYeiDdV+pbEoiq5DLZfNowAf5qfG98
	 zGpgevM1E7EIWconnCfkRqU+0fa+hpf0cLsUQVXPGkjA+UYSwQ41xXtcPLUJGQMKXS
	 DhZMv2WmiWwVp8cbISWsMxx92365KPrAIzYuD3fsMfqcW25Qtd8uxInAQ2J5Mq5wGk
	 KCnL9C0BSkrCwRv+nqMiG7YWOZ/KMTc94CZM8LEKZ2+cGZTY49JmpaWXFxj5GxielA
	 47/HKIC8Bjguw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 699F017E04F7
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 09:52:17 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 2/5] org.bluez.Device: Make Security Level props optional
Date: Thu, 26 Nov 2026 09:52:08 +0100
Message-ID: <20261126085211.80204-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126085211.80204-1-frederic.danis@collabora.com>
References: <20261126085211.80204-1-frederic.danis@collabora.com>
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

