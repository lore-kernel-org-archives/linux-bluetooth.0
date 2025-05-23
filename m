Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7631A5BBD
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747985220; cv=none; b=daMXQLPln+RBy9tvn2JGQIV5/HvzZM+A0bjqJ19S37gN3k95yGqCx9CZzdedXZtZqeMAv9TaSg6s9HAvpdK0m/NKPRrHQb7Av5+iapyXfoYvdewzjfIPuYj8tNUzKTyvl63a7kZW6Z9A5o3LD67HqvoyZy1luys+nciznoxrvR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747985220; c=relaxed/simple;
	bh=Gh72Q/f1jxW3RtpBujWN5zXw3qzNswzP55CXTSkJoc4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=TA5UQFTILUP9YoiIwi4InGZeKPUk3DbzF04+nnBgBZm0dy0j4Ra3kGKQcIa+eMSyr0wZDthbozkYT59ordAVQn/1mVCFZablqMbWVSXFcLnawv2MleIR7yk2tDmu1N+DdrCP3YXjeLrjJHlgfzDef+gSSjkovHQMrK0QrfVq4NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ktKn4NHJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ktKn4NHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747985215;
	bh=Gh72Q/f1jxW3RtpBujWN5zXw3qzNswzP55CXTSkJoc4=;
	h=From:To:Subject:Date:From;
	b=ktKn4NHJSVhSW7GlXJLW7iarKkEsBH9BVpKdrom/Mj3405PfWFN53TdEVgIysOCMa
	 QenLElldRkprtCTvTCHrek2+DVMRqhSsdtua+O8bru4+COL/M6eLB/NVXeAAScuQ8o
	 d9hmieu36Ldvex/WBLD6EhLoMSZ3AU/VfK1C23bxP1+0lEPeEtm7WSiYR+hnxQlOhO
	 8O6IXzSuqG03sprkNPn605DLI2npCB5UgBbbc720cb2HnA9HOIT/lTfgdLEuItsOz7
	 whSn4PcrBGGUfoTxA39UOggw5PlS/0YeKltae2Rl+43nV3Z1j5YiOzznctHIcmnp9p
	 sPiW4txVsqAXQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-83a4-18CE-8675-8031.rev.sfr.net [IPv6:2a02:8428:af44:1001:83a4:18ce:8675:8031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6BA1C17E0FB8
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 09:26:55 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 0/4] Propagate disconnection reason
Date: Fri, 23 May 2025 09:26:43 +0200
Message-ID: <20250523072647.689324-1-frederic.danis@collabora.com>
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
v2->v3: Replace numerical value by name and message to be more consistent
        with Device.Connect error reply.
v3->v4: Add MGMT_DEV_DISCONN_AUTH_FAILURE to be in sync with kernel
        definitions

Frédéric Danis (4):
  lib/mgmt: Add MGMT_DEV_DISCONN_AUTH_FAILURE define
  src/device: Add Disconnected signal to propagate disconnection reason
  doc/device: Add Disconnected signal
  client: Display disconnection reason

 client/main.c            | 18 +++++++++++++
 doc/org.bluez.Device.rst | 41 +++++++++++++++++++++++++++++
 lib/mgmt.h               |  1 +
 src/adapter.c            | 13 +++++----
 src/device.c             | 57 ++++++++++++++++++++++++++++++++++++++--
 src/device.h             |  3 ++-
 6 files changed, 125 insertions(+), 8 deletions(-)

-- 
2.43.0

