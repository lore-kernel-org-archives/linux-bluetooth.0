Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DCB388360
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349563; cv=none; b=Xu/k2PGDK0rO4UXg0yiop5lDEKQ29N6YhZ9WBFDA2CJ1fm4O3trDbUXRY+wz9wjSu9T/ZK92l9tfCELUH1uMoVe4UMiMwYLkfqfO7iYa7CZwFFtXEiXkP2s9S5PBFckZ4PWgRutVXNTVtoxv1uEnkGflTrMtPegbYp1EiWhCSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349563; c=relaxed/simple;
	bh=sLOXjd+NfAwNXadZFH7WDVyUde0hvaq0L0Srnaupd8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fujlUxcJM+/pAibwyvu5e24yg4LP/1CQNK+ewHv1OdTm8jgb6JXEsBFawlDezbdax6CGCb3+AkdI1uC5U2o/bSmU2pXVv8BPPJZbX8/BzilcB4zvd9doaSrjeyRV8wZm6MndXrOzrAN/6zWR8o9ahvYuQ5PrhDXS4GcMlk8a8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=robTeF0H; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="robTeF0H"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-59e23d70dfaso1382542e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783349561; x=1783954361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pei7zU5fit2kiS0qO76Myjn3DP91N9i6Q/nmtwzzNx4=;
        b=robTeF0HhSPr00Y4NKI/uDxQ8v/mIGnRlEql16Vc/PXudRhuBvDIJvtWndqaI8fdWo
         s6d5+q22rOrwBmHaHw2T14lJuVJjPZffGAjMs7od+elOF2iRjt0ei8SBB8ay3bs1ZeqM
         DO4z65+csUWhU6Ep5WG8ZTs393W9ZI4k94fNr1elzBKxkFS/o8NUi+tftJJoKodrWi3D
         VDz3THlpZ9uxlkl1pm9JzQS8Ws8viXizQnwXcO2TLfhh++LD4/EKTMaZCBahpa8gMfN/
         xjfonWKcSVgqy1Ql3Y+WENwFzt9W3xJfJSabXFw3lk8tYrCq2oMt5NGZ27dyYe7xQ5Xr
         W4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349561; x=1783954361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pei7zU5fit2kiS0qO76Myjn3DP91N9i6Q/nmtwzzNx4=;
        b=RnpVvM5WHD7CFIbd4QIwk9RYrZRFhwcksC+5NRax2CnskWVXYjbuADVejK5iPyaBte
         KNdleg6trP5qkOwmd+1vwrZipyu8n+w1NcP7oazlfX2R3e9VtJpPuj7Zfw1XCn/+ijUe
         yGhDygGc8ZCe1D6hF/3TjFE6clZZYWbC3HCgrqp/y/4FqFtUPfEFwc0gRYEDMDtbmaDr
         b8UqVQLfqgRSmzrK6HZ0xERt7Sv0UpERNWUDgYnkJ0yGxYmkHTodhyixjMdHJIXCzO8b
         2wc5azNg+sTqGoo+ksQJB+UeeSboQXqZfNMTWkbJHyk9VzIcjyehMYoaDC4/kiyF2E+O
         HGAQ==
X-Gm-Message-State: AOJu0YwNS83Tf04p3CJXERRuqrVS2z5xZrpKzeGjveORCbHSqz/j/c8O
	K5pfjfWl//1lB6X9jJQ3bkBDMdO3uyisUdiP1qAeTHVcBXmFwWtvVcIa
X-Gm-Gg: AfdE7cmtgSVC5Y5lk5pumjKy3zKuCuQgQzHzS6Hrhs9aD8WqpMm6WQdZczUMPYxUNvy
	1+zQeltLNKOJSFyuUg40BRxk0qPxjjxBuEQ05yp0yR5Wsjlt21/p/UXNoEq3Hth0R7Tjm8CYl6Y
	0JEKalFLe5EjRj8gRx+Wg/U2WqFCvBGLEE0PVjQrEzrVx73h2XQiZVBG5tWd44AbV7Y3cZwplbm
	vgMiShbjgFcrV1hZ+xjKTmxN0IhO9/BJLTm2bVPDUssOOmJ2XGVY6sHHi9VbETSW+MMO4i07scr
	S07lVuFi5OKyYrgtxOybLRO7t5z2u/piCtXa8ZwSc3MZ9FYA+O5NEZ6rmM0z2XRomLqzBf6aZrk
	dlBxqrjMYvTgN8B1ievpaprqLf349hnL4tiu83MHd+ps0u+L7L6UNdWNIrEcVnSogR7LpnNSKEQ
	J5HTmuEJW4oo0bD4rZQLMDaWmPTX8jjLeyPr7CF4A+U874m38bue60/z14cwSBbM7DyabUfMQK2
	6AqiZT6r8UPH1i/RA==
