Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2125782F
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Sep 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758987991; cv=none; b=LwJ/F3p5inZ9zfI0Ty+CiuXiN37C48c/4YP3hMSbvNZITbkcZXwrSCgCLiECb3akryvS6QuBgCGARBqBJZHT1SGL78DEYlxhb0g8UaG549vkH4PNfIAeigWR6bVJYeg5+Ud9thySsAqJjYsN8IlDunoW/uc4Xl19wjXNfHbAq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758987991; c=relaxed/simple;
	bh=QC+ole/VNUsyTUW4VqiWVKT3tiTYgeDkgSna8bQ4+no=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3/EFmzMGv/CM7c1uK5UF+0VZ055K20VdcTWZ9JfE3TP7aG22gpoJWN/u9NzGEGGsyTHRWKnBj8Axe+sfNfzlO6eVA/4QHRSiGZEUyPQU4wKX3dQgPeYLGo0qOxW4cZIZzNt1UXrq9t00Kc5w3VWLV+mQG7vcJyTbQ/OrWojioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLPTN/oo; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLPTN/oo"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54a8f6a2d80so1141715e0c.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Sep 2025 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758987989; x=1759592789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJgzNxwmUbpe80yIz0NE1vMDun+tBOsupWEm3Ft1lGs=;
        b=iLPTN/ooal6q1+sOiqLnpjbwtKFBs7dx7BAjZr7da3yiBVU5VPdkJYTrcaMRc6EJVF
         PM6z9fcxRhG1ulf79ps13O0IhiE7fPQ+wAiAsdNUnn5lixAFHtS6pNQ1bRZiLzo4vnX2
         WrLYHir+byMweBLVPDSR2ICV8vlmrd05CUMPG+FrRZCaiBr/dOctfBQuSDG/IhKC7EOx
         +RI6qtsSCVF62K5zvSbN0ZsnyfzY61jZCA40f5kvI8dOChnhvBWULhUvISGhgUJkU5gn
         D99KkaPQCf2nXSfZDug2ZiJCsboB7BMd3TR4xsr0cLF1DEthEXikWPjJ3R5hH9AqxaqD
         p0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758987989; x=1759592789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJgzNxwmUbpe80yIz0NE1vMDun+tBOsupWEm3Ft1lGs=;
        b=nLH1ownhP84SpNv3xeHCRj0S2IePJ/QxuAxcGjucI3//xSXa8A5j95m2lXbAsL+RxD
         mQGL6mrflwPTf9lCDGRdiHKH+sxQnOZlFzlazsrh1q4nZSZliHz4hbjsmHnItROU2hLg
         68AqMgfIbB8ByIOVmLQOezN+MbhHsm7rKwzqL+jYfbC8wQyJJ1/qSwGsd4TElHut8rMR
         1yHAxlCu+aqvn0RsdKOMQ/M+2poOQ7GpZaJ47m3tWG+k0dFLkzIXgTE1dQdxoQ+EVSYW
         bHiPno8Ka6B0zy9qJxUTt2XiHHJwM1RizE7C2f4FVCHhCO2aXrcaTmC/X3TG9XAd33jw
         t/mw==
X-Gm-Message-State: AOJu0YzFpOsnygaSBNi+d3SvgiI5cccLKsnNFbial+gCfv6e+tXlaOJ5
	z4LLhmPqlEPNXIBUHGxKsmxuhcnRr4ogFLMOgWG+F2hsFYQXuK5jzp1Wi05naw==
X-Gm-Gg: ASbGnctAY1AEUS+4KMDzxJA1LxjPjNeFx0bVDZ4U7akIZG+yxj96FcJQAE5AW79qdzS
	+Y8aSfVSF0ZbFlOBdeSR/DxdT7YBkZXPEGtSCXxkWxxtq7CPtlhvZeEc10pkuIWw+JiR9lXRsRs
	Fy7id1OO9dRXZGhi0H/InPxOzRLXO/Gpc6sGJwCdrQUlITANrKk3dsxbiRZRekZnbqwMfPP46Ek
	wOxkQuBW6yJaqqYbeeq4O7ZQ6otJ2HM1iRJ1Ncoppp/mGd78Z4JPEAS4F308PKfjDM888mc3NxV
	ThO0p8XkOx3A+lD/GybABPp448iZrorze2MXRQYuwvJ+7IHGwPUic/CCcskEaSW6FEDbI0HFCV9
	x5nttaWxQZHqwKP5RehijiuEdybflzSR4D9xNn+RS8yb7dG+MBckHBlHHZdKoixAK2ZEv8clFjf
	dZ
X-Google-Smtp-Source: AGHT+IHRGpnk3Y7LMzYuxMMDSElRrKrHJpsFUs/Q4O680GHYj4NTF54zN0aYxTWR4sV0y6xl3HAWaQ==
X-Received: by 2002:a05:6122:308a:b0:54b:cab1:d8b0 with SMTP id 71dfb90a1353d-54bea0a9f6fmr4309889e0c.2.1758987988687;
        Sat, 27 Sep 2025 08:46:28 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bed89e291sm1637980e0c.7.2025.09.27.08.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 08:46:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2025-09-27
