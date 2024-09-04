Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19D1EBFF7
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458671; cv=none; b=gkmxYFRlZg2COZGe/Whn+mD7vdjtVwXPBmAPaOymWsjqJc9aDjBAk9URiuP0+unqidwQxqzllG4ZNPDe1HsUcsD569V3Xrslydf4LJ9pD14xpTiy3e5aOaaYLh7cRnfvDJPpha3pyP3nXekwuTn8jeSgmO2lkSaOW/7nbmiDkR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458671; c=relaxed/simple;
	bh=gDMP2gK8J2yWeRJeh/SfzYN9ZzIPbzdUti1PMTOKawc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=ZK1Mwzl3uQfYsxFP5LgEBNzrLl+z46cWdbscHGz7fi9vOmWTNfW5x4uCfv/gEVxdRdJB7WtoRaL6Qc9Vy8NaxxIcI7uQU6AFhrD/ozzMpPTK+zvjGL7axCu6WumsBqyVK1g1mmc9paXlbt+2UMFLHdA/KRwKvk6PMO02zBXym8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MQOBRilO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MQOBRilO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725458668;
	bh=gDMP2gK8J2yWeRJeh/SfzYN9ZzIPbzdUti1PMTOKawc=;
	h=From:To:Subject:Date:From;
	b=MQOBRilOvEq0HlT0bTm66FJNzE/KfROdNBqns68DOL+0CiHVQQAB1Mu3VRK6xJwiq
	 uXwF0XFINQGUXrFL+bGFDyhemEKtVt4sfEJlSrc7H5D38nrehFAbMaVfBhDFGdZyf+
	 coKNb5sulCP3ZegaYjduCznc9JxBYJIjorGUMkt4xUiJacJAMNTOuqQVWuhLEQHUMW
	 LfclF7dI15QFa6rf2Krua9/tDEVSrC+IcKOjDGr/x5dxsFZQCNT+IdhW6M4cXak+XR
	 QhjwkfqXmpUW6E3h76CFPf0q2+oqyHUO/bhOGyClF0kkTn3x3ZPmEJFLecBa4WKwNd
	 GBZ6USORs6aNQ==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F361D17E10C2
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 16:04:27 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/7] Add BIP for AVRCP covert art OBEX client
Date: Wed,  4 Sep 2024 16:04:14 +0200
Message-Id: <20240904140421.283166-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

If AVRCP Target supports Cover Art download its SDP record contains an
additional access protocol for OBEX with an LCAP PSM on which the OBEX
client session should connect to, with the specific OBEX target header
7163DD54-4A7E-11E2-B47C-0050C2490048.

Once the OBEX session is connected, the AVRCP track metadata will contain
an Image Handle which can be used to get the associated image using
GetImageThumbnail or GetImage with one of the description property found
with GetImageProperties.

Frédéric Danis (7):
  obexd: Add PSM support to session create
  player: Add OBEX PSM port for cover art support
  player: Add image handle support property
  obexd: Add BIP client for AVRCP cover art download.
  obexd: Add GetImageProperties to bip-avrcp
  obexd: Add GetImage to bip-avrcp
  doc: Add description of org.bluez.obex.BipAvrcp

 Makefile.am                     |   9 +-
 Makefile.obexd                  |   2 +
 doc/org.bluez.MediaPlayer.rst   |  10 +
 doc/org.bluez.obex.BipAvrcp.rst |  72 +++
 doc/org.bluez.obex.Client.rst   |   5 +
 doc/org.bluez.obex.Session.rst  |   5 +
 monitor/avctp.c                 |   3 +
 obexd/client/bip-avrcp.c        | 421 +++++++++++++++++
 obexd/client/bip-avrcp.h        |  12 +
 obexd/client/bip-common.c       | 769 ++++++++++++++++++++++++++++++++
 obexd/client/bip-common.h       |  25 ++
 obexd/client/manager.c          |  16 +-
 obexd/client/session.c          |  27 +-
 obexd/client/session.h          |   1 +
 obexd/client/transfer.c         |  16 +
 obexd/client/transfer.h         |   2 +
 profiles/audio/avrcp.c          |  64 ++-
 profiles/audio/avrcp.h          |   3 +-
 profiles/audio/player.c         |  29 ++
 profiles/audio/player.h         |   1 +
 tools/parser/avrcp.c            |   3 +
 21 files changed, 1476 insertions(+), 19 deletions(-)
 create mode 100644 doc/org.bluez.obex.BipAvrcp.rst
 create mode 100644 obexd/client/bip-avrcp.c
 create mode 100644 obexd/client/bip-avrcp.h
 create mode 100644 obexd/client/bip-common.c
 create mode 100644 obexd/client/bip-common.h

-- 
2.34.1