X-Received: by 2002:a05:6122:46aa:b0:5bd:b0de:a736 with SMTP id 71dfb90a1353d-5be907a7dd5mr473218e0c.8.1783349560419;
        Mon, 06 Jul 2026 07:52:40 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5be0299616fsm5074880e0c.6.2026.07.06.07.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:52:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-07-06
Date: Mon,  6 Jul 2026 10:52:29 -0400
Message-ID: <20260706145229.728127-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 9e05e91a9a847ed57926414bd7c2c5e54d6c56c6:

  amt: fix size calculation in amt_get_size() (2026-07-06 13:01:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-07-06

for you to fetch changes up to 6e1930ece855a4c256f1c7e6632d634cfb9888b5:

  Bluetooth: L2CAP: fix tx ident leak for commands without a response (2026-07-06 10:46:58 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_conn: Fix null ptr deref in hci_abort_conn()
 - af_bluetooth: fix UAF in bt_accept_dequeue()
 - L2CAP: validate option length before reading conf opt value
 - L2CAP: cancel pending_rx_work before taking conn->lock
 - L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
 - L2CAP: fix tx ident leak for commands without a response
 - SCO: Fix a race condition in sco_sock_timeout()
 - ISO: avoid NULL deref of conn in iso_conn_big_sync()
 - ISO: fix malformed ISO_END/CONT handling
 - ISO: exclude RFU bits from ISO_SDU_Length
 - MGMT: Fix adv monitor add failure cleanup
 - MGMT: Fix UAF of hci_conn_params in add_device_complete
 - bnep: pin L2CAP connection during netdev registration
 - 6lowpan: avoid untracked enable work
 - 6lowpan: hold L2CAP conn across debugfs control
 - 6lowpan: Fix using chan->conn as indication to no remote netdev
 - btintel_pcie: Refactor FLR to use device_reprobe()
 - btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v3()
 - hci_uart: clear HCI_UART_SENDING when write_work is canceled
 - bpa10x: avoid OOB read of revision string in bpa10x_setup()

----------------------------------------------------------------
Cen Zhang (3):
      Bluetooth: 6lowpan: avoid untracked enable work
      Bluetooth: 6lowpan: hold L2CAP conn across debugfs control
      Bluetooth: MGMT: Fix adv monitor add failure cleanup

Kiran K (1):
      Bluetooth: btintel_pcie: Refactor FLR to use device_reprobe()

Luiz Augusto von Dentz (1):
      Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev

Maoyi Xie (1):
      Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v3()

Muhammad Bilal (2):
      Bluetooth: ISO: avoid NULL deref of conn in iso_conn_big_sync()
      Bluetooth: L2CAP: validate option length before reading conf opt value

Pauli Virtanen (3):
      Bluetooth: hci_uart: clear HCI_UART_SENDING when write_work is canceled
      Bluetooth: ISO: fix malformed ISO_END/CONT handling
      Bluetooth: ISO: exclude RFU bits from ISO_SDU_Length

Runyu Xiao (1):
      Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock

Samuel Page (1):
      Bluetooth: MGMT: Fix UAF of hci_conn_params in add_device_complete

Siwei Zhang (2):
      Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

Stig Hornang (1):
      Bluetooth: L2CAP: fix tx ident leak for commands without a response

Sungwoo Kim (1):
      Bluetooth: sco: Fix a race condition in sco_sock_timeout()

Weiming Shi (1):
      Bluetooth: bpa10x: avoid OOB read of revision string in bpa10x_setup()

Yousef Alhouseen (2):
      Bluetooth: bnep: pin L2CAP connection during netdev registration
      Bluetooth: fix UAF in bt_accept_dequeue()

 drivers/bluetooth/bpa10x.c       |   8 ++-
 drivers/bluetooth/btintel_pcie.c | 102 ++++++++++++++--------------
 drivers/bluetooth/btnxpuart.c    |   6 ++
 drivers/bluetooth/hci_ldisc.c    |  14 ++--
 include/net/bluetooth/hci.h      |   5 +-
 include/net/bluetooth/hci_core.h |   1 +
 include/net/bluetooth/l2cap.h    |  10 +--
 net/bluetooth/6lowpan.c          |  84 +++++++----------------
 net/bluetooth/af_bluetooth.c     |  17 +----
 net/bluetooth/bnep/core.c        |  27 ++++++--
 net/bluetooth/hci_conn.c         |  21 +-----
 net/bluetooth/hci_sync.c         | 133 +++++++++++++++++++++++++++++++++----
 net/bluetooth/iso.c              |  44 +++++++-----
 net/bluetooth/l2cap_core.c       | 140 ++++++++++++++++++++++++++++++---------
 net/bluetooth/l2cap_sock.c       | 107 ++++++++++++++----------------
 net/bluetooth/mgmt.c             |   5 ++
 net/bluetooth/msft.c             |   2 +-
 net/bluetooth/sco.c              |  15 ++++-
 net/bluetooth/smp.c              |  27 ++------
 19 files changed, 467 insertions(+), 301 deletions(-)
