Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F7175AD
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493308; cv=none; b=WsHVbLQAqMz7HyblxgrxFw0VFCBmfZ3RXsc6TmZ7H6Z6QRTCBVGQPuw5v54/YoknFsUj4LISlyqJ6zkC6geTJU/0WFVZ5ktdOB9PNfmkjckAPDX1mwD0Q747bnIaqLtDlf8tql6YHEerC6kdVsYWjw/vZhNLo1lBkHqKtzogjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493308; c=relaxed/simple;
	bh=F89kjAJ2udWpisCQNTJexB45QyGdoSYLYfm+tZfpdBM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=i6rcKsxrPQY1F6sOGfE8yAv1RaVcEM+DYZXr1x8HTrkfdyWyEz4vxCv0Y3b/UpS9JrG1WMb38erFNMznbsL/oVsXoHy03m4sVGRoC1WD4Slcc+KxKNW0APt4xYodbira8DoCyFen7qDYP5Om3f9yWFVLmWyhtEtyZs7PZ7WIIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SG/WWx0/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SG/WWx0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726493298;
	bh=F89kjAJ2udWpisCQNTJexB45QyGdoSYLYfm+tZfpdBM=;
	h=From:To:Subject:Date:From;
	b=SG/WWx0/7UNiEVSDWeAC9W+W6j4DmhZ2QUhSy5uv8wHJF1ETsLFQXzPR1fTOxhD7+
	 kA5qO1Ae8/wpPgUPSjGXvl+B9UQ0pwAFQ5KjNqJX2tyzh5rskSmr6i6dbggYT4hjzS
	 sppArX8k+KTe5duapMs1WHUvEuGOyRvB4/LBo1jAuODzb6MHPDNfvXQisnWEhK26SN
	 TAo6i4cDNbQ7N+bytiiSTg2j6jqXLqbh3ac4skS6gqsqoyvFV+2PPuLGMiPJhlzP9f
	 /aKEPdnVTrJBU/BheBYPDk25kDLu3IcFmClf2puOmiPlWH/ZAh/fvm+LW2RfcD1vLD
	 SEcm7KGFkcvoA==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 018C517E14FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 15:28:17 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/9] Add BIP for AVRCP covert art OBEX client
Date: Mon, 16 Sep 2024 15:28:04 +0200
Message-Id: <20240916132813.165731-1-frederic.danis@collabora.com>
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

This has been tested with iPhone 14, iPhone 15 Pro and Samsung S23.

v1 -> v2: Parse integer properties as integer instead of string
          Return GetImageProperties values as aa{sv} instead of aa{ss}
          Get properties for GetImage as a{sv} instead of a{ss}
          Set new properties and interface as experimental
v2 -> v3: Rename obexd/client/bip-avrcp.[ch] to obexd/client/bip.[ch]
          Update the AVRCP Controller version in SDP to 1.6
          Add commit to support for specific headers in obex transfer
          Fix memory leaks

Frédéric Danis (9):
  obexd: Add PSM support to session create
  player: Add OBEX PSM port for cover art support
  player: Add image handle support property
  obexd: Add support for specific headers in obex transfer
  obexd: Add BIP client for AVRCP cover art download
  obexd: Add GetImageProperties to bip-avrcp
  obexd: Add GetImage to bip-avrcp
  avrcp: Update controller SDP record with cover art support
  doc: Add description of org.bluez.obex.BipAvrcp

 Makefile.am                     |   9 +-
 Makefile.obexd                  |   2 +
 doc/org.bluez.MediaPlayer.rst   |  11 +
 doc/org.bluez.obex.BipAvrcp.rst |  72 +++
 doc/org.bluez.obex.Client.rst   |   5 +
 doc/org.bluez.obex.Session.rst  |   5 +
 monitor/avctp.c                 |   3 +
 obexd/client/bip-common.c       | 800 ++++++++++++++++++++++++++++++++
 obexd/client/bip-common.h       |  24 +
 obexd/client/bip.c              | 440 ++++++++++++++++++
 obexd/client/bip.h              |  12 +
 obexd/client/manager.c          |  16 +-
 obexd/client/session.c          |  27 +-
 obexd/client/session.h          |   1 +
 obexd/client/transfer.c         |  19 +
 obexd/client/transfer.h         |   2 +
 profiles/audio/avrcp.c          |  66 ++-
 profiles/audio/avrcp.h          |   3 +-
 profiles/audio/player.c         |  30 ++
 profiles/audio/player.h         |   1 +
 tools/parser/avrcp.c            |   3 +
 21 files changed, 1531 insertions(+), 20 deletions(-)
 create mode 100644 doc/org.bluez.obex.BipAvrcp.rst
 create mode 100644 obexd/client/bip-common.c
 create mode 100644 obexd/client/bip-common.h
 create mode 100644 obexd/client/bip.c
 create mode 100644 obexd/client/bip.h

-- 
2.34.1

