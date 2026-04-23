Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A75B322B7D
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930808; cv=none; b=BKzykiHQKF/+2EHGOGmAydvDT9rkrYuBtgaPViwlkwYGdJYENUratWjkIWMjYRq9+9UeqwenaW/4SYTEd1Rro3At/32VgirK6DUjQgt4jsZALeMA59w9TvgaVSUx9fJ4BHMridrO0XfN5C+Rlif5gk52eOdfbn24NQXxiachkWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930808; c=relaxed/simple;
	bh=kq7MfNLwuLXTiZiPVorUHmCI88HVr+aXr9qC7kQ/M9I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKEq8hORvvBV1guJoU8WKMce869yYvr62GItVVkhjoG8v9gihKDBbs7bVJh7J+FxJQ95wzcLKTUpfLPVQHqqXHu374vWTj8PngFTrN31+2v5npOkFZocaJk5oQkBB3V3IxBghKYhPfzOYrXFCgHQOM92noMcx3ayUwgVJceB8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HmZRkcEc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HmZRkcEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776930800;
	bh=kq7MfNLwuLXTiZiPVorUHmCI88HVr+aXr9qC7kQ/M9I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HmZRkcEcoQrIBg5OZ5TmAcCIZWPjRfQObElfCxHN1qWXrw82VBz4YjDXqO+mWNS5T
	 +4LmXUcgK31AhwFGGCp8bFAs/6wdc9iyp8CQlNmg/EN79f9Af1TWxnmD7k0LDnYI82
	 aX97hkeq7tIuR7hkRX+RXPOBONOxKqjyo9RRfd8LiIy0m5vqoIcAPbIj8qrIcadnmm
	 NOjQoCmFMBoxJEzzVDwsHYV0bVDHnCBUQ9/IrX/CCJjU6n9tOjXYuUStjf/t5g2RdE
	 MvOJRK+G1DnbEIwpup0eK9iN/qYgDUW6ouYf5X45b1TxSmrzMBGM6jy6lb7Vv+O4z/
	 nhkz/4wwL/JYg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2460617E13D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 09:53:20 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] doc: Add documentation for readwrite CIS transport Links property
Date: Thu, 23 Apr 2026 09:53:08 +0200
Message-ID: <20260423075309.493820-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423075309.493820-1-frederic.danis@collabora.com>
References: <20260423075309.493820-1-frederic.danis@collabora.com>
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

