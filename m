Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA55466AF0
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303394; cv=none; b=XNM6c9GlAuJbLOKkbZYGxEGAjVpzEauAmjX1yDJSRUirfaXnnUdRxGnH0DfgTADamChv0r6AH1OyeM+wz47MqYIAsXKPWXHgWu39eUuGPk9A0ThzFybf9Hg/IF7AuYccK0yV0XEYalLYNnUhF+EXn2JYwthw5eTPX/28/1E4pAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303394; c=relaxed/simple;
	bh=hyA+fEJak61H/k5Q4SthdQlXFy40YWiMcfF3ACjNGY4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJ5AuCi1RuOR1D4OBu4SGANEgz2eARzivqJHc2sxVmBJcSW88iRZ2MbqA545+vsXaHGayjIh1m5hXlVHfcAU+Q8rxnD8WwP/QBvQhnnUeP2mgfXw2R91dNQGvii4zj4OPfGmAEDmaRlirV6XdEOPStof7ukOi3GdZSZ4/1J2bsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YyXu4+CR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YyXu4+CR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787303354;
	bh=hyA+fEJak61H/k5Q4SthdQlXFy40YWiMcfF3ACjNGY4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YyXu4+CR/ViNprcRrdwdYLqLyoptzDjizkx1Cv6OQ51SQJi0vWI3h4Xg64bjH5cQa
	 iFqbp+V+9mnVGzaVFmOFGUPgNKkmEkKeY6Ifr3F2PFSnX00MfH3JvzFnb0emgGBwLi
	 y02ktIzz0Qokqj89OZYBMj4JzrigYMjQjIQQDmdPIUu37rnF0/B2OVuKdij50foeKA
	 v1J9btwMAW3tNp2nau9BH0dFcrPkMEZV/LzNOiPbNEWN8xx3s8xIO4giontGAOEFYE
	 4TBwImcYtCYehRyqY6pSvHraFQsVjUESe5PedMQxP3X0daPfVCxl2a5l+mukHsjPyQ
	 JD73BWunS3iTA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4944517E0FAF
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 11:09:14 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/6] org.bluez.Device: Add Security Level related properties
Date: Fri, 21 Aug 2026 11:09:07 +0200
Message-ID: <20260821090908.1546451-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821090908.1546451-1-frederic.danis@collabora.com>
References: <20260821090908.1546451-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This adds the SecurityLevel and EncryptionType properties which can be
used by clients to get the security level and encryption type in use
for a connection.
---
 doc/org.bluez.Device.rst | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 3e6a30aaf..5120dbede 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -478,3 +478,39 @@ Possible values:
 Examples:
 
 :bluetoothctl: > bearer <dev> [last-seen/bredr/le]
+
+byte SecurityLevel [readonly, experimental]
+```````````````````````````````````````````
+Indicate the Security Level of a connection.
+
+Possible values:
+
+:0:
+	No security
+
+:1:
+	Unauthenticated pairing with encryption not required
+
+:2:
+	Unauthenticated pairing with encryption desired
+
+:3:
+	Authenticated pairing with encryption
+
+:4:
+	FIPS authenticated pairing with encryption
+
+byte EncryptionType [readonly, experimental]
+````````````````````````````````````````````
+Indicate the Encryption type in use for a connection.
+
+Possible values:
+
+:0:
+	No encryption
+
+:1:
+	E0 encryption
+
+:2:
+	AES-CCM encryption
-- 
2.43.0

