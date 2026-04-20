Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591B33F586
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701633; cv=none; b=Y3C2A0+Jzw4+yJSBhFLWhWaD+yeDI3HxEhDYf+REutGz6WPwRHgWhE1T8OtTm2yjzjHy2jnavIuSTDMOqDuQ375qF4Xwg8/A3+7chyBg0LhIf2K1qvjCkoKRDMYhM3E0FoCerx2sUB7jGe5KgYGbhqx07+FE4bj7t1XosMLvrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701633; c=relaxed/simple;
	bh=kq7MfNLwuLXTiZiPVorUHmCI88HVr+aXr9qC7kQ/M9I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WemOHEs4VAXbwYk/31q1BNaB45oLAT1CF3fJHA80v1U9iX3wuK2AgqxbsecKa0RfF2tYzWbj8j/ok6Zo5s3pbQwmPdQfDVpbm/DTmctGq6EIVTO3Xm5FkVA63rlaaVAWDfGpUSrootabvKw4cRvnnIrmyGjGyNzwjVfUG4YoNEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cMC3/6Gq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cMC3/6Gq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776701630;
	bh=kq7MfNLwuLXTiZiPVorUHmCI88HVr+aXr9qC7kQ/M9I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cMC3/6GqUf317ymEuVz4IYxr//PWd1PYI8oUOBIZHwO3pK6aT8FvALwEziTgS73KH
	 k3Bc69+M1QepQr3T+YBKukcSras37aBHwc3OfrxX1rduOezUdby/EhbrcDS0ApnmUO
	 RQdGCjjjoTeizsrzj37p1sA0MfU98KSWN+08GbKAVRt5xHWTdOKyrYq1PZWlY78gtQ
	 a0FFCmLyCc8ZdyuImOYJKxMZ5qRoDmH6U6RCJ6m/OvlZK5t1F0X6gLEDCtClpRK/hY
	 aCq8v4x07ohgwJZe061NlwU22BUwcMesWO/CkgmAS9yWy/AjLuS+EpgJ/1Vo2eBWVd
	 KHubYiTLusUEQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8007517E141B
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 18:13:50 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] doc: Add documentation for readwrite CIS transport Links property
Date: Mon, 20 Apr 2026 18:13:44 +0200
Message-ID: <20260420161345.145089-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420161345.145089-1-frederic.danis@collabora.com>
References: <20260420161345.145089-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This is only supported when bluetoothd is started in testing mode.
---
 doc/org.bluez.MediaTransport.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 81cf9e4da..fe69f948b 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -180,6 +180,11 @@ array{object} Links [readonly, optional, CIS only, experimental]
 
 Linked transport objects which the transport is associated with.
 
+If D-Bus testing interfaces as been enabled this property is readwrite.
+
+This can be used to manually unlink transport objects by sending empty array.
+Then, each link needs be acquired separately.
+
 array{object} Links [readwrite, BIS only, experimental]
 ```````````````````````````````````````````````````````
 
-- 
2.43.0

