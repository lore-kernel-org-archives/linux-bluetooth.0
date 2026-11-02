Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658022;
	b=Amp5xzBbdBgj34MLwQWPkqkDqodNnhMZvFHrGfCQ8nm7PuaRXSJRTnF0GL/sfipKRfVm
	 l1jrDHTO3/u1sOUi7+4es8M3tgh0NVKcO/6KhIahdUMvp/NxD1WXGWlgx46kysfnxUKTj
	 LrQgqhyf8CjxVqLMASDF534lb1z/Yuuy3HTZ70bmS3GM/8gX0OKpryu45iUKx+jT/S2OO
	 cZRqIOvztoshXs5w7nzBvfIRLMm35XEmxYXq00VZZk7OhQmcbFQtA6J2eA6xBJLGVYdu7
	 Hj0z0zaqxgOlYH88i43Anf9p9kMlaz26oTzBfjqPsMMYViKG1T4lcDhSoqiHqnUyN5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1gEpsqS1i+/K0+uv78zfDi7xU2QuotIgijxmoIPRWJ4=;
	b=XdLCAOEYIZcgM84DNr5b9h4DwITnxyJDZ9UG2E/19Mlpj/mTFjr5/rYKXnvQOUblr2Hw
	 u+U9fGsd5bbxFTAaKPWoIuVQ9+uaGgyQzAVznNQvoqv+uaZ2nG7fcZ39etMsOjIGyD83k
	 uiF1Aku2cFHgM2VhFaxwVh8yPaG9zqA4OK+v0ByWTtEPdf1lTh+RA8qr4Px4GQdHF/QTP
	 WLM1MUlwtOVqFbk2+S7BPmBzghQZatM93bqVOyP2q/HMlyFML5z/xj8ZNcqq65WZtZO1E
	 iG/jGIR6OZCvdttj9dO372nsEnqaPiCYVGYef7W00x5L3B8FHma+XBE9zyUnKYutNog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJsgLaiy;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E3606A327
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 22:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 968E3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJsgLaiy
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so2829568e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 14:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793658020; x=1794262820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gEpsqS1i+/K0+uv78zfDi7xU2QuotIgijxmoIPRWJ4=;
        b=WJsgLaiyFWH3yZDo/24vhifFvQJoqbaSVBGEmcXUKvU8bJyPaXDbZv3KIRZGNZK5Va
         KOosJxWAmg4Ceu3szZ6RQxccpK82hsNpeEp3EcasFwF8zxHiMG49RKmLB1+9GlsENLzj
         ygSWBrcMuhZy2QqFjFywZk6AWG0ExFYROIJ+qTUtwpbmLrQjsuewnq9eBljKWf1v6FaU
         pWwP1H5wH1FmARwh/PXySglLBakJ/uVb4fdR0bDJpZRVmVahjZkA+eF8ds2SO6l5gO8j
         slxkq8RHQ+8pFR9J5lJVdiyycHZANNMZq/e0xTdi2vQZ32HeQr7IEN/a2I8xPEMYfJvP
         Qm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793658020; x=1794262820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gEpsqS1i+/K0+uv78zfDi7xU2QuotIgijxmoIPRWJ4=;
        b=KutuiH7rDAZUkvH/puQoiCA5NBHY6ZVYhfOYufowXf5hr4IBTqc5BtIfJQLciJH/mG
         kPs4kJIeGgnmgImPO5Lvk1Tm84MoK3NdcypZx8TXrydbovRUF2RwVD+RF8uwpQOGJ1ES
         EMupovTFnxDCVf5TSZDVPRgSmxNrcfI09l6fm+BLA+hbb4nPOpSlZ+DHYVSpnG5mDCBi
         RgUaZZflSgvvO+XG2NyJczqmHnlScUflQAMQhA42+9SLrARlE5thtpuHTalpzciwZACE
         Iv+lTWuKVXWdH19tIDnwwbTxz5JkQ970ZPVaBZCYNcrzp59fo2Lk3fh7BVw+St6RKHIe
         ol6A==
