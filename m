Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7095C38C407
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677217; cv=none; b=ujvSn/5AA0S4XHEStFepzzrbTlY+mtZOSnrZYHWqqHbw+eirwzJd/IU+m7T7hDTy0ypcr4iM6kRWIQ2ZjgvlcNW4EQ/rfTl7RC/y0nsl7dGeHEOAX+75/67DOfDDMCB2hOj5zpu9FLk08kF1nhfgGK2fmviPSWRJQoBx7QO7yQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677217; c=relaxed/simple;
	bh=hyA+fEJak61H/k5Q4SthdQlXFy40YWiMcfF3ACjNGY4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfuvAFZ4uju/uNI0j3o/FAezFEE0F7CTWvVziWa5AI9f1tsOVJm5GnwXPBT7+1ekP2JxCGYnBmq4bDzhV+dMjkXZPUVbqY7UVT6DuyRS/RDsTwGqRczkCRIh/ZjjWg03bnDaKDBb2xUYu/gyPXvkj3Liwx/rMWEGDch7qsiCwCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mH+7oEg8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mH+7oEg8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790677201;
	bh=hyA+fEJak61H/k5Q4SthdQlXFy40YWiMcfF3ACjNGY4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mH+7oEg8yye1dILKVD3TrvrGzxWDk/9KI1EiW/n60lHRQcmnceGXs0wK0YAgYaHBH
	 DuKAUeqo6nF1vVULcN3H9O3trHTivSWSLr3wD+8QryTCmxucZacO/+j0VXoQfGVsKP
	 zA+Fs9lFtHh3vp4GW8P5IDsvgC3X3CUadCWE9NkdQv/tQYDygTp1BT0VWINO0xTPHW
	 1aHQY+uBn2qUdak6FEghmeT2p8zk7CIXuDnH0AqxDpL7987e/D8EMixzdhlnrdBVuV
	 SZhWcf17jB1ByjHErK9sGJNTPHBR5/1To8yeeW0aZNgeywXQw4OnYUM+GKscembu00
	 hh6HkxTne33jA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 48F3E17E0D66
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 12:20:01 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 5/6] org.bluez.Device: Add Security Level related properties
Date: Tue, 29 Sep 2026 12:19:52 +0200
Message-ID: <20260929101953.254969-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929101953.254969-1-frederic.danis@collabora.com>
References: <20260929101953.254969-1-frederic.danis@collabora.com>
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

