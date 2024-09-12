Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C35A143C6C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163371; cv=none; b=j5uFRIqkBBApIt5PLuVJ1f+QMknmxi2JOfFzKGo/BO9oYdJn7TNarCxfhRmdITwKRwkq/tWtrd1gjVm4UYwbnNWHKPaL4dlE1W9XwW46LKMd7K/RCwkMpl1Wu8ymHYKU2gdzXW71+C4nlWd9P4cjcBdNR62FoT46+gpcjdByng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163371; c=relaxed/simple;
	bh=rI5M+vvAgcB4GflgHj3Itv/xz1SZN7JWbqTWrPWbn3U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=YA/02gh6yBumMaCYSG1vAYbuxgM2AmaO+4Y4UV2LlLQhitmhYFHn5NZiK/+eVlIzQbn1xfiaiPHaeFuRpzTBniH9UmdW6Ej2DyGaR9TmGOT8iolTC0RT5R/38nGL1RONYLSgsY9vQAIR2b+jr1dySStEuItJPeYSyP9Tz7xBra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mGsha7Il; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mGsha7Il"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726163367;
	bh=rI5M+vvAgcB4GflgHj3Itv/xz1SZN7JWbqTWrPWbn3U=;
	h=From:To:Subject:Date:From;
	b=mGsha7IlQR5RCIEARMJow/LVhe7SbYMma8jo7OPcqLGxZPA4Vvy/ARYZI36hlGjnh
	 VLZEahCAaZZdyixe1glWolBOWEXCLRDFjV9vxkt9Xi2nCzv+mjPKdHChExRcw4dsWQ
	 7P/XyH5WaBYhGaHFuI7Nle6o5Y+wqsHSLLkydVXjIqIqT7MKzYfxHmXr02smXKSTZW
	 wg/XalGpBtPHyQpby6rsiCCk0hZY+BoWmtDfBWlir4RzwCNdgrpNrHEyIh3WhXsQEh
	 8Jqfuyk/Xm1Uyk06fDoqLeNY3ossoEW9x/goC4iBLXT+spxb6yu4YArx3mR8MD7tSv
	 EdCG1UVhguFDg==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B5A417E35FD
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 19:49:27 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/7] Add BIP for AVRCP covert art OBEX client
Date: Thu, 12 Sep 2024 19:49:14 +0200
Message-Id: <20240912174921.386856-1-frederic.danis@collabora.com>
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

v1 -> v2: Parse integer properties as integer instead of string
          Return GetImageProperties values as aa{sv} instead of aa{ss}
          Get properties for GetImage as a{sv} instead of a{ss}
          Set new properties and interface as experimental

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
 doc/org.bluez.MediaPlayer.rst   |  11 +
 doc/org.bluez.obex.BipAvrcp.rst |  72 +++
 doc/org.bluez.obex.Client.rst   |   5 +
 doc/org.bluez.obex.Session.rst  |   5 +
 monitor/avctp.c                 |   3 +
 obexd/client/bip-avrcp.c        | 427 +++++++++++++++++
 obexd/client/bip-avrcp.h        |  12 +
 obexd/client/bip-common.c       | 800 ++++++++++++++++++++++++++++++++
 obexd/client/bip-common.h       |  24 +
 obexd/client/manager.c          |  16 +-
 obexd/client/session.c          |  27 +-
 obexd/client/session.h          |   1 +
 obexd/client/transfer.c         |  16 +
 obexd/client/transfer.h         |   2 +
 profiles/audio/avrcp.c          |  64 ++-
 profiles/audio/avrcp.h          |   3 +-
 profiles/audio/player.c         |  30 ++
 profiles/audio/player.h         |   1 +
 tools/parser/avrcp.c            |   3 +
 21 files changed, 1514 insertions(+), 19 deletions(-)
 create mode 100644 doc/org.bluez.obex.BipAvrcp.rst
 create mode 100644 obexd/client/bip-avrcp.c
 create mode 100644 obexd/client/bip-avrcp.h
 create mode 100644 obexd/client/bip-common.c
 create mode 100644 obexd/client/bip-common.h

-- 
2.34.1

