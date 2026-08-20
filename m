Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51943B6BE5
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230699; cv=none; b=Hn4tWLo9Ic857qJNjF94IFW8b43Z7z4ztiMajjcFravd7c0RrTy+t7qFYLIwAHlhyEwu4pqjfLuKgjyXBaLH2j51D7kzA+uRwgKXgIr+gdEps1TM4lLIQ1O3yQdpugKmErXdKw1CcfuhXBTL9TeAId+miYFEzRR0z18PLteIVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230699; c=relaxed/simple;
	bh=hyA+fEJak61H/k5Q4SthdQlXFy40YWiMcfF3ACjNGY4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWLMRQ79XffiebBlEcJA3mRejxkrMSbraXigj+0sDS6NclzIuxToDQ2ABD4ur/hbHHoC0JEKCyqpn/1MwR1Jeof4u0nKlkAYXMuGPKwpSThS8sQeSvjX4aD8W8UTyJaNKwzDAv34O9boTAQZjB0o6NQMMvn23LDrWGUxdl+2OJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VIMQEpeP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VIMQEpeP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787230693;
	bh=hyA+fEJak61H/k5Q4SthdQlXFy40YWiMcfF3ACjNGY4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VIMQEpeP70eYhpimh3rLPhXD0CZq7SRcMaIJONKWcKXk4zobMjmDAHKRvVcj+Eow4
	 Xmnt4K651yiuDtqLJ/GgcRjoj9wKbpa43FUB44Hjrpj9LwTdlH1IkVEhtP2A7ZNPlT
	 30/OglwsvJyO7YyPTlTOhD3+7rFZfO1S3N4jtIYV4k6Ca2uT4fTMzf0UZROUjR1MnH
	 1OmFAeo0urC99ho5X3bzBL5ZNpo/soNp06T3zPoLXkMzY9ei4jwBDmqj7vUx52r4iE
	 9wFwSZTBw9WGUCpM3sGqUO7yAlIMxQ9ly7pUDD8rFD30NFMMZ6t3I6Ubx8nM3o/4f1
	 dQ7lCm8UvJXjg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2297317E0CBE
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 14:58:13 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/6] org.bluez.Device: Add Security Level related properties
Date: Thu, 20 Aug 2026 14:58:05 +0200
Message-ID: <20260820125806.1253547-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820125806.1253547-1-frederic.danis@collabora.com>
References: <20260820125806.1253547-1-frederic.danis@collabora.com>
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

