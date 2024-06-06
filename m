Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5682C3B1BC;
	Thu,  6 Jun 2024 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698647; cv=none; b=fE6kZFMXpQj7TN2119QLcoqnieBXFT9+h4eqWPy8wFe+/WMmYY2XrDezSkEautd3oVo5GWNx7THo0ly2D85wikWRK3sJyYq5R3BBguKkk7oXnuRUjAahfyuKGfuY2WOwNyoTbgNBFch8FP5csBLBqs7j2mCv7qvw9UexTcwYVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698647; c=relaxed/simple;
	bh=eiFOztAyht4OQS06fzz0niDBbZpbcltfMxTe5TVsVLU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Il/i04EnDoXim77I8ZRWvFIkqFuXCfpSUpiaXmL4kM/djtItLWwOMBpGzjV9XWhQu0fcVsZ2P3beqhV2wa70/UzTSXPwlOGvIhil0OUbGPVmmI1iflZT1WN6A/WpNc8sFU2026+sk/OazHpD6rKfmWFDHZDxGeL8iBbdcRTZHKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=BGHcMQ3O; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="BGHcMQ3O"
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sFHso-0090wq-34;
	Thu, 06 Jun 2024 20:30:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ychHDkTsgy+jS6D/8C9orKrwj+iW1wCK5Xyhu/ynjbg=; b=BGHcMQ3O39NECSs5U0lIjPkcxi
	8qfTfTt9TBD1iCEicDKWq6d/DdFXk7aX8I+24YODZgqniX28vFPilJU4KNODgGS5Lc8BvMM3X9DXj
	KX1V66fyJFSwCw09bgcpNpSAE1cU0MaSoBuiLqQADQtjrrHj0S5hIjzZ+1GlXMVmMp52mH72pBS6p
	EhFwz+L2okX1H9huaOv5LKCOEOnmlZUWDVoOv6CjsawqumfThyq6c03tcoLD+NIJwgS2D/Rk+is0w
	TzH4h7Gw1U7c6vNaS5n6mxts5F6sKB5iAwAC5uk7iEJMMDeCm6MZi4xSbVv364vGTkXIFV4/nCkTs
	8DpMruFw==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sFHsj-002nvS-1W;
	Thu, 06 Jun 2024 20:30:39 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sFHsk-002s4M-01;
	Thu, 06 Jun 2024 20:30:38 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan@kernel.org,
	pmenzel@molgen.mpg.de,
	jirislaby@kernel.org,
	andreas@kemnade.info,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
	robh@kernel.org,
	hns@goldelico.com
Subject: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
Date: Thu,  6 Jun 2024 20:30:28 +0200
Message-Id: <20240606183032.684481-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of these chips have GNSS support. In some vendor kernels
a driver on top of misc/ti-st can be found providing a /dev/tigps
device which speaks the secretive Air Independent Interface (AI2) protocol.

To be more compatible with userspace send out NMEA by default but
allow a more raw mode by using a module parameter.

This was tested on the Epson Moverio BT-200.

Who will take this series (1-3)? GNSS with ack from Bluetooth?

Changes since V3:
- Finally remove the period from 1/4 subject
- include things directly for get_unaligned_le16() to fix 0-day issues

Changes since V2:
- Optimize waits
- Fix some packet analysis / checksum computation issue
- Adding a proposal for removing those waits as RFC
- Minor spell corrections and improved descriptions

Changes since V1:
- Set up things for NMEA output
- Powerup/down at open()/close()
- split out logic between drivers/bluetooth and drivers/gnss
- leave out drivers/misc/ti-st driver removal to avoid
  filling up mailboxes during the iterations, this series is
  still a proof that it is not needed, will take the brush after
  this series is accepted.


Andreas Kemnade (4):
  gnss: Add AI2 protocol used by some TI combo chips
  Bluetooth: ti-st: Add GNSS subdevice for TI Wilink chips
  gnss: Add driver for AI2 protocol
  gnss: ai2: replace long sleeps by wait for acks

 drivers/bluetooth/hci_ll.c   |  81 +++++
 drivers/gnss/Kconfig         |  13 +
 drivers/gnss/Makefile        |   3 +
 drivers/gnss/ai2.c           | 560 +++++++++++++++++++++++++++++++++++
 drivers/gnss/core.c          |   1 +
 include/linux/gnss.h         |   1 +
 include/linux/ti_wilink_st.h |   8 +
 7 files changed, 667 insertions(+)
 create mode 100644 drivers/gnss/ai2.c

-- 
2.39.2

