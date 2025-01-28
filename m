Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A804619C554
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060199; cv=none; b=TcEtyA38PTkgj29t0QCj2HhuSW+j6P5UuIlwcdOrKoHjpOFHxBY8yhxbwV4Z+x18hXw6+cACHrhhz0WFqHqSuXh4mfL3Ox1hmiVoEuvNqio8CfO1qIj+D4VWqcJ6P6yfNSReL4ti+kJ4UT/obEV+3vIIbAvZVGlofuNZrzjOfFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060199; c=relaxed/simple;
	bh=23LhEh1cNzHvOgp3Xt5pg/+YDaJ3C/aFyV7/UUkygk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvtXUOOGzErtCOfCgtKAY4ce5DLqH1Ix3Lpi67CPjqbv+I1bXPnR2fRaB5AqYUXv4Usn3x36gCbOBiylE5OSsKaycppCAKRrfFJ5U1urdm0p+pkhFIR4ix+dEF9ZfUo4Wz3abo0JBO1ZisXMaL3dz8RMprIvFZBnSsQh1rCsAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nh0GusIK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nh0GusIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1738060195;
	bh=23LhEh1cNzHvOgp3Xt5pg/+YDaJ3C/aFyV7/UUkygk8=;
	h=From:To:Cc:Subject:Date:From;
	b=nh0GusIK8HdqZszVcfcROhf6SR95ACPv8e3ywTOuuFohd8Yr4D3CZMjO9yUs1NEyv
	 +he2/uE/OwT/etzcbOCjQuFrIwkAIjpkg71a+W8FfVHsjX+7HMmSPi+mDmlfG0TUVl
	 XzXojtnaN3yHkzR4iNhkHEFbDPXcxE/IRYoOgGNPvuKvLzPKM1DxqrnLNw/6se9Vdm
	 lOJkZp8v6iWkMzrJx2lci2GLsiCZXn04BGkb7spQOQ9Qt4UhcsHbdqIpfGfddBRgFP
	 3u3XlzzcaOAP5DaEmvcdp3Jtmw/8d0BwJvPQ33ptxpIieXcALQTPqFrodm0cgABdpG
	 EVHSYE0q2SYcw==
Received: from localhost.localdomain (unknown [81.56.123.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8816C17E0CD5;
	Tue, 28 Jan 2025 11:29:55 +0100 (CET)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ] adapter: Include pending flags in device_flags_changed_callback
Date: Tue, 28 Jan 2025 11:29:37 +0100
Message-ID: <20250128102937.16215-1-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When signalling the new device flags, we need to include the pending
ones. Otherwise, the eventual non-zero `pending_flags` will be wiped out
in `btd_device_flags_changed()`, and we'll lose the pending changed
flags.

Fixes https://github.com/bluez/bluez/issues/1076
---
 src/adapter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5d4117a49..cbc0f678f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5727,6 +5727,7 @@ static void device_flags_changed_callback(uint16_t index, uint16_t length,
 	struct btd_adapter *adapter = user_data;
 	struct btd_device *dev;
 	char addr[18];
+	uint32_t changed_flags = 0;
 
 	if (length < sizeof(*ev)) {
 		btd_error(adapter->dev_id,
@@ -5744,7 +5745,9 @@ static void device_flags_changed_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	btd_device_flags_changed(dev, ev->supported_flags, ev->current_flags);
+	changed_flags = ev->current_flags | btd_device_get_pending_flags(dev);
+
+	btd_device_flags_changed(dev, ev->supported_flags, changed_flags);
 }
 
 
-- 
2.48.1

