Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E6984A35;
	Mon,  3 Jun 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425871; cv=none; b=EGplKHKqCvCi8UP/HvGedj/rHtcw/otAgDKurbV1IVjJ6eucZbsQcnMdSuPgR5Yc8CI/GlQBVwbTLgMNejfwaDWF0ETupTuYy0cdCKn7g5e0I3Hc7f4ZJRZ++U0Igxgkzcgx3Ho69ksJhm42IKGnVQE47aR4nXnui/DHrDMpsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425871; c=relaxed/simple;
	bh=LL9VTFcQkhlxWV1L/jgrJeTOtwYRWbP06bumMRDRhSI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=hJ+heJ+m0cwkPpfc22loE0z4SSJ5iPYefRrSfLLKiLVCAZg3IQXRXOJ7hSJWmFOcISbxKHGgv8/eBS7I/nHgDYnnTdKqfXKlNJBz8AeGboh7oF17qOFoRd/PaBncdv1NF9uxxL61dIruUshgcx44yml+69LawLnO22i+1xUiPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=pp7Ap/yp; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="pp7Ap/yp"
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sE8v6-008hAf-2v;
	Mon, 03 Jun 2024 16:44:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=brF7VvD3tRd3wTM6Hl6zpzwjSLrm8R+002hZn2Vpoiw=; b=pp7Ap/yptWDGmByh3o0em4Bf5E
	wO8c3Y/RAUi+KuVxRdTqJRWyATtsTGB3OP8db3xSbMqK7hR2yJGhXRHWcxbWF9F7pIYC/mNGvi+Ez
	CSRINYpOz+DJd1FEJKx17YXgJyYJ59frgrZcFPmibd6u+6wWZa7FOVYpWkHNmWlnDJ/D/OdavGbWo
	5sru4wx1+jlgeBGstFCzZ8RGjW93MTEQS9C0llNO+cQMd/PqwPsTevI0v5WqCWTesrkZrbNSaNv0C
	ICX7BFTj6VY0+WxyxwyKB3c3FSPwH7K6ti2/NcmMMAWqTMTOYvdNMmRrvXYCsDL2EKLMP1TGFSCxx
	3DYVgRlQ==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sE8v2-002UeY-2a;
	Mon, 03 Jun 2024 16:44:18 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sE8v3-009DAi-1F;
	Mon, 03 Jun 2024 16:44:17 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	andreas@kemnade.info,
	pmenzel@molgen.mpg.de,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
	robh@kernel.org,
	hns@goldelico.com
Subject: [PATCH v3 0/4] bluetooth/gnss: GNSS support for TiWi chips
Date: Mon,  3 Jun 2024 16:43:56 +0200
Message-Id: <20240603144400.2195564-1-andreas@kemnade.info>
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
  gnss: Add AI2 protocol used by some TI combo chips.
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

