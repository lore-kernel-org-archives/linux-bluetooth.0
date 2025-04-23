Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7BE149E17
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419262; cv=none; b=lbx4MUSd/NQZ2GRny0aejGMgQFL7TqQyQbRx5a30ZkGU8PSZpWolL2ysSOnzAYZylqYUtqmZ4UXe+ebA6EKKPkmVvBIMOysrfNYTKmB2B9jDTbeTy0HDAK9xotVZzGtSqMm5JQZTLc9NdxiZ3jJhCW/un7NYfvtKghfJTI0FlW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419262; c=relaxed/simple;
	bh=+wwhvVuRFH1OeEyTQ2APM8f3KNnrhvUDGB5OVHH93Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLWhbQuDNSAy/UiLruS1vDJn/8HCB6FPCvunoIMjq7ICqIjrEVEtF7lYFsaCRh3Fc8NqpcmajtxHezSpULLmK1bWZcKqAdofrCKDxkNpFIYnIUfvuSH8MEREowqA9B8LIBwPSboy/SvdyvXFIDeq7AwxKiDAdjYy67vbPbl4gWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dil8Hfl2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dil8Hfl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745419258;
	bh=+wwhvVuRFH1OeEyTQ2APM8f3KNnrhvUDGB5OVHH93Y0=;
	h=From:To:Cc:Subject:Date:From;
	b=Dil8Hfl2aPUk7ifsk00APhoOMtlhN2jIuanRLnkGw3gKQjQn+bKjncLjwLwZBJJtA
	 nf/XNZK6Q9diOm7YBhrB46b7ui975KXi97KtRPrETsqAUcK/LX7wrU44ADwEA79ys1
	 ncc98Fx0zk/dWgMVUmu6PWfwZdUfB7tUBS1ZCpIrnSnt34RuZWk1zPxJF1FXFMsqhi
	 f73NyJ8z7vnBAaoc/0YdMUDEX9k7vNcsSfMri1dyqAcg3A7OFkzmQg+H7t9cEvkJpH
	 mEPzkWtOwRHwpgimBAHboboet2la36cp0eVjNNuTgkePcvs2OiX1SY9o45m0eKABiz
	 USVCJ1UIBuUVg==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2797F17E088C;
	Wed, 23 Apr 2025 16:40:58 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v2 0/8] Support Sixaxis gamepad with classic bonded only
Date: Wed, 23 Apr 2025 16:40:12 +0200
Message-ID: <20250423144020.358828-1-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new "SixaxisCablePairing" property to allow us to
indentify sixaxis devices that have been paired using the canonical USB
cable method. With that information, we can dynamically enforce
encryption to drastically reduce the attack surface, compared to just
disabling the "ClassicBondedOnly" property.

The "SixaxisCablePairing" property is exposed via D-Bus to allow
clients to potentually show this information to end users.

As far as I can tell, starting the listening input server with
BT_IO_SEC_LOW and then bumping it in `hidp_add_connection()` should not
have any negative effect regarding the overall security. However,
please let me know if it turns out not being the case. 

The last commit "input: Validate the Sixaxis HID report descriptor" can
probably be reviewed and merged separately if needed.

Addresses https://github.com/bluez/bluez/issues/1165

Changes in v2:
 - Start the listening input server with BT_IO_SEC_LOW only if we
   actually have a known sixaxis device

Ludovico de Nittis (8):
  src: Add new SixaxisCablePairing property
  client: Print SixaxisCablePairing value if BlueZ was compiled with
    sixaxis
  plugins: Set SixaxisCablePairing property when pairing a sixaxis with
    USB
  adapter: Add btd_adapter_has_sixaxis_cable_pairing()
  input: Automatically use security level low when using a sixaxis
    device
  adapter: Set server security level in load_devices()
  sixaxis: Set security level when adding a sixaxis device
  input: Validate the Sixaxis HID report descriptor

 client/main.c            |  3 ++
 configure.ac             |  3 ++
 doc/org.bluez.Device.rst |  6 ++++
 plugins/sixaxis.c        |  8 ++++-
 profiles/input/device.c  | 77 ++++++++++++++++++++++++++++++++++++++--
 profiles/input/manager.c |  3 +-
 profiles/input/server.c  | 62 ++++++++++++++++++++++++++++++--
 profiles/input/server.h  |  3 +-
 src/adapter.c            | 24 +++++++++++++
 src/adapter.h            |  1 +
 src/device.c             | 44 +++++++++++++++++++++++
 src/device.h             |  3 ++
 12 files changed, 229 insertions(+), 8 deletions(-)

-- 
2.49.0

