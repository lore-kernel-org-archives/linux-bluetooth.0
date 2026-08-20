Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02004189D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223167; cv=none; b=NamOcGbYy4iHYF619FyvRpYALmNFNvE3Hy3dm08TPN30kJ70tf7tfo/NLVBHYUp5d5j4X7jw/ay0TpWnrD4lPEuPfqAq+XkN1NVTS1jKrGxh4gYUGrooPdVaPZ22BXCfh+vrQvD+gZCoSkhIeit/EX8yWyBiXUemHxwAH/T+LhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223167; c=relaxed/simple;
	bh=hyA+fEJak61H/k5Q4SthdQlXFy40YWiMcfF3ACjNGY4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZ3/JIP5eOKMOrbRJcHXRnVzXAQ5SIeAe+3jh+MjMGPUYgav19+cvvZraZjMwooWgLPtuM1cU5dyyQ9BdnZJJUgHf5NV+/15X+TZqmy+emGUN6Z/aDG3PPXCw0jU83xpBdOIPVFjESR0aSx52WaAG9A5/6NUmyjGaKfQ7dlOilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CXEJo5CB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CXEJo5CB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787223162;
	bh=hyA+fEJak61H/k5Q4SthdQlXFy40YWiMcfF3ACjNGY4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CXEJo5CBG0/f3GMTy3Dl9AXjlqxLXObH65T1444YZZOKSOXwfCysn3jf/Bw7P0HFi
	 iex7zmETRZI5UDlQv3On7eGskYW10GvyEQ677N3afGk5Sqk86e066GN1M3I3Tk/0kw
	 TgErGXWcczAGlxWWUaa58ylLtjOsSp7sp4LEHxQYTFDf7vnJg4GnP21rkR5yLYoPh5
	 y3Mo92UmpUDOvO92eILl8Z8G33LtsrDOOxrqGj/POXbxUP3m1O1NbaCtHDUOFegKyy
	 /3wk2YVGvtrgdC1YDKBBcgUL+7vKsOn2KJkIuNh+Qtwd/AbspSvJE3cSM6PlIFoknL
	 bSzvJ3AlXulaA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2460B17E0FEA
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:52:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] org.bluez.Device: Add Security Level related properties
Date: Thu, 20 Aug 2026 12:52:33 +0200
Message-ID: <20260820105235.1190318-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820105235.1190318-1-frederic.danis@collabora.com>
References: <20260820105235.1190318-1-frederic.danis@collabora.com>
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

