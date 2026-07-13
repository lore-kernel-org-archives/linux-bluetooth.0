Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984D2652AF
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952393; cv=none; b=W+X6BhzjCoX09kCBPaP4wtdTznPW8+uvIZ2YFwpH4td+JFEMBORxobDALVO+9VbhHe41xhS4AT/j7cqXqKxqdGg506a3Y8gf5cH4gBT9VTG8l+4QTh4Pju2LH/dOGxDWXFM6cs5iCaKSlDAuKlXdJpN4X6IWTyJg53F2ai/5FHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952393; c=relaxed/simple;
	bh=HSlD0G+1NO1J804SwzOhBO53801rZi0eAjWh+vAbNjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtkcDDxyAZnCgQIreX574oqmvbd0MTlx0GDOjimXHXN6kDeX07jm3N0IGSntZrFyM0rSo5YjQXyNFcq328m8QmQsjNvplrRuRH1Dwcm0uRYr/cMSCMQOb7jdUu2HmTyBKLgP9433v5kpN1rb/14PTYk+vcNaHn/s5vCLRoOQOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN7w3NJB; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN7w3NJB"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7380954d1c6so1141128137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 07:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783952391; x=1784557191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tHRuq+0PlV02iNJ53ayTa7ZvWzJi1MCxKOTZd93rI6Q=;
        b=AN7w3NJBz1dMUQtNIMV5a9gSaPc5m/Vh4kf/3o/gp0Y3zqU6k+vYflYRrA2u5gHaTq
         XYC33u+CM/SwfzMUEZVXUY2IIk/96V+Shm3EsF6xPIshu9WxXJB5Xq3Ik42ZCuuQ8Gv4
         k0VsNuQm6vxTHTI1e+in7iB57dTjnNInYIuuXSItFuKfyCpoYWV+ZJEOJkzgEGdRDVUI
         lUoEUDjQd/qgVu9awhXAsNTXq55qPYxCb2YSIzdynckGq0JxePKHXtYAKUgmiOas+VhA
         gdS8gRyVGBEnupfnaJBqcBn6ydeHgZuqyvy5DY6XO+faxkvc45I1u/+MntFLS5wFPFiV
         CFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783952391; x=1784557191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHRuq+0PlV02iNJ53ayTa7ZvWzJi1MCxKOTZd93rI6Q=;
        b=PC2MfEc/lNsEB058OX6Opr3D/YU2Z/K/bmfXophRH9aLjjPUnItGXXPLPmbr/BxbTq
         bgbC0YIXkpWFOGpmUekpYuuQGi6vmJaY777Iojtn4mHqSYWfGJExISqadi1HGOwxg6i4
         jqANhfoCBC8VUA3RF3m2BpHhOv2f4olpxeC5PVeZgvDQ9MCcw+ZwuoeEuS7FsxoWR5YW
         aebO0ctDiE3okBi/vjnZMKhkLlZvVEb24oFmON/5UcFb0ahn5G8/TT1X69fCUaP0/KTK
         +zBJE+FxOkzBJrk56I0qMfO3EbawAnOxkzaZFrxxU9pW+BFOThfOGAq2TN80DFTSWyCz
         aqIg==
X-Gm-Message-State: AOJu0YyUdv0nAU4SR2qictBFgevBOc9+ibbH5iAVC/WmsM30DJlhPX/s
	Y9aThiqh/ZSCpwhaT3/BWzyEn7ysQV3VNoYrMyJLcv1RPzVDks1jXqbvyZOXmVNp0t4=
X-Gm-Gg: AfdE7cnTL3fwYPn2Vv7Pl8GpgVj6J2wl8FGmzOmDg4RlzygqCt3EfxxOgjpkOSOHVRk
	Scm/R19bZWm7aWASUeriOX75VSzP2JQ7m1hha4igNmFAMpuwqsDpLj2l/Ouq1mp8BY35g2Xeo7I
	EW/mItAxsshtQLTpmhzsCR9+pUl90xm0amf3YpczSIPeYvh52cqaiPWnvGcXmAxv1EnApF6a9f5
	dvQcDKrk+ctnvj3o6Suo7lytPZSUh9vK/gBAEinK7mgm6MNlyXWE+r3WEyE2vhvrH5WrD+gkAte
	h3rmBMR0eoAesO9+ZjvRyQy8+YM2Vuh8/YxobaWDHxnnotaxRQMdd7YjBxkGL8uuLTs8aINUvzZ
	MhlLL663ufExBWUa6rdZ0Pl0RQoHVuMxJz5WvOhpmsIIwZD9IgBx0QGDbWLq9TD/vHjueE9eGIy
	i45cOOpHJzh/wbNVsqsRNoxUahlP9NmvBmrQhvuNYmvj7sti1hx17ts2XCiuq1z2RHAYFXHQ9wf
	tuXZW8=
X-Received: by 2002:a05:6102:4487:b0:73e:9fae:5841 with SMTP id ada2fe7eead31-74533ea3581mr5049701137.29.1783952391050;
        Mon, 13 Jul 2026 07:19:51 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6e38b3bsm8980017137.10.2026.07.13.07.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:19:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-07-13
Date: Mon, 13 Jul 2026 10:19:40 -0400
Message-ID: <20260713141940.954317-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 3f1f755366687d051174739fb99f7d560202f60b:

  net: openvswitch: reject oversized nested action attrs (2026-07-11 13:09:11 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-07-13

for you to fetch changes up to c1cec2bbbeb5922d42d28c6af1707c4f3f8647e3:

  Bluetooth: mgmt: Translate HCI reason in Device Disconnected event (2026-07-13 10:10:13 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: hold hdev->lock for hci_conn_params lookups
 - hci_sync: extend conn_hash lookup critical sections
 - hci_qca: Clear memdump state on invalid dump size
 - MGMT: revalidate LOAD_CONN_PARAM queued update
 - MGMT: Translate HCI reason in Device Disconnected event
 - MGMT: fix locking in unpair_device/disconnect_sync
 - MGMT: hold reference for hci_conn in mgmt_pending_cmds
 - btrtl: validate firmware patch bounds
 - qca: fix NVM tag length underflow in TLV parser

----------------------------------------------------------------
Cen Zhang (1):
      Bluetooth: MGMT: revalidate LOAD_CONN_PARAM queued update

Laxman Acharya Padhya (1):
      Bluetooth: btrtl: validate firmware patch bounds

Mikhail Gavrilov (1):
      Bluetooth: mgmt: Translate HCI reason in Device Disconnected event

Pauli Virtanen (4):
      Bluetooth: hci_sync: extend conn_hash lookup critical sections
      Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync
      Bluetooth: mgmt: hold reference for hci_conn in mgmt_pending_cmds
      Bluetooth: hci_sync: hold hdev->lock for hci_conn_params lookups

Ruoyu Wang (1):
      Bluetooth: hci_qca: Clear memdump state on invalid dump size

Xiang Mei (1):
      Bluetooth: qca: fix NVM tag length underflow in TLV parser

 drivers/bluetooth/btqca.c        |   2 +-
 drivers/bluetooth/btrtl.c        |   5 +-
 drivers/bluetooth/hci_qca.c      |   4 ++
 include/net/bluetooth/hci_core.h |   1 +
 net/bluetooth/hci_event.c        |  18 +------
 net/bluetooth/hci_sync.c         |  66 +++++++++++++++++++++---
 net/bluetooth/mgmt.c             | 105 +++++++++++++++++++++++++++++++++------
 7 files changed, 160 insertions(+), 41 deletions(-)