X-Gm-Message-State: APuU4Z/GR8wYPS+DmAHjE7wpPKKxvlH49XRk8NsnT9dkhbqwYTARBChC
	eeuZyfI3hxqrC7cXs52n6B2aaL4uB6P+jQQYXSJ8ETkYdHZCMRnZWd1D
X-Gm-Gg: AYBFou2jZ82GqeJgInLXJQCMXRuQTMlNIrOS6XpCsA3Znwoyp/3Fnza6zXYVytmHV3p
	2pbw4or4ZGCXWVRHgH5107fLJiGKDZCBqPGFM3eml9jGqrEFWJOdYXD+zvcMhmC2r8/Rk/qFnf5
	KcziTU2gvLQaz4ElimOk5V2T6S+jy9+Tn9uchOpZedTNL9fcTxCeeGkgbddq2u9MlJSKvT+Ktcc
	vmxA5SUEA+puLwIJ9DwsA+3kGFc0mEL6Q04S5T9VZtKUQh/ULY0wCyoNEZtB1izYZDCJJFaD5X+
	acGeUZfkq0qJl1+BEXsw3q7KoooWzQpeX5BTWQoCW9xBYAUbp0ZWFdiioO7NU+iJzmGzLKY3Ib9
	0FqGjwlsusGsImYKyOEE6eW5ZMIVfJKjXLn/I9Ry9OKzuqToKVPoKNdsXEEdv6aM1l0QNalN0af
	p/PH1YwG09TIwGpYe5lY5TMBuRLvC1u+oWry6TsObzSOSwZ8oKtsRuAUsIGNCpAGfZloPNpkwHN
	SzzW1bFWHKnHxoe9NE0FeX2Fa7PQ+Sr5gErfHwxhtYcst3+8AmutYJWTFGTs86ZXAMCo81AUw2V
	VTysQezP7lSjJvf6M54hXRwwyj952pR1TIIl8b0KQa5EGnb9SS5I+LqRZR5Fd6ntYvX4ecvRcBz
	vctwBfC0Quwk1N9Q4q4NRidgqXztK0M3mU/5TqT8/Bh+WpUyM/6s9BF6k4kJplZ8jYakeFkmeuQ
	qP1tw=
X-Received: by 2002:a05:6122:790:b0:5d0:1207:b693 with SMTP id 71dfb90a1353d-5ec6851ce52mr5132479e0c.1.1793658020346;
        Mon, 02 Nov 2026 14:20:20 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c99e3csm11306519e0c.15.2026.11.02.14.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:20:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-11-02
