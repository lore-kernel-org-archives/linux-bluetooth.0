Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5E1E0E0D
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171416; cv=none; b=JiS1HuvNASHZYlNIay86OrGQcFHaU1lqvXSzwksWb4LMsfErTvlp0uhq/A5HHGl3oMCMi9+/U8Wg7T0IlHKKTekCkvWY0xCuevk4Qni+0chCyHYb8OadPSLT98NNjoUhYA2xlomkeYI1RGbK1UZOD3b6iwB/Dj1xrGm2ZJYgFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171416; c=relaxed/simple;
	bh=/eniqgg76+QBo/3Pj0Ylm952ITUtt97hW9HdwDmHVcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYE9CBNH1hJGdresAw/FvPdhfkiru8e1E7pocdiugtKypMqOpC3qKFmwAJ6ESvY3Om40S+2oYX01lNPOEtcsZ5WU3GHBjOavopU4WhjKKbJTD8DB3OwWyg8dfFXClZVpymqxXSj4bzaBOrNpWL1Kj0i2GHCHZdIYKM/XB0FrXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X9sAlhbc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X9sAlhbc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1738171412;
	bh=/eniqgg76+QBo/3Pj0Ylm952ITUtt97hW9HdwDmHVcs=;
	h=From:To:Cc:Subject:Date:From;
	b=X9sAlhbc2yHBu8htkujjAP5fiDEvDnWXDufkOYHnhgIKjjhbys6Y/LWWNcmDcnzXr
	 t48TFgNOvEu1BQ4zJTOEJIls6RPHESLHqP2qB1ruWts7yshB059mp3gS4Iuh5G3pTR
	 baYVYY0wmrOikzMqtufOLhjokSSTNSUlVxbQWugDcUADSXvESEJQuQLvjFb3tN9I/h
	 ry+i2lDKlHxN7Geu7ROpEUl0rYRwp6ESf9AOSZYBL5E/5DlH/JOk2u1rtY4gHlIODl
	 zrjROec9wucoEHZsjnbeTRYYae9LG9K7GmYOFicRsc8YrUISVu40IEJdPGRbuFz7Qt
	 vsRzzkbc/NMhQ==
Received: from localhost.localdomain (unknown [81.56.123.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 89C1F17E0848;
	Wed, 29 Jan 2025 18:23:32 +0100 (CET)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ] adapter: Fix the pending changing flags check
Date: Wed, 29 Jan 2025 18:23:16 +0100
Message-ID: <20250129172316.329330-1-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When checking if the new desired device flags are already pending, we
should compare them against the XOR of current flags and desired flags,
i.e. the flags that are going to change.

For example, let's assume the following situation:
- We have a device with `current_flags == DEVICE_FLAG_REMOTE_WAKEUP`
(i.e. 1)
- We want to disable the `wake_allowed` property
- `device_set_wake_allowed()` will call `adapter_set_device_flags()`
with `flags == 0`
- When in `adapter_set_device_flags()`, we'll have:
  - current == 1
  - pending == 0
  - flags == 0
In this situation `flags == (flags & pending)` would not return what
we'd expect.
---
 src/adapter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5d4117a49..e55fb7f3b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5684,6 +5684,7 @@ void adapter_set_device_flags(struct btd_adapter *adapter,
 				mgmt_request_func_t func, void *user_data)
 {
 	struct mgmt_cp_set_device_flags cp;
+	uint32_t current = btd_device_get_current_flags(device);
 	uint32_t supported = btd_device_get_supported_flags(device);
 	uint32_t pending = btd_device_get_pending_flags(device);
 	const bdaddr_t *bdaddr;
@@ -5694,7 +5695,7 @@ void adapter_set_device_flags(struct btd_adapter *adapter,
 		return;
 
 	/* Check if changing flags are pending */
-	if (flags == (flags & pending))
+	if ((current ^ flags) == (flags & pending))
 		return;
 
 	/* Set Device Privacy Mode if it has not set the flag yet. */
-- 
2.48.1

