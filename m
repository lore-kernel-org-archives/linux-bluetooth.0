Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADEA204C18
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818912; cv=none; b=rcv+UcUP2SKw/OaXdqjLSSSzSqmiOH7+5gOFsJzRnlYOd6CIW046VyOgy7SP11MQBfDfoOH86eY+WscEl1tuVw5w4imVetbyWLG67Y9nQhWfeTW8Pj3C/3HF12d0lxj+Gz72rCnzk5b7Rsco6Lb3TedWOuZsDDkXvV20gO6Gakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818912; c=relaxed/simple;
	bh=pxR17IeCFN1/aqaM8Y/qn2MggexUUZUIg49SJMEWk64=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z1u2SgrWwe3s8r2t8O1U/odEZxtii0C1Cww7JHZTHO/oBRJC4NJxlOto8Z5JDmSkeU/gB9jX/orQAIHhH4qtG+ay7/lsngS+hajJ6wv0OuubR3H5KxW23qdgvpRkPCkrb06Y2HnCzGmxBzkHsSdcYD5V/D8b0FLgpjsiQ4pturE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pugU4y63; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pugU4y63"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744818908;
	bh=pxR17IeCFN1/aqaM8Y/qn2MggexUUZUIg49SJMEWk64=;
	h=From:To:Subject:Date:From;
	b=pugU4y63pG3F9GRWMudCpdlr0SYGygwDu63xb6XZeoQOPODQ+nx90inINcQt9sFkf
	 pygvA1wuuMs03Zd9zVV85o8l0R1DPG7+XqB0ptjRE187hkDOBrw0buMq28y37ajr5a
	 NHUNUYyQSNYG6pwiBsV4c3V/51/WFeApQhIwTPbZp/CDs4ATx6XOnp/zfRn1oE2r1D
	 tIWjSmC54J+ZpUdSRKCPBBsHuH3foxZDvOjcCb7zEAFJfaT4bRCcCJ8d8Rp9K/1VJg
	 nD+k/hqJyNzYyQbMfeWTX8HRP7XHNkKcJOpDkM/lw+JXQT5YC/c82/Wh0Q59AnoSp3
	 cogsrjhvSlYnA==
Received: from fdanis-XPS-13-9370.. (2a02-8428-af44-1001-B876-6480-8eAf-ACd0.rev.sfr.net [IPv6:2a02:8428:af44:1001:b876:6480:8eaf:acd0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E5DA517E0062
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 17:55:07 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] device: Reset svc_resolved on device_discover_services() request
Date: Wed, 16 Apr 2025 17:55:01 +0200
Message-ID: <20250416155503.250763-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This allows profiles requesting to re-retrieve the services records
(SDP or GATT) to be called back once the services are completed using
device_wait_for_svc_complete().
---
 src/device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 097b1fbba..ee9216a8e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5989,10 +5989,13 @@ int device_discover_services(struct btd_device *device)
 {
 	int err;
 
-	if (device->bredr)
+	if (device->bredr) {
+		device->bredr_state.svc_resolved = FALSE;
 		err = device_browse_sdp(device, NULL);
-	else
+	} else {
+		device->le_state.svc_resolved = FALSE;
 		err = device_browse_gatt(device, NULL);
+	}
 
 	if (err == 0 && device->discov_timer) {
 		timeout_remove(device->discov_timer);
-- 
2.43.0

