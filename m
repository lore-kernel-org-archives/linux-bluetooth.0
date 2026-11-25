Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593436;
	b=DFaUU70+GjjCW1g+aQEQienywiCz8FGOL8rmXuM+mlVKdtEWZ4Hh+bKP79k1uZYIE9Or
	 OCJgwN1Nue10PTQ20EwDc80etcL5+mgPQWpu/ypuZkkarppzutbWb5pTGExRKAY0YNdZd
	 JhD/KAmpQsUwbfkTbwESI+Kyof5Q/X26+gTB/mYL5CUqhEyYRJcXtrjSjogm/6tjZvSro
	 2UjVHx3tPeoZvpBVZjImJROiez3mS3ByaCaFmJyp3JJr37lYL8hBSpUbSaygdmpMgRtAf
	 W1eeq8N50JBoXGBBy4dcMVIrU2d48SuHwR++Uedh5JELcDavFq3t5jboSCIe0xa0yFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593436;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Type:
	 Content-Transfer-Encoding;
	bh=GYNbbugO/NZ6w6cd+8ISkdbwHoQ/wRI4QCWh7H+kQts=;
	b=Fu40MTx+ftxnEvOILHURIaA5XCldMoMacbKoLaSUMErnrGp5X83uLQphMr8aYzuB/O27
	 2rESZ+P3SPtOOFy7ir8fwnKop5Bmx0i1qKgcPAm4L13vEWFkKWaojnayp89Cv1ETDGspJ
	 OVsvGru/j7yY4g1yQTYe0vZ5orig2xsLWmPvsvgBhjOUasRrmGpHHROEznIJzZavL2ZQv
	 w0OSVPsyvSg/YRifvj5j0XHchFYd/k+xj3QhAWRdf6K04zIhZdtKeMf6EWHO43pCiNH02
	 jO/Fkz6fv8cUTcOHCw46AlObDgLElEyqk41mf6lEn9YrpDiqRCPeixp6lGFILt00kLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=RBaCbnrd;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF18E606A327
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF18E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=RBaCbnrd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795593434;
	bh=l4da9cLDskRYCgqJuD2wnlA4gHc3xgjx0661iO/PVno=;
	h=From:To:Subject:Date:From;
	b=RBaCbnrdblcfo2i9PzAiTGZriONoz0n9ADSaOwYvfCJDIymFbt8CYlVceopNHHQBp
	 04mqcjIKyiPQqAOw1Av+o8sUmMSu8Ib20d3dPF2LaW7m4ijuF87ZsWuMsYg89BYnhv
	 BBE5UdZEMJyJda81U5nzl+l11v/PBlnmyV8kTKC3xzBIfo5+wwvQXDCedy+cLHefgh
	 FTeZME7YYLn2qb7WkqAOj2A4oddwf9ui8UjiwAgHIAkrbGnbmfoYLqwE3H96gBOH+c
	 WUMCU2so9NDv7zfNDfb1fDNtO71zAwysrtwnvJkgEeBq9aEMDmIeJyUbsP5DDQdBx+
	 C9Qy9QGUS0iAg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EB70E17E04F7
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:57:13 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 0/3] client/btpclient: Security Level reporting
Date: Wed, 25 Nov 2026 08:57:06 +0100
Message-ID: <20261125075709.459719-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Set org.bluez.Device SecurityLevel and EncryptionType properties to
optional so application can access them only when they are meaningful.

Send BTP_EV_GAP_SEC_LEVEL_CHANGED event from SecurityLevel property
changes once the device's services are resolved, matching the BTP levels
expected by auto-pts.
This reduces connection time for the BAP tests.

v1->v2: Retitled patch 1 from "device: Provide Security Level related
  props when supported by kernel" (subject line was exceeding the
  mailing list's 80-character limit with the series prefix).
v2->v3: Patch 3 (BTP_EV_GAP_SEC_LEVEL_CHANGED support): only read and
  report SecurityLevel when ServicesResolved becomes true, so a stale
  cached level isn't reported as a security-level-changed event when an
  encrypted peer disconnects.
v3->v4: Patch 3 (BTP_EV_GAP_SEC_LEVEL_CHANGED support): fetch the
  device's Address/AddressType D-Bus properties instead of reading the
  btp_device struct fields directly, consistent with the other event
  builders in gap.c.

Frédéric Danis (3):
  device: Provide Security Level props when kernel supports them
  org.bluez.Device: Make Security Level props optional
  client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support

 client/btpclient/gap.c   | 65 +++++++++++++++++++++++++++++++++++++++-
 doc/org.bluez.Device.rst |  8 ++---
 src/adapter.c            |  4 +++
 src/adapter.h            |  1 +
 src/device.c             | 13 ++++++--
 src/shared/btp.h         | 11 +++++++
 6 files changed, 95 insertions(+), 7 deletions(-)

-- 
2.43.0

