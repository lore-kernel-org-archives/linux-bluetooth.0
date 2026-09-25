Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285FA492E20
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332167; cv=none; b=DvgBoWxNsCTM4A9f/FCbB30hdvXAnF2rSPA6+uF4U7CCrrLCSyuMGPDO1IxbjfmS178/DvSSpO0iBEXgq61Vy+BGIdPMCYtMVwxHv45gBb2F44zRIix/9p8eozPHl5bYgAWOZ0gwo6GhKFZizROX9sG3NKgbhTMyX4wmpGkLHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332167; c=relaxed/simple;
	bh=hyA+fEJak61H/k5Q4SthdQlXFy40YWiMcfF3ACjNGY4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etG5Yx0K+Ii/ive5KtDezQleZLviJW0dJLEwJSyC0eU8G+x9sanhdavpfNT824WTADUonRe626DL0UfKPVe8KLcGjN4VRD4zZSwFb8tBll4YFJCG64uDt2tJyagK/RBgisQBg6Gd9jVSoOQF6eG/XhVpvTAL3pL9gCk+zun+ylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UVaN8fet; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UVaN8fet"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790332160;
	bh=hyA+fEJak61H/k5Q4SthdQlXFy40YWiMcfF3ACjNGY4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UVaN8fetwuM8GufrXV8mvaYbHuhoJqRZ8mlX00ER83qFKoSj+SZc7TlauXeUbf/AY
	 AzU2hE8+w7x34vF5+vLieaqKTU18a8PLZmpWvdGoTdpptAi2YiVViM1rJPodIhxO5k
	 +wRFkd9J3iYsbCKTFc/4H9AJqfTECZF3JpXzrKiilyK016N7Jmj/aGWGEOrIhTSJC1
	 Tmk4D/q0ilfDCgPXSyCtrpPGQnNtJp4fRP7hkpdEYM+swaGvkyT+VgFdEWNpav5cu7
	 zX1VAtbZ4Ssg7vBQD/6wvh1Te6CDekWRmuiO4W0arP0HNJ3gkJsnfpRNvD9gyTDkOg
	 HAuAN2by1eB8g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 854EA17E0D7E
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 12:29:20 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 RESEND 5/6] org.bluez.Device: Add Security Level related properties
Date: Fri, 25 Sep 2026 12:29:13 +0200
Message-ID: <20260925102914.3282319-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925102914.3282319-1-frederic.danis@collabora.com>
References: <20260925102914.3282319-1-frederic.danis@collabora.com>
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

