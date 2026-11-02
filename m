Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657849;
	b=Gz6OgezmfHolwWHQb7aluC/LeKALSSuM8G9vEGofFG4G28lG6zo3MI3tWG7ZDwGo7cMc
	 pIvMTOR1vXmG/bos+vMRKCap/frWDbYGA4igT3aIGRFLvtd6g+UO7hAk0l2wwS7KCU64K
	 CC8FyYfn2F3Z1ksRxY/xxcfVl9Xilcwu+W/hcHwF8hCZ668ldDmPhnVadcIVGodL0DJyV
	 GqIRGU5gY7UmKLffhDmsNdbQt8/aCdSKX6MOSynsh6y/mkTWpeC9mKy2Q64HyZm3ab0RA
	 4JrFQ0nhLfDsDaeNP/0qYwat/DbJMrH+4yEPDplQDSFwVJFCH3cQKtLvdgW9jCWQgyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1gEpsqS1i+/K0+uv78zfDi7xU2QuotIgijxmoIPRWJ4=;
	b=2ANOODMEBVsHhRL30CQzgbP/mMCx6Dxv4OCSStDGVVKm9RdAYL5AXVb4YQRmCgCYckc/
	 wdE4tIOLma7jIkXZpM21CA2R4WPc5RBxMLO0bAWoLOVqL0FHo9OA0Aks055b8liiBrVwP
	 /vrN70nWbgayEVU+PyASHHxG399fTLWmzFYH9gSsTVAiBbacO06MZdUF+jmOo13s/fzPZ
	 ZUKuTbJjxUSC3WuWBIGUDp9yWDKAtfoJEX1uGjPTULhrBOZwLqZzY8zO4STmQVB2s59/p
	 6MvBen9WVWOrbtpLCzn7dcdTHiAn3I5iC/FSeUU64HsKY9KU0Z2q7FsLzpyqwqL9pxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HXcFbb8E;
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1873606A324
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 22:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1873606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HXcFbb8E
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so2150466241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 14:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793657848; x=1794262648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gEpsqS1i+/K0+uv78zfDi7xU2QuotIgijxmoIPRWJ4=;
        b=HXcFbb8ESgyuptPtVBsX81pKlksX754fcFMN7yaZfpvAD/9g+k9XeAYlo47IXzZFMS
         fa59OGC5g+lOZHN5skyK0wPMB1wExz03lVIBr8dEuggMV5kzOMMOEptcnjYCYgOt3dmL
         sn9DE6AquFhErrW0V1TD0QQCDfWje74QW+BpmonPJh6CtacUsA0h/qGFCt/yQrkYGa79
         2t2rb05C05AyBIkFfvj3THpZWB/VVVVcLtMmb37d/O6uXLc1K9QPB0uniHcOhxYJmbeQ
         rQtnCNmXIr0ODCdHZOFgC+f9HdhHVqnBSH07ocr4YAKXzXKcbNDfd9tiFgQiONUJD0mL
         FkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657848; x=1794262648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1gEpsqS1i+/K0+uv78zfDi7xU2QuotIgijxmoIPRWJ4=;
        b=XpiwnAshNgDsSpvfmpOQrQrN6wVgzQIvWAKv4yMtNKMqCcsBh2XZI+y64KaxfNwSXz
         mpmdtl/5/ZcwYQ35RnKQcqFSsqdYTPB1QhhJBO6xoUuEcx/q+9r5LCwMhRbyECEDaSU0
         a14C9Lww6ZJcn5IqXSb3bw9aFqBOK02DNu/nrKffSOi7mPyKbAH40whR1rH2KBbKqe+s
         IbzqtwcPM/EWit6Ma8ZCwMjblCvNypyQ6DeYzf5z/PhJMrZEiBbUkPVxuDuKP4/OuW7C
         suWt/BaXbaiI20VBSm3LELtmD+HdnO3sAPXO6xpSNhJNtbijOBQZnE5Tm63Yw2RrdHie
         pV2Q==
X-Gm-Message-State: APuU4Z/o/1dY0RQ20QQOx5RrNQt8jm0m0K9NkrDi0QUCQ1FI4JgTYCiT
	G2iP4APRJlnfPNJ0dOfJU7+Ny52Z7NWTrPmFpSAtlu9sCklbji4GKDaJU7dDKgWR
X-Gm-Gg: AYBFou1LCUHCGnXEvmquPuaN2tvLQzdYbnn2FUqeQg18IyL5iZBGj0Y0+gwWJmMiv/l
	+viiRqz0+V6bW3BndN5OxgXIpXNlM5yNLqI2RayVO8TTNqj8Wrg2Pbc/L68pSpCbtHDpFlsKpRi
	huJknSHdageqjxoP0MdQGwJ/9a1B0ClG4NIf2b3dyNkM5I8E6slKX1ELGii94eOWtJNFEDUJ1BA
	2pZeiIyc5s/VgucCxataHmLDxPdNEv6/B+1WFW0gtUZcdSyYdzfAR0ROWw3oIeZqMFP6RXOcQZZ
	6zHhr5X2XkwWsORkXhM794SBl9YRS2B8MNsOq1Pw9fzmxuQdw2uTj+aQdBKCnF3AzR2tMp90vPP
	2roeNSHa9RTsKffMtee8rImNmyvfpg6o8W9RvGIZMrsPVh41NacArmK2AV0hUYp/mLYxkYV8vIM
	lu7NHnhqanlrJOLAi8ioIHAx6bMl2eaWbWUmkeNXpG+CeSm0DRuD+22uZ68NGL534rJWC/TE7Nk
	1RlCuDzWGDsJwxYH6aLJhp6GHj9R3taQ8biqHZGSKN2eP0xX5eo19cNR0N2Fh4In0jsMWFXyqB/
	j2Jw3S5OT1YHu7SWCu+vxJ+JYoJs05uYJtkrQvLfN4bq5US1V2kg38Uw8gHh4f5NVbnhWvF36qF
	+T+lWSkdLeQ3SG3tbWJbBcGfFvat2GsRtu7AdRsimBPWB/O/MuiZ+03eqqfPyH3L/TzjNIRAaCu
	PMTVuzXaCdwh9l/EX969tpQ/yd
X-Received: by 2002:a05:6102:290c:b0:7cc:1b19:9258 with SMTP id ada2fe7eead31-7d07223f8e2mr4442892137.3.1793657847652;
        Mon, 02 Nov 2026 14:17:27 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d0775a716dsm11350449137.6.2026.11.02.14.17.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:17:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-11-02
Date: Mon,  2 Nov 2026 17:17:25 -0500
Message-ID: <20261102221725.2603463-1-luiz.dentz@gmail.com>
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