Date: Sat, 27 Sep 2025 11:46:16 -0400
Message-ID: <20250927154616.1032839-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 1493c18fe8696bfc758a97130a485fc4e08387f5:

  Merge branch 'selftests-mark-auto-deferring-functions-clearly' (2025-09-26 17:54:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-09-27

for you to fetch changes up to be812ace0378a9db86344ad637c5ed2a5d11f216:

  Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings (2025-09-27 11:37:43 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:

 - MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver
 - Avoid a couple dozen -Wflex-array-member-not-at-end warnings
 - bcsp: receive data only if registered
 - HCI: Fix using LE/ACL buffers for ISO packets
 - hci_core: Detect if an ISO link has stalled
 - ISO: Don't initiate CIS connections if there are no buffers
 - ISO: Use sk_sndtimeo as conn_timeout

drivers:

 - btusb: Check for unexpected bytes when defragmenting HCI frames
 - btusb: Add new VID/PID 13d3/3627 for MT7925
 - btusb: Add new VID/PID 13d3/3633 for MT7922
 - btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1
 - btintel: Add support for BlazarIW core
 - btintel_pcie: Add support for _suspend() / _resume()
 - btintel_pcie: Define hdev->wakeup() callback
 - btintel_pcie: Add Bluetooth core/platform as comments
 - btintel_pcie: Add id of Scorpious, Panther Lake-H484
 - btintel_pcie: Refactor Device Coredump

----------------------------------------------------------------
Arkadiusz Bokowy (1):
      Bluetooth: btusb: Check for unexpected bytes when defragmenting HCI frames

Bartosz Golaszewski (1):
      MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver

Calvin Owens (1):
      Bluetooth: remove duplicate h4_recv_buf() in header

Chandrashekar Devegowda (2):
      Bluetooth: btintel_pcie: Add support for _suspend() / _resume()
      Bluetooth: btintel_pcie: Define hdev->wakeup() callback

Chris Lu (2):
      Bluetooth: btusb: Add new VID/PID 13d3/3627 for MT7925
      Bluetooth: btusb: Add new VID/PID 13d3/3633 for MT7922

Gustavo A. R. Silva (1):
      Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings

Ivan Pravdin (1):
      Bluetooth: bcsp: receive data only if registered

Kiran K (4):
      Bluetooth: btintel: Add support for BlazarIW core
      Bluetooth: btintel_pcie: Add Bluetooth core/platform as comments
      Bluetooth: btintel_pcie: Add id of Scorpious, Panther Lake-H484
      Bluetooth: btintel_pcie: Refactor Device Coredump

Luiz Augusto von Dentz (12):
      Bluetooth: btintel_pcie: Move model comment before its definition
      Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
      Bluetooth: HCI: Fix using LE/ACL buffers for ISO packets
      Bluetooth: ISO: Use sk_sndtimeo as conn_timeout
      Bluetooth: hci_core: Detect if an ISO link has stalled
      Bluetooth: MGMT: Fix not exposing debug UUID on MGMT_OP_READ_EXP_FEATURES_INFO
      Bluetooth: Add function and line information to bt_dbg
      Bluetooth: hci_core: Print number of packets in conn->data_q
      Bluetooth: hci_core: Print information of hcon on hci_low_sent
      Bluetooth: SCO: Fix UAF on sco_conn_free
      Bluetooth: ISO: Fix possible UAF on iso_conn_free
      Bluetooth: hci_sync: Fix using random address for BIG/PA advertisements

Pauli Virtanen (2):
      Bluetooth: ISO: free rx_skb if not consumed
      Bluetooth: ISO: don't leak skb in ISO_CONT RX

Thorsten Blum (2):
      Bluetooth: Annotate struct hci_drv_rp_read_info with __counted_by_le()
      Bluetooth: btintel_pcie: Use strscpy() instead of strscpy_pad()

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1

 MAINTAINERS                       |   7 +
 drivers/bluetooth/bpa10x.c        |   2 +-
 drivers/bluetooth/btintel.c       |   3 +
 drivers/bluetooth/btintel_pcie.c  | 328 +++++++++++++++++++++-----------------
 drivers/bluetooth/btintel_pcie.h  |   2 +
 drivers/bluetooth/btmtksdio.c     |   2 +-
 drivers/bluetooth/btmtkuart.c     |   2 +-
 drivers/bluetooth/btnxpuart.c     |   2 +-
 drivers/bluetooth/btusb.c         |  23 +++
 drivers/bluetooth/h4_recv.h       | 153 ------------------
 drivers/bluetooth/hci_bcsp.c      |   3 +
 include/net/bluetooth/bluetooth.h |   3 +-
 include/net/bluetooth/hci.h       |   1 +
 include/net/bluetooth/hci_core.h  |  11 +-
 include/net/bluetooth/hci_drv.h   |   2 +-
 include/net/bluetooth/mgmt.h      |   9 +-
 net/bluetooth/hci_conn.c          |  27 ++--
 net/bluetooth/hci_core.c          |  52 ++++--
 net/bluetooth/hci_event.c         |  16 +-
 net/bluetooth/hci_sync.c          |  10 +-
 net/bluetooth/iso.c               |  34 +++-
 net/bluetooth/mgmt.c              |  10 +-
 net/bluetooth/mgmt_config.c       |   4 +-
 net/bluetooth/sco.c               |   7 +
 24 files changed, 345 insertions(+), 368 deletions(-)
 delete mode 100644 drivers/bluetooth/h4_recv.h
