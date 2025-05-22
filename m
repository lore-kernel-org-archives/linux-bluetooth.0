Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312362F41
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928994; cv=none; b=bTtTjFahDkZXR4GWFb3qUttQcWft0gQdN3l2uBITWDxPLk9aIg/TvR3vbiCx76zCHch3vqs14xCJU0dvtCia5WsNxlVjzNFsue7ekKeOSvDOWqGs8Ac2PCiSuyXs6C+GGEddCKPXuJKpZQvwb7pAgLhBO4QK6z7tWKZ4dzcpDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928994; c=relaxed/simple;
	bh=Ae7fbk+bR7Ko6hPug2fRBsjvMwugg2hmJCOeh44DWVQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=QXE8693HmZW0Gzy+n2uIPq6Njvzn/uxOqNA0dsc0E+YzY9XlSwwh+0ZbRTojA+T039gpH4blql7pVZsNRbLB5MHYGw7jn4HYWNAIjG2xB+Ug00MIvmq0b+wg+TVpeKjevycVxEbNmgPh2pX6hQiHJ2IJsq7JqFvtznUVFeKu+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VF4+XsLr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VF4+XsLr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747928990;
	bh=Ae7fbk+bR7Ko6hPug2fRBsjvMwugg2hmJCOeh44DWVQ=;
	h=From:To:Subject:Date:From;
	b=VF4+XsLrVIsmBqK5UpYgER0n0E7+kCmKkZo5bDMhc5X8Lxl2WL756OrKpcWCDjsCk
	 z8jm8vE1WIZNBBwBGbTqTHQwO5H4+FWFCbWNVrE6b/cQ4VTB3fa7i5GHnsO8kdBZ8a
	 YZNvptCOY12kCv3cQkB35NWf4H+A8DWjmiDdb+ihrB2XAhnh/AjdBHuWg5e5CVzIac
	 SoOlsWYLY80bd4FjjHQZ/rdoIlVs+uJcqNrZnB5m8UBXuoaLxL966244ntBYhJbLCO
	 k6RbhDC0sDxPjSJ6bDIX8Ir/ueMs7D2AFCxkR3XM1UdUUNaafcNMI/0AUoGHgrQwK7
	 MudyJKYxnUV+Q==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-c115-20FF-2911-21D4.rev.sfr.net [IPv6:2a02:8428:af44:1001:c115:20ff:2911:21d4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 06FEF17E156C
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 17:49:49 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/3] Propagate disconnection reason
Date: Thu, 22 May 2025 17:49:41 +0200
Message-ID: <20250522154944.665655-1-frederic.danis@collabora.com>
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
v1->v2: Replace numerical value by name and message to be more consistent
        with Device.Connect error reply.

Frédéric Danis (3):
  src/device: Add Disconnected signal to propagate disconnection reason
  doc/device: Add Disconnected signal
  client: Display disconnection reason

 client/main.c            | 18 +++++++++++++
 doc/org.bluez.Device.rst | 41 +++++++++++++++++++++++++++++
 src/adapter.c            | 13 +++++----
 src/device.c             | 57 ++++++++++++++++++++++++++++++++++++++--
 src/device.h             |  3 ++-
 5 files changed, 124 insertions(+), 8 deletions(-)

-- 
2.43.0

