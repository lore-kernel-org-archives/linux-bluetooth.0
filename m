Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514449;
	b=SbYJNSrd40+DHMNazFfRShOv3yZlCRfrpu7dv33Yex1+Hbx4alK/NAfGuEKxX1RSxlt1
	 s+pTdu6KxTwVzcSi5OLd980QuN682E2Kw/JaaPNRA7SVdDc08uMx5hPzaz6/IT4973cs0
	 kOa7Uj1bPW4KjUfNBbVDcACCK9WHm8mihielQjJSfZw6MZEGGOQ1USnw01WYe+I+PTIUh
	 qkTMSx29j5R+4DJ4XkLHmcpDBHRrYYY3WX4vRd95Ntb0f7ZQlqBYmd0/HU4izhOiW+zx+
	 X7LCx0eJlu3bEYrVfw7VDbzDTbLoYQc4pvR/FLSJNo+glZ9k28rXTijkqqm4xw9Z1Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514449;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z8CPHifgbrYj6tkLh25010bVskSYe89pgAlLXtXCMcA=;
	b=Fk3Qy/+9jTx4Aj+6BiZaQFesAcsLcXKmEsaXwpNhjo5txqncMI+Zgh3+LZXYbWV7Ptse
	 6ImDFMJ9EtdcDt9laIgaYrbP6sNOoD1eBkijvNz+qZLjdRW6Fh70r28X8yAjlYxICBhLl
	 p6OCQXSFRSwrh2qh3BZsJA0mD0ZWT5Nh5BMvSOPCZANup3htjbonmjDMXp4jvhl4r872x
	 4Ddmjv/VQJDxDQRPTOMYDEdRgQA5J/kQ5a1jq4CMk0/nCCfxXvTPjUI+hCERW6WT81GMs
	 4/3i5v/Bq4odtvj8AyZaXQvqYSJ7VLQ8yerCqcg1Y4cClGm0fNMHR/51zg3CHv/ug9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=QesKsI9V;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ACA606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64ACA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=QesKsI9V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795514441;
	bh=NmHlHxD6ZkScGBBB3+zgEJW6bIgZ9it26kku/JG79hc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QesKsI9VBezbvK4oe2HPnvdDycS12NitBQe6LjxWod4aYfkUC64vsyG2tSU3Fu6dA
	 E9pYMIjOoPM+LECe7obkuXtWXUfqF/mUmd2Mqmek7Z1UoJKAaOpFUwOXyOCVSr+70P
	 tU3DAbph5EmZNEIeZCFIF2N6/RGDDdp5b0P3OF1YSeOmImKj6u3pDO139nQPFGmkOT
	 ByYtPCGLndlGOBhdk2OkAwPbWLR7W6lj4mJruRQer2MGLkbCbQbqgvsfPZWRYqpgMX
	 syZAEiLt+Rv0EIL4Nckd6zuZsQc4QLZobOvnPWIMXBLxNrxeFO39NtNlfedgSxl0wP
	 kXWkVfjPgbD6g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 881AE17E0BCD
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:00:41 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] org.bluez.Device: Make Security Level props optional
Date: Tue, 24 Nov 2026 11:00:34 +0100
Message-ID: <20261124100035.245953-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124100035.245953-1-frederic.danis@collabora.com>
References: <20261124100035.245953-1-frederic.danis@collabora.com>
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

