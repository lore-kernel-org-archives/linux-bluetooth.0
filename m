Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA43DDAF3
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340840; cv=none; b=HI/D2cuZS9CNDYSG2UI7azq8Y0jpn4gnKptrSpbhcUOIpl0kXvsl2ST/j/xU2yi4WOIiEeHGbaw7OsJ921tBLIY/ZwyQiWvCNH6zeTUpO7GsidUKhv1cOTWiFkV7Bo/o0C93R+2hVqvh9nC6UoDV2d+K32NqeJzjXET7EOgEugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340840; c=relaxed/simple;
	bh=Q25BcWd5GUmLwIFP6oEGb4A+HsBf+NdFdI73G2xnFro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hO1luPSGE1dsnKDZw35JRGlbQBrq7Oq9RtmC9KsbMd/bkSTd0xl30wmvgIBV5VmNqt5UOs7gnXkXTjc1aUryx8M2pqnehi9s6/V0pRPm5ekc2vZJ1OwvGuzIKt+VnxI72w+nI+pJQI3Rz4ilZw26jfK8ejMttr9oSPK4H9OqW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jVqmeLP0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jVqmeLP0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787340836;
	bh=Q25BcWd5GUmLwIFP6oEGb4A+HsBf+NdFdI73G2xnFro=;
	h=From:To:Cc:Subject:Date:From;
	b=jVqmeLP0Z8J+liISx0TwQmA/Z6qviYot6Yv7Nft0AwJB/bmM8Oki90hgQHJ6FiFCx
	 q/velFQZNLeJl6+Yx1liEBItTZZ/tCyfux9cqVUPubsTiOs1lae0qwHHvA3l0cXe94
	 fg8SFlY0ZV+xzhGiaJ/x5vmjEBlpopPHORS0JnL8CiJ8xxMpnF+Jqg/MXPKeNRBJKf
	 fP1uHJW/h7sS/KqO2Om1abHIwlckEarAl/e5lvkivAQPdFtE+4lp/B7OSp3BGjfhrt
	 cP60pAAqWv4UCyzpCR2he8rv+ktGgfkQGxAIU6JmzzWTSUvhYP7xBUY796mso/MkbT
	 jXO44biOgzktw==
Received: from vninja (unknown [100.64.1.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gkiagia)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B2BF517E07FD;
	Fri, 21 Aug 2026 21:33:56 +0200 (CEST)
From: George Kiagiadakis <george.kiagiadakis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: George Kiagiadakis <george.kiagiadakis@collabora.com>
Subject: [PATCH BlueZ] build: Ignore the test-sdp-xml binary
Date: Fri, 21 Aug 2026 22:31:20 +0300
Message-ID: <20260821193120.1335629-1-george.kiagiadakis@collabora.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unit/test-sdp-xml has been built by make check ever since the test was
added, but was never added to .gitignore, so it shows up as untracked.

Fixes: e55ff8818f72 ("unit: Add test for sdp_xml_parse_record()")

Assisted-by: Claude:claude-opus-5
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index c5efe8536..bfebed6cb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -106,6 +106,7 @@ unit/test-crc
 unit/test-textfile
 unit/test-gdbus-client
 unit/test-sdp
+unit/test-sdp-xml
 unit/test-lib
 unit/test-mgmt
 unit/test-uhid

base-commit: c73fa2f9ae2d366cb8a4f101fa9a5ccd9f33a4ea
-- 
2.54.0 (Apple Git-157)

