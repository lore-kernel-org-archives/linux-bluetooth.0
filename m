Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65D1922FA
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919957; cv=none; b=VrdNkM1mWDVLmccJZUdWNkoU75JEPjCexA+3lt49UL0QdhXF6PhVY7/cw3i0y3hqJFF6UYa1qx+azTtyLXDb7HYpBb6dH32VVfkSuQxlj9jUohF7qEmHFn5SdQfWRKfnZICwMArAsAqWNUKYQZb/cY9yZZ+8ZWxXZPtFlZm2qrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919957; c=relaxed/simple;
	bh=+1SSirNnAWMmxsDokTbFnCv5zO7iqbYRpFkZ9Luex5U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dpIM1kkdm1c7nbeabfB61zMkYZed6g4x3oSbu4m+heb0ihaQqnSNW5dqdqBgDZ8hvc2ioFiqW1slXWVgGQzj09vXplHBHNvGgQilsKe58P3H6L/NBdqPcu2eWVQaGfB10Vam8S98CPtQSao+BUs0Yz5QXFe84BB3BAX6sRneDuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UaweXhiO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UaweXhiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742919953;
	bh=+1SSirNnAWMmxsDokTbFnCv5zO7iqbYRpFkZ9Luex5U=;
	h=From:To:Subject:Date:From;
	b=UaweXhiOKDh+RH6/dxfhkL4AHBDmUr8FcmT6eBojLoM7OiKqieLH+tI312V8WZZdP
	 himvtIHuFKUrcXsiSZpm9aDAVyWNhSMODkMIwIb0ZkzXHj4Ov/mF0DXu78nUkgXgV6
	 UDGCjYwshk1XTqpKu82t3XzL98o+oVJEyeDHy/saMZK0oi6gUa6Mu05kMYHkKrN3af
	 cZXlqhIsa4vS+X9CFeOquGYSucsGWDDJG4GyXvJz148GibN0h81aWZZvnZ7BUo6RNb
	 KFe4byM3O3Btdnof9M12mbod1ztAHgz6/o0ur9E94MHE3JqQ4kC+mAFFs8L+IzQwLA
	 8Jf7oUdU1x1PQ==
Received: from fdanis-XPS-13-9370.. (2A02-8428-af44-1001-374E-Ffb6-aA7e-68B9.rev.sfr.net [IPv6:2a02:8428:af44:1001:374e:ffb6:aa7e:68b9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3697917E09BE
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 17:25:53 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] profiles/avdtp: Fix reply for bad media transport format
Date: Tue, 25 Mar 2025 17:25:48 +0100
Message-ID: <20250325162548.149495-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the avdtp_setconf_cmd() fails to check the capability length
of the Media Transport Service Category, which should be 0, because
caps_to_list() doesn't add it to the list of services as it should
be bigger than packet boundary.

This commit add a fake Media Transport capability with invalid length
of 1, so avdtp_setconf_cmd() can check it and send reject error
AVDTP_BAD_MEDIA_TRANSPORT_FORMAT.

This is required for passing AVDTP/SNK/ACP/TRA/BTR/BI-01-C PTS test
case:
To verify that the IUT (ACP) is able to issue a set configuration
reject response to the INT if the format of the media transport is
incorrect.
---
 profiles/audio/avdtp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 80fbe847e..67d32278f 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1328,6 +1328,17 @@ static GSList *caps_to_list(uint8_t *data, size_t size,
 
 		cap = (struct avdtp_service_capability *)data;
 
+		if (cap->category == AVDTP_MEDIA_TRANSPORT &&
+					cap->length != 0) {
+			error("Invalid media transport in getcap resp");
+			cpy = util_malloc(sizeof(*cpy) + 1);
+			memcpy(cpy, cap, sizeof(*cap));
+			cpy->length = 1;
+			cpy->data[0] = 0;
+			caps = g_slist_append(caps, cpy);
+			break;
+		}
+
 		if (sizeof(*cap) + cap->length > size) {
 			error("Invalid capability data in getcap resp");
 			break;
-- 
2.43.0

