Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B790261370
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234029; cv=none; b=Z9ciySUhTWSWM3RHsojag1ODefMtaCp1mF+fhFBzWVZtCOBh71r84co9RnnA95lyQZ5Gv7FTFFjb7DTMh7b7k0VJ4kSEmGIQO86aTrsTFruYmq2zBm6BiAv2t5WCzH9U3oMojlJzBdWc8jSxXA/5j6y5DOTqoqCkW/WoAw5gB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234029; c=relaxed/simple;
	bh=2pe6XjjC0mhZG7nI/GV4gZgYITk5arIObQn1QvX8Yng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5t1v5be6UhE0YQuJoVRflVLoJOvgMYGFWTUfdmzeyVRTJgmSGZ0U493PHREFtzhEMuBFUvYTEvg9zTxbCaTgG5KZLn/aDsV6zt51Efip/YKySsMVy3ubtZddwu+JJINzJWY3kNKMWsD+sJ9bbBTWBnfjxJZA3OCixYCX5A1lU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mKG9X8lx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mKG9X8lx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745234025;
	bh=2pe6XjjC0mhZG7nI/GV4gZgYITk5arIObQn1QvX8Yng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKG9X8lxYCqArB6r9u3xoL8HFMC59B1Rq7N/T+POU6XDaLIh0BNFC0MIBLMe5H3PD
	 SvJaZWbqB5T4DDi6cfy9fT1fYUJq536/VJF6GDJe4RfdF8aefsNAqW6GSvV1h+nI8w
	 OEfTxcmt+obFKxHda8gL8Ad/bopBlsdqN9C9aJlN7illWCE7QVu2A10fENr4OP38zr
	 +fLpOBnpwazWVIbmmt44ksChoWUYP7E6vmyNiDsIwk/BHOn9ux4fTmKqoJrKwx1LPP
	 0di7usL6fb+WN84/34kTuRjJWYTlNX+w7PJNxy75T1nl6u+6dhC2VO1CX5fBTGHSLL
	 sV4yA4s5LJNaw==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E6E0D17E00FC;
	Mon, 21 Apr 2025 13:13:44 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ 3/5] plugins: Set SixaxisCablePairing property when pairing a sixaxis with USB
Date: Mon, 21 Apr 2025 13:12:49 +0200
Message-ID: <20250421111251.108943-4-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421111251.108943-1-ludovico.denittis@collabora.com>
References: <20250421111251.108943-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we are pairing a Sixaxis device using a USB cable, we set the
SixaxisCablePairing property to flag that event.
---
 plugins/sixaxis.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 3e69f1dd2..84dd3891b 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -296,10 +296,13 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 	remove_device = false;
 	btd_device_set_temporary(closure->device, false);
 
-	if (closure->type == CABLE_PAIRING_SIXAXIS)
+	if (closure->type == CABLE_PAIRING_SIXAXIS) {
 		btd_device_set_record(closure->device, HID_UUID,
 						 SIXAXIS_HID_SDP_RECORD);
 
+		device_set_sixaxis_cable_pairing(closure->device, true);
+	}
+
 	ba2str(&closure->bdaddr, device_addr);
 	ba2str(&central_bdaddr, central_addr);
 	ba2str(adapter_bdaddr, adapter_addr);
-- 
2.49.0

