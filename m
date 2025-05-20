Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE33258CC0
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758391; cv=none; b=qG5IxTN3/k+W6WkD/RkzlD2Kp5qHMqE4R3DfMJnPYlXkKuUoPgXGURf5U6zARhBrPRJMH6Eo4ccQ8T1pAhk9OzrQTT94I9SZyilCcw2K37ns+qFt/iC30hzBaAidBYBo3qIZQROySTGYRy3F6uFXq+wh18AdabOButF5vnRAXh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758391; c=relaxed/simple;
	bh=OI7iAhv4G26RLNGvb1sV6s/K41XWaD6E/Z/Gst+Mv7Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=Of/hsVWG8xTUAxjXVCn6UunKMWpuN8rWergnXdx5geqwldl1PK47oeU1/9v3ijRxA2sdD1gE1TV6lZtUBYDq36CyM4ddyyDhZiGoJTyYppztJ39FSfqgFdiUVQUfXMx4ZPZa5OcckS4A/T9rfQHlARO7/E2WN8JW8LfKfpx3iKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CRaqKgd1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CRaqKgd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747758387;
	bh=OI7iAhv4G26RLNGvb1sV6s/K41XWaD6E/Z/Gst+Mv7Y=;
	h=From:To:Subject:Date:From;
	b=CRaqKgd1GdvXi0lVzeEew0gZjVesNGVItY1QRUQobc3dNUFhlniyIndETyxCRTbTH
	 at/4Fm7hBXBuYpAH5hOEwyd7L3xftz0k8QQLRakL5IwRqKWH2CYLNOlIfUcUz7RxsR
	 +gyLVgsHt1B2Vq1SYnQz2FNAWxye8JkAiS7OT7ikKs+aJzqDeUpYe2nXxJ1YX63Lre
	 Pq5u7KaT6zhI4uVKRveALGG44NZ+pzX5jhv1UJDu1EPfKn/gR2viFL/s3XGIKdGyDm
	 o2eoRC36f0B53bIlZlo6DRPOEkKk4FKq7LPIidbzDqRDVVYEIDq2toa3Fp2jyrHUfB
	 RdzgnEXc7gMng==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-AF44-1001-66a1-C560-f4d8-070F.rev.sfr.net [IPv6:2a02:8428:af44:1001:66a1:c560:f4d8:70f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D74BA17E0FD9
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 18:26:26 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/3] Propagate disconnection reason
Date: Tue, 20 May 2025 18:26:18 +0200
Message-ID: <20250520162621.190769-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently a client application is informed of the disconnection by the
update of the Connected property to false.
This sends a Disconnected signal with the disconnection reason before
the property is updated.

This will help client application to know the reason for the
disconnection and to take appropriate action.

bluetoothctl is updated to display the disconnection reason on reception
of the signal.

This can be tested in bluetoothctl by disconnecting a device, which
generates:
[SIGNAL] org.bluez.Device1.Disconnected disconnection-local-host

v1->v2: Propagate numerical reason instead of text one
	Improve documentation
	Display disconnect reason in numerical and text in bluetoothctl

Frédéric Danis (3):
  src/device: Add Disconnected signal to propagate disconnection reason
  doc/device: Add Disconnected signal
  client: Display disconnection reason

 client/main.c            | 40 ++++++++++++++++++++++++++++++++++
 doc/org.bluez.Device.rst | 47 ++++++++++++++++++++++++++++++++++++++++
 src/adapter.c            | 13 ++++++-----
 src/device.c             | 16 ++++++++++++--
 src/device.h             |  3 ++-
 5 files changed, 111 insertions(+), 8 deletions(-)

-- 
2.43.0

