Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C04826FDB4
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289021; cv=pass; b=h5NXKJia3q24N9Wre4LleG1BpjFy7QSF3ATK7FNqT3vuXQaFYwtHtw3DK+YMlTMclB35nLkWoyeFwBbmboVJ5ieguATB/CreG4hkRlm6B79NXG/s6kbWPqGo0lEQtIwKzyf8rh5mNYc+w8qFIztg58RFAgQdGbR0MyScWHlEzsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289021; c=relaxed/simple;
	bh=UHL8Y0FIUzdxy/05MppI/Tb8Jpp2Ea2Dduvp9760H8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdVzBVf4uWqW9/d5FomU6A6sNxBZVMlgfIvIzXe1CyaoiJHCZ1i2yemQzhhKfIUOOhs7CJ5ODg7iNfSyh8OEPtt8xnv4lomaD7Gu5yKmcwClaiKrkmzbiPld9JOJjROs9X02cPuD0GPT2ujeSWr+eizSwVsTn9pn/2zazbb5m2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=cD5R5Nri; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="cD5R5Nri"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z7zqD6mRvz49Q73;
	Thu,  6 Mar 2025 21:23:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1741289017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rs7aDxlfWuzNdTmfEuBXwiMo4g9LKsIBtes+mX3GHo=;
	b=cD5R5NrifHlEWNURCsRuEB3pUb2iBn4CAN+xGXoY6t65XfB5ZsjQEWz0DmujRw2yiq2epP
	OZ6vm4jflW3HqzwzBG/sEkgEE1VHzbDic8Gz4uF+kpOej8tI8c7T92Okp6upAb5OBStpcR
	xVCtC81l4aHES3iU3EJx7Ru7JP6tvWQjoUhP81F8xHLI70ftHRpxWYUgRSDS16pvpHn5Z+
	AsQBgtzPIw3R5OOyYN9InaeZp0BO0EhpnapJnqymLS9xlu10luKI5Lx65GLNIeCsk8wbDe
	9DVxaJneuqzlDiB+6g8FvvKGiefsiSCxLPbY93PeYGCjXWs15YncHEG6TeBC4Q==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1741289017; a=rsa-sha256;
	cv=none;
	b=gxODig3fcHnKFDSVYj3IpDz8Qyqkqt5Rq+uS+GmC0FWUn8mjrzUhxdaKiemDIjgBof82rb
	qSITpqD4qUnjkPLiFqHz6x/uLOJkFbxQ0BnpHj0Q6Wgeq8chCS6kgSDdFdBfSCqTNo4rpT
	BvPGkbUJhPWUADTLcBgd9yy2nsHf94JEsvO+GBQFiJ4W7x/gtuQN3bYRXoY4I5SMOYrMT0
	Mh0JkGKwYOFMvcH1liWUaelgaMPm4sH91zUXp9cZ3FXdjEdNXMlFlSSGQLtWSx9rps37AH
	tR6uKGd8A4VfGDKtdsZSBPNXJ+sQt1foeCfXYIADXjoAmIDHs5LIXTWxcnCCJg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1741289017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rs7aDxlfWuzNdTmfEuBXwiMo4g9LKsIBtes+mX3GHo=;
	b=tlaXYv5uwCHpLSs8KGV73TfujiA2ETHdk1CJt/KlFADBc6BjsxA3RCxbysUIT+/jaizTCi
	KG0b6PU7BSaxN//3NtlxAf7cFK6i8p5R9hkCvwwRhJI7e9uJQzLPaZwDROekQHRivZiJnZ
	3WRE45iOhG3HEIhL5P/gbhQkjlivJ3SbM++FhX5p2YbrT9ulAtx4KjdeuXSAsA8f0gGO+R
	EJXYedvUQc3gvWY/ATKSBL/yHdSlEPcgAEX/CH7/VtxveRmi79USoTjT3sMMHwqkTOLzGF
	3E/3C2H5hniSs8Z9dWqVr4DBhis2rqGVZ9Zilt5W51+okkNUyFp99uP2F37f/w==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 5/6] btdev: support disabling commands
Date: Thu,  6 Mar 2025 21:23:17 +0200
Message-ID: <c69eadf08ad65d0894080a2757e167a27a183c35.1741288951.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <ab105eb0ca4c2e91218ff76a9040e46fe5f64a2d.1741288951.git.pav@iki.fi>
References: <ab105eb0ca4c2e91218ff76a9040e46fe5f64a2d.1741288951.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add function to return command mask, so that it is possible to disable
some in tests if needed.
---
 emulator/btdev.c  |  5 +++++
 emulator/btdev.h  |  2 ++
 emulator/hciemu.c | 14 ++++++++++++++
 emulator/hciemu.h |  1 +
 4 files changed, 22 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 3542fdad5..599df3430 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -7406,6 +7406,11 @@ uint8_t *btdev_get_features(struct btdev *btdev)
 	return btdev->features;
 }
 
+uint8_t *btdev_get_commands(struct btdev *btdev)
+{
+	return btdev->commands;
+}
+
 uint8_t btdev_get_scan_enable(struct btdev *btdev)
 {
 	return btdev->scan_enable;
diff --git a/emulator/btdev.h b/emulator/btdev.h
index cad5f699f..a96c1a325 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -76,6 +76,8 @@ bool btdev_set_bdaddr(struct btdev *btdev, const uint8_t *bdaddr);
 
 uint8_t *btdev_get_features(struct btdev *btdev);
 
+uint8_t *btdev_get_commands(struct btdev *btdev);
+
 uint8_t btdev_get_scan_enable(struct btdev *btdev);
 
 uint8_t btdev_get_le_scan_enable(struct btdev *btdev);
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index f13b4bda1..ccc57aada 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -528,6 +528,20 @@ uint8_t *hciemu_get_features(struct hciemu *hciemu)
 	return btdev_get_features(dev);
 }
 
+uint8_t *hciemu_get_commands(struct hciemu *hciemu)
+{
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return NULL;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
+		return NULL;
+
+	return btdev_get_commands(dev);
+}
+
 const uint8_t *hciemu_get_central_bdaddr(struct hciemu *hciemu)
 {
 	struct btdev *dev;
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index dba920fdd..9fbe34316 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -55,6 +55,7 @@ void hciemu_flush_client_events(struct hciemu *hciemu);
 
 const char *hciemu_get_address(struct hciemu *hciemu);
 uint8_t *hciemu_get_features(struct hciemu *hciemu);
+uint8_t *hciemu_get_commands(struct hciemu *hciemu);
 
 const uint8_t *hciemu_get_central_bdaddr(struct hciemu *hciemu);
 const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu);
-- 
2.48.1

