Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12EC315777
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316844; cv=none; b=nxCkqVI9uQxx50bsA327G+VH/HLAAL/6AvknjtDbQppSM9Vo/T3D3gn+ju2DocVhFvuuze2PoNVtlzATtCCPWXYn7AxgFZSfHZxdIynEGRravXYKb5m7Yhtk03JjiRNX1XBfvlpWzWV4wERSQfY6ionfE+8/tzocV4ev93lvYfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316844; c=relaxed/simple;
	bh=v08xknFFTGOEj5jvOzGYy91+6zcHC7QaFdvE1yN8qQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tIi3mA864dTFqXZ0Dmd/mJydf8OqkBq6vs1MgNwdWy5JZ/u5T6sIGYJAmGK3ntrtKIMIUa96ICJVRMGdhfOcZbdyeiCGKF1o1YzUGY4uwjO7HC2NcGw0DPuWZKtrESe0pYM7Av9vuNLg5xxdtOn2Qz+WmX88R26vcY03mJcHeOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lgjxzeek; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgjxzeek"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-934ad40c2c2so814562241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761316842; x=1761921642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hC3pW8YG1jqy0I870M9s3ez7qPAIgDcYoaMDRv/PTc=;
        b=LgjxzeekVCq5GuAgiMfZ2JxDpHe8Xx1EDScNDL16578SAwUsl0GDHihCaU/gcwhtCq
         37U8BCK4O7R6QeUafsETa1l5gPgRBG0s15pBZYMUIknFOn+SBvzKoeXZD37Vc/FSAxR5
         TrFLoLbAggqWnekT9gLgHhSzuiAbMksBA1P/xuThUsn+58Nw+uqlIkTPSUKOofGw5cBA
         ygxdFU/JT9LVrU6UyITPaUQeJCfH+ou73/K4V6ba8ff4Gm9zI8sBhocGyXF4LVffipdx
         jD0Bk8DHZ9CpyM9wCer46IkFh/EbcYVkqCr4P+znTTXi/MPRcgdmuKb98sP7rtPrm1VR
         YUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316842; x=1761921642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hC3pW8YG1jqy0I870M9s3ez7qPAIgDcYoaMDRv/PTc=;
        b=rF5jPh38Q5TVxMOo/wofM9sWJkSD5mTyiKmGsTZjw7cofc9TTBeSSFkfjrJd5UuIPZ
         dzhRxVVEM836FrGbunNQP7XFRFsa5Jf/SbVTSEFrXpkDilCXPLxFD/IGOsEHImVJiTHM
         Htu1D8aJKlVGnXBRFyWrF2sAMVTR4ZZqyzDmQ154fc/FPzflFjznlRwJRor/aLv7OjsK
         pdxd5ox9qy/2KErLlfZbkQ+c/3OvHwdFQ3uh/ew6kdIfwmoL+8OK2nVeVRlQJ514fwZ6
         KEazfnSAUehC2J52AKRJbvnla0CsA1Do5zFiS5R/UKNq0bDSWuU9RhXbMQEyCVJabrN+
         Z4Qg==
X-Gm-Message-State: AOJu0YxSXyOjNkyqH0ZWs2NJrOICnPp44BQ0cS04GE4YcGbBXCRnpMYR
	r95B4PVgy7ejPav4WQwM5oJzJqUILVWM28EZwciUhk8JJx2hGWXU0BfJ
X-Gm-Gg: ASbGncvMPGqh9YHlMKy+VefatqW11PJNhkc2UsWbAWt1SPXWq3GP6L9lEOAGUHfIJQC
	LU9SifhLR91gH6AJREWSOMzUH3gA75EISPMCb1cYmWMbr2NexIcqBL6c3tprk41sUqhGFW/ri22
	rX3D7MxvIfN4COM6TEdiz5GhbaRnTf7FEE+HRlKNW97545tbdNrnwSrNv2ftmCHKblTaWwR1Soi
	01lg/KEUpMAa9AuRWFZ93gK474LoGK31GmSOCofVrDBwC3sN+abuIzEHcP5CSyi1npSz8bxevrJ
	I2rfbdvYIRsGCAd+w+ITUdB0bXBeUUPgWXVCCIpdTVbm1tbqXbW1436Jiky4hAUt+1u3vpJ7yVI
	xKMk/HlVSL6DqUgGmCROejGs6Ezf+62mA7FAxMwzbOHuqkAjPrUXUV7an3lOxQ5AMCvNKJkq2aI
	wog6fEHV8LJ5WbjQ==