Date: Mon,  2 Nov 2026 17:20:18 -0500
Message-ID: <20261102222018.2610820-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit c3e67bd82b9b9b1a5118f09a429ccefe2aab0741:

  ipv6: reject wrapped temporary address preferred lifetimes (2026-11-02 22:31:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-11-02

for you to fetch changes up to 60b10121db602a43ada3dbc39792bbf93d25991b:

  Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery (2026-11-02 17:09:03 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_core: Initialize IRK before publication
 - hci_core: Initialize link key before publication
 - hci_core: Initialize LTK before publication
 - hci_core: Fix queuing rx_work while workqueue is drained
 - hci_core: Keep link-key filtering inside RCU
 - hci_core: Initialize advertising RPA work only once
 - hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
 - hci_sync: re-enable legacy advertising on resume
 - hci_sync: pause advertising for the scan address update
 - hci_sync: Update the CIS host feature when enabling LE
 - hci_sync: Copy the LE accept list under hdev->lock
 - hci_sync: Protect resolving-list lookups
 - hci_sync: Copy the resolving-list IRK under RCU
 - hci_event: Clear explicit connect state on LE connection
 - L2CAP: Hold incoming data until encryption key size is known
 - L2CAP: Ignore connection responses with wrong ident
 - SMP: Protect link keys during LTK derivation
 - SMP: Protect LTK encryption with RCU
 - MGMT: Return RFKILLED for Set Powered on a blocked controller
 - MGMT: Clear disabled connection parameters when loading none
 - MGMT: Fix discovery stuck after a failed Stop Discovery
 - validate retained LE Create CIS command length
 - validate retained LE Set CIG Parameters command length

Drivers:

 - btintel: fix buffer over-read in fw payload
 - btmtk: drop zero-length ISO packets from endpoint padding
 - btmtk: bound the ISO payload length by the controller's MTU
 - btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD
 - btmtk: fix error handling in btmtk_usb_isointf_init()
 - qca: Fix the WCN3950 NVM baud rate offset

----------------------------------------------------------------
Akhil Arul (1):
      Bluetooth: hci_core: Fix queuing rx_work while workqueue is drained

Binbin Deng (3):
      Bluetooth: hci_core: Initialize IRK before publication
      Bluetooth: hci_core: Initialize link key before publication
      Bluetooth: hci_core: Initialize LTK before publication

Catherine L (1):
      Bluetooth: btintel: fix buffer over-read in fw payload

Cen Zhang (7):
      Bluetooth: hci_sync: Copy the LE accept list under hdev->lock
      Bluetooth: hci_sync: Protect resolving-list lookups
      Bluetooth: hci_core: Keep link-key filtering inside RCU
      Bluetooth: SMP: Protect link keys during LTK derivation
      Bluetooth: SMP: Protect LTK encryption with RCU
      Bluetooth: hci_sync: Copy the resolving-list IRK under RCU
      Bluetooth: hci_core: Initialize advertising RPA work only once

Chris Lu (3):
      Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
      Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
      Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD

Ismail Tarim (1):
      Bluetooth: btmtk: fix error handling in btmtk_usb_isointf_init()

Jinwang Li (1):
      Bluetooth: L2CAP: Ignore connection responses with wrong ident

Kevin Dewald (3):
      Bluetooth: hci_event: Clear explicit connect state on LE connection
      Bluetooth: MGMT: Clear disabled connection parameters when loading none
      Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
      Bluetooth: hci_core: Convert hci_conn flags to a bitmap
      Bluetooth: L2CAP: Hold incoming data until encryption key size is known
      Bluetooth: hci_sync: Update the CIS host feature when enabling LE

Michael McAllister (1):
      Bluetooth: qca: Fix the WCN3950 NVM baud rate offset

Tobias Wilken (1):
      Bluetooth: MGMT: Return RFKILLED for Set Powered on a blocked controller

Valentin Kindschi (2):
      Bluetooth: hci_sync: re-enable legacy advertising on resume
      Bluetooth: hci_sync: pause advertising for the scan address update

Yifan Zhang (2):
      Bluetooth: validate retained LE Create CIS command length
      Bluetooth: validate retained LE Set CIG Parameters command length

 drivers/bluetooth/btintel.c      |  24 ++++-
 drivers/bluetooth/btmtk.c        |  49 +++++++--
 drivers/bluetooth/btqca.c        |   3 +-
 include/net/bluetooth/hci_core.h | 104 +++++++++---------
 net/bluetooth/hci_conn.c         |  92 ++++++++--------
 net/bluetooth/hci_core.c         |  54 +++++++---
 net/bluetooth/hci_event.c        | 212 +++++++++++++++++++++++--------------
 net/bluetooth/hci_sync.c         | 223 ++++++++++++++++++++++++++++++---------
 net/bluetooth/iso.c              |  20 ++--
 net/bluetooth/l2cap_core.c       |  26 +++--
 net/bluetooth/mgmt.c             |  51 ++++++---
 net/bluetooth/smp.c              |  53 ++++++----
 12 files changed, 609 insertions(+), 302 deletions(-)
