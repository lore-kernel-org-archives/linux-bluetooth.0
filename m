Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7F1EB2F
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671264; cv=none; b=jtw5TpDCMrrjilSB8cMq1oNVMt5SqWnG69rVVE30gmLUOvESteA4v6tmySNt3Phq+H1stzTWSHTcvZEDdsaNGZNrpazpQXL95tiVkmAV22ENCmP4q1sKCihWgILiPS5ThgCRf22Gvh50wXMK1XIU8u4lhTB8amCsV/Boe3IJr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671264; c=relaxed/simple;
	bh=Z3+nTdXhQqix0Zu0u6QDAywBrx6RzSjxMeKJlinkOSo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=tSGcXx/0FUAhGyCWz0YF3VZjogidGZjygbisnDlk9WVxO4jJdIbWWVuDoW6189pgQ8IBjvWOAtOpyuZAdZNUMLVl1DwvKtEtfIhpatLzq7QNQ3enu+Sxby4Eu7FSDmf7KPpBpAAplWTuqPUDBlvqlwHuNerok54GROS89sB5y48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kXi4pQGK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kXi4pQGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747671258;
	bh=Z3+nTdXhQqix0Zu0u6QDAywBrx6RzSjxMeKJlinkOSo=;
	h=From:To:Subject:Date:From;
	b=kXi4pQGKXFBzlBqVuYocqXlyT5sQRZncl2viCyyiTNO87hjW/88pNJmzeTJtUvfyi
	 J81BGgRmYeue+V5URQS7s1Omh8tBZ5pejJk66THOylk96n2yKluf5rvmzUZGPf5m62
	 GJEMCKza6c939wU0wmViJp5dG1I23M957Nop3QZxgNntuWoiEKwJojadWvrpA8PDCV
	 5q0c5sJW3Hm6OshMrbbqA6UFz2mUQT8rZLikCsbHSqQfkgQg73uelotAIgE+80xfcJ
	 nYpSm8CXpvzktDC8qbuIOJIIJr16sledsZBA8qYAfZudKIJqraQBnU+OvnHGHYRPtH
	 EBcuoNjPAo3zQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-131b-51fE-028d-5689.rev.sfr.net [IPv6:2a02:8428:af44:1001:131b:51fe:28d:5689])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9A5AE17E05F0
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 18:14:18 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/3] Propagate disconnection reason
Date: Mon, 19 May 2025 18:14:09 +0200
Message-ID: <20250519161412.107904-1-frederic.danis@collabora.com>
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

Frédéric Danis (3):
  src/device: Add Disconnected signal to propagate disconnection reason
  doc/device: Add Disconnected signal
  client: Display disconnection reason

 client/main.c            | 20 ++++++++++++++++++++
 doc/org.bluez.Device.rst | 17 +++++++++++++++++
 src/adapter.c            | 13 ++++++++-----
 src/device.c             | 37 +++++++++++++++++++++++++++++++++++--
 src/device.h             |  3 ++-
 5 files changed, 82 insertions(+), 8 deletions(-)

-- 
2.43.0

