Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C3611E
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307659; cv=none; b=B7M+DC9kpPYmJnQWa8MFvX7KlrKOQVf3yusKSL/I/QO7609/xD9fElT3GuadizAvcLm+Ia9HuB5bj5sTn9+BlcRj2BFZhHuoYq6yMyKTF9h72pl3KSQ67cb5YbRN2lkHWy02U0bx7L9Z13SKW+2Q2UtxUnrw84ac6IJwxmF3/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307659; c=relaxed/simple;
	bh=PDf98gx4S3mdROcdbjQGarOTtoZYCaL+6X6Wy3c8TNQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XUg78/XDp0Ho46E2FXcaByMQ7YaSZ7uVbdfugcx8KGhFSKXZmIHwu3q0cjLeM8W57/CS36fDXM8HrHn0Fneltg4n8+CVcK8WF6TaGL8+uLEdA9fGJQYPMam5c+3udAKKwGreTzGWRZxB58hZ+lEnhIzPyVAHzQ4hVMm646f7JUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p906NtlW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p906NtlW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712307655;
	bh=PDf98gx4S3mdROcdbjQGarOTtoZYCaL+6X6Wy3c8TNQ=;
	h=From:To:Subject:Date:From;
	b=p906NtlWjkP3TFqMvQo43aHYlL5TrPsBxUwOaUSvpAsUgI8MynA3R4KPCR7oCM44P
	 IPGVfaUEn9gp4m1CmJMuynqAAtbqIKs/RtS9tsi3wVldXCGFR+qtgda2LazfuRN0fZ
	 J/OacMTdOu2WlbrRu+qVq8fZz3E6wVd8LfF2X2IsI6cv1gGzaPf4EbFctz4HJG9SmM
	 eV3m4QyEOUcihD5thOo+S5JccxwP0VGp8sF+ETq3aTx9uE662nymO/iQ8IApiXIwKf
	 UCEFday3tofHaerg0NkBJ4dERuO4qAiBfaMKkpbMYTi+kR+IThoXO53aKIm8de6Tjg
	 zXnIObLfoZf+g==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8C33E3780EC6
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 09:00:55 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix airpods pairing
Date: Fri,  5 Apr 2024 11:00:50 +0200
Message-Id: <20240405090050.1477187-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Apple Airpods are discoverable and pairable in BREDR mode, but also
advertise in unconnectable mode in LE with the same Public address, at the
same time. As the pairing process uses the latest seen address, sometimes
it uses the LE Public address to pair, which fails.

This commit introduces the connectable state when selecting the bearer to
use for a connection. The last_seen value is used only for connectable
devices.
---
 src/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index ac0b0e003..1d4b8ab36 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2537,13 +2537,13 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	if (dev->bdaddr_type == BDADDR_LE_RANDOM)
 		return dev->bdaddr_type;
 
-	if (dev->bredr_state.last_seen) {
+	if (dev->bredr_state.connectable && dev->bredr_state.last_seen) {
 		bredr_last = current - dev->bredr_state.last_seen;
 		if (bredr_last > SEEN_TRESHHOLD)
 			bredr_last = NVAL_TIME;
 	}
 
-	if (dev->le_state.last_seen) {
+	if (dev->le_state.connectable && dev->le_state.last_seen) {
 		le_last = current - dev->le_state.last_seen;
 		if (le_last > SEEN_TRESHHOLD)
 			le_last = NVAL_TIME;
-- 
2.34.1