X-Google-Smtp-Source: AGHT+IHDFx0Dwy8ZuT3MuN2G8gNP1MbR2kNZtG+WI4dHqp1lZZDo6L4k7tHg+/hI57FVOEzeOtdtKA==
X-Received: by 2002:a05:6122:920:b0:557:d6d4:2f51 with SMTP id 71dfb90a1353d-557d6d432a7mr373074e0c.8.1761316841684;
        Fri, 24 Oct 2025 07:40:41 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bdbe3bc6sm2129464e0c.18.2025.10.24.07.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:40:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-10-24
Date: Fri, 24 Oct 2025 10:40:32 -0400
Message-ID: <20251024144033.355820-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 1ab665817448c31f4758dce43c455bd4c5e460aa:

  virtio-net: drop the multi-buffer XDP packet in zerocopy (2025-10-23 17:30:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-10-24

for you to fetch changes up to 91d35ec9b3956d6b3cf789c1593467e58855b03a:

  Bluetooth: rfcomm: fix modem control handling (2025-10-24 10:32:19 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - fix corruption in h4_recv_buf() after cleanupCen Zhang (1):
 - hci_sync: fix race in hci_cmd_sync_dequeue_once
 - btmtksdio: Add pmctrl handling for BT closed state during reset
 - Revert "Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()"
 - rfcomm: fix modem control handling
 - btintel_pcie: Fix event packet loss issue
 - ISO: Fix BIS connection dst_type handling
 - HCI: Fix tracking of advertisement set/instance 0x00
 - ISO: Fix another instance of dst_type handling
 - hci_conn: Fix connection cleanup with BIG with 2 or more BIS
 - hci_core: Fix tracking of periodic advertisement
 - MGMT: fix crash in set_mesh_sync and set_mesh_complete

----------------------------------------------------------------
Calvin Owens (1):
      Bluetooth: fix corruption in h4_recv_buf() after cleanup

Cen Zhang (1):
      Bluetooth: hci_sync: fix race in hci_cmd_sync_dequeue_once

Chris Lu (1):
      Bluetooth: btmtksdio: Add pmctrl handling for BT closed state during reset

Frédéric Danis (1):
      Revert "Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()"

Johan Hovold (1):
      Bluetooth: rfcomm: fix modem control handling

Kiran K (1):
      Bluetooth: btintel_pcie: Fix event packet loss issue

Luiz Augusto von Dentz (5):
      Bluetooth: ISO: Fix BIS connection dst_type handling
      Bluetooth: HCI: Fix tracking of advertisement set/instance 0x00
      Bluetooth: ISO: Fix another instance of dst_type handling
      Bluetooth: hci_conn: Fix connection cleanup with BIG with 2 or more BIS
      Bluetooth: hci_core: Fix tracking of periodic advertisement

Pauli Virtanen (1):
      Bluetooth: MGMT: fix crash in set_mesh_sync and set_mesh_complete

 drivers/bluetooth/bpa10x.c       |  4 +++-
 drivers/bluetooth/btintel_pcie.c | 11 ++++++-----
 drivers/bluetooth/btmtksdio.c    | 12 ++++++++++++
 drivers/bluetooth/btmtkuart.c    |  4 +++-
 drivers/bluetooth/btnxpuart.c    |  4 +++-
 drivers/bluetooth/hci_ag6xx.c    |  2 +-
 drivers/bluetooth/hci_aml.c      |  2 +-
 drivers/bluetooth/hci_ath.c      |  2 +-
 drivers/bluetooth/hci_bcm.c      |  2 +-
 drivers/bluetooth/hci_h4.c       |  6 +++---
 drivers/bluetooth/hci_intel.c    |  2 +-
 drivers/bluetooth/hci_ll.c       |  2 +-
 drivers/bluetooth/hci_mrvl.c     |  6 +++---
 drivers/bluetooth/hci_nokia.c    |  4 ++--
 drivers/bluetooth/hci_qca.c      |  2 +-
 drivers/bluetooth/hci_uart.h     |  2 +-
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/l2cap.h    |  4 ++--
 include/net/bluetooth/mgmt.h     |  2 +-
 net/bluetooth/hci_conn.c         |  7 +++++++
 net/bluetooth/hci_event.c        | 11 +++++++++--
 net/bluetooth/hci_sync.c         | 21 +++++++++++++--------
 net/bluetooth/iso.c              | 10 ++++++++--
 net/bluetooth/l2cap_core.c       |  4 ++--
 net/bluetooth/mgmt.c             | 26 +++++++++++++++-----------
 net/bluetooth/rfcomm/tty.c       | 26 +++++++++++---------------
 27 files changed, 113 insertions(+), 67 deletions(-)
